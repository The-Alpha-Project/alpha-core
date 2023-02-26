from __future__ import annotations

import math
from random import randint
from struct import pack
from typing import TYPE_CHECKING, Optional

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.maps.MapManager import MapManager
from game.world.managers.objects.script.AIEventHandler import AIEventHandler
from game.world.managers.objects.script.ScriptManager import ScriptManager
from game.world.managers.objects.spell import ExtendedSpellData
from network.packet.PacketWriter import PacketWriter
from utils.constants.MiscCodes import ObjectTypeFlags
from utils.constants.OpCodes import OpCode
from utils.constants.ScriptCodes import CastFlags
from utils.constants.SpellCodes import SpellCheckCastResult, SpellTargetMask, SpellInterruptFlags
from utils.constants.UnitCodes import UnitFlags, UnitStates, AIReactionStates

if TYPE_CHECKING:
    from game.world.managers.objects.units.UnitManager import UnitManager
    from game.world.managers.objects.units.creature.CreatureManager import CreatureManager


class CreatureAI:
    # Creature spell lists should be updated every 1.2 seconds according to research.
    # https://www.reddit.com/r/wowservers/comments/834nt5/felmyst_ai_system_research/
    CREATURE_CASTING_DELAY = 1200

    def __init__(self, creature: Optional[CreatureManager]):
        if creature:
            self.creature = creature
            self.use_ai_at_control = False
            self.melee_attack = True  # If we allow melee auto attack.
            self.combat_movement = True  # If we allow targeted movement gen (chasing target).
            self.casting_delay = 0  # Cooldown before updating spell list again.
            self.last_alert_time = 0
            self.creature_spells = []  # Contains the currently used creature_spells template.
            self.load_spell_list()
            self.ai_event_handler = AIEventHandler(creature)

    def load_spell_list(self):
        # Load creature spells if available.
        if self.creature.creature_template.spell_list_id:
            spell_list_id = self.creature.creature_template.spell_list_id
            creature_spells = WorldDatabaseManager.CreatureSpellHolder.get_creature_spell_by_spell_list_id(
                spell_list_id)
            if creature_spells:
                # Finish loading each creature_spell.
                for creature_spell in creature_spells:
                    creature_spell.finish_loading()
                    if creature_spell.has_valid_spell:
                        self.creature_spells.append(creature_spell)

    def has_spell_list(self):
        return len(self.creature_spells) > 0

    # Called at World update tick.
    def update_ai(self, elapsed):
        if self.last_alert_time > 0:
            self.last_alert_time = max(0, self.last_alert_time - elapsed)

    # Like UpdateAI, but only when the creature is a dead corpse.
    def update_ai_corpse(self, elapsed):
        pass

    def permissible(self, creature):
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
            if self.creature.is_moving():
                self.creature.stop_movement()
            self.last_alert_time = 10  # Seconds.

        data = pack('<QI', self.creature.guid, ai_reaction)
        packet = PacketWriter.get_packet(OpCode.SMSG_AI_REACTION, data)
        self.creature.movement_manager.send_face_target(victim)
        victim.enqueue_packet(packet)
        return True

    # Called when the creature is killed.
    def just_died(self):
        self.entered_combat = False
        charmer_or_summoner = self.creature.get_charmer_or_summoner()
        # Detach from controller if this unit is an active pet and the summoner is a unit
        # (game objects can spawn creatures, but they don't have a PetManager).
        if charmer_or_summoner and charmer_or_summoner.get_type_mask() & ObjectTypeFlags.TYPE_UNIT:
            charmer_or_summoner.pet_manager.detach_pet_by_guid(self.creature.guid)

    # Called when the creature summon is killed.
    def summoned_creature_just_died(self, creature):
        pass

    # Group member just died.
    def group_member_just_died(self, unit, is_leader):
        pass

    # Called when the creature kills a unit.
    def killed_unit(self, unit):
        pass

    # Called when owner of m_creature (if m_creature is PROTECTOR_PET) kills a unit.
    def owner_killed_unit(self, unit):
        pass

    # Called only for pets.
    def owner_attacked_by(self, attacker):
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
    def spell_hit(self, caster, spell_entry):
        pass

    # Called when spell hits creature's target.
    def spell_hit_target(self, unit, spell_entry):
        pass

    # Called when creature is spawned or respawned (for resetting variables).
    def just_respawned(self):
        # Reset spells template to default on respawn.
        # Reset combat movement and melee attack.

        self.entered_combat = False

        # Apply passives.
        for spell_id in self.creature.get_template_spells():
            spell = DbcDatabaseManager.SpellHolder.spell_get_by_id(spell_id)
            if not spell:
                continue
            self.creature.spell_manager.apply_passive_spell_effects(spell)

        # Run on-spawn AI scripts
        self.ai_event_handler.on_spawn()
        self.ai_event_handler.on_idle()

    # Called when a creature is despawned by natural means (TTL).
    def just_despawned(self):
        pass

    # Called when the creature summon successfully other creature or gameobject.
    def just_summoned(self, world_object):
        pass

    # Called at waypoint reached or point movement finished.
    def movement_inform(self, move_type=None, data=None):
        pass

    # Called at text emote receive from player.
    def receive_emote(self, player, emote):
        pass

    # Called if a temporary summoned of m_creature reach a move point.
    def summoned_movement_inform(self, creature, motion_type, point_id):
        pass

    # Called when the creature summon despawn.
    def summoned_creatures_despawn(self, creature):
        pass

    # Called when the creature is target of hostile action: swing, hostile spell landed, fear/etc).
    def attacked_by(self, attacker):
        pass

    # Called when creature attack is expected (if creature can and doesn't have current victim).
    # Note: for reaction at hostile action must be called AttackedBy function.
    def attack_start(self, victim):
        self._initialize_spell_list_cooldowns()

    def can_cast_spell(self, target, spell_entry, triggered):
        pass

    def do_cast_spell_if_can(self, target, spell_id, cast_flags, original_caster_guid):
        pass

    def set_spell_list(self, spell_list):
        pass

    def update_spell_list(self, elapsed):
        if not self.has_spell_list():
            return

        if self.casting_delay <= 0:
            self.casting_delay = CreatureAI.CREATURE_CASTING_DELAY
            self.do_spell_list_cast()
        else:
            self.casting_delay -= elapsed * 1000

    def _initialize_spell_list_cooldowns(self):
        if self.has_spell_list():
            for creature_spell in self.creature_spells:
                initial_cooldown_delay = randint(creature_spell.delay_init_min, creature_spell.delay_init_max) * 1000
                self.creature.spell_manager.force_cooldown(creature_spell.spell.ID, initial_cooldown_delay)

    def do_spell_list_cast(self):
        do_not_cast = False

        for creature_spell in self.creature_spells:
            cast_flags = creature_spell.cast_flags
            chance = creature_spell.chance
            script_id = creature_spell.script_id
            # Check cooldown and if self is casting this spell at the moment.
            if not self.creature.spell_manager.is_on_cooldown(creature_spell.spell) and \
                    not self.creature.spell_manager.is_casting_spell(creature_spell.spell.ID):
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
                    continue

                # Validate spell cast.
                cast_result = self.try_to_cast(unit_target, casting_spell, cast_flags, chance)
                if cast_result == SpellCheckCastResult.SPELL_NO_ERROR:
                    do_not_cast = not cast_flags & CastFlags.CF_TRIGGERED

                    # Stop if ranged spell or movement interrupt flag.
                    if casting_spell.spell_entry.InterruptFlags & SpellInterruptFlags.SPELL_INTERRUPT_FLAG_MOVEMENT \
                            or cast_flags & CastFlags.CF_MAIN_RANGED_SPELL:
                        self.creature.stop_movement()

                    # TODO: Run script if available.
                    # if script_id:
                    #     should run script.

                    # Trigger the cast.
                    self.creature.spell_manager.start_spell_cast(initialized_spell=casting_spell)
                elif cast_result == SpellCheckCastResult.SPELL_FAILED_TRY_AGAIN:
                    # Chance roll failed, so we set a new random cooldown.
                    self.creature.spell_manager.set_on_cooldown(casting_spell)

    def try_to_cast(self, target, casting_spell, cast_flags, chance):
        # Unable to initialize CastingSpell by caller.
        if not casting_spell:
            return SpellCheckCastResult.SPELL_FAILED_ERROR

        # Could not resolve a target.
        if not target:
            return SpellCheckCastResult.SPELL_FAILED_BAD_IMPLICIT_TARGETS

        # Target is fleeing.
        if target.unit_flags & UnitFlags.UNIT_FLAG_FLEEING or target.unit_state & UnitStates.FLEEING:
            # VMaNGOS uses SPELL_FAILED_FLEEING at 0x1E, not sure if it's the same.
            return SpellCheckCastResult.SPELL_FAILED_NOPATH

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
        #  TODO: We need to known which type of movement the unit is 'using', chase, spline, etc..
        if (cast_flags & CastFlags.CF_TARGET_UNREACHABLE and
                (self.creature.is_within_interactable_distance(target)
                 or self.creature.is_moving() or not (self.creature.unit_state & UnitStates.ROOTED)
                 or not MapManager.can_reach_object(self.creature, target))):
            return SpellCheckCastResult.SPELL_FAILED_MOVING

        if not cast_flags & CastFlags.CF_FORCE_CAST:
            # Need internal/custom unit states. UNIT_STAT_CAN_NOT_MOVE
            # Check self fleeing.
            if self.creature.unit_flags & UnitFlags.UNIT_FLAG_FLEEING or self.creature.unit_state & UnitStates.FLEEING:
                return SpellCheckCastResult.SPELL_FAILED_NOPATH

            # If the spell requires specific unit placement.
            target_is_facing_caster = target.location.has_in_arc(self.creature.location, math.pi)
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
        if cast_flags & CastFlags.CF_INTERRUPT_PREVIOUS and target.spell_manager.is_casting():
            self.creature.spell_manager.remove_colliding_casts(casting_spell)

        # Roll chance to cast from script after all checks have passed.
        if chance:
            if not chance > randint(0, 99):
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
        return self.melee_attack

    def set_melee_attack(self, enabled):
        pass

    def set_combat_movement(self, enabled):
        pass

    # Called for reaction at enter to combat if not in combat yet (enemy can be None).
    def enter_combat(self, unit = None):
        self.ai_event_handler.on_enter_combat()	
        pass

    # Called when leaving combat.
    def on_combat_stop(self):
        # Reset back to default spells template. This also resets timers.
        # Reset combat movement and melee attack.
        pass

    # Called at any Damage to any victim (before damage apply).
    def damage_deal(self, unit, damage):
        pass

    # Called at any Damage from any attacker (before damage apply).
    # Note: it for recalculation damage or special reaction at damage
    # for attack reaction use AttackedBy called for not DOT damage in Unit::DealDamage also
    def damage_taken(self, attacker, damage):
        self.ai_event_handler.on_damage_taken()
        pass

    # Called at any heal cast/item used (call non implemented).
    def healed_by(self):
        pass

    # Called at reaching home after evade.
    def just_reached_home(self):
        pass

    # Called when a unit moves within visibility distance.
    def move_in_line_of_sight(self, unit: UnitManager):
        pass

    # Called for reaction at stopping attack at no attackers or targets.
    def enter_evade_mode(self):
        pass
