import time
from struct import pack
from typing import Optional

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.dbc.DbcModels import Spell, SpellRange, SpellDuration, SpellCastTimes, SpellVisual
from game.world.managers.abstractions.Vector import Vector
from game.world.managers.maps.MapManager import MapManager
from game.world.managers.objects.ObjectManager import ObjectManager
from game.world.managers.objects.item.ItemManager import ItemManager
from game.world.managers.objects.item.Stats import SpellStat
from game.world.managers.objects.spell.EffectTargets import TargetMissInfo, EffectTargets
from game.world.managers.objects.units.DamageInfoHolder import DamageInfoHolder
from game.world.managers.objects.units.player.StatManager import UnitStats
from game.world.managers.objects.spell.SpellEffect import SpellEffect
from network.packet.PacketWriter import PacketWriter
from utils.constants.ItemCodes import ItemClasses, ItemSubClasses
from utils.constants.MiscCodes import ObjectTypeFlags, AttackTypes, HitInfo, ObjectTypeIds
from utils.constants.OpCodes import OpCode
from utils.constants.SpellCodes import SpellState, SpellCastFlags, SpellTargetMask, SpellAttributes, SpellAttributesEx, \
    AuraTypes, SpellEffects, SpellInterruptFlags, SpellImplicitTargets


