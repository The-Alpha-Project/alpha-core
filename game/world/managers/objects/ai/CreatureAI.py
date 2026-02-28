from __future__ import annotations

from random import randint
from struct import pack
from typing import TYPE_CHECKING, Optional

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.objects.script.AIEventHandler import AIEventHandler
from game.world.managers.objects.script.ScriptManager import ScriptManager
from game.world.managers.objects.spell import ExtendedSpellData
from game.world.managers.objects.units.movement.behaviors.ChaseMovement import ChaseMovement
from network.packet.PacketWriter import PacketWriter
from utils.Logger import Logger
from utils.constants.OpCodes import OpCode
from utils.constants.ScriptCodes import CastFlags
from utils.constants.SpellCodes import SpellCheckCastResult, SpellTargetMask, SpellInterruptFlags, \
    SpellEffects
from utils.constants.UnitCodes import UnitFlags, UnitStates, AIReactionStates, CreatureReactStates

if TYPE_CHECKING:
    from game.world.managers.objects.units.creature.CreatureManager import CreatureManager


class CreatureAI:
    # Creature spell lists should be updated every 1.2 seconds according to research.
    # https://www.reddit.com/r/wowservers/comments/834nt5/felmyst_ai_system_research/
    CREATURE_CASTING_DELAY = 1200

    def __init__(self, creature: Optional[CreatureManager]):
        if creature:
            self.creature = creature
            self.use_ai_at_control = False
            self.combat_movement = True  # If we allow targeted movement gen (chasing target).
            self.casting_delay = 0  # Cooldown before updating spell list again.
            self.last_alert_time = 0
            self.creature_spells = []  # Contains the currently used creature_spells template.
            self.creature_spell_cooldowns = []  # Per-slot cooldowns for creature_spells.
            self.load_spell_list()
            self.ai_event_handler = AIEventHandler(creature)
            self.script_phase = 0

    def load_spell_list(self):
        # Clear current list if any.
        self.creature_spells.clear()
        self.creature_spell_cooldowns.clear()

        if not self.creature.spell_list_id:
            return
        # Load creature spells if available.
        spell_list_id = self.creature.spell_list_id
        creature_spells = WorldDatabaseManager.CreatureSpellHolder.get_creature_spell_by_spell_list_id(spell_list_id)
        if not creature_spells:
            return
        # Finish loading each creature_spell.
        for creature_spell in creature_spells:
            creature_spell.finish_loading()
            if creature_spell.has_valid_spell:
                self.creature_spells.append(creature_spell)
                self.creature_spell_cooldowns.append(0)

    def has_spell_list(self):
        return len(self.creature_spells) > 0

    def update_ai(self, elapsed, now):
        if self.creature and self.creature.threat_manager:
            target = self.creature.threat_manager.get_hostile_target()
            # Has a target, check if we need to attack or switch target.
            if target and self.creature.combat_target != target:
                self.creature.attack(target)

        if self.last_alert_time > 0:
            self.last_alert_time = max(0, self.last_alert_time - elapsed)

    # Like UpdateAI, but only when the creature is a dead corpse.
    def update_ai_corpse(self, elapsed):
        pass

    def permissible(self, creature):
        pass

    def attach_escort_link(self, player_mgr):
        pass

    def detach_escort_link(self, player_mgr=None):
        pass

    # Distract creature, if player gets too close while stealth/prowling.
    # AIReactionStates.AI_REACT_ALERT
    def trigger_alert(self, unit):
        pass

    # Modifies unit facing and sometimes plays a sound.
    def send_ai_reaction(self, victim, ai_reaction):
        if ai_reaction == AIReactionStates.AI_REACT_ALERT:
            if self.last_alert_time > 0:
                return False
            # Stop creature movement if needed.
            self.creature.movement_manager.stop()
            self.last_alert_time = 10  # Seconds.

        data = pack('<QI', self.creature.guid, ai_reaction)
        packet = PacketWriter.get_packet(OpCode.SMSG_AI_REACTION, data)
        self.creature.movement_manager.face_target(victim)
        self.creature.get_map().send_surrounding(packet, self.creature, False)
        return True

    def on_script_event(self, event_id, event_data, target):
        self.ai_event_handler.on_script_event_happened(event_id, event_data, target)

    # Called when the creature is killed.
    def just_died(self, killer=None):
        self.ai_event_handler.on_death(killer)
        
    # Called when the creature summon is killed.
    def summoned_creature_just_died(self, creature):
        self.ai_event_handler.on_summoned_just_died(creature)

    # Group member just died.
    def group_member_just_died(self, unit, is_leader):
        self.ai_event_handler.on_group_member_died(unit, is_leader)

    # Called when the creature kills a unit.
    def killed_unit(self, unit):
        self.ai_event_handler.on_killed_unit(unit)

    # Called when owner of m_creature (if m_creature is PROTECTOR_PET) kills a unit.
    def owner_killed_unit(self, unit):
        pass

    # Called only for pets.
    def owner_attacked_by(self, attacker, proximity_aggro=False):
        pass

    # Called only for pets.
    def owner_attacked(self, target):
        pass

    # Called before being removed from the map.
    def on_remove_from_world(self):
        pass

    # Called when the corpse of this creature gets removed.
    def corpse_removed(self, respawn_delay):
        pass

    # Called by another script.
    def on_script_happened(self, event, data, world_object):
        pass

    # Called when hit by a spell.
    def spell_hit(self, caster, casting_spell):
        self.ai_event_handler.on_spell_hit(casting_spell, caster)

    # Called when spell hits creature's target.
    def spell_hit_target(self, unit, spell_entry):
        self.ai_event_handler.on_spell_hit_target(unit, spell_entry)

    # Called when creature is spawned or respawned (for resetting variables).
    def just_respawned(self):
        # Apply passives and cast pet summons.
        for spell_id in self.creature.get_template_spells():
            spell = DbcDatabaseManager.SpellHolder.spell_get_by_id(spell_id)
            if not spell:
                continue

            spell = self.creature.spell_manager.try_initialize_spell(spell, self.creature,
                                                                     SpellTargetMask.SELF, validate=False)

            if spell.is_passive():
                self.creature.spell_manager.apply_passive_spell_effects(spell.spell_entry)
            elif spell.has_effect_of_type(SpellEffects.SPELL_EFFECT_SUMMON_PET, SpellEffects.SPELL_EFFECT_SUMMON):
                self.creature.spell_manager.start_spell_cast(initialized_spell=spell)

        # Run on-spawn AI scripts.
        self.ai_event_handler.on_spawn()

    # Called when a creature is despawned by natural means (TTL).
    def just_despawned(self):
        pass

    # Called when the creature summon successfully other creature or gameobject.
    def just_summoned(self, world_object):
        self.ai_event_handler.on_summoned(world_object)

    # Called at waypoint reached or point movement finished.
    def movement_inform(self, move_type=None, data=None):
        pass

    # Called at text emote receive from player.
    def receive_emote(self, player, emote):
        self.ai_event_handler.on_emote_received(player, emote)

    # Called if a temporary summoned of m_creature reach a move point.
    def summoned_movement_inform(self, creature, motion_type, point_id):
        pass

    # Called when the creature summon despawn.
    def summoned_creatures_despawn(self, creature):
        self.ai_event_handler.on_summoned_just_despawned(creature)

    # TODO: PlayerAI, route both player and creatures add_thread through AI.
    # Called when the creature is target of hostile action: swing, hostile spell landed, fear/etc).
    def attacked_by(self, attacker):
        self.creature.threat_manager.add_threat(attacker)

    # Called when creature attack is expected (if creature can and doesn't have current victim).
    # Note: for reaction at hostile action must be called AttackedBy function.
    def attack_start(self, victim, chase=True):
        if chase and self.creature.has_melee():
            self.creature.movement_manager.move_chase()
        # Notify creature group.
        if self.creature.creature_group:
            self.creature.creature_group.on_members_attack_start(self.creature, victim)
        self._initialize_spell_list_cooldowns()

    def can_cast_spell(self, target, spell_entry, triggered):
        pass

    def do_cast_spell_if_can(self, target, spell_id, cast_flags, original_caster_guid):
        pass

    def set_spell_list(self, spell_list):
        spell_list_id = max(0, spell_list)

        # Invalid spell-list ids should not wipe/replace the spell list.
        if spell_list_id:
            creature_spells = WorldDatabaseManager.CreatureSpellHolder.get_creature_spell_by_spell_list_id(
                spell_list_id
            )
            if not creature_spells:
                Logger.warning(f'CreatureAI: Failed to set spell list {spell_list_id} for '
                               f'creature entry {self.creature.entry}; list does not exist.')
                return False

        self.creature.spell_list_id = spell_list_id
        self.load_spell_list()
        self.casting_delay = 0

        # Set initial cooldowns.
        if self.has_spell_list():
            self._initialize_spell_list_cooldowns()
        return True

    def update_spell_list(self, elapsed):
        if not self.has_spell_list():
            return

        if not self.creature.threat_manager.can_resolve_target():
            return

        elapsed_ms = int(elapsed * 1000)

        if self.casting_delay <= elapsed_ms:
            desync = elapsed_ms - self.casting_delay
            self.do_spell_list_cast(CreatureAI.CREATURE_CASTING_DELAY + desync)
            self.casting_delay = CreatureAI.CREATURE_CASTING_DELAY - desync \
                if desync < CreatureAI.CREATURE_CASTING_DELAY else 0
        else:
            self.casting_delay -= elapsed_ms

    def _set_spell_slot_cooldown(self, slot_index, delay_min, delay_max):
        self.creature_spell_cooldowns[slot_index] = randint(delay_min, delay_max) * 1000

    def _initialize_spell_list_cooldowns(self):
        if self.has_spell_list():
            for slot_index, creature_spell in enumerate(self.creature_spells):
                self._set_spell_slot_cooldown(slot_index, creature_spell.delay_init_min, creature_spell.delay_init_max)

    def do_spell_list_cast(self, ui_diff):
        do_not_cast = False

        for slot_index, creature_spell in enumerate(self.creature_spells):
            slot_cooldown = self.creature_spell_cooldowns[slot_index]
            if slot_cooldown > ui_diff:
                self.creature_spell_cooldowns[slot_index] -= ui_diff
                continue

            self.creature_spell_cooldowns[slot_index] = 0
            cast_flags = creature_spell.cast_flags
            chance = creature_spell.chance
            # Prevent casting multiple spells in the same update, only update timers.
            if not (cast_flags & (CastFlags.CF_TRIGGERED | CastFlags.CF_INTERRUPT_PREVIOUS)):
                # Can't be casting while using this spell.
                if do_not_cast or self.creature.is_casting():
                    continue

            # Spell entry.
            spell_template = creature_spell.spell

            # Target mask.
            spell_target_mask = spell_template.Targets

            # Resolve a target.
            unit_target = ScriptManager.get_target_by_type(self.creature,
                                                           self.creature,
                                                           creature_spell.cast_target,
                                                           creature_spell.target_param1,
                                                           abs(creature_spell.target_param2),
                                                           spell_template)
            # Unable to find target, move on.
            if not unit_target:
                continue

            spell_target = unit_target

            # Override target with Vector if this spell targets terrain.
            if spell_target_mask & SpellTargetMask.CAN_TARGET_TERRAIN != 0:
                spell_target = unit_target.location.copy()
            elif spell_target_mask == SpellTargetMask.SELF and unit_target is not self.creature:
                spell_target_mask = SpellTargetMask.UNIT

            # Try to initialize the spell.
            casting_spell = self.creature.spell_manager.try_initialize_spell(spell_template,
                                                                             spell_target,
                                                                             spell_target_mask,
                                                                             validate=True,
                                                                             creature_spell=creature_spell)
            # Initial spell validation failed.
            if not casting_spell:
                self.update_main_ranged_cast_state(cast_flags, SpellCheckCastResult.SPELL_FAILED_ERROR)
                continue

            # Validate spell cast.
            cast_result = self.try_to_cast(unit_target, casting_spell, cast_flags, chance)
            self.update_main_ranged_cast_state(cast_flags, cast_result)
            if cast_result == SpellCheckCastResult.SPELL_NO_ERROR:
                is_triggered = cast_flags & CastFlags.CF_TRIGGERED
                if is_triggered:
                    casting_spell.force_instant_cast()
                do_not_cast = not is_triggered
                self._set_spell_slot_cooldown(slot_index, creature_spell.delay_repeat_min, creature_spell.delay_repeat_max)

                # Stop if movement interrupt flag.
                if not cast_flags & CastFlags.CF_MAIN_RANGED_SPELL and \
                        casting_spell.spell_entry.InterruptFlags & SpellInterruptFlags.SPELL_INTERRUPT_FLAG_MOVEMENT:
                    self.creature.movement_manager.stop(force=True)

                # Trigger the cast.
                self.creature.spell_manager.start_spell_cast(initialized_spell=casting_spell)
            elif cast_result == SpellCheckCastResult.SPELL_FAILED_TRY_AGAIN:
                # Chance roll failed, so we set a new random cooldown.
                self._set_spell_slot_cooldown(slot_index, creature_spell.delay_repeat_min, creature_spell.delay_repeat_max)

    def try_to_cast(self, target, casting_spell, cast_flags, chance):
        # Unable to initialize CastingSpell by caller.
        if not casting_spell:
            return SpellCheckCastResult.SPELL_FAILED_ERROR

        # Non-triggered casts cannot overlap unless explicitly configured to interrupt.
        if self.creature.spell_manager.is_casting() and not (cast_flags & (
                CastFlags.CF_TRIGGERED | CastFlags.CF_INTERRUPT_PREVIOUS)):
            return SpellCheckCastResult.SPELL_FAILED_SPELL_IN_PROGRESS

        # Could not resolve a target.
        if not target:
            return SpellCheckCastResult.SPELL_FAILED_BAD_IMPLICIT_TARGETS

        if cast_flags & CastFlags.CF_TARGET_CASTING and not target.spell_manager.is_casting():
            return SpellCheckCastResult.SPELL_FAILED_UNKNOWN

        # Don't recast active area aura spells.
        if self.creature.spell_manager.is_spell_active(casting_spell.spell_entry.ID):
            return SpellCheckCastResult.SPELL_FAILED_AURA_BOUNCED

        # This spell should only be cast when target does not have the aura it applies.
        if cast_flags & CastFlags.CF_AURA_NOT_PRESENT and target.aura_manager.has_aura_by_spell_id(
                casting_spell.spell_entry.ID):
            return SpellCheckCastResult.SPELL_FAILED_AURA_BOUNCED

        # Need to use combat distance.
        if cast_flags & CastFlags.CF_ONLY_IN_MELEE and not self.creature.is_within_interactable_distance(target):
            return SpellCheckCastResult.SPELL_FAILED_OUT_OF_RANGE

        # This spell should not be used if target is in melee range.
        if cast_flags & CastFlags.CF_NOT_IN_MELEE and self.creature.is_within_interactable_distance(target):
            return SpellCheckCastResult.SPELL_FAILED_TOO_CLOSE

        # This spell should only be cast when we cannot get into melee range.
        if cast_flags & CastFlags.CF_TARGET_UNREACHABLE:
            movement = self.creature.movement_manager.get_current_behavior()
            is_rooted = bool(self.creature.unit_state & UnitStates.ROOTED)
            can_reach_target = self.creature.get_map().can_reach_object(self.creature, target)
            if self.creature.is_within_interactable_distance(target) \
                    or not isinstance(movement, ChaseMovement) \
                    or (not is_rooted and can_reach_target):
                return SpellCheckCastResult.SPELL_FAILED_MOVING

        if not (cast_flags & CastFlags.CF_FORCE_CAST):
            # Need internal/custom unit states. UNIT_STAT_CAN_NOT_MOVE
            if (self.creature.unit_flags & UnitFlags.UNIT_FLAG_FLEEING or self.creature.unit_state & UnitStates.FLEEING
                    or self.creature.unit_state & UnitStates.CONFUSED):
                return SpellCheckCastResult.SPELL_FAILED_NOPATH

            # If the spell requires specific unit placement.
            target_is_facing_caster = target.location.has_in_arc(self.creature.location)
            if not ExtendedSpellData.CastPositionRestrictions.is_position_correct(casting_spell.spell_entry.ID,
                                                                                  target_is_facing_caster):
                if ExtendedSpellData.CastPositionRestrictions.is_from_behind(casting_spell.spell_entry.ID):
                    return SpellCheckCastResult.SPELL_FAILED_UNIT_NOT_BEHIND
                return SpellCheckCastResult.SPELL_FAILED_UNIT_NOT_INFRONT

            # No point in casting if target is immune.
            if casting_spell.has_only_harmful_effects() and casting_spell.is_target_immune_to_effects():
                return SpellCheckCastResult.SPELL_FAILED_ERROR

            # Mind control abilities can't be used with just 1 attacker or mob will reset.
            if self.creature.threat_manager.get_targets_count() == 1 and casting_spell.get_charm_effect():
                return SpellCheckCastResult.SPELL_FAILED_CANT_BE_CHARMED

        # Interrupt any previous spell.
        if cast_flags & CastFlags.CF_INTERRUPT_PREVIOUS and self.creature.spell_manager.is_casting():
            self.creature.spell_manager.remove_colliding_casts(casting_spell)

        # Roll chance to cast from script after all checks have passed.
        if chance and chance != 100:
            if not chance > randint(0, 100):
                return SpellCheckCastResult.SPELL_FAILED_TRY_AGAIN

        # Return as succeeded.
        return SpellCheckCastResult.SPELL_NO_ERROR

    def do_cast(self, victim, spell_id, triggered):
        pass

    def do_cast_aoe(self, spell_id, triggered):
        pass

    # Will auto attack if the swing timer is ready.
    def do_melee_attack_if_ready(self):
        pass

    def is_combat_movement_enabled(self):
        return self.combat_movement

    def is_melee_attack_enabled(self):
        return self.creature.has_melee()

    def update_main_ranged_cast_state(self, cast_flags, cast_result):
        if not cast_flags & CastFlags.CF_MAIN_RANGED_SPELL:
            return

        if cast_result == SpellCheckCastResult.SPELL_NO_ERROR:
            if self.creature.is_moving():
                self.creature.movement_manager.stop(force=True)
            self.set_combat_movement(False)
            self.set_melee_attack(False)
            return

        self.set_combat_movement(True)
        self.set_melee_attack(True)

    def set_melee_attack(self, enabled):
        if self.creature.melee_disabled == (not enabled):
            return

        self.creature.melee_disabled = not enabled

    def set_combat_movement(self, enabled):
        if self.combat_movement == enabled:
            return

        self.combat_movement = enabled

        if not self.creature.combat_target:
            return

        movement = self.creature.movement_manager.get_current_behavior()
        is_chasing = isinstance(movement, ChaseMovement)
        if not enabled and is_chasing:
            self.creature.movement_manager.stop(force=True)
        elif enabled and not is_chasing:
            self.creature.movement_manager.move_chase()

    # Called for reaction on enter combat if not in combat yet (enemy can be None).
    def enter_combat(self, source=None):
        self.ai_event_handler.on_enter_combat(source)
        self.ai_event_handler.update_target_range_events(source, 0)

    # Called when leaving combat.
    def on_combat_stop(self):
        # Reset back to default spells template. This also resets timers.
        self.set_spell_list(self.creature.creature_template.spell_list_id)
        # Reset combat movement and melee attack.
        self.set_combat_movement(True)
        self.set_melee_attack(True)
        self.ai_event_handler.on_evade()

    def on_leave_combat(self):
        self.ai_event_handler.on_leave_combat()

    # Called at any Damage to any victim (before damage apply).
    def damage_deal(self, unit, damage):
        pass

    # Called at any Damage from any attacker (before damage apply).
    # Note: it for recalculation damage or special reaction at damage
    # for attack reaction use AttackedBy called for not DOT damage in Unit::DealDamage also
    def damage_taken(self, attacker, damage):
        pass

    # Called at any heal cast/item used (call non implemented).
    def healed_by(self):
        pass

    # Called at reaching home after evade.
    def just_reached_home(self):
        self.ai_event_handler.on_reached_home()

    # Called when a unit moves within visibility distance.
    def move_in_line_of_sight(self, unit, ai_event=False):
        if not ai_event:
            return
        self.ai_event_handler.on_ooc_los(source=unit)

    # Called when a player interacts with this creature.
    def player_interacted(self, pause_seconds=180):
        # From VMaNGOS NPC_MOVEMENT_PAUSE_TIME (Blizzlike time taken from Classic).
        self.creature.movement_manager.try_pause_ooc_movement(duration_seconds=pause_seconds)

    def is_ready_for_new_attack(self):
        target = self.creature.combat_target
        return (self.creature.is_alive and not self.creature.is_evading
                and not self.creature.unit_state & UnitStates.STUNNED
                and not self.creature.unit_flags & UnitFlags.UNIT_FLAG_PACIFIED
                and (not target or not target.is_alive)
                and not self.get_react_state() == CreatureReactStates.REACT_PASSIVE)

    def assist_unit(self, target):
        if not self.creature.is_alive:
            return

        self.creature.attack(target.combat_target)

    def get_react_state(self):
        return self.creature.react_state
