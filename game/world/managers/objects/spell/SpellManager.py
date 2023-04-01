import math
import time
from random import randint
from struct import pack
from typing import Optional

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.dbc.DbcModels import Spell
from database.realm.RealmDatabaseManager import RealmDatabaseManager, CharacterSpell
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.WorldSessionStateHandler import WorldSessionStateHandler
from game.world.managers.abstractions.Vector import Vector
from game.world.managers.maps.MapManager import MapManager
from game.world.managers.objects.ObjectManager import ObjectManager
from game.world.managers.objects.locks.LockManager import LockManager
from game.world.managers.objects.spell import ExtendedSpellData
from game.world.managers.objects.spell.CastingSpell import CastingSpell
from game.world.managers.objects.spell.CooldownEntry import CooldownEntry
from game.world.managers.objects.spell.SpellEffectHandler import SpellEffectHandler
from game.world.managers.objects.units.DamageInfoHolder import DamageInfoHolder
from game.world.managers.objects.units.player.EnchantmentManager import EnchantmentManager
from network.packet.PacketWriter import PacketWriter, OpCode
from utils.Logger import Logger
from utils.constants.ItemCodes import InventoryError, ItemSubClasses, ItemClasses, ItemDynFlags
from utils.constants.MiscCodes import ObjectTypeFlags, HitInfo, GameObjectTypes, AttackTypes, ObjectTypeIds, ProcFlags
from utils.constants.MiscFlags import GameObjectFlags
from utils.constants.SpellCodes import SpellCheckCastResult, SpellCastStatus, \
    SpellMissReason, SpellTargetMask, SpellState, SpellAttributes, SpellCastFlags, \
    SpellInterruptFlags, SpellChannelInterruptFlags, SpellAttributesEx, SpellEffects, SpellHitFlags, SpellSchools
from utils.constants.UnitCodes import PowerTypes, StandState, WeaponMode, Classes, UnitStates, UnitFlags