class CastingSpell:
    spell_entry: Spell
    cast_state: SpellState
    cast_flags: SpellCastFlags  # TODO Write proc flag when needed
    spell_caster = None
    source_item = None
    initial_target = None
    targeted_unit_on_cast_start = None

    object_target_results: dict[int, TargetMissInfo] = {}  # Assigned on cast - contains guids and results on successful hits/misses/blocks etc.
    spell_target_mask: SpellTargetMask
    range_entry: SpellRange
    duration_entry: SpellDuration
    cast_time_entry: SpellCastTimes
    spell_visual_entry: SpellVisual
    _effects: list[Optional[SpellEffect]]

    cast_start_timestamp: float
    cast_end_timestamp: float
    spell_impact_timestamps: dict[int, float]
    caster_effective_level: int

    spell_attack_type: int
    used_ranged_attack_item: ItemManager  # Ammo or thrown.

    def __init__(self, spell, caster, initial_target, target_mask, source_item=None, triggered=False):
        self.spell_entry = spell
        self.spell_caster = caster
        self.source_item = source_item
        self.initial_target = initial_target
        self.spell_target_mask = target_mask
        self.triggered = triggered

        self.duration_entry = DbcDatabaseManager.spell_duration_get_by_id(spell.DurationIndex)
        self.range_entry = DbcDatabaseManager.spell_range_get_by_id(spell.RangeIndex)
        self.cast_time_entry = DbcDatabaseManager.spell_cast_time_get_by_id(spell.CastingTimeIndex)
        self.cast_end_timestamp = self.get_base_cast_time()/1000 + time.time()
        self.spell_visual_entry = DbcDatabaseManager.spell_visual_get_by_id(spell.SpellVisualID)

        if self.spell_caster.object_type_mask & ObjectTypeFlags.TYPE_UNIT:
            self.caster_effective_level = self.calculate_effective_level(self.spell_caster.level)
        else:
            self.caster_effective_level = 0

        # Resolve the weapon required for the spell.
        self.spell_attack_type = -1
        # Item target casts (enchants) have target item info in equipment requirements - ignore.
        if spell.EquippedItemClass == ItemClasses.ITEM_CLASS_WEAPON and not self.initial_target_is_item():
            self.spell_attack_type = AttackTypes.RANGED_ATTACK if self.is_ranged_weapon_attack() else AttackTypes.BASE_ATTACK

        self.cast_state = SpellState.SPELL_STATE_PREPARING
        self.spell_impact_timestamps = {}

        if caster.get_type_id() == ObjectTypeIds.ID_PLAYER:
            selection_guid = self.spell_caster.current_selection if self.spell_caster.current_selection else caster.guid
            self.targeted_unit_on_cast_start = MapManager.get_surrounding_unit_by_guid(
                self.spell_caster, selection_guid, include_players=True)

        if self.is_fishing_spell():
            # Locate liquid vector in front of the caster.
            self.initial_target = MapManager.find_liquid_location_in_range(self.spell_caster,
                                                                           self.range_entry.RangeMin,
                                                                           self.range_entry.RangeMax)
        self.cast_flags = SpellCastFlags.CAST_FLAG_NONE

        # Ammo needs to be resolved on initialization since it's needed for validation and spell cast packets.
        self.used_ranged_attack_item = self.get_ammo_for_cast()
        if self.used_ranged_attack_item:
            self.cast_flags |= SpellCastFlags.CAST_FLAG_HAS_AMMO

        self.load_effects()

    def initial_target_is_object(self):
        return isinstance(self.initial_target, ObjectManager)

    def initial_target_is_unit_or_player(self):
        if not self.initial_target_is_object():
            return False

        return self.initial_target.object_type_mask & ObjectTypeFlags.TYPE_UNIT

    def initial_target_is_player(self):
        if not self.initial_target_is_object():
            return False

        return self.initial_target.get_type_id() == ObjectTypeIds.ID_PLAYER

    def initial_target_is_item(self):
        if not self.initial_target_is_object():
            return False

        return self.initial_target.get_type_id() == ObjectTypeIds.ID_ITEM

    def initial_target_is_gameobject(self):
        if not self.initial_target_is_object():
            return False

        return self.initial_target.get_type_id() == ObjectTypeIds.ID_GAMEOBJECT

    def initial_target_is_terrain(self):
        return isinstance(self.initial_target, Vector)

    def get_initial_target_info(self):  # ([values], len)
        is_terrain = self.initial_target_is_terrain()
        return ([self.initial_target.x, self.initial_target.y, self.initial_target.z] if is_terrain
                else [self.initial_target.guid]), ('3f' if is_terrain else 'Q')

    def resolve_target_info_for_effects(self):
        for effect in self.get_effects():
            self.resolve_target_info_for_effect(effect.effect_index)

    # noinspection PyUnresolvedReferences
    def resolve_target_info_for_effect(self, index):
        if index < 0 or not self._effects[index]:
            return
        effect = self._effects[index]
        if not effect:
            return

        effect.targets.resolve_targets()
        effect_info = effect.targets.get_effect_target_miss_results()
        self.object_target_results = self.object_target_results | effect_info

    def get_ammo_for_cast(self) -> Optional[ItemManager]:
        if not self.is_ranged_weapon_attack():
            return None

        if self.spell_caster.get_type_id() != ObjectTypeIds.ID_PLAYER:
            return None  # TODO Ammo type resolving for other units.

        equipped_weapon = self.spell_caster.get_current_weapon_for_attack_type(AttackTypes.RANGED_ATTACK)

        if not equipped_weapon:
            return None

        required_ammo = equipped_weapon.item_template.ammo_type

        ranged_attack_item = equipped_weapon  # Default to the weapon used to account for thrown weapon case.
        if required_ammo in [ItemSubClasses.ITEM_SUBCLASS_ARROW, ItemSubClasses.ITEM_SUBCLASS_BULLET]:
            target_bag_slot = self.spell_caster.inventory.get_bag_slot_for_ammo(required_ammo)
            if target_bag_slot == -1:
                return None  # No ammo pouch/quiver.

            target_bag = self.spell_caster.inventory.get_container(target_bag_slot)
            target_ammo = next(iter(target_bag.sorted_slots.values()), None)  # Get first item in bag.
            if not target_ammo:
                return None  # No required ammo.

            ranged_attack_item = target_ammo

        return ranged_attack_item

    def is_instant_cast(self):
        # Due to auto shot not existing yet,
        # ranged attacks are handled like regular spells with cast time despite having no cast time.
        if self.casts_on_ranged_attack():
            return False

        return not self.cast_time_entry or self.cast_time_entry.Base <= 0

    def is_passive(self):
        return self.spell_entry.Attributes & SpellAttributes.SPELL_ATTR_PASSIVE == SpellAttributes.SPELL_ATTR_PASSIVE

    def is_channeled(self):
        return self.spell_entry.AttributesEx & SpellAttributesEx.SPELL_ATTR_EX_CHANNELED

    def generates_threat(self):
        return not self.spell_entry.AttributesEx & SpellAttributesEx.SPELL_ATTR_EX_NO_THREAT

    def generates_threat_on_miss(self):
        return self.spell_entry.AttributesEx & SpellAttributesEx.SPELL_ATTR_EX_THREAT_ON_MISS

    def requires_implicit_initial_unit_target(self):
        # Some spells are self casts, but require an implicit unit target when casted.
        if self.spell_target_mask != SpellTargetMask.SELF:
            return False

        # Self casts that require a unit target for other effects (arcane missiles).
        if self.spell_entry.ImplicitTargetA_1 == SpellImplicitTargets.TARGET_SELF and \
                self.spell_entry.ImplicitTargetA_2 == SpellImplicitTargets.TARGET_ENEMY_UNIT:
            return True

        # Return true if the effect has an implicit unit selection target.
        return any([effect.implicit_target_b == SpellImplicitTargets.TARGET_HOSTILE_UNIT_SELECTION for effect in self.get_effects()])

    def has_spell_visual_pre_cast_kit(self):
        return self.spell_visual_entry and self.spell_visual_entry.PrecastKit > 0

    def is_target_power_type_valid(self):
        if not self.initial_target:
            return False

        if len(self._effects) == 0:
            return True

        for effect in self.get_effects():
            if (effect.effect_type == SpellEffects.SPELL_EFFECT_POWER_BURN
                    or effect.effect_type == SpellEffects.SPELL_EFFECT_POWER_DRAIN
                    or effect.aura_type == AuraTypes.SPELL_AURA_PERIODIC_MANA_LEECH) \
                    and effect.misc_value != self.initial_target.power_type:
                continue
            return True
        return False

    # TODO, Check 'IsImmuneToDamage' - VMaNGOS
    def is_target_immune_to_damage(self):
        return False

    def cast_breaks_stealth(self):
        return not self.spell_entry.AttributesEx & SpellAttributesEx.SPELL_ATTR_EX_NOT_BREAK_STEALTH

    def is_fishing_spell(self):
        return self.spell_entry.ImplicitTargetA_1 == SpellImplicitTargets.TARGET_SELF_FISHING

    def is_pick_pocket_spell(self):
        return self.spell_entry.AttributesEx & SpellAttributesEx.SPELL_ATTR_EX_FAILURE_BREAKS_STEALTH

    def is_area_of_effect_spell(self):
        for effect in self.get_effects():
            if {effect.implicit_target_a, effect.implicit_target_b}.intersection(EffectTargets.AREA_TARGETS):
                return True
        return False

    # TODO, need more checks.
    #  Refer to 'IsPositiveEffect' in SpellEntry.cpp - VMaNGOS
    def is_positive_spell(self):
        return not self.spell_caster.can_attack_target(self.initial_target)

    def is_charm_spell(self):
        for spell_effect in self.get_effects():
            if spell_effect.aura_type in [AuraTypes.SPELL_AURA_MOD_CHARM, AuraTypes.SPELL_AURA_MOD_POSSESS]:
                return True
            if spell_effect.effect_type == SpellEffects.SPELL_EFFECT_TAME_CREATURE:
                return True
        return False

    def is_enchantment_spell(self):
        enchantment_effects = [SpellEffects.SPELL_EFFECT_ENCHANT_ITEM_PERMANENT,
                               SpellEffects.SPELL_EFFECT_ENCHANT_ITEM_TEMPORARY]
        return any(effect.effect_type in enchantment_effects for effect in self.get_effects())

    def is_temporary_enchant_spell(self):
        return any(effect.effect_type == SpellEffects.SPELL_EFFECT_ENCHANT_ITEM_TEMPORARY
                   for effect in self.get_effects())

    def is_duel_spell(self):
        return any(effect.effect_type == SpellEffects.SPELL_EFFECT_DUEL
                   for effect in self.get_effects())

    def is_unlocking_spell(self):
        unlock_effects = [SpellEffects.SPELL_EFFECT_OPEN_LOCK, SpellEffects.SPELL_EFFECT_OPEN_LOCK_ITEM]
        return any(effect.effect_type in unlock_effects for effect in self.get_effects())

    def get_lock_effect(self):
        unlock_effects = [SpellEffects.SPELL_EFFECT_OPEN_LOCK, SpellEffects.SPELL_EFFECT_OPEN_LOCK_ITEM]
        for effect in self.get_effects():
            if effect.effect_type in unlock_effects:
                return effect

    def is_pickpocket_spell(self):
        return any(effect.effect_type == SpellEffects.SPELL_EFFECT_PICKPOCKET for effect in self.get_effects())

    def is_refreshment_spell(self):
        spell_effect = self._effects[0]  # Food/drink effect should be first.
        if not spell_effect:
            return False

        # Food/drink spells aren't labeled,
        # but they need to be distinguished from other regeneration spells.
        # All food spells have a period of 3000 and are castable while sitting.
        # No other spells in 0.5.3 match this condition.

        has_refreshment_period = spell_effect.aura_period == 3000
        has_sitting_attribute = self.spell_entry.Attributes & SpellAttributes.SPELL_ATTR_CASTABLE_WHILE_SITTING
        is_regen_buff = spell_effect.aura_type == AuraTypes.SPELL_AURA_PERIODIC_HEAL or \
            spell_effect.aura_type == AuraTypes.SPELL_AURA_PERIODIC_ENERGIZE

        return has_sitting_attribute and is_regen_buff and has_refreshment_period

    def is_overpower(self):
        return self.spell_entry.AttributesEx & SpellAttributesEx.SPELL_ATTR_EX_ENABLE_AT_DODGE

    def has_effect_of_type(self, effect_type: SpellEffects):
        for effect in self.get_effects():
            if effect.effect_type == effect_type:
                return True
        return False

    def get_effect_by_type(self, effect_type: SpellEffects) -> Optional[SpellEffect]:
        for effect in self.get_effects():
            if effect.effect_type == effect_type:
                return effect
        return None

    def trigger_cooldown_on_aura_remove(self):
        return self.spell_entry.Attributes & SpellAttributes.SPELL_ATTR_DISABLED_WHILE_ACTIVE == SpellAttributes.SPELL_ATTR_DISABLED_WHILE_ACTIVE

    def casts_on_swing(self):
        return self.spell_entry.Attributes & SpellAttributes.SPELL_ATTR_ON_NEXT_SWING_1 == SpellAttributes.SPELL_ATTR_ON_NEXT_SWING_1

    def casts_on_ranged_attack(self):
        # Quick Shot has a negative base cast time (-1000000), which will resolve to 0 in get_base_cast_time().
        # Ranged attacks occurring on next ranged have a base cast time of 0.
        if not self.cast_time_entry or self.cast_time_entry.Base < 0:
            return False  # No entry or Quick Shot.

        # All instant ranged attacks are by default next ranged.
        return self.is_ranged_weapon_attack() and self.cast_time_entry.Base == 0

    def is_ranged_weapon_attack(self):
        if self.spell_entry.EquippedItemClass != ItemClasses.ITEM_CLASS_WEAPON:
            return False

        ranged_mask = (1 << ItemSubClasses.ITEM_SUBCLASS_BOW) | \
                      (1 << ItemSubClasses.ITEM_SUBCLASS_GUN) | \
                      (1 << ItemSubClasses.ITEM_SUBCLASS_THROWN) | \
                      (1 << ItemSubClasses.ITEM_SUBCLASS_CROSSBOW) | \
                      (1 << ItemSubClasses.ITEM_SUBCLASS_WAND)

        return self.spell_entry.EquippedItemSubclass & ranged_mask != 0

    def requires_fishing_pole(self):
        if self.spell_entry.EquippedItemClass != ItemClasses.ITEM_CLASS_WEAPON:
            return False

        return self.spell_entry.EquippedItemSubclass & (1 << ItemSubClasses.ITEM_SUBCLASS_FISHING_POLE) != 0

    def requires_combo_points(self):
        cp_att = SpellAttributesEx.SPELL_ATTR_EX_REQ_TARGET_COMBO_POINTS | SpellAttributesEx.SPELL_ATTR_EX_REQ_COMBO_POINTS
        return self.spell_caster.get_type_id() == ObjectTypeIds.ID_PLAYER and \
            self.spell_entry.AttributesEx & cp_att != 0

    def calculate_effective_level(self, level):
        if level > self.spell_entry.MaxLevel > 0:
            level = self.spell_entry.MaxLevel
        elif level < self.spell_entry.BaseLevel:
            level = self.spell_entry.BaseLevel
        return max(level - self.spell_entry.SpellLevel, 0)

    def get_base_cast_time(self):
        if self.is_instant_cast():
            return 0

        skill = 0
        if self.spell_caster.get_type_id() == ObjectTypeIds.ID_PLAYER:
            skill = self.spell_caster.skill_manager.get_skill_value_for_spell_id(self.spell_entry.ID)

        cast_time = int(max(self.cast_time_entry.Minimum, self.cast_time_entry.Base + self.cast_time_entry.PerLevel * skill))

        if self.is_ranged_weapon_attack() and self.spell_caster.object_type_mask & ObjectTypeFlags.TYPE_UNIT:
            # Ranged attack tooltips are unfinished, so this is partially a guess.
            # All ranged attacks without delay seem to say "next ranged".
            # Ranged attacks with delay (cast time) say "attack speed + X (delay) sec".
            ranged_delay = self.spell_caster.stat_manager.get_total_stat(UnitStats.RANGED_DELAY)
            cast_time += ranged_delay

        return max(0, cast_time)

    def get_resource_cost(self):
        mana_cost = self.spell_entry.ManaCost
        power_cost_mod = 0

        if self.spell_caster.get_type_id() == ObjectTypeIds.ID_PLAYER and self.spell_entry.ManaCostPct != 0:
            mana_cost = self.spell_caster.base_mana * self.spell_entry.ManaCostPct / 100

        if self.spell_caster.get_type_id() == ObjectTypeIds.ID_PLAYER:
            mana_cost = self.spell_caster.stat_manager.apply_bonuses_for_value(mana_cost, UnitStats.SCHOOL_POWER_COST,
                                                                               misc_value=self.spell_entry.School)
        # ManaCostPerLevel is not used by anything relevant, ignore for now (only 271/4513/7290) TODO

        return mana_cost + power_cost_mod

    def get_cast_damage_info(self, attacker, victim, damage, absorb):
        damage_info = DamageInfoHolder()

        if not victim:
            return None

        damage_info.attacker = attacker
        damage_info.target = victim
        damage_info.attack_type = self.spell_attack_type if self.spell_attack_type != -1 else 0

        damage_info.damage += damage
        damage_info.damage_school_mask = self.spell_entry.School
        # Not taking "subdamages" into account
        damage_info.total_damage = max(0, damage - absorb)
        damage_info.absorb = absorb
        damage_info.hit_info = HitInfo.DAMAGE

        return damage_info

    def load_effects(self):
        # Some spells have undefined effects (ie. effect type = 0) before defined effects.
        # Use a fixed-length list to avoid indexing issues caused by invalid effects.
        self._effects = [None, None, None]
        effect_ids = [self.spell_entry.Effect_1, self.spell_entry.Effect_2, self.spell_entry.Effect_3]
        for i in range(3):
            if not effect_ids[i]:
                continue
            self._effects[i] = SpellEffect(self, i)

    def get_effects(self):
        # Some spells have missing effects (see load_effects) - only return loaded ones.
        return [effect for effect in self._effects if effect is not None]

    def get_reagents(self):
        return (self.spell_entry.Reagent_1, self.spell_entry.ReagentCount_1), (self.spell_entry.Reagent_2, self.spell_entry.ReagentCount_2), \
               (self.spell_entry.Reagent_3, self.spell_entry.ReagentCount_3), (self.spell_entry.Reagent_4, self.spell_entry.ReagentCount_4), \
               (self.spell_entry.Reagent_5, self.spell_entry.ReagentCount_5), (self.spell_entry.Reagent_6, self.spell_entry.ReagentCount_6), \
               (self.spell_entry.Reagent_7, self.spell_entry.ReagentCount_7), (self.spell_entry.Reagent_8, self.spell_entry.ReagentCount_8)

    def get_item_spell_stats(self) -> Optional[SpellStat]:
        if not self.source_item:
            return None
        for spell_info in self.source_item.spell_stats:
            if spell_info.spell_id == self.spell_entry.ID:
                return spell_info
        return None

    def get_required_tools(self):
        return [self.spell_entry.Totem_1, self.spell_entry.Totem_2]

    def get_conjured_items(self):
        conjured_items = []
        for effect in self.get_effects():
            item_count = abs(effect.get_effect_points())
            conjured_items.append([effect.item_type, item_count])
        return tuple(conjured_items)

    def handle_partial_interrupt(self):
        if not self.spell_entry.InterruptFlags & SpellInterruptFlags.SPELL_INTERRUPT_FLAG_PARTIAL:
            return

        # TODO Did pushback resistance exist?
        curr_time = time.time()
        remaining_cast_before_pushback = self.cast_end_timestamp - curr_time

        if self.is_channeled() and self.cast_state == SpellState.SPELL_STATE_ACTIVE:
            channel_length = self.duration_entry.Duration/1000  # /1000 for seconds.
            final_opcode = OpCode.MSG_CHANNEL_UPDATE
            pushback_length_sec = min(remaining_cast_before_pushback, channel_length * 0.25)
            for effect in self.get_effects():
                if remaining_cast_before_pushback <= pushback_length_sec:
                    # Applied aura duration is not timestamp based so it's stored in milliseconds.
                    # To avoid rounding issues, set to zero instead of subtracting if pushback leads to channel stop.
                    effect.applied_aura_duration = 0
                else:
                    effect.applied_aura_duration -= pushback_length_sec * 1000  # aura duration is stored as millis.
                effect.remove_old_periodic_effect_ticks()

            self.cast_end_timestamp -= pushback_length_sec
            data = pack('<I', int((remaining_cast_before_pushback - pushback_length_sec)*1000))  # *1000 for millis.

        elif self.cast_state == SpellState.SPELL_STATE_CASTING:
            final_opcode = OpCode.SMSG_SPELL_DELAYED
            cast_progress_seconds = self.get_base_cast_time()/1000 - remaining_cast_before_pushback  # base cast time in seconds.
            pushback_length_sec = min(cast_progress_seconds, 0.5)  # Push back 0.5s or to beginning of cast.

            self.cast_end_timestamp += pushback_length_sec
            data = pack('<QI', self.spell_caster.guid, int(pushback_length_sec * 1000))  # *1000 for millis.
        else:
            return

        MapManager.send_surrounding(PacketWriter.get_packet(final_opcode, data), self.spell_caster,
                                    include_self=self.spell_caster.get_type_id() == ObjectTypeIds.ID_PLAYER)
