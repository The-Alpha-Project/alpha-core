import math
import time
from struct import pack
from typing import Optional

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.realm.RealmDatabaseManager import RealmDatabaseManager, CharacterSpell
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.WorldSessionStateHandler import WorldSessionStateHandler
from game.world.managers.abstractions.Vector import Vector
from game.world.managers.maps.MapManager import MapManager
from game.world.managers.objects.ObjectManager import ObjectManager
from game.world.managers.objects.spell import ExtendedSpellData
from game.world.managers.objects.spell.CastingSpell import CastingSpell
from game.world.managers.objects.spell.CooldownEntry import CooldownEntry
from game.world.managers.objects.spell.SpellEffectHandler import SpellEffectHandler
from network.packet.PacketWriter import PacketWriter, OpCode
from utils.Logger import Logger
from utils.constants.ItemCodes import InventoryError, ItemSubClasses, ItemClasses
from utils.constants.MiscCodes import ObjectTypeFlags, HitInfo, GameObjectTypes, AttackTypes, ObjectTypeIds
from utils.constants.SpellCodes import SpellCheckCastResult, SpellCastStatus, \
    SpellMissReason, SpellTargetMask, SpellState, SpellAttributes, SpellCastFlags, \
    SpellInterruptFlags, SpellChannelInterruptFlags, SpellAttributesEx
from utils.constants.UnitCodes import PowerTypes, StandState, WeaponMode


