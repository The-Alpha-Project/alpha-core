import math
from random import randint
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.objects.script.ScriptManager import ScriptManager
from game.world.managers.objects.spell import ExtendedSpellData
from game.world.managers.objects.units.creature.CreatureSpellsEntry import CreatureAISpellsEntry
from utils.constants.ScriptCodes import CastFlags
from utils.constants.SpellCodes import SpellCheckCastResult, SpellTargetMask
from utils.constants.UnitCodes import UnitFlags, UnitStates


class CreatureAI:
    # Creature spell lists should be updated every 1.2 seconds according to research.
    # https://www.reddit.com/r/wowservers/comments/834nt5/felmyst_ai_system_research/
    CREATURE_CASTING_DELAY = 1200

    def __init__(self, creature):
        if creature:
            self.creature = creature
            self.use_ai_at_control = False
            self.melee_attack = True  # If we allow melee auto attack.
            self.combat_movement = True  # If we allow targeted movement gen (chasing target).
            self.casting_delay = 0  # Cooldown before updating spell list again.
            self.last_alert_time = 0
            self.creature_spells = []  # Contains the currently used creature_spells template.
            self.load_spell_list()

    def load_spell_list(self):
        # Load creature spells if available.
        if self.creature.creature_template.spell_list_id:
            spell_list_id = self.creature.creature_template.spell_list_id
            creature_spells = WorldDatabaseManager.CreatureSpellHolder.get_creature_spell_by_spell_list_id(spell_list_id)
            if creature_spells:
                # Finish loading each creature_spell.
                for creature_spell in creature_spells:
                    creature_spell.finish_loading()
                    if creature_spell.has_valid_spell:
                        self.creature_spells.append(CreatureAISpellsEntry(creature_spell))

    def has_spell_list(self):
        return len(self.creature_spells) > 0

    # Called at World update tick.
    def update_ai(self, elapsed):
        pass

    # Like UpdateAI, but only when the creature is a dead corpse.
    def update_ai_corpse(self, elapsed):
        pass

    def permissible(self, creature):
        pass

    # Distract creature, if player gets too close while stealth/prowling.
    def trigger_alert(self, unit):
        pass

    # Called when the creature is killed.
    def just_died(self, unit):
        pass

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

    # Called when creature is spawned or respawned (for reseting variables).
    def just_respawned(self):
        # Reset spells template to default on respawn.
        # Reset combat movement and melee attack.
        pass

    # Called when the creature summon successfully other creature or gameobject.
    def just_summoned(self, world_object):
        pass

    # Called at waypoint reached or point movement finished.
    def movement_inform(self, move_type, data):
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

    # Called when creature attack expected (if creature can and no have current victim).
    # Note: for reaction at hostile action must be called AttackedBy function.
    def attack_start(self, victim):
        pass

    def can_cast_spell(self, target, spell_entry, triggered):
        pass

    def do_cast_spell_if_can(self, target, spell_id, cast_flags, original_caster_guid):
        pass

    def set_spell_list(self, spell_list):
        pass

    def update_spell_list(self, elapsed):
        if not self.has_spell_list() or not self.creature.combat_target:
            return

        if self.casting_delay <= 0:
            self.casting_delay = CreatureAI.CREATURE_CASTING_DELAY
            self.do_spell_list_cast(self.casting_delay / 1000)
        else:
            self.casting_delay -= elapsed * 1000

    def do_spell_list_cast(self, elapsed):
        do_not_cast = False
        for creature_spell in self.creature_spells:
            creature_spell.cooldown -= elapsed
            if creature_spell.cooldown < 0:
                creature_spell.cooldown = 0
            creature_spell_entry = creature_spell.creature_spell_entry
            cast_flags = creature_spell_entry.cast_flags
            chance = creature_spell_entry.chance
            script_id = creature_spell_entry.script_id
            # Check cooldown and if self is casting at the moment.
            if creature_spell.cooldown <= 0:
                # Prevent casting multiple spells in the same update, only update timers.
                if not (cast_flags & (CastFlags.CF_TRIGGERED | CastFlags.CF_INTERRUPT_PREVIOUS)):
                    if do_not_cast or self.creature.is_casting():
                        continue

                spell_template = creature_spell.creature_spell_entry.spell
                # Resolve a target.
                target = ScriptManager.get_target_by_type(self.creature,
                                                          self.creature,
                                                          creature_spell_entry.cast_target,
                                                          creature_spell_entry.target_param1,
                                                          abs(creature_spell_entry.target_param2),
                                                          spell_template)
                # Unable to find target, move on.
                if not target:
                    continue

                # Dynamic target mask.
                spell_target_mask = SpellTargetMask.SELF if target == self.creature else SpellTargetMask.UNIT

                # Try to initialize the spell.
                casting_spell = self.creature.spell_manager.try_initialize_spell(spell_template,
                                                                                 target,
                                                                                 spell_target_mask,
                                                                                 validate=True)
                # Invalid spell perhaps.
                if not casting_spell:
                    continue

                # Validate spell cast.
                cast_result = self.try_to_cast(target, casting_spell, cast_flags, chance)
                if cast_result == SpellCheckCastResult.SPELL_NO_ERROR:
                    do_not_cast = not cast_flags & CastFlags.CF_TRIGGERED
                    # Set a new random cooldown for this spell.
                    creature_spell.set_new_random_cooldown()
                    # Stop if ranged spell.
                    if cast_flags & CastFlags.CF_MAIN_RANGED_SPELL and self.creature.is_moving():
                        self.creature.stop_movement()

                    # TODO: Run script if available.
                    # if script_id:
                    #     should run script.

                    # Trigger the cast.
                    self.creature.spell_manager.start_spell_cast(initialized_spell=casting_spell)
                elif cast_result == SpellCheckCastResult.SPELL_FAILED_NOPATH \
                        or cast_result == SpellCheckCastResult.SPELL_FAILED_SPELL_IN_PROGRESS:
                    continue
                elif cast_result == SpellCheckCastResult.SPELL_FAILED_TRY_AGAIN:
                    # Chance roll failed, so we set a new random cooldown.
                    creature_spell.set_new_random_cooldown()

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
        # TODO: Missing pathfinding to check for reachability.
        #  We need to known which type of movement the unit is 'using', chase, spline, etc..
        #  For now, if we are not in melee range and rooted or moving, return failed due moving.
        if (cast_flags & CastFlags.CF_TARGET_UNREACHABLE and not self.creature.is_within_interactable_distance(target)) \
                and (self.creature.unit_state & UnitStates.ROOTED or self.creature.is_moving()):
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
                return SpellCheckCastResult.SPELL_FAILED_UNIT_NOT_BEHIND

            # If the spell requires the target having a specific power type.
            if not casting_spell.is_area_of_effect_spell() and not casting_spell.is_target_power_type_valid():
                return SpellCheckCastResult.SPELL_FAILED_UNKNOWN

            # No point in casting if target is immune.
            if target and target != self:
                if not casting_spell.is_positive_spell() and casting_spell.is_target_immune_to_damage():
                    return SpellCheckCastResult.SPELL_FAILED_ERROR

            # Mind control abilities can't be used with just 1 attacker or mob will reset.
            if len(target.attackers) == 1 and casting_spell.is_charm_spell():
                return SpellCheckCastResult.SPELL_FAILED_CANT_BE_CHARMED

        # Interrupt any previous spell.
        if cast_flags & CastFlags.CF_INTERRUPT_PREVIOUS and target.spell_manager.is_casting():
            self.creature.spell_manager.remove_colliding_casts(casting_spell)

        # Roll chance to cast from script (must be after cast checks, this is why its here)
        # TODO: Should be checked after spell_manager do all the proper validations.
        #  Refer to prepare() in Spell.cpp - vMaNGOS
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
    def enter_combat(self, unit):
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
        pass

    # Called at any heal cast/item used (call non implemented).
    def healed_by(self):
        pass

    # Called at reaching home after evade.
    def just_reached_home(self):
        pass

    # Called when an unit moves within visibility distance.
    def move_in_line_of_sight(self, unit):
        pass

    # Called for reaction at stopping attack at no attackers or targets.
    def enter_evade_mode(self):
        pass
