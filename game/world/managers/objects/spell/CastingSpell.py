import time
from struct import pack
from typing import Optional

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.dbc.DbcModels import Spell, SpellRange, SpellDuration, SpellCastTimes
from game.world.managers.abstractions.Vector import Vector
from game.world.managers.maps.MapManager import MapManager
from game.world.managers.objects.ObjectManager import ObjectManager
from game.world.managers.objects.item.ItemManager import ItemManager
from game.world.managers.objects.units.DamageInfoHolder import DamageInfoHolder
from game.world.managers.objects.units.player.StatManager import UnitStats
from game.world.managers.objects.spell.SpellEffect import SpellEffect
from network.packet.PacketWriter import PacketWriter
from utils.constants.ItemCodes import ItemClasses, ItemSubClasses
from utils.constants.MiscCodes import ObjectTypeFlags, AttackTypes, HitInfo, ObjectTypeIds
from utils.constants.OpCodes import OpCode
from utils.constants.SpellCodes import SpellState, SpellCastFlags, SpellTargetMask, SpellAttributes, SpellAttributesEx, \
    AuraTypes, SpellEffects, SpellInterruptFlags


class CastingSpell(object):
    spell_entry: Spell
    cast_state: SpellState
    cast_flags: SpellCastFlags  # TODO Write proc flag when needed
    spell_caster = None
    source_item = None
    initial_target = None
    targeted_unit_on_cast_start = None

    object_target_results = {}  # Assigned on cast - contains guids and results on successful hits/misses/blocks etc.
    spell_target_mask: SpellTargetMask
    range_entry: SpellRange
    duration_entry: SpellDuration
    cast_time_entry: SpellCastTimes
    effects: list

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
            self.targeted_unit_on_cast_start = MapManager.get_surrounding_unit_by_guid(
                self.spell_caster, self.spell_caster.current_selection, include_players=True)

        self.load_effects()

        self.cast_flags = SpellCastFlags.CAST_FLAG_NONE

        # Ammo needs to be resolved on initialization since it's needed for validation and spell cast packets.
        self.used_ranged_attack_item = self.get_ammo_for_cast()
        if self.used_ranged_attack_item:
            self.cast_flags |= SpellCastFlags.CAST_FLAG_HAS_AMMO

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
        for effect in self.effects:
            self.resolve_target_info_for_effect(effect.effect_index)

    # noinspection PyUnresolvedReferences
    def resolve_target_info_for_effect(self, index):
        if index < 0 or index > len(self.effects) - 1:
            return
        effect = self.effects[index]
        if not effect:
            return

        effect.targets.resolve_targets()
        effect_info = effect.targets.get_effect_target_miss_results()
        self.object_target_results = {**self.object_target_results, **effect_info}

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
        return not (self.spell_entry.AttributesEx & SpellAttributesEx.SPELL_ATTR_EX_NO_THREAT)

    def is_refreshment_spell(self):
        if len(self.effects) == 0:
            return False
        spell_effect = self.effects[0]  # Food/drink effect should be first
        has_sitting_attribute = self.spell_entry.Attributes & SpellAttributes.SPELL_ATTR_CASTABLE_WHILE_SITTING
        is_regen_buff = spell_effect.aura_type == AuraTypes.SPELL_AURA_PERIODIC_HEAL or \
            spell_effect.aura_type == AuraTypes.SPELL_AURA_PERIODIC_ENERGIZE

        return has_sitting_attribute and is_regen_buff

    def has_effect_of_type(self, effect_type: SpellEffects):
        for effect in self.effects:
            if effect.effect_type == effect_type:
                return True
        return False

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
                      (1 << ItemSubClasses.ITEM_SUBCLASS_CROSSBOW)

        return self.spell_entry.EquippedItemSubclass & ranged_mask != 0

    def requires_combo_points(self):
        cp_att = SpellAttributesEx.SPELL_ATTR_EX_REQ_TARGET_COMBO_POINTS | SpellAttributesEx.SPELL_ATTR_EX_REQ_COMBO_POINTS
        return self.spell_caster.get_type_id() == ObjectTypeIds.ID_PLAYER and \
               self.spell_entry.AttributesEx & cp_att != 0

    def requires_hostile_target(self):
        for effect in self.effects:
            if not effect.targets.can_target_friendly():
                return True
        return False

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
        self.effects = []
        if self.spell_entry.Effect_1 != 0:
            self.effects.append(SpellEffect(self, len(self.effects)))
        if self.spell_entry.Effect_2 != 0:
            self.effects.append(SpellEffect(self, len(self.effects)))
        if self.spell_entry.Effect_3 != 0:
            self.effects.append(SpellEffect(self, len(self.effects)))  # Use effects length for index - some spells (by mistake?) have empty effect slots before an actual effect

    def get_reagents(self):
        return (self.spell_entry.Reagent_1, self.spell_entry.ReagentCount_1), (self.spell_entry.Reagent_2, self.spell_entry.ReagentCount_2), \
               (self.spell_entry.Reagent_3, self.spell_entry.ReagentCount_3), (self.spell_entry.Reagent_4, self.spell_entry.ReagentCount_4), \
               (self.spell_entry.Reagent_5, self.spell_entry.ReagentCount_5), (self.spell_entry.Reagent_6, self.spell_entry.ReagentCount_6), \
               (self.spell_entry.Reagent_7, self.spell_entry.ReagentCount_7), (self.spell_entry.Reagent_8, self.spell_entry.ReagentCount_8)

    def get_item_spell_stats(self) -> Optional[ItemManager.SpellStat]:
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
        for effect in self.effects:
            item_count = abs(effect.get_effect_points(self.caster_effective_level))
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
            for effect in self.effects:
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