class SpellManager(object):
    def __init__(self, caster):
        self.caster = caster  # GameObject, Unit or Player.
        self.spells = {}
        self.cooldowns = []
        self.casting_spells = []

    def load_spells(self):
        for spell in RealmDatabaseManager.character_get_spells(self.caster.guid):
            self.spells[spell.spell] = spell

    def learn_spell(self, spell_id, cast_on_learn=False) -> bool:
        if self.caster.get_type_id() != ObjectTypeIds.ID_PLAYER:
            return False

        spell = DbcDatabaseManager.SpellHolder.spell_get_by_id(spell_id)
        if not spell:
            return False

        if spell_id in self.spells:
            return False

        db_spell = CharacterSpell()
        db_spell.guid = self.caster.guid
        db_spell.spell = spell_id
        RealmDatabaseManager.character_add_spell(db_spell)
        self.spells[spell_id] = db_spell

        data = pack('<H', spell_id)
        self.caster.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_LEARNED_SPELL, data))

        if cast_on_learn or spell.AttributesEx & SpellAttributesEx.SPELL_ATTR_EX_CAST_WHEN_LEARNED:
            self.start_spell_cast(spell, self.caster, SpellTargetMask.SELF)

        # Apply passive effects when they're learned. This will also apply talents on learn.
        if spell.Attributes & SpellAttributes.SPELL_ATTR_PASSIVE:
            self.apply_passive_spell_effects(spell)

        # TODO Teach skill required as well like in CharCreateHandler
        return True

    def unlearn_spell(self, spell_id) -> bool:
        if self.caster.get_type_id() == ObjectTypeIds.ID_PLAYER and \
                RealmDatabaseManager.character_delete_spell(self.caster.guid, spell_id) == 0:
            self.remove_cast_by_id(spell_id)
            del self.spells[spell_id]
            return True

        return False

    def cast_passive_spells(self):
        # Self-cast all passive spells. This will apply learned skills, proficiencies, talents etc.
        for spell_id in self.spells.keys():
            spell_template = DbcDatabaseManager.SpellHolder.spell_get_by_id(spell_id)
            if spell_template and spell_template.Attributes & SpellAttributes.SPELL_ATTR_PASSIVE:
                self.apply_passive_spell_effects(spell_template)

    def apply_cast_when_learned_spells(self):
        # Cast any spell with SPELL_ATTR_EX_CAST_WHEN_LEARNED flag on player.
        for spell_id in self.spells.keys():
            spell_template = DbcDatabaseManager.SpellHolder.spell_get_by_id(spell_id)
            if spell_template and spell_template.AttributesEx & SpellAttributesEx.SPELL_ATTR_EX_CAST_WHEN_LEARNED:
                self.start_spell_cast(spell_template, self.caster, SpellTargetMask.SELF)

    def apply_passive_spell_effects(self, spell_template):
        if spell_template.Attributes & SpellAttributes.SPELL_ATTR_PASSIVE:
            spell = self.try_initialize_spell(spell_template, self.caster, SpellTargetMask.SELF,
                                              validate=False)
            spell.resolve_target_info_for_effects()
            self.apply_spell_effects(spell)

    def get_initial_spells(self) -> bytes:
        spell_buttons = RealmDatabaseManager.character_get_spell_buttons(self.caster.guid)

        data = pack('<BH', 0, len(self.spells))
        for spell_id, spell in self.spells.items():
            index = spell_buttons[spell.spell] if spell.spell in spell_buttons else 0
            data += pack('<2h', spell.spell, index)
        data += pack('<H', 0)

        return PacketWriter.get_packet(OpCode.SMSG_INITIAL_SPELLS, data)

    def handle_item_cast_attempt(self, item, spell_target, target_mask):
        if not self.caster.object_type_mask & ObjectTypeFlags.TYPE_UNIT:
            return

        for spell_info in item.spell_stats:
            if spell_info.spell_id == 0:
                break
            spell = DbcDatabaseManager.SpellHolder.spell_get_by_id(spell_info.spell_id)
            if not spell:
                Logger.warning(f'Spell {spell_info.spell_id} tied to item {item.item_template.entry} ({item.item_template.name}) could not be found in the spell database.')
                continue

            casting_spell = self.try_initialize_spell(spell, spell_target, target_mask, item)
            if not casting_spell:
                continue
            if casting_spell.is_refreshment_spell():  # Food/drink items don't send sit packet - handle here
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

    def try_initialize_spell(self, spell, spell_target, target_mask, source_item=None,
                             triggered=False, validate=True) -> Optional[CastingSpell]:
        spell = CastingSpell(spell, self.caster, spell_target, target_mask, source_item, triggered=triggered)
        if not validate:
            return spell
        return spell if self.validate_cast(spell) else None

    def start_spell_cast(self, spell=None, spell_target=None, target_mask=SpellTargetMask.SELF, source_item=None,
                         triggered=False, initialized_spell=None):
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

        # If the spell uses a ranged weapon, draw it.
        if self.caster.object_type_mask & ObjectTypeFlags.TYPE_UNIT and casting_spell.is_ranged_weapon_attack():
            self.caster.set_weapon_mode(WeaponMode.RANGEDMODE)

        if not casting_spell.is_instant_cast():
            if not casting_spell.triggered:
                self.send_cast_start(casting_spell)
            return

        # Spell is instant, perform cast
        self.perform_spell_cast(casting_spell, validate=False)

    def perform_spell_cast(self, casting_spell, validate=True):
        if validate and not self.validate_cast(casting_spell):
            self.remove_cast(casting_spell)
            return

        casting_spell.resolve_target_info_for_effects()

        if casting_spell.cast_state == SpellState.SPELL_STATE_DELAYED:
            return  # Spell is in delayed state, do nothing for now

        self.send_cast_result(casting_spell.spell_entry.ID, SpellCheckCastResult.SPELL_NO_ERROR)
        self.send_spell_go(casting_spell)

        if self.caster.object_type_mask & ObjectTypeFlags.TYPE_UNIT and \
                not casting_spell.triggered:  # Triggered spells (ie. channel ticks) shouldn't interrupt other casts
            self.caster.aura_manager.check_aura_interrupts(cast_spell=True)

        travel_times = self.calculate_impact_delays(casting_spell)

        if len(travel_times) != 0:
            casting_spell.spell_impact_timestamps = {}
            curr_time = time.time()

            for guid, delay in travel_times.items():
                casting_spell.spell_impact_timestamps[guid] = curr_time + delay

            casting_spell.cast_state = SpellState.SPELL_STATE_DELAYED
            self.consume_resources_for_cast(casting_spell)  # Remove resources
            return

        casting_spell.cast_state = SpellState.SPELL_STATE_FINISHED
        if casting_spell.is_channeled():
            self.handle_channel_start(casting_spell)  # Channeled spells require more setup before effect application
        else:
            self.apply_spell_effects(casting_spell)  # Apply effects
            # Some spell effect handlers will set the spell state to active as the handler needs to be called on updates
            if casting_spell.cast_state != SpellState.SPELL_STATE_ACTIVE:
                self.remove_cast(casting_spell)

        self.set_on_cooldown(casting_spell)
        self.consume_resources_for_cast(casting_spell)  # Remove resources - order matters for combo points

    def apply_spell_effects(self, casting_spell, remove=False, update=False, partial_targets=None):
        if not update:
            self.handle_procs_for_cast(casting_spell)

        for effect in casting_spell.get_effects():
            if not update:
                effect.start_aura_duration()

            if effect.effect_type in SpellEffectHandler.AREA_SPELL_EFFECTS:
                SpellEffectHandler.apply_effect(casting_spell, effect, casting_spell.spell_caster, None)
                continue

            object_targets = effect.targets.get_resolved_effect_targets_by_type(ObjectManager)

            for target in object_targets:
                if partial_targets and target.guid not in partial_targets:
                    continue
                info = casting_spell.object_target_results[target.guid]
                # TODO deflection handling? Swap target/caster for now
                if info.result == SpellMissReason.MISS_REASON_DEFLECTED:
                    SpellEffectHandler.apply_effect(casting_spell, effect, info.target, casting_spell.spell_caster)
                elif info.result == SpellMissReason.MISS_REASON_NONE:
                    SpellEffectHandler.apply_effect(casting_spell, effect, casting_spell.spell_caster, info.target)

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
                if target_info.result != SpellMissReason.MISS_REASON_NONE:
                    continue
                if target.object_type_mask & ObjectTypeFlags.TYPE_UNIT:
                    target.aura_manager.check_aura_procs(involved_cast=casting_spell)
                if casting_spell.spell_caster.get_type_id() != ObjectTypeIds.ID_GAMEOBJECT:
                    casting_spell.spell_caster.aura_manager.check_aura_procs(involved_cast=casting_spell)
                applied_targets.append(target.guid)

    def cast_queued_melee_ability(self, attack_type) -> bool:
        melee_ability = self.get_queued_melee_ability()

        if not melee_ability or not self.validate_cast(melee_ability):
            self.remove_cast(melee_ability)
            return False

        melee_ability.spell_attack_type = attack_type

        melee_ability.cast_state = SpellState.SPELL_STATE_CASTING
        self.perform_spell_cast(melee_ability, False)
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

            cast_finished = casting_spell.cast_end_timestamp <= timestamp
            if casting_spell.cast_state == SpellState.SPELL_STATE_ACTIVE:  # Channel tick/spells that need updates.
                self.handle_spell_effect_update(casting_spell, timestamp)  # Update effects if the cast wasn't interrupted.

                if casting_spell.is_channeled() and cast_finished:
                    self.remove_cast(casting_spell)
                continue

            if casting_spell.cast_state == SpellState.SPELL_STATE_CASTING and not casting_spell.is_instant_cast():
                if cast_finished:
                    self.perform_spell_cast(casting_spell)
                    if casting_spell.cast_state == SpellState.SPELL_STATE_FINISHED:  # Spell finished after perform (no impact delay).
                        self.remove_cast(casting_spell)

            if casting_spell.cast_state == SpellState.SPELL_STATE_DELAYED:  # Waiting for impact delay.
                targets_due = [guid for guid, stamp in casting_spell.spell_impact_timestamps.items() if stamp <= timestamp]
                if not targets_due:
                    continue

                for target in targets_due:
                    casting_spell.spell_impact_timestamps.pop(target)

                if len(casting_spell.spell_impact_timestamps) == 0:  # All targets finished impact delay.
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
            SpellInterruptFlags.SPELL_INTERRUPT_FLAG_AUTOATTACK: received_auto_attack,
        }
        channeling_spell_flag_cases = {
            SpellChannelInterruptFlags.CHANNEL_INTERRUPT_FLAG_DAMAGE: received_damage,
            SpellChannelInterruptFlags.CHANNEL_INTERRUPT_FLAG_MOVEMENT: moved,
            SpellChannelInterruptFlags.CHANNEL_INTERRUPT_FLAG_TURNING: turned,
            SpellChannelInterruptFlags.CHANNEL_INTERRUPT_FLAG_FULL_INTERRUPT: received_auto_attack

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
                    if not (channel_flags & SpellChannelInterruptFlags.CHANNEL_INTERRUPT_FLAG_FULL_INTERRUPT) and hit_info != HitInfo.CRUSHING and \
                            flag != SpellChannelInterruptFlags.CHANNEL_INTERRUPT_FLAG_MOVEMENT:
                        casting_spell.handle_partial_interrupt()
                    else:
                        self.remove_cast(casting_spell, SpellCheckCastResult.SPELL_FAILED_INTERRUPTED, interrupted=True)
                continue

            for flag, condition in casting_spell_flag_cases.items():
                spell_flags = casting_spell.spell_entry.InterruptFlags
                if not (spell_flags & flag) or not condition:
                    continue

                # - Creatures dealing enough damage (crushing blow) will now fully interrupt casting. (0.5.3 notes).
                if spell_flags & SpellInterruptFlags.SPELL_INTERRUPT_FLAG_PARTIAL and hit_info != HitInfo.CRUSHING and \
                        flag != SpellInterruptFlags.SPELL_INTERRUPT_FLAG_MOVEMENT:
                    casting_spell.handle_partial_interrupt()
                else:
                    self.remove_cast(casting_spell, SpellCheckCastResult.SPELL_FAILED_INTERRUPTED, interrupted=True)

    def remove_cast(self, casting_spell, cast_result=SpellCheckCastResult.SPELL_NO_ERROR, interrupted=False) -> bool:
        if casting_spell not in self.casting_spells:
            return False

        self.casting_spells.remove(casting_spell)

        # Cancel auras applied by an active spell if the spell was interrupted.
        # If the cast finished normally, auras should wear off because of duration.
        # Since spell update happens before aura update, last ticks will be skipped if auras are cancelled on cast finish.
        if casting_spell.cast_state == SpellState.SPELL_STATE_ACTIVE and interrupted:
            for miss_info in casting_spell.object_target_results.values():  # Get the last effect application results.
                if not miss_info.target.object_type_mask & ObjectTypeFlags.TYPE_UNIT:
                    continue
                miss_info.target.aura_manager.cancel_auras_by_spell_id(casting_spell.spell_entry.ID)  # Cancel effects from this aura.

        if casting_spell.is_channeled():
            self.handle_channel_end(casting_spell)

        if cast_result != SpellCheckCastResult.SPELL_NO_ERROR:
            self.send_cast_result(casting_spell.spell_entry.ID, cast_result)

        return True

    def remove_cast_by_id(self, spell_id, interrupted=False) -> bool:
        removed = False
        for casting_spell in list(self.casting_spells):
            if spell_id != casting_spell.spell_entry.ID:
                continue
            result = SpellCheckCastResult.SPELL_FAILED_INTERRUPTED if interrupted else SpellCheckCastResult.SPELL_NO_ERROR
            removed = removed or self.remove_cast(casting_spell, result, interrupted)
        return removed

    def remove_all_casts(self, cast_result=SpellCheckCastResult.SPELL_NO_ERROR):
        for casting_spell in list(self.casting_spells):
            result = SpellCheckCastResult.SPELL_FAILED_INTERRUPTED
            if not casting_spell.is_channeled() and casting_spell.cast_state == SpellState.SPELL_STATE_ACTIVE or \
                    casting_spell.cast_state == SpellState.SPELL_STATE_DELAYED:
                result = SpellCheckCastResult.SPELL_NO_ERROR  # Don't send interrupted error for active/delayed spells

            self.remove_cast(casting_spell, result, interrupted=True)

    def remove_unit_from_all_cast_targets(self, target_guid):
        for casting_spell in list(self.casting_spells):
            for effect in casting_spell.get_effects():
                effect.targets.remove_object_from_targets(target_guid)

            # Interrupt handling
            if not casting_spell.initial_target_is_unit_or_player() or \
                    (casting_spell.spell_target_mask == SpellTargetMask.SELF and not
                        casting_spell.requires_implicit_initial_unit_target()) or \
                    (casting_spell.is_instant_cast() and not casting_spell.is_channeled()):
                # Ignore spells that are non-unit targeted, self-cast or instant.
                continue

            if target_guid in casting_spell.object_target_results:  # Only target of this spell.
                result = SpellCheckCastResult.SPELL_FAILED_INTERRUPTED
                if not casting_spell.is_channeled() and casting_spell.cast_state == SpellState.SPELL_STATE_ACTIVE or \
                        casting_spell.cast_state == SpellState.SPELL_STATE_DELAYED:
                    result = SpellCheckCastResult.SPELL_NO_ERROR  # Don't send interrupted error for active/delayed spells.

                self.remove_cast(casting_spell, result, interrupted=True)
                return

    def remove_colliding_casts(self, current_cast):
        for casting_spell in self.casting_spells:
            if casting_spell.cast_state == SpellState.SPELL_STATE_CASTING or casting_spell.is_channeled():
                self.remove_cast(casting_spell, SpellCheckCastResult.SPELL_FAILED_INTERRUPTED, interrupted=True)
                continue

            if ExtendedSpellData.AuraSourceRestrictions.are_colliding_auras(casting_spell.spell_entry.ID,
                                                                            current_cast.spell_entry.ID):  # Paladin auras.
                self.remove_cast(casting_spell, interrupted=True)
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
        if not self.caster.object_type_mask & ObjectTypeFlags.TYPE_UNIT:
            return  # Non-unit casters should not broadcast their casts.

        data = [self.caster.guid, self.caster.guid,
                casting_spell.spell_entry.ID, casting_spell.cast_flags, casting_spell.get_base_cast_time(),
                casting_spell.spell_target_mask]

        signature = '<2QIHiH'  # source, caster, ID, flags, delay .. (targets, opt. ammo displayID / inventorytype).

        if casting_spell.initial_target and casting_spell.spell_target_mask != SpellTargetMask.SELF:  # Some self-cast spells crash client if target is written.
            target_info = casting_spell.get_initial_target_info()  # ([values], signature).
            data.extend(target_info[0])
            signature += target_info[1]

        if casting_spell.cast_flags & SpellCastFlags.CAST_FLAG_HAS_AMMO:
            signature += '2I'
            data.append(casting_spell.used_ranged_attack_item.item_template.display_id)
            data.append(casting_spell.used_ranged_attack_item.item_template.inventory_type)

        data = pack(signature, *data)
        MapManager.send_surrounding(PacketWriter.get_packet(OpCode.SMSG_SPELL_START, data), self.caster,
                                    include_self=self.caster.get_type_id() == ObjectTypeIds.ID_PLAYER)

    def handle_channel_start(self, casting_spell):
        if not casting_spell.is_channeled() or casting_spell.duration_entry.Duration == -1:
            return
        casting_spell.cast_state = SpellState.SPELL_STATE_ACTIVE
        channel_end_timestamp = casting_spell.duration_entry.Duration/1000 + time.time()
        casting_spell.cast_start_timestamp = time.time()
        casting_spell.cast_end_timestamp = channel_end_timestamp  # Set the new timestamp for cast finish.

        if casting_spell.initial_target_is_object():
            self.caster.set_channel_object(casting_spell.initial_target.guid)
        self.caster.set_channel_spell(casting_spell.spell_entry.ID)

        self.apply_spell_effects(casting_spell)

        if self.caster.get_type_id() != ObjectTypeIds.ID_PLAYER:
            return

        data = pack('<2I', casting_spell.spell_entry.ID, casting_spell.duration_entry.Duration)  # No channeled spells with duration per level.
        self.caster.enqueue_packet(PacketWriter.get_packet(OpCode.MSG_CHANNEL_START, data))
        # TODO Channeling animations do not play

    def handle_spell_effect_update(self, casting_spell, timestamp):
        for effect in casting_spell.get_effects():
            # Refresh targets.
            casting_spell.resolve_target_info_for_effect(effect.effect_index)

            # Auras applied by channels can be independent of targets.
            # Handle all channeled spells in a way that they don't require an AuraManager tick to update.

            # Update ticks that expired during previous update.
            effect.remove_old_periodic_effect_ticks()

            # Update effect aura duration.
            effect.update_effect_aura(timestamp)

            # Area spell effect update.
            if effect.effect_type in SpellEffectHandler.AREA_SPELL_EFFECTS:
                self.apply_spell_effects(casting_spell, update=True)

    def handle_channel_end(self, casting_spell):
        if not casting_spell.is_channeled():
            return

        if self.caster.get_type_id() != ObjectTypeIds.ID_PLAYER:
            return

        if self.caster.channel_object:  # Interrupting Ritual of Summoning required special handling.
            self._handle_summoning_channel_end()

        self.caster.set_channel_object(0)
        self.caster.set_channel_spell(0)

        if self.caster.get_type_id() != ObjectTypeIds.ID_PLAYER:
            return

        data = pack('<I', 0)
        self.caster.enqueue_packet(PacketWriter.get_packet(OpCode.MSG_CHANNEL_UPDATE, data))

    def send_spell_go(self, casting_spell):
        # The client expects the source to only be set for unit casters.
        source_unit = self.caster.guid if self.caster.object_type_mask & ObjectTypeFlags.TYPE_UNIT else 0

        data = [self.caster.guid, source_unit,
                casting_spell.spell_entry.ID, casting_spell.cast_flags]

        signature = '<2QIH'  # caster, source, ID, flags .. (targets, ammo info).

        # Prepare target data
        results_by_type = {SpellMissReason.MISS_REASON_NONE: []}  # Hits need to be written first.

        # Only include the primary effect targets.
        targets = casting_spell.get_effects()[0].targets.get_resolved_effect_targets_by_type(ObjectManager)
        for target in targets:
            miss_info = casting_spell.object_target_results[target.guid]
            new_targets = results_by_type.get(miss_info.result, [])
            new_targets.append(target.guid)
            results_by_type[miss_info.result] = new_targets  # Sort targets by hit type for filling packet fields.

        hit_count = len(results_by_type[SpellMissReason.MISS_REASON_NONE])
        miss_count = len(targets) - hit_count  # Subtract hits from all targets.
        # Write targets, hits first
        for result, guids in results_by_type.items():
            if result == SpellMissReason.MISS_REASON_NONE:  # Hit count is written separately.
                signature += 'B'
                data.append(hit_count)

            if result != SpellMissReason.MISS_REASON_NONE:  # Write reason for miss.
                signature += 'B'
                data.append(result)

            if len(guids) > 0:  # Write targets if there are any.
                signature += f'{len(guids)}Q'
            for target_guid in guids:
                data.append(target_guid)

            if result == SpellMissReason.MISS_REASON_NONE:  # Write miss count at the end of hits since it needs to be written even if none happen.
                signature += 'B'
                data.append(miss_count)

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

        packed = pack(signature, *data)
        MapManager.send_surrounding(PacketWriter.get_packet(OpCode.SMSG_SPELL_GO, packed), self.caster,
                                    include_self=self.caster.get_type_id() == ObjectTypeIds.ID_PLAYER)

    def set_on_cooldown(self, casting_spell, start_locked_cooldown=False):
        spell = casting_spell.spell_entry

        if spell.RecoveryTime == 0 and spell.CategoryRecoveryTime == 0:
            return

        timestamp = time.time()

        if start_locked_cooldown:
            data = pack('<IQ', spell.ID, self.caster.guid)
            self.caster.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_COOLDOWN_EVENT, data))
            for cooldown in self.cooldowns:
                if cooldown.spell_id == spell.ID:
                    cooldown.unlock(timestamp)
                    return
            Logger.warning(f'[SpellManager]: Attempted to unlock cooldown for spell {spell.ID}, but the cooldown didn\'t exist.')

        cooldown_entry = CooldownEntry(spell, timestamp, casting_spell.trigger_cooldown_on_aura_remove())
        self.cooldowns.append(cooldown_entry)

        if self.caster.get_type_id() != ObjectTypeIds.ID_PLAYER:
            return

        data = pack('<IQI', spell.ID, self.caster.guid, cooldown_entry.cooldown_length)
        self.caster.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_SPELL_COOLDOWN, data))

    def check_spell_cooldowns(self):
        for cooldown_entry in list(self.cooldowns):
            if cooldown_entry.is_valid():
                continue

            self.cooldowns.remove(cooldown_entry)
            if self.caster.get_type_id() != ObjectTypeIds.ID_PLAYER:
                continue
            data = pack('<IQ', cooldown_entry.spell_id, self.caster.guid)
            self.caster.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_CLEAR_COOLDOWN, data))

    def is_on_cooldown(self, spell_entry) -> bool:
        for cooldown_entry in list(self.cooldowns):
            if cooldown_entry.is_valid() and cooldown_entry.matches_spell(spell_entry):
                return True
        return False

    def is_casting(self):
        for spell in list(self.casting_spells):
            if spell.cast_state == SpellState.SPELL_STATE_CASTING or \
                    (spell.is_channeled() and spell.cast_state == SpellState.SPELL_STATE_ACTIVE):
                return True
        return False

    def is_casting_spell(self, spell_id):
        for spell in list(self.casting_spells):
            if spell.spell_entry.ID == spell_id and \
                    (spell.cast_state == SpellState.SPELL_STATE_CASTING or
                        (spell.is_channeled() and spell.cast_state == SpellState.SPELL_STATE_ACTIVE)):
                return True
        return False

    def validate_cast(self, casting_spell) -> bool:
        if self.is_on_cooldown(casting_spell.spell_entry):
            self.send_cast_result(casting_spell.spell_entry.ID, SpellCheckCastResult.SPELL_FAILED_NOT_READY)
            return False

        if (not casting_spell.triggered and not casting_spell.source_item) and casting_spell.cast_state == SpellState.SPELL_STATE_PREPARING and \
                self.caster.get_type_id() == ObjectTypeIds.ID_PLAYER and \
                (not casting_spell.spell_entry or casting_spell.spell_entry.ID not in self.spells):
            self.send_cast_result(casting_spell.spell_entry.ID, SpellCheckCastResult.SPELL_FAILED_NOT_KNOWN)
            return False

        # Caster unit-only checks.
        if self.caster.object_type_mask & ObjectTypeFlags.TYPE_UNIT:
            if not self.caster.is_alive and \
                    casting_spell.spell_entry.Attributes & SpellAttributes.SPELL_ATTR_ALLOW_CAST_WHILE_DEAD != SpellAttributes.SPELL_ATTR_ALLOW_CAST_WHILE_DEAD:
                self.send_cast_result(casting_spell.spell_entry.ID, SpellCheckCastResult.SPELL_FAILED_CASTER_DEAD)
                return False

            if not casting_spell.spell_entry.Attributes & SpellAttributes.SPELL_ATTR_CASTABLE_WHILE_SITTING and \
                    self.caster.stand_state != StandState.UNIT_STANDING:
                self.send_cast_result(casting_spell.spell_entry.ID, SpellCheckCastResult.SPELL_FAILED_NOTSTANDING)
                return False

            if casting_spell.spell_entry.Attributes & SpellAttributes.SPELL_ATTR_ONLY_STEALTHED and \
                    not self.caster.is_stealthed():
                self.send_cast_result(casting_spell.spell_entry.ID, SpellCheckCastResult.SPELL_FAILED_ONLY_STEALTHED)
                return True

        # Target validation.

        validation_target = casting_spell.initial_target
        # In the case of the spell requiring an unit target but being cast on self,
        # validate the spell against the caster's current unit selection instead.
        if casting_spell.spell_target_mask == SpellTargetMask.SELF and \
                casting_spell.requires_implicit_initial_unit_target():
            validation_target = casting_spell.targeted_unit_on_cast_start

            if validation_target and not self.caster.can_attack_target(validation_target):
                # All secondary initial unit targets are hostile. Unlike (nearly?) all other spells,
                # the target for arcane missiles is not validated by the client (script effect). Catch that case here.
                self.send_cast_result(casting_spell.spell_entry.ID, SpellCheckCastResult.SPELL_FAILED_BAD_TARGETS)
                return False

        if not validation_target:
            self.send_cast_result(casting_spell.spell_entry.ID, SpellCheckCastResult.SPELL_FAILED_BAD_IMPLICIT_TARGETS)
            return False

        if casting_spell.initial_target_is_unit_or_player() and not validation_target.is_alive:  # TODO dead targets (resurrect)
            self.send_cast_result(casting_spell.spell_entry.ID, SpellCheckCastResult.SPELL_FAILED_TARGETS_DEAD)
            return False

        if casting_spell.initial_target_is_unit_or_player():  # Orientation checks.
            target_is_facing_caster = validation_target.location.has_in_arc(self.caster.location, math.pi)
            if not ExtendedSpellData.CastPositionRestrictions.is_position_correct(casting_spell.spell_entry.ID, target_is_facing_caster):
                self.send_cast_result(casting_spell.spell_entry.ID, SpellCheckCastResult.SPELL_FAILED_NOT_BEHIND)  # no code for target must be facing caster?
                return False

        # Check if the caster is within range of the (world) target to cast the spell.
        if not casting_spell.initial_target_is_item() and \
                casting_spell.range_entry.RangeMin > 0 or casting_spell.range_entry.RangeMax > 0:
            if casting_spell.initial_target_is_terrain():
                distance = validation_target.distance(self.caster.location)
            else:
                distance = validation_target.location.distance(self.caster.location)

            if distance > casting_spell.range_entry.RangeMax:
                self.send_cast_result(casting_spell.spell_entry.ID, SpellCheckCastResult.SPELL_FAILED_OUT_OF_RANGE)
                return False
            if distance < casting_spell.range_entry.RangeMin:
                self.send_cast_result(casting_spell.spell_entry.ID, SpellCheckCastResult.SPELL_FAILED_TOO_CLOSE)
                return False

        # Aura bounce check.
        if casting_spell.initial_target_is_unit_or_player():
            if not validation_target.aura_manager.are_spell_effects_applicable(casting_spell):
                self.send_cast_result(casting_spell.spell_entry.ID, SpellCheckCastResult.SPELL_FAILED_AURA_BOUNCED)
                return False

        # Special case of Ritual of Summoning.
        summoning_channel_id = 698
        if casting_spell.spell_entry.ID == summoning_channel_id and not self._validate_summon_cast(casting_spell):
            # If the summon effect fails, the channel must be interrupted.
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
            self.send_cast_result(casting_spell.spell_entry.ID,
                                  SpellCheckCastResult.SPELL_FAILED_BAD_IMPLICIT_TARGETS)
            return False

        target_unit = WorldSessionStateHandler.find_player_by_guid(target_guid)
        if not target_unit:  # Couldn't find player with this guid - not a player.
            self.send_cast_result(casting_spell.spell_entry.ID, SpellCheckCastResult.SPELL_FAILED_TARGET_NOT_PLAYER)
            return False

        if not target_unit.is_alive:
            self.send_cast_result(casting_spell.spell_entry.ID, SpellCheckCastResult.SPELL_FAILED_TARGETS_DEAD)
            return False

        if not self.caster.group_manager or not self.caster.group_manager.is_party_member(target_guid):
            self.send_cast_result(casting_spell.spell_entry.ID,
                                  SpellCheckCastResult.SPELL_FAILED_TARGET_NOT_IN_PARTY)
            return False  # Only party members can be summoned.

        if casting_spell.cast_state in [SpellState.SPELL_STATE_PREPARING, SpellState.SPELL_STATE_CASTING]:
            # The checks before this are used during ritual cast initialization and finishing.
            # The checks after are also used for the summon spell finishing.
            return True

        if not self.caster.channel_object:
            self.send_cast_result(casting_spell.spell_entry.ID, SpellCheckCastResult.SPELL_FAILED_DONT_REPORT)
            return False

        channel_object = MapManager.get_surrounding_gameobject_by_guid(self.caster,
                                                                       self.caster.channel_object)
        if not channel_object or channel_object.gobject_template.type != GameObjectTypes.TYPE_RITUAL or channel_object.ritual_caster is not self.caster:
            self.send_cast_result(casting_spell.spell_entry.ID, SpellCheckCastResult.SPELL_FAILED_DONT_REPORT)
            return False

        return True

    def _handle_summoning_channel_end(self):
        # Specific handling of ritual of summoning interrupting.
        if not self.caster.channel_object:
            return
        channel_object = MapManager.get_surrounding_gameobject_by_guid(self.caster, self.caster.channel_object)
        if not channel_object or channel_object.gobject_template.type != GameObjectTypes.TYPE_RITUAL:
            return

        # If the ritual caster interrupts channeling, interrupt others and remove the portal.
        if channel_object.ritual_caster is self.caster:
            MapManager.remove_object(channel_object)

            ritual_channel_spell_id = channel_object.gobject_template.data2
            for player in channel_object.ritual_participants:
                # Note that this call will lead to _handle_summoning_channel_end() calls from the participants.
                player.spell_manager.remove_cast_by_id(ritual_channel_spell_id)

        # If a participant interrupts their channeling, remove from participants and interrupt summoning if necessary.
        elif self.caster in channel_object.ritual_participants:
            channel_object.ritual_participants.remove(self.caster)
            required_participants = channel_object.gobject_template.data0
            if len(channel_object.ritual_participants) < required_participants - 1:  # -1 to include ritual caster.
                ritual_summon_spell_id = channel_object.gobject_template.data1
                channel_object.ritual_caster.spell_manager.remove_cast_by_id(ritual_summon_spell_id)

    def meets_casting_requisites(self, casting_spell) -> bool:
        # This method should only check resource costs (ie. power/combo/items).
        if not self.caster.object_type_mask & ObjectTypeFlags.TYPE_UNIT:
            return True  # Skip checks for non-unit casters.

        has_health_cost = casting_spell.spell_entry.PowerType == PowerTypes.TYPE_HEALTH
        power_cost = casting_spell.get_resource_cost()
        has_correct_power = self.caster.power_type == casting_spell.spell_entry.PowerType or has_health_cost
        is_player = self.caster.get_type_id() == ObjectTypeIds.ID_PLAYER
        # Non players are able to cast spells even if they lack the required power.
        ignore_wrong_power = not is_player

        if not has_health_cost and power_cost and not has_correct_power and not ignore_wrong_power:
            # Doesn't have the correct power type.
            self.send_cast_result(casting_spell.spell_entry.ID, SpellCheckCastResult.SPELL_FAILED_NO_POWER)
            return False

        current_power = self.caster.health if has_health_cost else self.caster.get_power_type_value()
        if power_cost > current_power and has_correct_power:
            # Doesn't have enough power. Check for correct power to properly ignore wrong power if necessary.
            if not has_health_cost:
                self.send_cast_result(casting_spell.spell_entry.ID, SpellCheckCastResult.SPELL_FAILED_NO_POWER)
            else:
                # Health cost fail displays on client before server response.
                self.send_cast_result(casting_spell.spell_entry.ID, SpellCheckCastResult.SPELL_NO_ERROR)
            return False

        # Player only checks
        if self.caster.get_type_id() == ObjectTypeIds.ID_PLAYER:
            # Check if player has required combo points.
            if casting_spell.requires_combo_points() and \
                    (casting_spell.initial_target.guid != self.caster.combo_target or
                     # Doesn't have required combo points.
                     self.caster.combo_points == 0):
                self.send_cast_result(casting_spell.spell_entry.ID, SpellCheckCastResult.SPELL_FAILED_NO_COMBO_POINTS)
                return False

            # Check if player has required reagents.
            for reagent_info, count in casting_spell.get_reagents():
                if reagent_info == 0:
                    break

                if self.caster.inventory.get_item_count(reagent_info) < count:
                    self.send_cast_result(casting_spell.spell_entry.ID, SpellCheckCastResult.SPELL_FAILED_REAGENTS)
                    return False

            # Check if player has required weapon and ammo.
            if casting_spell.spell_attack_type != -1:
                required_weapon_mask = casting_spell.spell_entry.EquippedItemSubclass
                equipped_weapon = self.caster.get_current_weapon_for_attack_type(casting_spell.spell_attack_type)
                if not equipped_weapon:
                    self.send_cast_result(casting_spell.spell_entry.ID, SpellCheckCastResult.SPELL_FAILED_EQUIPPED_ITEM)
                    return False
                subclass_mask = 1 << equipped_weapon.item_template.subclass
                if not required_weapon_mask & subclass_mask:
                    self.send_cast_result(casting_spell.spell_entry.ID, SpellCheckCastResult.SPELL_FAILED_EQUIPPED_ITEM_CLASS)
                    return False

                required_ammo = equipped_weapon.item_template.ammo_type
                # Only check consumable ammo.
                if required_ammo in [ItemSubClasses.ITEM_SUBCLASS_ARROW, ItemSubClasses.ITEM_SUBCLASS_BULLET]:
                    target_bag_slot = self.caster.inventory.get_bag_slot_for_ammo(required_ammo)
                    if target_bag_slot == -1:
                        # SPELL_FAILED_NEED_AMMO_POUCH Seems to crash client.
                        self.send_cast_result(casting_spell.spell_entry.ID, SpellCheckCastResult.SPELL_FAILED_NO_AMMO)
                        return False

                    target_bag = self.caster.inventory.get_container(target_bag_slot)
                    target_ammo = next(iter(target_bag.sorted_slots.values()), None)  # Get first item in bag.
                    if not target_ammo or target_ammo != casting_spell.used_ranged_attack_item:
                        # Also validate against casting_spell.used_ranged_attack_item,
                        # the initially selected ammo (inventory manipulation during casting)

                        # Note: SPELL_FAILED_NEED_AMMO crashes client even though it is present in the code.
                        # It was used later for "Ammo needs to be in the paper doll ammo slot before it can be fired",
                        # but the slot does not exist in 0.5.3.
                        self.send_cast_result(casting_spell.spell_entry.ID, SpellCheckCastResult.SPELL_FAILED_NO_AMMO)
                        return False

            # Spells cast with consumables.
            if casting_spell.source_item and casting_spell.source_item.has_charges():
                spell_stats = casting_spell.get_item_spell_stats()
                charges = spell_stats.charges
                if charges == 0:  # no charges left.
                    self.send_cast_result(casting_spell.spell_entry.ID,
                                          SpellCheckCastResult.SPELL_FAILED_NO_CHARGES_REMAIN)
                    return False
                if charges < 0 and self.caster.inventory.get_item_count(casting_spell.source_item.item_template.entry) < 1:  # Consumables have negative charges.
                    self.send_cast_result(casting_spell.spell_entry.ID,
                                          SpellCheckCastResult.SPELL_FAILED_ITEM_NOT_FOUND)  # Should never really happen but catch this case.
                    return False

            for tool in casting_spell.get_required_tools():
                if not tool:
                    break
                if not self.caster.inventory.get_first_item_by_entry(tool):
                    self.send_cast_result(casting_spell.spell_entry.ID, SpellCheckCastResult.SPELL_FAILED_TOTEMS)
                    return False

            # Check if player inventory has space left.
            for item, count in casting_spell.get_conjured_items():
                if item == 0:
                    break

                item_template = WorldDatabaseManager.ItemTemplateHolder.item_template_get_by_entry(item)
                error = self.caster.inventory.can_store_item(item_template, count)
                if error != InventoryError.BAG_OK:
                    self.caster.inventory.send_equip_error(error)
                    self.send_cast_result(casting_spell.spell_entry.ID, SpellCheckCastResult.SPELL_FAILED_DONT_REPORT)
                    return False

        return True

    def consume_resources_for_cast(self, casting_spell):
        # This method assumes that the reagents exist (meets_casting_requisites was run).
        if not self.caster.object_type_mask & ObjectTypeFlags.TYPE_UNIT:
            return

        power_type = casting_spell.spell_entry.PowerType
        # Check if this spell should consume all power.
        if casting_spell.spell_entry.AttributesEx & SpellAttributesEx.SPELL_ATTR_EX_DRAIN_ALL_POWER:
            new_power = 0
        else:
            cost = casting_spell.get_resource_cost()
            # Note: resources are consumed after the cast, which means that the caster's power type can change.
            # Pass the required power to get_power_type_value.
            current_power = self.caster.health if power_type == PowerTypes.TYPE_HEALTH else self.caster.get_power_type_value(power_type)
            new_power = current_power - cost

        if power_type == PowerTypes.TYPE_MANA:
            self.caster.set_mana(new_power)
        elif power_type == PowerTypes.TYPE_RAGE:
            self.caster.set_rage(new_power)
        elif power_type == PowerTypes.TYPE_FOCUS:
            self.caster.set_focus(new_power)
        elif power_type == PowerTypes.TYPE_ENERGY:
            self.caster.set_energy(new_power)
        elif power_type == PowerTypes.TYPE_HEALTH:
            self.caster.set_health(new_power)

        if self.caster.get_type_id() == ObjectTypeIds.ID_PLAYER and \
                casting_spell.requires_combo_points():
            self.caster.remove_combo_points()

        for reagent_info in casting_spell.get_reagents():  # Reagents.
            if reagent_info[0] == 0:
                break
            self.caster.inventory.remove_items(reagent_info[0], reagent_info[1])

        # Ammo
        used_ammo_or_weapon = casting_spell.used_ranged_attack_item
        if casting_spell.spell_attack_type == AttackTypes.RANGED_ATTACK and used_ammo_or_weapon:
            # Validation ensures that the initially selected ammo (used_ranged_attack_item) remains the same.
            ammo_class = used_ammo_or_weapon.item_template.class_
            ammo_subclass = used_ammo_or_weapon.item_template.subclass

            # Projectiles and thrown weapons are consumed on use.
            is_consumable = ammo_class == ItemClasses.ITEM_CLASS_PROJECTILE or \
                (ammo_class == ItemClasses.ITEM_CLASS_WEAPON and
                    ammo_subclass == ItemSubClasses.ITEM_SUBCLASS_THROWN)
            if is_consumable:
                self.caster.inventory.remove_from_container(used_ammo_or_weapon.item_template.entry, 1,
                                                            used_ammo_or_weapon.item_instance.bag)

        # Spells cast with consumables.
        if casting_spell.source_item and casting_spell.source_item.has_charges():
            spell_stats = casting_spell.get_item_spell_stats()
            charges = spell_stats.charges
            if charges < 0:  # Negative charges remove items.
                self.caster.inventory.remove_items(casting_spell.source_item.item_template.entry, 1)

            if charges != 0 and charges != -1:  # don't modify if no charges remain or this item is a consumable.
                new_charges = charges-1 if charges > 0 else charges+1
                spell_stats.charges = new_charges

        if self.caster.get_type_id() == ObjectTypeIds.ID_PLAYER:
            self.caster.set_dirty_inventory()

    def send_cast_result(self, spell_id, error):
        # TODO CAST_SUCCESS_KEEP_TRACKING
        #  cast_status = SpellCastStatus.CAST_SUCCESS if error == SpellCheckCastResult.SPELL_CAST_OK else SpellCastStatus.CAST_FAILED

        if self.caster.get_type_id() != ObjectTypeIds.ID_PLAYER:
            return

        if error == SpellCheckCastResult.SPELL_NO_ERROR:
            data = pack('<IB', spell_id, SpellCastStatus.CAST_SUCCESS)
        else:
            data = pack('<I2B', spell_id, SpellCastStatus.CAST_FAILED, error)

        self.caster.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_CAST_RESULT, data))