class SpellManager:
    def __init__(self, caster):
        self.caster = caster  # GameObject, Unit or Player.
        self.spells: dict[int, CharacterSpell] = {}
        self.cooldowns: dict[int, CooldownEntry] = {}
        self.casting_spells: list[CastingSpell] = []

    def load_spells(self):
        for spell in RealmDatabaseManager.character_get_spells(self.caster.guid):
            self.spells[spell.spell] = spell

    def can_learn_spell(self, spell_id):
        if self.caster.get_type_id() != ObjectTypeIds.ID_PLAYER:
            return False

        spell = DbcDatabaseManager.SpellHolder.spell_get_by_id(spell_id)
        if not spell:
            return False

        if spell_id in self.spells:
            return False

        # If a profession spell is learned for this spell, check if we can actually add that skill.
        related_profession_skill = ExtendedSpellData.ProfessionInfo.get_profession_skill_id_for_spell(spell_id)
        if related_profession_skill and not self.caster.skill_manager.has_skill(related_profession_skill) and \
                self.caster.skill_manager.has_reached_skills_limit():
            return False

        character_skill, skill, skill_line_ability = self.caster.skill_manager.get_skill_info_for_spell_id(spell_id)
        # Character does not have the skill, but it is a valid skill, check if we can add that skill.
        if not character_skill and skill and not self.caster.skill_manager.has_skill(skill.ID) and \
                self.caster.skill_manager.has_reached_skills_limit():
            return False

        return True

    def learn_spell(self, spell_id, cast_on_learn=False) -> bool:
        if not self.can_learn_spell(spell_id):
            return False

        spell = DbcDatabaseManager.SpellHolder.spell_get_by_id(spell_id)
        if not spell:
            return False

        # If a profession spell is learned, grant the required skill.
        related_profession_skill = ExtendedSpellData.ProfessionInfo.get_profession_skill_id_for_spell(spell_id)
        if related_profession_skill and not self.caster.skill_manager.has_skill(related_profession_skill):
            if not self.caster.skill_manager.add_skill(related_profession_skill):
                return False
        # If the player already knows the skill, update max skill level.
        elif related_profession_skill:
            self.caster.skill_manager.update_skills_max_value()

        character_skill, skill, skill_line_ability = self.caster.skill_manager.get_skill_info_for_spell_id(spell_id)
        # Character does not have the skill, but it is a valid skill.
        if not character_skill and skill and not self.caster.skill_manager.has_skill(skill.ID):
            if not self.caster.skill_manager.add_skill(skill.ID):
                return False

        # Check if this skill requires a 'cast ui' spell. e.g. Poisons frame.
        if skill and spell.Effect_1 != SpellEffects.SPELL_EFFECT_SPELL_CAST_UI:
            cast_ui_spells = self.caster.skill_manager.get_cast_ui_spells_for_skill_id(skill.ID)
            # Player doesn't have any cast UI for this spell yet.
            if cast_ui_spells and not self.spells.keys() & cast_ui_spells:
                # Get cast UI with lowest spell ID (lowest rank where applicable).
                cast_ui_spell = min(cast_ui_spells)
                if self.can_learn_spell(cast_ui_spell):
                    self.learn_spell(cast_ui_spell)

        db_spell = CharacterSpell()
        db_spell.guid = self.caster.guid
        db_spell.spell = spell_id
        RealmDatabaseManager.character_add_spell(db_spell)
        self.spells[spell_id] = db_spell

        # If this spell was preceded, handle spell supersede.
        # Some spells allow for multiple rank holding, others do not.
        should_learn = True
        preceded_by_spell = DbcDatabaseManager.SkillLineAbilityHolder.skill_line_abilities_get_preceded_by_spell(spell_id)
        if preceded_by_spell and self.unlearn_spell(preceded_by_spell.Spell, new_spell_id=spell_id):
            should_learn = False

        # It's not preceded by a known spell, should learn as new.
        if should_learn:
            data = pack('<H', spell_id)
            self.caster.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_LEARNED_SPELL, data))

        if cast_on_learn or spell.AttributesEx & SpellAttributesEx.SPELL_ATTR_EX_CAST_WHEN_LEARNED:
            self.start_spell_cast(spell, self.caster, SpellTargetMask.SELF)

        # Apply passive effects when they're learned. This will also apply talents on learn.
        # Shapeshift passives are only updated on shapeshift change.
        if spell.Attributes & SpellAttributes.SPELL_ATTR_PASSIVE and not spell.ShapeshiftMask:
            self.apply_passive_spell_effects(spell)

        return True

    def unlearn_spell(self, spell_id, new_spell_id=0) -> bool:
        if self.caster.get_type_id() == ObjectTypeIds.ID_PLAYER and spell_id in self.spells:
            if new_spell_id:
                self.spells[spell_id].active = 0
                RealmDatabaseManager.character_update_spell(self.spells[spell_id])
            else:
                if RealmDatabaseManager.character_delete_spell(self.caster.guid, spell_id) == 0:
                    del self.spells[spell_id]

            self.remove_cast_by_id(spell_id)
            self.supersede_spell(spell_id, new_spell_id)
            return True
        return False

    # Replaces a given spell with another (Updates action bars and SpellBook), deletes if new spell is 0.
    def supersede_spell(self, old_spell_id, new_spell_id):
        data = pack('<2H', old_spell_id, new_spell_id)
        packet = PacketWriter.get_packet(OpCode.SMSG_SUPERCEDED_SPELL, data)
        self.caster.enqueue_packet(packet)

    def cast_passive_spells(self):
        # Self-cast all passive spells. This will apply learned skills, proficiencies, talents etc.
        for spell_id in self.spells.keys():
            # Skip inactive spells.
            if not self.spells[spell_id].active:
                continue
            spell_template = DbcDatabaseManager.SpellHolder.spell_get_by_id(spell_id)

            # Shapeshift passives are only applied on shapeshift change.
            if spell_template.ShapeshiftMask:
                continue

            if spell_template and spell_template.Attributes & SpellAttributes.SPELL_ATTR_PASSIVE:
                self.apply_passive_spell_effects(spell_template)

    def apply_cast_when_learned_spells(self):
        # Cast any spell with SPELL_ATTR_EX_CAST_WHEN_LEARNED flag on player.
        for spell_id in self.spells.keys():
            # Skip inactive spells.
            if not self.spells[spell_id].active:
                continue
            spell_template = DbcDatabaseManager.SpellHolder.spell_get_by_id(spell_id)
            if spell_template and spell_template.AttributesEx & SpellAttributesEx.SPELL_ATTR_EX_CAST_WHEN_LEARNED:
                self.start_spell_cast(spell_template, self.caster, SpellTargetMask.SELF)

    def apply_passive_spell_effects(self, spell_template):
        if not spell_template.Attributes & SpellAttributes.SPELL_ATTR_PASSIVE:
            return

        spell = self.try_initialize_spell(spell_template, self.caster, SpellTargetMask.SELF,
                                          validate=False)

        # Don't use actual target resolvers since the caster may not be fully initialized yet.
        for effect in spell.get_effects():
            effect.targets.resolved_targets_a = [self.caster]
            if not spell.object_target_results:
                spell.object_target_results = effect.targets.get_effect_target_miss_results()

        self.apply_spell_effects(spell)

        # Add any passive area auras to casts.
        if spell.cast_state == SpellState.SPELL_STATE_ACTIVE:
            self.casting_spells.append(spell)

    def get_initial_spells(self) -> bytes:
        spell_buttons = RealmDatabaseManager.character_get_spell_buttons(self.caster.guid)

        data = pack('<BH', 0, len(self.spells))
        for spell_id, spell in self.spells.items():
            index = spell_buttons[spell.spell] if spell.spell in spell_buttons else 0
            data += pack('<2h', spell.spell, index)
        data += pack('<H', 0)

        return PacketWriter.get_packet(OpCode.SMSG_INITIAL_SPELLS, data)

    def handle_equipment_change(self):
        casting_spell = self.get_casting_spell()
        if not casting_spell:
            return

        # No required item.
        if casting_spell.spell_entry.EquippedItemClass == -1:
            return

        attack_type = AttackTypes.RANGED_ATTACK if casting_spell.is_ranged_weapon_attack() else AttackTypes.BASE_ATTACK
        weapon = self.caster.get_current_weapon_for_attack_type(attack_type)
        # No weapon and spell requires it, interrupt.
        if not weapon:
            self.interrupt_casting_spell()
            return

        # Check if the current weapon satisfies spell requirements.
        required_item_class = casting_spell.spell_entry.EquippedItemClass
        required_item_subclass = casting_spell.spell_entry.EquippedItemSubclass
        item_class = weapon.item_template.class_
        item_subclass_mask = 1 << weapon.item_template.subclass
        if required_item_class != item_class or not required_item_subclass & item_subclass_mask:
            self.interrupt_casting_spell()

    def handle_item_cast_attempt(self, item, spell_target, target_mask):
        if not self.caster.get_type_mask() & ObjectTypeFlags.TYPE_UNIT:
            return

        for spell_info in item.spell_stats:
            if spell_info.spell_id == 0:
                break
            spell = DbcDatabaseManager.SpellHolder.spell_get_by_id(spell_info.spell_id)
            if not spell:
                Logger.warning(f'Spell {spell_info.spell_id} tied to item {item.item_template.entry} '
                               f'({item.get_name()}) could not be found in the spell database.')
                continue

            casting_spell = self.try_initialize_spell(spell, spell_target, target_mask, item)
            if not casting_spell:
                continue

            if casting_spell.is_refreshment_spell():  # Food/drink items don't send sit packet - handle here.
                self.caster.set_stand_state(StandState.UNIT_SITTING)

            self.start_spell_cast(initialized_spell=casting_spell)

    def handle_cast_attempt(self, spell_id, spell_target, target_mask, triggered=False, validate=True):
        spell = DbcDatabaseManager.SpellHolder.spell_get_by_id(spell_id)
        if not spell or not spell_target:
            return

        if not validate:
            initialized_spell = self.try_initialize_spell(spell, spell_target, target_mask,
                                                          triggered=triggered, validate=validate)
            self.start_spell_cast(initialized_spell=initialized_spell)
            return

        self.start_spell_cast(spell, spell_target, target_mask, triggered=triggered)

    def try_initialize_spell(self, spell: Spell, spell_target, target_mask, source_item=None,
                             triggered=False, triggered_by_spell=None,
                             validate=True, creature_spell=None) -> Optional[CastingSpell]:
        spell = CastingSpell(spell, self.caster, spell_target, target_mask, source_item,
                             triggered=triggered, triggered_by_spell=triggered_by_spell,
                             creature_spell=creature_spell)
        if not validate:
            return spell
        return spell if self.validate_cast(spell) else None

    def start_spell_cast(self, spell: Optional[Spell] = None, spell_target=None, target_mask=SpellTargetMask.SELF,
                         source_item=None, triggered=False, initialized_spell: Optional[CastingSpell]=None):
        casting_spell = self.try_initialize_spell(spell, spell_target, target_mask, source_item, triggered=triggered) \
            if not initialized_spell else initialized_spell

        if not casting_spell:
            return

        if not casting_spell.triggered:
            self.remove_colliding_casts(casting_spell)
        else:
            casting_spell.cast_flags |= SpellCastFlags.CAST_FLAG_PROC

        casting_spell.cast_start_timestamp = time.time()

        if casting_spell.casts_on_swing():  # Handle swing ability queue and state
            casting_spell.cast_state = SpellState.SPELL_STATE_DELAYED  # Wait for next swing
            self.casting_spells.append(casting_spell)
            return

        self.casting_spells.append(casting_spell)
        casting_spell.cast_state = SpellState.SPELL_STATE_CASTING

        if self.caster.get_type_mask() & ObjectTypeFlags.TYPE_UNIT:
            # If the spell uses a ranged weapon, draw it if needed.
            if casting_spell.is_ranged_weapon_attack():
                self.caster.set_weapon_mode(WeaponMode.RANGEDMODE)
            # Need to make sure creatures go back to melee if needed.
            elif self.caster.get_type_id() == ObjectTypeIds.ID_UNIT:
                self.caster.set_weapon_mode(WeaponMode.NORMALMODE)

            # If the spell uses a fishing pole, draw it if needed.
            if casting_spell.requires_fishing_pole():
                self.caster.set_weapon_mode(WeaponMode.NORMALMODE)

        if not casting_spell.is_instant_cast():
            if not casting_spell.triggered:
                self.send_cast_start(casting_spell)
            return

        # Spell is instant, perform cast
        self.perform_spell_cast(casting_spell, validate=False)

    def perform_spell_cast(self, casting_spell: CastingSpell, validate=True):
        if validate and not self.validate_cast(casting_spell):
            self.remove_cast(casting_spell)
            return

        casting_spell.resolve_target_info_for_effects()

        # Reset mana regen timer on cast perform.
        # Regen update will handle regen timer resets if a spell is casting,
        # but instants reach perform without update.
        if not casting_spell.triggered:
            self.caster.mana_regen_timer = 0

        if casting_spell.cast_state == SpellState.SPELL_STATE_DELAYED:
            return  # Spell is in delayed state, do nothing for now

        self.send_cast_result(casting_spell, SpellCheckCastResult.SPELL_NO_ERROR)
        self.send_spell_go(casting_spell)

        if casting_spell.requires_combo_points():
            # Combo points will be reset by consume_resources_for_cast.
            casting_spell.spent_combo_points = self.caster.combo_points

        if self.caster.get_type_mask() & ObjectTypeFlags.TYPE_UNIT and \
                not casting_spell.triggered:  # Triggered spells (ie. channel ticks) shouldn't interrupt other casts.
            self.caster.aura_manager.check_aura_interrupts(cast_spell=casting_spell)

        self.set_on_cooldown(casting_spell)
        self.consume_resources_for_cast(casting_spell)

        travel_times = self.calculate_impact_delays(casting_spell)

        if len(travel_times) != 0:
            casting_spell.spell_impact_timestamps = {}
            curr_time = time.time()

            for guid, delay in travel_times.items():
                casting_spell.spell_impact_timestamps[guid] = curr_time + delay

            casting_spell.cast_state = SpellState.SPELL_STATE_DELAYED
            return

        if casting_spell.is_channeled() and not casting_spell.is_target_immune_to_effects():
            # Channeled spells require more setup before effect application.
            # If the target is immune, no channel needs to be started and the spell can be resolved normally.
            self.handle_channel_start(casting_spell)
        else:
            casting_spell.cast_state = SpellState.SPELL_STATE_FINISHED
            self.apply_spell_effects(casting_spell)  # Apply effects
            # Some spell effect handlers will set the spell state to active as the handler needs to be called on updates
            if casting_spell.cast_state != SpellState.SPELL_STATE_ACTIVE:
                self.remove_cast(casting_spell)

    def apply_spell_effects(self, casting_spell: CastingSpell, remove=False, update=False, update_index=-1,
                            partial_targets: Optional[list[int]] = None):
        if not update and not casting_spell.is_passive() and not casting_spell.is_target_immune_to_effects():
            self.handle_procs_for_cast(casting_spell)

            # Handle related skill gain.
            if self.caster.get_type_mask() & ObjectTypeFlags.TYPE_UNIT:
                self.caster.handle_spell_cast_skill_gain(casting_spell)

        for effect in casting_spell.get_effects():
            if update and update_index != effect.effect_index:
                continue

            object_targets = effect.targets.get_resolved_effect_targets_by_type(ObjectManager)

            if not update:
                effect.start_aura_duration()

            if effect.effect_type in SpellEffectHandler.AREA_SPELL_EFFECTS:
                SpellEffectHandler.apply_effect(casting_spell, effect, casting_spell.spell_caster, None)
                continue

            if effect.is_full_miss():
                # Don't apply following effects if the previous one results in a full miss.
                [target.threat_manager.add_threat(casting_spell.spell_caster) for target in object_targets]
                remove = True
                break

            for target in object_targets:
                if partial_targets and target.guid not in partial_targets:
                    continue
                if target.guid not in casting_spell.object_target_results:
                    continue
                info = casting_spell.object_target_results[target.guid]

                spell_target = target
                spell_caster = casting_spell.spell_caster
                # Swap target/caster on reflect. TODO actual reflect handling - this flag is never set.
                if info.flags & SpellHitFlags.REFLECTED:
                    spell_target = casting_spell.spell_caster
                    spell_caster = target

                if info.result == SpellMissReason.MISS_REASON_NONE:
                    SpellEffectHandler.apply_effect(casting_spell, effect, spell_caster, spell_target)
                elif target.get_type_id() == ObjectTypeIds.ID_UNIT and casting_spell.generates_threat() and \
                        casting_spell.spell_caster.can_attack_target(target):  # Add threat for failed hostile casts.
                    target.threat_manager.add_threat(casting_spell.spell_caster)

            if len(object_targets) > 0:
                continue  # Prefer unit target for handling (don't attempt to resolve other target types for one effect if unit targets aren't empty)

            for target in effect.targets.get_resolved_effect_targets_by_type(Vector):
                SpellEffectHandler.apply_effect(casting_spell, effect, casting_spell.spell_caster, target)

        if remove:
            self.remove_cast(casting_spell)

    # noinspection PyMethodMayBeStatic
    def handle_procs_for_cast(self, casting_spell):
        applied_targets = []
        for effect in casting_spell.get_effects():
            for target in effect.targets.get_resolved_effect_targets_by_type(ObjectManager):
                if target.guid in applied_targets:
                    continue

                target_info = casting_spell.object_target_results[target.guid]
                damage_info = None
                if target_info.result != SpellMissReason.MISS_REASON_NONE:
                    # Pass damage info with proc flags for handling dodge/parry/block procs off spells.
                    proc_flags = {
                        SpellMissReason.MISS_REASON_DODGED: ProcFlags.DODGE,
                        SpellMissReason.MISS_REASON_PARRIED: ProcFlags.PARRY,
                        SpellMissReason.MISS_REASON_BLOCKED: ProcFlags.BLOCK
                    }
                    damage_info = DamageInfoHolder(attacker=casting_spell.spell_caster, target=target,
                                                   proc_victim=proc_flags.get(target_info.result, 0))

                for proc_target in (target, casting_spell.spell_caster):
                    if proc_target.get_type_mask() & ObjectTypeFlags.TYPE_UNIT:
                        proc_target.aura_manager.check_aura_procs(involved_cast=casting_spell,
                                                             damage_info=damage_info)
                applied_targets.append(target.guid)

    def handle_damage_event_procs(self, damage_info: DamageInfoHolder):
        # Only handling Overpower procs here for now.
        if self.caster is not damage_info.attacker or self.caster.class_ != Classes.CLASS_WARRIOR:
            return

        if any([damage_info.proc_victim & overpower_trigger for overpower_trigger in
                [ProcFlags.DODGE, ProcFlags.PARRY, ProcFlags.BLOCK]]):
            self.caster.add_combo_points_on_target(damage_info.target, 1, hide=True)

    def cast_queued_melee_ability(self, attack_type) -> bool:
        melee_ability = self.get_queued_melee_ability()

        if not melee_ability or not self.validate_cast(melee_ability):
            self.remove_cast(melee_ability)
            return False

        melee_ability.spell_attack_type = attack_type

        melee_ability.cast_state = SpellState.SPELL_STATE_CASTING
        self.perform_spell_cast(melee_ability, validate=False)
        return True

    def get_queued_melee_ability(self) -> Optional[CastingSpell]:
        for casting_spell in self.casting_spells:
            if not casting_spell.casts_on_swing() or \
                    casting_spell.cast_state != SpellState.SPELL_STATE_DELAYED:
                continue
            return casting_spell
        return None

    def update(self, timestamp):
        self.check_spell_cooldowns()
        for casting_spell in list(self.casting_spells):
            # Queued spells cast on swing will be updated on call from attack handling.
            if casting_spell.cast_state == SpellState.SPELL_STATE_DELAYED and \
                    casting_spell.casts_on_swing():
                continue

            cast_finished = casting_spell.cast_end_timestamp <= timestamp and casting_spell.cast_end_timestamp != -1
            # Channel tick/spells that need updates.
            if casting_spell.cast_state == SpellState.SPELL_STATE_ACTIVE:
                # Active spells can either finish because of the associated channel ending or
                # because of their effects' duration.
                cast_finished = self.handle_area_spell_effect_update(casting_spell, timestamp) or \
                                (casting_spell.is_channeled() and cast_finished)
                if cast_finished:
                    self.remove_cast(casting_spell)
                continue

            if casting_spell.cast_state == SpellState.SPELL_STATE_CASTING and not casting_spell.is_instant_cast():
                if cast_finished:
                    self.perform_spell_cast(casting_spell)
                    # Spell finished after perform (no impact delay).
                    if casting_spell.cast_state == SpellState.SPELL_STATE_FINISHED:
                        self.remove_cast(casting_spell)

            # Waiting for impact delay.
            if casting_spell.cast_state == SpellState.SPELL_STATE_DELAYED:
                targets_due = [guid for guid, stamp
                               in casting_spell.spell_impact_timestamps.items()
                               if stamp <= timestamp]
                if not targets_due:
                    continue

                for target in targets_due:
                    casting_spell.spell_impact_timestamps.pop(target)

                # All targets finished impact delay.
                if len(casting_spell.spell_impact_timestamps) == 0:
                    self.apply_spell_effects(casting_spell, remove=True, partial_targets=targets_due)
                    continue

                # Only some targets finished delay
                self.apply_spell_effects(casting_spell, partial_targets=targets_due)

    def check_spell_interrupts(self, moved=False, turned=False, received_damage=False, hit_info=HitInfo.DAMAGE,
                               interrupted=False, received_auto_attack=False):  # TODO provide interrupted
        casting_spell_flag_cases = {
            SpellInterruptFlags.SPELL_INTERRUPT_FLAG_MOVEMENT: moved,
            SpellInterruptFlags.SPELL_INTERRUPT_FLAG_DAMAGE: received_damage,
            SpellInterruptFlags.SPELL_INTERRUPT_FLAG_INTERRUPT: interrupted,
            SpellInterruptFlags.SPELL_INTERRUPT_FLAG_AUTOATTACK: received_auto_attack
        }
        channeling_spell_flag_cases = {
            SpellChannelInterruptFlags.CHANNEL_INTERRUPT_FLAG_DAMAGE: received_damage,
            SpellChannelInterruptFlags.CHANNEL_INTERRUPT_FLAG_MOVEMENT: moved,
            SpellChannelInterruptFlags.CHANNEL_INTERRUPT_FLAG_TURNING: turned
        }
        for casting_spell in list(self.casting_spells):
            if casting_spell.cast_state == SpellState.SPELL_STATE_DELAYED:
                continue

            if casting_spell.is_channeled() and casting_spell.cast_state == SpellState.SPELL_STATE_ACTIVE:
                for flag, condition in channeling_spell_flag_cases.items():
                    channel_flags = casting_spell.spell_entry.ChannelInterruptFlags
                    if not (channel_flags & flag) or not condition:
                        continue

                    # TODO Do crushing blows interrupt channeling too?
                    if not (channel_flags & SpellChannelInterruptFlags.CHANNEL_INTERRUPT_FLAG_FULL_INTERRUPT) and \
                            not hit_info & HitInfo.CRUSHING:
                        if flag & SpellChannelInterruptFlags.CHANNEL_INTERRUPT_FLAG_DAMAGE:
                            casting_spell.handle_partial_interrupt()
                            continue

                    self.remove_cast(casting_spell, SpellCheckCastResult.SPELL_FAILED_INTERRUPTED, interrupted=True)
                continue

            if casting_spell.cast_state == SpellState.SPELL_STATE_ACTIVE:
                # If the spell is already active (area aura etc.), don't check SpellInterrupts.
                continue

            for flag, condition in casting_spell_flag_cases.items():
                spell_flags = casting_spell.spell_entry.InterruptFlags
                if not (spell_flags & flag) or not condition:
                    continue

                # - Creatures dealing enough damage (crushing blow) will now fully interrupt casting. (0.5.3 notes).
                if spell_flags & SpellInterruptFlags.SPELL_INTERRUPT_FLAG_PARTIAL and not hit_info & HitInfo.CRUSHING:
                    if flag & SpellInterruptFlags.SPELL_INTERRUPT_FLAG_DAMAGE:
                        casting_spell.handle_partial_interrupt()
                        continue
                    elif flag & SpellInterruptFlags.SPELL_INTERRUPT_FLAG_AUTOATTACK:
                        continue  # Skip auto attack for partial interrupts.

                self.remove_cast(casting_spell, SpellCheckCastResult.SPELL_FAILED_INTERRUPTED, interrupted=True)

    def interrupt_casting_spell(self, cooldown_penalty=0):
        casting_spell = self.get_casting_spell()
        if not casting_spell:
            return

        self.remove_cast(casting_spell, cast_result=SpellCheckCastResult.SPELL_FAILED_INTERRUPTED, interrupted=True)
        self.set_on_cooldown(casting_spell, cooldown_penalty=cooldown_penalty)

    def remove_cast(self, casting_spell, cast_result=SpellCheckCastResult.SPELL_NO_ERROR, interrupted=False) -> bool:
        if casting_spell not in self.casting_spells:
            return False

        try:
            self.casting_spells.remove(casting_spell)
        except ValueError:
            return False

        casting_spell.cast_state = SpellState.SPELL_STATE_FINISHED

        if casting_spell.dynamic_object:
            casting_spell.dynamic_object.despawn()
        [effect.area_aura_holder.destroy() for effect in casting_spell.get_effects() if effect.area_aura_holder]

        # Cancel auras applied by an active spell if the spell was interrupted.
        # If the cast finished normally, auras should wear off because of duration.
        # Spell update happens before aura update, last ticks will be skipped if auras are cancelled on cast finish.
        if casting_spell.cast_state == SpellState.SPELL_STATE_ACTIVE and interrupted:
            for miss_info in casting_spell.object_target_results.values():  # Get the last effect application results.
                if not miss_info.target.get_type_mask() & ObjectTypeFlags.TYPE_UNIT:
                    continue
                miss_info.target.aura_manager.remove_auras_from_spell(casting_spell)

        if casting_spell.is_channeled():
            self.handle_channel_end(casting_spell)

        # Always make sure to set interrupted result if necessary.
        # Client interrupts animations/sounds for a given world object to observers upon unsuccessful casts.
        if interrupted:
            cast_result = SpellCheckCastResult.SPELL_FAILED_INTERRUPTED

        if cast_result != SpellCheckCastResult.SPELL_NO_ERROR:
            self.send_cast_result(casting_spell, cast_result)

        return True

    def remove_cast_by_id(self, spell_id, interrupted=False) -> bool:
        removed = False
        for casting_spell in list(self.casting_spells):
            if spell_id != casting_spell.spell_entry.ID:
                continue
            result = SpellCheckCastResult.SPELL_FAILED_INTERRUPTED if interrupted else SpellCheckCastResult.SPELL_NO_ERROR
            removed = removed or self.remove_cast(casting_spell, result, interrupted)
        return removed

    def handle_death(self):
        self.remove_casts()
        # Always flush channel fields.
        self.caster.flush_channel_fields()

    def remove_casts(self, remove_active=True):
        for casting_spell in list(self.casting_spells):
            result = SpellCheckCastResult.SPELL_FAILED_INTERRUPTED

            if not remove_active:
                if casting_spell.is_far_sight():
                    # Far Sight stuns the caster, but shouldn't interrupt the channel.
                    # TODO this is kind of a hack...
                    #  SPELL_ATTR_EX_FARSIGHT doesn't relate to the stun and is used by other perspective change spells.
                    continue

            if casting_spell.cast_state == SpellState.SPELL_STATE_FINISHED:
                # Cast finished normally, but this was called before update removed the cast.
                result = SpellCheckCastResult.SPELL_NO_ERROR

            # "Passive" casts like active area auras and delayed spells.
            if not casting_spell.is_channeled() and \
                    casting_spell.cast_state == SpellState.SPELL_STATE_ACTIVE or \
                    casting_spell.cast_state == SpellState.SPELL_STATE_DELAYED:
                if not remove_active:
                    continue
                result = SpellCheckCastResult.SPELL_NO_ERROR  # Don't send interrupted error for active/delayed spells

            self.remove_cast(casting_spell, result, interrupted=result != SpellCheckCastResult.SPELL_NO_ERROR)

    def remove_unit_from_all_cast_targets(self, target_guid):
        for casting_spell in list(self.casting_spells):
            for effect in casting_spell.get_effects():
                effect.targets.remove_object_from_targets(target_guid)
                if effect.area_aura_holder:
                    effect.area_aura_holder.remove_target(target_guid)

            # Interrupt handling
            if not casting_spell.initial_target_is_unit_or_player() or \
                    (casting_spell.spell_target_mask == SpellTargetMask.SELF and not
                     casting_spell.requires_implicit_initial_unit_target()) or \
                    (casting_spell.is_instant_cast() and not casting_spell.is_channeled()):
                # Ignore spells that are non-unit targeted, self-cast or instant.
                continue

            if target_guid in casting_spell.object_target_results:  # Only target of this spell.
                result = SpellCheckCastResult.SPELL_FAILED_INTERRUPTED
                # Don't send interrupted error for finished/active/delayed spells.
                if casting_spell.cast_state == SpellState.SPELL_STATE_FINISHED or \
                        not casting_spell.is_channeled() and casting_spell.cast_state in \
                        {SpellState.SPELL_STATE_ACTIVE, SpellState.SPELL_STATE_DELAYED}:
                    result = SpellCheckCastResult.SPELL_NO_ERROR

                self.remove_cast(casting_spell, result, interrupted=result != SpellCheckCastResult.SPELL_NO_ERROR)
                return

    def remove_colliding_casts(self, current_cast):
        for casting_spell in self.casting_spells:
            if casting_spell.cast_state == SpellState.SPELL_STATE_CASTING or casting_spell.is_channeled():
                self.remove_cast(casting_spell, SpellCheckCastResult.SPELL_FAILED_INTERRUPTED, interrupted=True)
                continue

            if ExtendedSpellData.AuraSourceRestrictions.are_colliding_auras(casting_spell.spell_entry.ID,
                                                                            current_cast.spell_entry.ID):  # Paladin auras.
                self.remove_cast(casting_spell, interrupted=False)
                continue
            if current_cast.casts_on_swing() and casting_spell.casts_on_swing() and casting_spell.cast_state == SpellState.SPELL_STATE_DELAYED:
                self.remove_cast(casting_spell, SpellCheckCastResult.SPELL_FAILED_DONT_REPORT, interrupted=True)
                continue

    def calculate_impact_delays(self, casting_spell) -> dict[int, float]:
        impact_delays = {}
        if casting_spell.spell_entry.Speed == 0:
            return impact_delays

        lowest_delay = 0
        for effect in casting_spell.get_effects():
            vector_targets = effect.targets.get_resolved_effect_targets_by_type(Vector)
            if len(vector_targets) > 0:  # Throwable items - bombs etc. Set as the minimum delay for unit targets.
                travel_distance = vector_targets[0].distance(effect.targets.effect_source)
                lowest_delay = travel_distance / casting_spell.spell_entry.Speed

            unit_targets = effect.targets.get_resolved_effect_targets_by_type(ObjectManager)
            source = effect.targets.effect_source
            for target in unit_targets:
                if casting_spell.spell_impact_timestamps.get(target.guid, None) == -1:
                    # Instant target handlers should write -1 to timestamps.
                    # In these cases, assign the lowest impact delay to the target to still account for regular impact delay.
                    impact_delays[target.guid] = -1
                    continue

                target_unit_location = target.location
                travel_distance = source.location.distance(target_unit_location)
                delay = travel_distance / casting_spell.spell_entry.Speed
                if delay == 0:
                    continue
                impact_delays[target.guid] = delay
                lowest_delay = delay if delay < lowest_delay or lowest_delay == 0 else lowest_delay

        for guid, delay in impact_delays.items():
            impact_delays[guid] = lowest_delay if delay == -1 else delay

        return impact_delays

    def send_cast_start(self, casting_spell):
        if not self.caster.get_type_mask() & ObjectTypeFlags.TYPE_UNIT:
            return  # Non-unit casters should not broadcast their casts.

        is_player = self.caster.get_type_id() == ObjectTypeIds.ID_PLAYER

        source_guid = casting_spell.initial_target.guid if casting_spell.initial_target_is_item() else self.caster.guid
        cast_flags = casting_spell.cast_flags

        # Validate if this spell crashes the client.
        # Force SpellCastFlags.CAST_FLAG_PROC, which hides the start cast.
        if not is_player and not ExtendedSpellData.UnitSpellsValidator.spell_has_valid_cast(casting_spell):
            Logger.warning(f'Hiding spell {casting_spell.spell_entry.Name_enUS} start cast due invalid cast.')
            cast_flags |= SpellCastFlags.CAST_FLAG_PROC

        data = [source_guid, self.caster.guid,
                casting_spell.spell_entry.ID, cast_flags, casting_spell.get_cast_time_ms(),
                casting_spell.spell_target_mask]

        signature = '<2QIHiH'  # source, caster, ID, flags, delay .. (targets, opt. ammo displayID / inventorytype).

        # Client never expects a unit target for self target mask.
        if casting_spell.initial_target and casting_spell.spell_target_mask != SpellTargetMask.SELF:
            target_info = casting_spell.get_initial_target_info()  # ([values], signature).
            data.extend(target_info[0])
            signature += target_info[1]

        if casting_spell.cast_flags & SpellCastFlags.CAST_FLAG_HAS_AMMO:
            signature += '2I'
            data.append(casting_spell.used_ranged_attack_item.item_template.display_id)
            data.append(casting_spell.used_ranged_attack_item.item_template.inventory_type)

        # Spell start.
        data = pack(signature, *data)
        packet = PacketWriter.get_packet(OpCode.SMSG_SPELL_START, data)
        MapManager.send_surrounding(packet, self.caster, include_self=is_player)

    def handle_channel_start(self, casting_spell):
        if not casting_spell.is_channeled():
            return

        casting_spell.cast_state = SpellState.SPELL_STATE_ACTIVE
        casting_spell.cast_start_timestamp = time.time()

        # Set new timestamp for cast finish. This will be -1 on an infinite channel (Drain Soul).
        channel_duration = casting_spell.get_duration()
        channel_end_timestamp = channel_duration / 1000 + time.time() if channel_duration != -1 else -1
        casting_spell.cast_end_timestamp = channel_end_timestamp

        if casting_spell.initial_target_is_object():
            self.caster.set_channel_object(casting_spell.initial_target.guid)

        self.caster.set_channel_spell(casting_spell.spell_entry.ID)

        self.apply_spell_effects(casting_spell)

        if self.caster.get_type_id() != ObjectTypeIds.ID_PLAYER or \
                casting_spell.cast_state != SpellState.SPELL_STATE_ACTIVE:
            # State will be changed to finished if the cast was removed during effect application (resist).
            return

        data = pack('<2i', casting_spell.spell_entry.ID, casting_spell.get_duration())
        self.caster.enqueue_packet(PacketWriter.get_packet(OpCode.MSG_CHANNEL_START, data))

    def handle_area_spell_effect_update(self, casting_spell, timestamp) -> bool:
        area_effects = [effect for effect in casting_spell.get_effects() if
                        effect.effect_type in SpellEffectHandler.AREA_SPELL_EFFECTS]
        if not area_effects:
            return False

        casting_spell.object_target_results.clear()  # Reset target results.
        is_finished = False
        for effect in area_effects:
            # Refresh targets.
            casting_spell.resolve_target_info_for_effect(effect.effect_index)

            if effect.is_periodic() and not effect.has_periodic_ticks_remaining():
                is_finished = True

            self.apply_spell_effects(casting_spell, update=True, update_index=effect.effect_index)
            effect.area_aura_holder.update(timestamp)

        return is_finished

    def handle_channel_end(self, casting_spell):
        if not casting_spell.is_channeled():
            return

        if self.caster.get_type_id() != ObjectTypeIds.ID_PLAYER:
            return

        if self.caster.channel_object:
            if casting_spell.is_fishing_spell():
                self._handle_fishing_node_end()
            else:
                # Interrupting Ritual of Summoning required special handling.
                self._handle_summoning_channel_end()

        # Always flush channel fields.
        self.caster.flush_channel_fields()

        if self.caster.get_type_id() != ObjectTypeIds.ID_PLAYER:
            return

        data = pack('<I', 0)
        self.caster.enqueue_packet(PacketWriter.get_packet(OpCode.MSG_CHANNEL_UPDATE, data))

    def send_login_effect(self):
        chr_race = DbcDatabaseManager.chr_races_get_by_race(self.caster.race)
        self.handle_cast_attempt(chr_race.LoginEffectSpellID, self.caster, SpellTargetMask.SELF, validate=False)

    def send_spell_go(self, casting_spell):
        # The client expects the source to only be set for unit casters.
        source_unit = self.caster.guid if self.caster.get_type_mask() & ObjectTypeFlags.TYPE_UNIT else 0

        data = [self.caster.guid, source_unit,
                casting_spell.spell_entry.ID, casting_spell.cast_flags]

        signature = '<2QIHB'  # caster, source, ID, flags .. (targets, ammo info).

        # Prepare target data.
        hits = []
        misses = []

        # Only include the primary effect targets.
        targets = casting_spell.get_effects()[0].targets.get_resolved_effect_targets_by_type(ObjectManager)
        for target in targets:
            miss_info = casting_spell.object_target_results[target.guid]
            if miss_info.result == SpellMissReason.MISS_REASON_NONE:
                hits.append(target.guid)
            else:
                misses.append((miss_info.result, target.guid))

        # Write hits.
        hit_count = len(hits)
        data.append(hit_count)
        if hit_count:
            data.extend(hits)
            signature += f'{hit_count}Q'

        # Write misses.
        signature += 'B'
        data.append(len(targets) - hit_count)
        for result, target_guid in misses:
            signature += 'BQ'
            data.append(result)
            data.append(target_guid)

        signature += 'H'  # SpellTargetMask
        data.append(casting_spell.spell_target_mask)

        if casting_spell.spell_target_mask != SpellTargetMask.SELF:  # Write target info - same as cast start.
            target_info = casting_spell.get_initial_target_info()  # ([values], signature)
            data.extend(target_info[0])
            signature += target_info[1]

        if casting_spell.cast_flags & SpellCastFlags.CAST_FLAG_HAS_AMMO:
            signature += '2I'
            data.append(casting_spell.used_ranged_attack_item.item_template.display_id)
            data.append(casting_spell.used_ranged_attack_item.item_template.inventory_type)

        is_player = self.caster.get_type_id() == ObjectTypeIds.ID_PLAYER
        packet = PacketWriter.get_packet(OpCode.SMSG_SPELL_GO, pack(signature, *data))
        MapManager.send_surrounding(packet, self.caster, include_self=is_player)

    def flush_cooldowns(self):
        for spell_id, cooldown_entry in list(self.cooldowns.items()):
            self.cooldowns[spell_id].cancel()
        self.check_spell_cooldowns()

    # Used by creatures to set their initial CD for their spell list. (Time before casting after attack start).
    def force_cooldown(self, spell_id, cooldown):
        spell = DbcDatabaseManager.SpellHolder.spell_get_by_id(spell_id)
        if not spell:
            return

        cooldown_entry = CooldownEntry(spell, time.time(), False, cooldown_penalty=cooldown, forced=True)
        self.cooldowns[spell.ID] = cooldown_entry

        if self.caster.get_type_id() != ObjectTypeIds.ID_PLAYER:
            return

        data = pack('<IQI', spell.ID, self.caster.guid, cooldown_entry.cooldown_length)
        self.caster.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_SPELL_COOLDOWN, data))

    def set_on_cooldown(self, casting_spell, cooldown_penalty=0):
        spell = casting_spell.spell_entry
        unlocks_on_trigger = casting_spell.unlock_cooldown_on_trigger()

        # If a penalty was provided or the spell comes from a creature spell,
        # Set the spell on cooldown for the given penalty or a new cd if it is greater than the spell dbc cooldown.
        if cooldown_penalty or casting_spell.creature_spell:
            if not cooldown_penalty and casting_spell.creature_spell:
                min_delay = casting_spell.creature_spell.delay_repeat_min
                max_delay = casting_spell.creature_spell.delay_repeat_max
                cooldown_penalty = randint(min_delay, max_delay) * 1000

            cooldown_entry = CooldownEntry(spell, time.time(), unlocks_on_trigger, cooldown_penalty=cooldown_penalty)
            # Update existent cooldown for this spell.
            self.cooldowns[spell.ID] = cooldown_entry
        # Normal cooldown handling.
        else:
            if spell.RecoveryTime == 0 and spell.CategoryRecoveryTime == 0:
                return
            cooldown_entry = CooldownEntry(spell, time.time(), unlocks_on_trigger)
            self.cooldowns[spell.ID] = cooldown_entry

        if self.caster.get_type_id() != ObjectTypeIds.ID_PLAYER or unlocks_on_trigger:
            return

        data = pack('<IQI', spell.ID, self.caster.guid, cooldown_entry.cooldown_length)
        self.caster.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_SPELL_COOLDOWN, data))

    def unlock_spell_cooldown(self, spell_id):
        if spell_id not in self.cooldowns:
            return

        self.cooldowns[spell_id].unlock(time.time())
        if self.caster.get_type_id() != ObjectTypeIds.ID_PLAYER:
            return

        data = pack('<IQ', spell_id, self.caster.guid)
        self.caster.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_COOLDOWN_EVENT, data))

    def check_spell_cooldowns(self):
        for spell_id, cooldown_entry in list(self.cooldowns.items()):
            if cooldown_entry.is_valid():
                continue

            del self.cooldowns[spell_id]
            if self.caster.get_type_id() != ObjectTypeIds.ID_PLAYER:
                continue
            data = pack('<IQ', cooldown_entry.spell_id, self.caster.guid)
            self.caster.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_CLEAR_COOLDOWN, data))

    def is_on_cooldown(self, spell_entry) -> bool:
        return spell_entry.ID in self.cooldowns

    def is_casting_spell(self, spell_id):
        for spell in list(self.casting_spells):
            if spell.spell_entry.ID == spell_id and \
                    (spell.cast_state == SpellState.SPELL_STATE_CASTING or
                     (spell.is_channeled() and spell.cast_state == SpellState.SPELL_STATE_ACTIVE)):
                return True
        return False

    def is_spell_active(self, spell_id):
        return any([spell for spell in self.casting_spells if
                    spell.spell_entry.ID == spell_id and
                    spell.cast_state == SpellState.SPELL_STATE_ACTIVE and
                    not spell.is_channeled()])

    def get_casting_spell(self):
        for spell in list(self.casting_spells):
            if spell.triggered:
                # Ignore triggered casts - they can have casting time but shouldn't affect other casts.
                continue

            if spell.cast_state != SpellState.SPELL_STATE_CASTING and not \
                    (spell.is_channeled() and spell.cast_state == SpellState.SPELL_STATE_ACTIVE):
                continue
            return spell
        return None

    def is_casting(self):
        return self.get_casting_spell() is not None

    def validate_cast(self, casting_spell) -> bool:
        if self.is_on_cooldown(casting_spell.spell_entry):
            self.send_cast_result(casting_spell, SpellCheckCastResult.SPELL_FAILED_NOT_READY)
            return False

        # Rough target type check for the client-provided target to avoid crashes.
        # If the client is behaving as expected, this will always be valid.
        if casting_spell.spell_entry.Targets & SpellTargetMask.ITEM and \
                not casting_spell.initial_target_is_item() or \
                (casting_spell.spell_entry.Targets & SpellTargetMask.UNIT_SELF and
                 not casting_spell.initial_target_is_unit_or_player()):
            self.send_cast_result(casting_spell, SpellCheckCastResult.SPELL_FAILED_BAD_TARGETS)
            return False

        # Unlearned spell.
        if (not casting_spell.triggered and not casting_spell.source_item) and \
                casting_spell.cast_state == SpellState.SPELL_STATE_PREPARING and \
                self.caster.get_type_id() == ObjectTypeIds.ID_PLAYER and \
                (not casting_spell.spell_entry or casting_spell.spell_entry.ID not in self.spells):
            self.send_cast_result(casting_spell, SpellCheckCastResult.SPELL_FAILED_NOT_KNOWN)
            return False

        # Caster unit-only state checks.
        if self.caster.get_type_mask() & ObjectTypeFlags.TYPE_UNIT:
            # Dead.
            if not casting_spell.spell_entry.Attributes & SpellAttributes.SPELL_ATTR_ALLOW_CAST_WHILE_DEAD and \
                    not self.caster.is_alive:
                self.send_cast_result(casting_spell, SpellCheckCastResult.SPELL_FAILED_CASTER_DEAD)
                return False

            # Stunned, spell source is not item and cast is not triggered.
            if self.caster.unit_state & UnitStates.STUNNED and not casting_spell.source_item and \
                    not casting_spell.triggered:
                self.send_cast_result(casting_spell, SpellCheckCastResult.SPELL_FAILED_STUNNED)
                return False

            # Pacified.
            if self.caster.unit_flags & UnitFlags.UNIT_FLAG_PACIFIED and \
                    casting_spell.spell_entry.Attributes & SpellAttributes.SPELL_ATTR_IS_ABILITY and \
                    casting_spell.spell_entry.School == SpellSchools.SPELL_SCHOOL_NORMAL:
                self.send_cast_result(casting_spell, SpellCheckCastResult.SPELL_FAILED_PACIFIED)
                return False

            # Silenced.
            if self.caster.unit_state & UnitStates.SILENCED and not casting_spell.source_item and \
                    not casting_spell.triggered:
                self.send_cast_result(casting_spell, SpellCheckCastResult.SPELL_FAILED_SILENCED)
                return False

            # Sitting.
            if not casting_spell.spell_entry.Attributes & SpellAttributes.SPELL_ATTR_CASTABLE_WHILE_SITTING and \
                    self.caster.stand_state != StandState.UNIT_STANDING:
                self.send_cast_result(casting_spell, SpellCheckCastResult.SPELL_FAILED_NOTSTANDING)
                return False

            # Not stealthed but the spell requires it.
            if casting_spell.spell_entry.Attributes & SpellAttributes.SPELL_ATTR_ONLY_STEALTHED and \
                    not self.caster.is_stealthed():
                self.send_cast_result(casting_spell, SpellCheckCastResult.SPELL_FAILED_ONLY_STEALTHED)
                return False

        # Required nearby spell focus GO.
        spell_focus_type = casting_spell.spell_entry.RequiresSpellFocus
        if spell_focus_type:
            surrounding_gos = [go for go in MapManager.get_surrounding_gameobjects(self.caster).values()]

            # Check if any nearby GO is the required spell focus.
            if not any([go.gobject_template.type == GameObjectTypes.TYPE_SPELL_FOCUS and
                        go.gobject_template.data0 == spell_focus_type and
                        self.caster.location.distance(go.location) <= go.gobject_template.data1
                        for go in surrounding_gos]):
                self.send_cast_result(casting_spell, SpellCheckCastResult.SPELL_FAILED_REQUIRES_SPELL_FOCUS,
                                      spell_focus_type)
                return False

        # Target validation.
        validation_target = casting_spell.initial_target
        # In the case of the spell requiring another unit target but being cast on self,
        # validate the spell against the caster's current unit selection or pet instead.
        if casting_spell.spell_target_mask == SpellTargetMask.SELF:
            if casting_spell.requires_implicit_initial_unit_target():
                validation_target = casting_spell.targeted_unit_on_cast_start
                if validation_target and not self.caster.can_attack_target(validation_target):
                    # All secondary initial unit targets are hostile. Unlike (nearly?) all other spells,
                    # the target for arcane missiles is not validated by the client (script effect). Catch that case here.
                    self.send_cast_result(casting_spell, SpellCheckCastResult.SPELL_FAILED_BAD_TARGETS)
                    return False
            elif casting_spell.has_pet_target():
                controlled_pet = self.caster.pet_manager.get_active_controlled_pet()
                validation_target = controlled_pet.creature if controlled_pet else None

        if not validation_target:
            result = SpellCheckCastResult.SPELL_FAILED_NOT_FISHABLE if casting_spell.is_fishing_spell() \
                else SpellCheckCastResult.SPELL_FAILED_BAD_IMPLICIT_TARGETS
            self.send_cast_result(casting_spell, result)
            return False

        # Unit target checks.
        if casting_spell.initial_target_is_unit_or_player():
            # Basic effect harmfulness/attackability check for fully harmful spells.
            # For unit-targeted AoE spells, skip validation for self casts.
            # The client checks this for player casts, but not pet casts.
            if (not casting_spell.is_area_of_effect_spell() or validation_target is not self.caster) and \
                    casting_spell.has_only_harmful_effects() and \
                    not self.caster.can_attack_target(validation_target):
                self.send_cast_result(casting_spell, SpellCheckCastResult.SPELL_FAILED_BAD_TARGETS)
                return False

            if not validation_target.is_alive and not \
                    (casting_spell.spell_entry.Targets & SpellTargetMask.UNIT_DEAD):
                self.send_cast_result(casting_spell, SpellCheckCastResult.SPELL_FAILED_TARGETS_DEAD)
                return False

            # Orientation checks.
            target_is_facing_caster = validation_target.location.has_in_arc(self.caster.location, math.pi)
            if not ExtendedSpellData.CastPositionRestrictions.is_position_correct(casting_spell.spell_entry.ID,
                                                                                  target_is_facing_caster):
                if ExtendedSpellData.CastPositionRestrictions.is_from_behind(casting_spell.spell_entry.ID):
                    self.send_cast_result(casting_spell, SpellCheckCastResult.SPELL_FAILED_NOT_BEHIND)
                else:
                    self.send_cast_result(casting_spell, SpellCheckCastResult.SPELL_FAILED_UNIT_NOT_INFRONT)
                return False

            # Aura bounce check.
            if not validation_target.aura_manager.are_spell_effects_applicable(casting_spell):
                self.send_cast_result(casting_spell, SpellCheckCastResult.SPELL_FAILED_AURA_BOUNCED)
                return False

            # Creature type check.
            if validation_target is not self.caster:
                req_creature_type_mask = casting_spell.spell_entry.TargetCreatureType
                target_creature_type_mask = 1 << (validation_target.creature_type - 1)
                if req_creature_type_mask and not req_creature_type_mask & target_creature_type_mask:
                    error = SpellCheckCastResult.SPELL_FAILED_TARGET_IS_PLAYER if \
                        validation_target.get_type_id() == ObjectTypeIds.ID_PLAYER \
                        else SpellCheckCastResult.SPELL_FAILED_BAD_TARGETS

                    self.send_cast_result(casting_spell, error)
                    return False

            # Target power type check (mana drain etc.)
            if not casting_spell.is_target_power_type_valid(validation_target):
                self.send_cast_result(casting_spell, SpellCheckCastResult.SPELL_FAILED_BAD_TARGETS)
                return False

        # Range validations. Skip for fishing as generated targets will always be valid.
        is_terrain = casting_spell.initial_target_is_terrain()
        if not casting_spell.is_fishing_spell() and not casting_spell.initial_target_is_item() and \
                validation_target is not self.caster:
            # Check if the caster is within range of the (world) target to cast the spell.
            target_loc = validation_target if is_terrain else validation_target.location
            if casting_spell.range_entry.RangeMin > 0 or casting_spell.range_entry.RangeMax > 0:
                distance = self.caster.location.distance(target_loc)
                if distance > casting_spell.range_entry.RangeMax:
                    self.send_cast_result(casting_spell, SpellCheckCastResult.SPELL_FAILED_OUT_OF_RANGE)
                    return False
                if distance < casting_spell.range_entry.RangeMin:
                    self.send_cast_result(casting_spell, SpellCheckCastResult.SPELL_FAILED_TOO_CLOSE)
                    return False
            # Line of sight.
            target_ray_vector = validation_target.get_ray_position() if not is_terrain \
                else target_loc.get_ray_vector(is_terrain=True)
            if not MapManager.los_check(self.caster.map_id, self.caster.get_ray_position(), target_ray_vector):
                self.send_cast_result(casting_spell, SpellCheckCastResult.SPELL_FAILED_LINE_OF_SIGHT)
                return False

        # Item target checks.
        if casting_spell.initial_target_is_item():
            # Match item class/subclass.
            if casting_spell.spell_entry.EquippedItemClass != -1:
                required_item_class = casting_spell.spell_entry.EquippedItemClass
                required_item_subclass = casting_spell.spell_entry.EquippedItemSubclass

                item_class = casting_spell.initial_target.item_template.class_
                item_subclass_mask = 1 << casting_spell.initial_target.item_template.subclass
                if required_item_class != item_class or \
                        not required_item_subclass & item_subclass_mask:
                    self.send_cast_result(casting_spell, SpellCheckCastResult.SPELL_FAILED_BAD_TARGETS)
                    return False

            # Validate item owner online status.
            item_owner = validation_target.get_owner_guid()
            if not item_owner or not WorldSessionStateHandler.find_player_by_guid(item_owner):
                self.send_cast_result(casting_spell, SpellCheckCastResult.SPELL_FAILED_BAD_TARGETS)
                return False

        # Effect-specific validation.

        # Enchanting checks.
        has_temporary_enchant_effect = casting_spell.has_effect_of_type(SpellEffects.SPELL_EFFECT_ENCHANT_ITEM_TEMPORARY)
        if has_temporary_enchant_effect or \
                casting_spell.has_effect_of_type(SpellEffects.SPELL_EFFECT_ENCHANT_ITEM_PERMANENT):
            # TODO: We don't have EquippedItemInventoryTypeMask, so we have no way to validate inventory slots.
            #  e.g. Enchant bracers would still work on legs, chest, etc. So maybe they had some filtering by name?

            # Do not allow temporary enchantments in trade slot.
            if has_temporary_enchant_effect:
                # TODO: Further research needed, we have neither SPELL_FAILED_NOT_TRADEABLE or 'Slot' in
                #   SpellItemEnchantment. Refer to VMaNGOS Spell.cpp 7822.
                if casting_spell.initial_target.get_owner_guid() != casting_spell.spell_caster.guid:
                    self.send_cast_result(casting_spell, SpellCheckCastResult.SPELL_FAILED_ERROR)
                    return False

            # Do not allow to enchant if it has an existent permanent enchantment.
            if EnchantmentManager.get_permanent_enchant_value(casting_spell.initial_target) != 0:
                self.send_cast_result(casting_spell, SpellCheckCastResult.SPELL_FAILED_ITEM_ALREADY_ENCHANTED)
                return False

        # Spell learning/teaching checks.
        taught_spells = [effect.trigger_spell_id for effect in casting_spell.get_effects()
                         if effect.effect_type in {SpellEffects.SPELL_EFFECT_LEARN_SPELL,
                                                   SpellEffects.SPELL_EFFECT_LEARN_PET_SPELL}]

        if casting_spell.initial_target_is_unit_or_player() and taught_spells:
            if validation_target.get_type_id() == ObjectTypeIds.ID_PLAYER:
                if any([spell in validation_target.spell_manager.spells for spell in taught_spells]):
                    self.send_cast_result(casting_spell, SpellCheckCastResult.SPELL_FAILED_SPELL_LEARNED)
                    return False  # Spell already known.
            else:
                # Teaching a pet a spell.
                pet = self.caster.pet_manager.get_active_permanent_pet()
                if not pet:
                    self.send_cast_result(casting_spell, SpellCheckCastResult.SPELL_FAILED_NO_PET)
                    return False  # No pet (or temporary charm).

                pet_data = pet.get_pet_data()
                if any([spell in pet_data.spells for spell in taught_spells]):
                    self.send_cast_result(casting_spell, SpellCheckCastResult.SPELL_FAILED_SPELL_LEARNED)
                    return False

                if any([not pet_data.can_learn_spell(spell) for spell in taught_spells]):
                    is_low_level = any([pet_data.can_ever_learn_spell(spell) for spell in taught_spells])
                    reason = SpellCheckCastResult.SPELL_FAILED_SPELL_UNAVAILABLE if not is_low_level \
                        else SpellCheckCastResult.SPELL_FAILED_LOWLEVEL
                    self.send_cast_result(casting_spell, reason)
                    return False  # Pet can't learn the teachable spell.

        # Charm checks.
        charm_effect = casting_spell.get_charm_effect()
        if self.caster.get_type_id() == ObjectTypeIds.ID_PLAYER and charm_effect:
            if not self.caster.can_attack_target(validation_target):
                self.send_cast_result(casting_spell, SpellCheckCastResult.SPELL_FAILED_BAD_TARGETS)
                return False

            active_pet = self.caster.pet_manager.get_active_controlled_pet()
            if active_pet:
                error = SpellCheckCastResult.SPELL_FAILED_ALREADY_HAVE_SUMMON if active_pet.is_permanent() \
                    else SpellCheckCastResult.SPELL_FAILED_ALREADY_HAVE_CHARM
                self.send_cast_result(casting_spell, error)
                return False

            # Taming restrictions.
            if charm_effect.effect_type == SpellEffects.SPELL_EFFECT_TAME_CREATURE:
                tame_result = self.caster.pet_manager.handle_tame_result(charm_effect, validation_target)
                if tame_result != SpellCheckCastResult.SPELL_NO_ERROR:
                    self.send_cast_result(casting_spell, tame_result)
                    return False
            else:
                # All charm effects have the level restriction in effect points.
                # Taming is handled separately since it has its own opcode for results.
                max_charm_level = charm_effect.get_effect_points()
                if validation_target.level > max_charm_level:
                    self.send_cast_result(casting_spell, SpellCheckCastResult.SPELL_FAILED_LEVEL_REQUIREMENT)
                    return False

        # Permanent pet summon check.
        summon_pet_effect = casting_spell.get_effect_by_type(SpellEffects.SPELL_EFFECT_SUMMON_PET)
        if summon_pet_effect:
            if not summon_pet_effect.misc_value and not len(self.caster.pet_manager.permanent_pets):
                self.send_cast_result(casting_spell, SpellCheckCastResult.SPELL_FAILED_NO_PET)
                return False

            if self.caster.pet_manager.get_active_controlled_pet():
                self.send_cast_result(casting_spell, SpellCheckCastResult.SPELL_FAILED_ALREADY_HAVE_SUMMON)
                return False

        # Pickpocketing target validity check.
        if casting_spell.has_effect_of_type(SpellEffects.SPELL_EFFECT_PICKPOCKET):
            if not self.caster.can_attack_target(validation_target):
                self.send_cast_result(casting_spell, SpellCheckCastResult.SPELL_FAILED_TARGET_FRIENDLY)
                return False
            # Patch 1.12.0 - Can now be used on targets that are in combat, as long as the rogue remains stealthed.
            if validation_target.in_combat:
                self.send_cast_result(casting_spell, SpellCheckCastResult.SPELL_FAILED_TARGET_AFFECTING_COMBAT)
                return False
            if validation_target.get_type_id() != ObjectTypeIds.ID_UNIT or \
                    not validation_target.pickpocket_loot_manager:
                self.send_cast_result(casting_spell, SpellCheckCastResult.SPELL_FAILED_TARGET_NO_POCKETS)
                return False

        # Duel target check.
        if casting_spell.has_effect_of_type(SpellEffects.SPELL_EFFECT_DUEL):
            # Duel cast attempt on a unit.
            if validation_target.get_type_id() != ObjectTypeIds.ID_PLAYER:
                self.send_cast_result(casting_spell, SpellCheckCastResult.SPELL_FAILED_BAD_TARGETS)
                return False
            if validation_target.duel_manager:
                self.send_cast_result(casting_spell, SpellCheckCastResult.SPELL_FAILED_TARGET_DUELING)
                return False
            if casting_spell.spell_caster.unit_flags & UnitFlags.UNIT_FLAG_SNEAK:
                # There is no 'SPELL_FAILED_CANT_DUEL_WHILE_STEALTHED' in alpha, but this needs to be handled.
                self.send_cast_result(casting_spell, SpellCheckCastResult.SPELL_FAILED_ERROR)
                return False

        # Lock/chest checks.
        open_lock_effect = casting_spell.get_effect_by_type(SpellEffects.SPELL_EFFECT_OPEN_LOCK,
                                                            SpellEffects.SPELL_EFFECT_OPEN_LOCK_ITEM)
        if open_lock_effect and not casting_spell.initial_target_is_unit_or_player():
            # Already unlocked.
            if not validation_target.lock:
                self.send_cast_result(casting_spell, SpellCheckCastResult.SPELL_FAILED_ALREADY_OPEN)
                return False

            # GameObject already in use. TODO: 'gameobject_requirement' table.
            if casting_spell.initial_target_is_gameobject() and \
                    (validation_target.is_active() or validation_target.has_flag(GameObjectFlags.IN_USE)):
                self.send_cast_result(casting_spell, SpellCheckCastResult.SPELL_FAILED_CHEST_IN_USE)
                return False

            # Item already unlocked.
            if casting_spell.initial_target_is_item() and \
                    validation_target.has_flag(ItemDynFlags.ITEM_DYNFLAG_UNLOCKED):
                self.send_cast_result(casting_spell, SpellCheckCastResult.SPELL_FAILED_ALREADY_OPEN)
                return False

            # Unlock spells can provide bonus skill.
            bonus_skill = open_lock_effect.get_effect_simple_points()

            # Skill checks and random failure chance.
            if casting_spell.cast_state == SpellState.SPELL_STATE_PREPARING:
                # Skill check only on initial validation.
                unlock_result = LockManager.can_open_lock(self.caster, open_lock_effect.misc_value, validation_target.lock,
                                                          cast_item=casting_spell.source_item, bonus_points=bonus_skill)
                unlock_result = unlock_result.result
            else:
                # Include failure chance on cast.
                unlock_result = self.caster.skill_manager.get_unlocking_attempt_result(open_lock_effect.misc_value,
                                                                                       validation_target.lock,
                                                                                       used_item=casting_spell.source_item,
                                                                                       bonus_skill=bonus_skill)
            if unlock_result != SpellCheckCastResult.SPELL_NO_ERROR:
                self.send_cast_result(casting_spell, unlock_result)
                return False

        # Special case of Ritual of Summoning.
        summoning_channel_id = 698
        if casting_spell.spell_entry.ID == summoning_channel_id and not self._validate_summon_cast(casting_spell):
            # If summon effect fails, the channel must be interrupted.
            self.remove_cast_by_id(summoning_channel_id)
            return False

        if not self.meets_casting_requisites(casting_spell):
            return False

        return True

    def _validate_summon_cast(self, casting_spell) -> bool:
        # The spell triggered by ritual of summoning has no attributes. Check for known restrictions here.
        # This method also interrupts the summoning channel when necessary.
        # Note that summoning didn't have many restrictions in 0.5.3. See SpellEffectHandler.handle_summon_player for notes.

        if self.caster.get_type_id() != ObjectTypeIds.ID_PLAYER:
            return False  # Only players can cast or participate.

        # Target validation
        target_guid = self.caster.current_selection
        if not target_guid:
            self.send_cast_result(casting_spell, SpellCheckCastResult.SPELL_FAILED_BAD_IMPLICIT_TARGETS)
            return False

        target_unit = WorldSessionStateHandler.find_player_by_guid(target_guid)
        if not target_unit:  # Couldn't find player with this guid - not a player.
            self.send_cast_result(casting_spell, SpellCheckCastResult.SPELL_FAILED_TARGET_NOT_PLAYER)
            return False

        if not target_unit.is_alive:
            self.send_cast_result(casting_spell, SpellCheckCastResult.SPELL_FAILED_TARGETS_DEAD)
            return False

        if not self.caster.group_manager or not self.caster.group_manager.is_party_member(target_guid):
            self.send_cast_result(casting_spell, SpellCheckCastResult.SPELL_FAILED_TARGET_NOT_IN_PARTY)
            return False  # Only party members can be summoned.

        if casting_spell.cast_state in [SpellState.SPELL_STATE_PREPARING, SpellState.SPELL_STATE_CASTING]:
            # The checks before this are used during ritual cast initialization and finishing.
            # The checks after are also used for the summon spell finishing.
            return True

        if not self.caster.channel_object:
            self.send_cast_result(casting_spell, SpellCheckCastResult.SPELL_FAILED_DONT_REPORT)
            return False

        channel_object = MapManager.get_surrounding_gameobject_by_guid(self.caster,
                                                                       self.caster.channel_object)
        if not channel_object or channel_object.gobject_template.type != GameObjectTypes.TYPE_RITUAL \
                or channel_object.summoner is not self.caster:
            self.send_cast_result(casting_spell, SpellCheckCastResult.SPELL_FAILED_DONT_REPORT)
            return False

        return True

    def _handle_fishing_node_end(self):
        if not self.caster.channel_object:
            return
        fishing_node_object = MapManager.get_surrounding_gameobject_by_guid(self.caster, self.caster.channel_object)
        if not fishing_node_object or fishing_node_object.gobject_template.type != GameObjectTypes.TYPE_FISHINGNODE:
            return
        # If this was an interrupt or miss hook, remove the bobber.
        # Else, it will be removed upon CMSG_LOOT_RELEASE.
        if not fishing_node_object.fishing_node_manager.hook_result:
            MapManager.remove_object(fishing_node_object)

    def _handle_summoning_channel_end(self):
        # Specific handling of ritual of summoning interrupting.
        if not self.caster.channel_object:
            return
        channel_object = MapManager.get_surrounding_gameobject_by_guid(self.caster, self.caster.channel_object)
        if not channel_object or channel_object.gobject_template.type != GameObjectTypes.TYPE_RITUAL:
            return
        channel_object.ritual_manager.channel_end(self.caster)

    def meets_casting_requisites(self, casting_spell) -> bool:
        # This method should only check resource costs (ie. power/combo/items).
        if not self.caster.get_type_mask() & ObjectTypeFlags.TYPE_UNIT:
            return True  # Skip checks for non-unit casters.

        has_health_cost = casting_spell.spell_entry.PowerType == PowerTypes.TYPE_HEALTH
        power_cost = casting_spell.get_resource_cost()
        has_correct_power = self.caster.power_type == casting_spell.spell_entry.PowerType or has_health_cost
        current_power = self.caster.health if has_health_cost else self.caster.get_power_value()
        is_player = self.caster.get_type_id() == ObjectTypeIds.ID_PLAYER
        # Items like scrolls or creatures need to be able to cast spells even if they lack the required power type.
        ignore_wrong_power = not is_player or casting_spell.source_item or casting_spell.triggered

        if has_health_cost:
            # Prevent dying from consuming health as resource.
            if power_cost == current_power:
                self.send_cast_result(casting_spell, SpellCheckCastResult.SPELL_FAILED_FIZZLE)
                return False

            # Health cost fail displays on client before server response, send empty error.
            elif power_cost > current_power:
                self.send_cast_result(casting_spell, SpellCheckCastResult.SPELL_NO_ERROR)
                return False
        else:
            # Doesn't have the correct power type.
            if power_cost and not has_correct_power and not ignore_wrong_power:
                self.send_cast_result(casting_spell, SpellCheckCastResult.SPELL_FAILED_NO_POWER)
                return False

            # Doesn't have enough power. Check for correct power to properly ignore wrong power if necessary.
            if power_cost > current_power and has_correct_power:
                self.send_cast_result(casting_spell, SpellCheckCastResult.SPELL_FAILED_NO_POWER)
                return False

        # Player only checks
        if self.caster.get_type_id() == ObjectTypeIds.ID_PLAYER:
            # Check if player has required combo points.
            if casting_spell.requires_combo_points():
                combo_target = casting_spell.initial_target if \
                    casting_spell.initial_target is not self.caster else casting_spell.targeted_unit_on_cast_start

                if not combo_target or combo_target.guid != self.caster.combo_target or not self.caster.combo_points:
                    self.send_cast_result(casting_spell, SpellCheckCastResult.SPELL_FAILED_NO_COMBO_POINTS)
                    return False

            # Check if player has required reagents.
            for reagent_info, count in casting_spell.get_reagents():
                if reagent_info == 0:
                    break

                if self.caster.inventory.get_item_count(reagent_info) < count:
                    self.send_cast_result(casting_spell, SpellCheckCastResult.SPELL_FAILED_REAGENTS)
                    return False

            # Check if player has required weapon and ammo.
            if casting_spell.spell_attack_type != -1:
                required_weapon_mask = casting_spell.spell_entry.EquippedItemSubclass
                equipped_weapon = self.caster.get_current_weapon_for_attack_type(casting_spell.spell_attack_type)
                if not equipped_weapon:
                    self.send_cast_result(casting_spell, SpellCheckCastResult.SPELL_FAILED_EQUIPPED_ITEM)
                    return False
                subclass_mask = 1 << equipped_weapon.item_template.subclass
                if not required_weapon_mask & subclass_mask:
                    self.send_cast_result(casting_spell, SpellCheckCastResult.SPELL_FAILED_EQUIPPED_ITEM_CLASS)
                    return False

                required_ammo = equipped_weapon.item_template.ammo_type
                # Only check consumable ammo.
                if required_ammo in [ItemSubClasses.ITEM_SUBCLASS_ARROW, ItemSubClasses.ITEM_SUBCLASS_BULLET]:
                    target_bag_slot = self.caster.inventory.get_bag_slot_for_ammo(required_ammo)
                    if target_bag_slot == -1:
                        required_bag = ItemSubClasses.ITEM_SUBCLASS_QUIVER if \
                            required_ammo == ItemSubClasses.ITEM_SUBCLASS_ARROW else ItemSubClasses.ITEM_SUBCLASS_AMMO_POUCH
                        self.send_cast_result(casting_spell, SpellCheckCastResult.SPELL_FAILED_NEED_AMMO_POUCH,
                                              misc_data=required_bag)
                        return False

                    target_bag = self.caster.inventory.get_container(target_bag_slot)
                    target_ammo = [ammo for ammo in target_bag.sorted_slots.values() if
                                   ammo.item_template.required_level <= self.caster.level]

                    # Also validate against casting_spell.used_ranged_attack_item,
                    # the initially selected ammo (inventory manipulation during casting)
                    if not target_ammo or target_ammo[-1] != casting_spell.used_ranged_attack_item:
                        self.send_cast_result(casting_spell, SpellCheckCastResult.SPELL_FAILED_NEED_AMMO,
                                              misc_data=required_ammo)
                        return False

            # Spells cast with consumables.
            if casting_spell.source_item and casting_spell.source_item.has_charges():
                charges = casting_spell.source_item.get_charges(casting_spell.spell_entry.ID)
                if charges == 0:  # no charges left.
                    self.send_cast_result(casting_spell, SpellCheckCastResult.SPELL_FAILED_NO_CHARGES_REMAIN)
                    return False
                item_id = casting_spell.source_item.item_template.entry
                # Consumables have negative charges.
                if charges < 0 and self.caster.inventory.get_item_count(item_id) < 1:
                    # Should never really happen but catch this case.
                    self.send_cast_result(casting_spell, SpellCheckCastResult.SPELL_FAILED_ITEM_NOT_FOUND)
                    return False

            for tool in casting_spell.get_required_tools():
                if not tool:
                    break
                if not self.caster.inventory.get_first_item_by_entry(tool):
                    self.send_cast_result(casting_spell, SpellCheckCastResult.SPELL_FAILED_TOTEMS)
                    return False

            # Check if player inventory has space left.
            for item, count in casting_spell.get_conjured_items():
                if item == 0:
                    break

                item_template = WorldDatabaseManager.ItemTemplateHolder.item_template_get_by_entry(item)
                error = self.caster.inventory.can_store_item(item_template, count)
                if error != InventoryError.BAG_OK:
                    self.caster.inventory.send_equip_error(error)
                    self.send_cast_result(casting_spell, SpellCheckCastResult.SPELL_FAILED_DONT_REPORT)
                    return False

        return True

    def consume_resources_for_cast(self, casting_spell):
        # This method assumes that the reagents exist (meets_casting_requisites was run).
        if not self.caster.get_type_mask() & ObjectTypeFlags.TYPE_UNIT:
            return

        is_player = self.caster.get_type_id() == ObjectTypeIds.ID_PLAYER
        power_type = casting_spell.spell_entry.PowerType
        # Check if this spell should consume all power.
        if casting_spell.spell_entry.AttributesEx & SpellAttributesEx.SPELL_ATTR_EX_DRAIN_ALL_POWER:
            new_power = 0
        else:
            cost = casting_spell.get_resource_cost()
            # Note: resources are consumed after the cast, which means that the caster's power type can change.
            # Pass the required power to get_power_value.
            current_power = self.caster.health if power_type == PowerTypes.TYPE_HEALTH \
                else self.caster.get_power_value(power_type)
            new_power = current_power - cost

        if power_type == PowerTypes.TYPE_HEALTH:
            self.caster.set_health(new_power)
        else:
            self.caster.set_power_value(new_power, power_type)

        if is_player and casting_spell.requires_combo_points():
            self.caster.remove_combo_points()

        removed_items = set()
        if is_player:
            for reagent_info in casting_spell.get_reagents():  # Reagents.
                if reagent_info[0] == 0:
                    break
                removed_items.add(reagent_info[0])
                self.caster.inventory.remove_items(reagent_info[0], reagent_info[1])

        # Ammo.
        used_ammo_or_weapon = casting_spell.used_ranged_attack_item
        if is_player and casting_spell.spell_attack_type == AttackTypes.RANGED_ATTACK and used_ammo_or_weapon:
            # Validation ensures that the initially selected ammo (used_ranged_attack_item) remains the same.
            ammo_class = used_ammo_or_weapon.item_template.class_
            ammo_subclass = used_ammo_or_weapon.item_template.subclass

            # Projectiles and thrown weapons are consumed on use.
            is_consumable = ammo_class == ItemClasses.ITEM_CLASS_PROJECTILE or (
                    ammo_class == ItemClasses.ITEM_CLASS_WEAPON and ammo_subclass == ItemSubClasses.ITEM_SUBCLASS_THROWN
            )
            if is_consumable:
                self.caster.inventory.remove_from_container(used_ammo_or_weapon.item_template.entry, 1,
                                                            used_ammo_or_weapon.item_instance.bag)

        # Spells cast with consumables.
        if is_player and casting_spell.source_item and casting_spell.source_item.has_charges():
            item_entry = casting_spell.source_item.item_template.entry
            charges = casting_spell.source_item.get_charges(casting_spell.spell_entry.ID)
            # Avoid removing items which were already removed as reagents.
            if charges < 0 and item_entry not in removed_items:  # Negative charges remove items.
                self.caster.inventory.remove_items(item_entry, 1)

            if charges != 0 and charges != -1:  # don't modify if no charges remain or this item is a consumable.
                new_charges = charges-1 if charges > 0 else charges+1
                casting_spell.source_item.set_charges(casting_spell.spell_entry.ID, new_charges)

    def send_cast_result(self, casting_spell, error, misc_data=-1):
        # TODO CAST_SUCCESS_KEEP_TRACKING
        #  cast_status = SpellCastStatus.CAST_SUCCESS if error == SpellCheckCastResult.SPELL_CAST_OK else SpellCastStatus.CAST_FAILED

        is_player = self.caster.get_type_id() == ObjectTypeIds.ID_PLAYER
        spell_id = casting_spell.spell_entry.ID

        # Send spell failure only if this was an active spell.
        if error != SpellCheckCastResult.SPELL_NO_ERROR:
            # Do not broadcast errors upon creature spell cast validate() failing.
            if spell_id not in self.casting_spells and casting_spell.creature_spell:
                return
            data = pack('<QIB', self.caster.guid, spell_id, error)
            packet = PacketWriter.get_packet(OpCode.SMSG_SPELL_FAILURE, data)
            MapManager.send_surrounding(packet, self.caster, include_self=is_player)

        if not is_player:
            charmer_or_summoner = self.caster.get_charmer_or_summoner()
            if charmer_or_summoner:
                charmer_or_summoner.pet_manager.handle_cast_result(spell_id, error)
            return

        # Only players receive cast results.
        if error == SpellCheckCastResult.SPELL_NO_ERROR:
            data = pack('<IB', spell_id, SpellCastStatus.CAST_SUCCESS)
        else:
            data = pack('<I2B', spell_id, SpellCastStatus.CAST_FAILED, error) if misc_data == -1 else \
                   pack('<I2BI', spell_id, SpellCastStatus.CAST_FAILED, error, misc_data)

        self.caster.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_CAST_RESULT, data))
