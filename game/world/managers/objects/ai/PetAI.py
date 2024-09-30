from typing import Optional

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.dbc.DbcModels import Spell
from game.world.managers.objects.ObjectManager import ObjectManager
from game.world.managers.objects.ai.CreatureAI import CreatureAI
from utils.constants.CustomCodes import Permits
from utils.constants.MiscCodes import MoveType
from utils.constants.PetCodes import PetCommandState, PetReactState, PetMoveState
from utils.constants.SpellCodes import SpellTargetMask, SpellEffects
from utils.constants.UnitCodes import UnitStates


class PetAI(CreatureAI):
    def __init__(self, creature):
        super().__init__(creature)
        self.move_state = PetMoveState.AT_HOME
        self.pending_spell_cast: Optional[tuple[Spell, ObjectManager, bool]] = None
        if creature:
            self.update_allies_timer = 0
            self.allies = ()
            self.update_allies()

    # override
    def update_ai(self, elapsed, now):
        owner = self.creature.get_charmer_or_summoner()
        if not self.creature or not owner:
            return

        if not self.pending_spell_cast:
            self._perform_auto_cast()

        if self.move_state == PetMoveState.AT_RANGE and self.pending_spell_cast:
            spell, target, autocast = self.pending_spell_cast
            self.do_spell_cast(spell, target, autocast=autocast, validate_range=False)
        elif self.move_state != PetMoveState.MOVE_RANGE:
            self.pending_spell_cast = None

        if owner.is_player():
            if self.creature.combat_target and not self.creature.combat_target.is_alive:
                self.creature.combat_target = self.select_next_target()
            if not self.creature.combat_target and self.creature.in_combat:
                self.creature.leave_combat()

            # TODO: Why this return always happening for other pet controlled pets? @Flug
            if not self.creature.is_guardian():
                return

        if self.creature.combat_target != owner.combat_target:
            if owner.combat_target:
                self.creature.attack(owner.combat_target)
            else:
                self.creature.attack_stop()

    # override
    def permissible(self, creature):
        if creature.is_pet():
            return Permits.PERMIT_BASE_SPECIAL
        return Permits.PERMIT_BASE_NO

    # Called when pet takes damage. This function helps keep pets from running off simply due to gaining aggro.
    # override
    def attacked_by(self, target):
        if self._get_react_state() != PetReactState.REACT_PASSIVE and not self.creature.combat_target:
            self.creature.attack(target)

    # Called from Unit::Kill() in case where pet or owner kills something.
    # If owner killed this victim, pet may still be attacking something else.
    # override
    def killed_unit(self, unit):
        pass

    # Receives notification when pet reaches stay or follow owner.
    # override
    def movement_inform(self, move_type=None, data=None):
        self.move_state = data

    # Called when owner takes damage. This function helps keep pets from running off simply due to owner gaining aggro.
    # override
    def owner_attacked_by(self, attacker, proximity_aggro=False):
        if self.creature.combat_target or self._get_react_state() == PetReactState.REACT_PASSIVE:
            return
        # If defensive state and owner did not take a real hit yet, do not attack.
        if self._get_react_state() == PetReactState.REACT_DEFENSIVE and proximity_aggro:
            return
        self.creature.attack(attacker)

    # Called when owner attacks something.
    # override
    def owner_attacked(self, target):
        if self._get_react_state() != PetReactState.REACT_PASSIVE and not self.creature.combat_target:
            self.creature.attack(target)

    # Provides next target selection after current target death.
    # This function should only be called internally by the AI.
    # Targets are not evaluated here for being valid targets, that is done in _CanAttack().
    # The parameter: allowAutoSelect lets us disable aggressive pet auto targeting for certain situations.
    def select_next_target(self, allow_auto_select=True):
        if self._get_react_state() == PetReactState.REACT_PASSIVE:
            return None

        owner = self.creature.get_charmer_or_summoner()
        if not owner:
            return

        return owner.combat_target

    # Handles attack with or without chase and also resets flags for next update / creature kill.
    def do_attack(self, target, chase):
        pass

    # Evaluates whether a pet can attack a specific target based on CommandState, ReactState and other flags.
    # IMPORTANT: The order in which things are checked is important, be careful if you add or remove checks.
    def can_attack(self, target):
        if not target:
            return

        if not self.creature.can_attack_target(target):
            return

        react_state = self._get_react_state()
        command_state = self._get_command_state()

        # Passive - passive pets can attack if told to.
        if react_state == PetReactState.REACT_PASSIVE:
            return command_state == PetCommandState.COMMAND_ATTACK

        # TODO: Check HasAuraPetShouldAvoidBreaking.
        if target.unit_state & UnitStates.FLEEING:
            return command_state == PetCommandState.COMMAND_ATTACK

        # Returning - pets ignore attacks only if owner clicked follow.
        if self.move_state == PetMoveState.RETURNING:
            return not command_state == PetCommandState.COMMAND_FOLLOW

        # Stay - can attack if target is within range or commanded to.
        if command_state == PetCommandState.COMMAND_STAY:
            return self.creature.is_within_interactable_distance(target) \
                or command_state == PetCommandState.COMMAND_ATTACK

        # Pets attacking something (or chasing) should only switch targets if owner tells them to
        if command_state == PetCommandState.COMMAND_ATTACK:
            if self.creature.combat_target and self.creature.combat_target != target:
                charmer_or_summoner = self.creature.get_charmer_or_summoner()
                if charmer_or_summoner and charmer_or_summoner.combat_target:
                    return target.guid == charmer_or_summoner.combat_target.guid

        # Follow.
        if command_state == PetCommandState.COMMAND_FOLLOW:
            return self.move_state != PetMoveState.RETURNING

        return False

    # Set all flags to FALSE
    def clear_charm_info_flags(self):
        pass

    # Set allies set based on this pet owner group, if any.
    def update_allies(self):
        pass

    def need_to_stop(self):
        pass

    def stop_attack(self):
        pass

    def do_spell_cast(self, spell, target, autocast=False, validate_range=True):
        if self.creature.spell_manager.is_casting() or \
                self.creature.spell_manager.is_on_cooldown(spell):
            return

        target_mask = SpellTargetMask.SELF if target.guid == self.creature.guid else SpellTargetMask.UNIT

        if validate_range:
            pet_movement = self._get_pet_movement_behavior()
            if not pet_movement:
                return

            casting_spell = self.creature.spell_manager.try_initialize_spell(spell, target, target_mask, validate=False)
            if casting_spell.has_effect_of_type(SpellEffects.SPELL_EFFECT_APPLY_AREA_AURA) or \
                casting_spell.is_self_targeted():
                target = self.creature  # Override target if the spell can be cast on self.

            range_max = casting_spell.range_entry.RangeMax
            if self.creature.location.distance(target.location) > range_max:
                pet_movement.move_in_range(target, range_max, casting_spell.get_cast_time_secs())
                self.pending_spell_cast = (spell, target, autocast)
                return

        self.pending_spell_cast = None
        casting_spell = self.creature.spell_manager.try_initialize_spell(spell, target, target_mask,
                                                                         hide_result=autocast)
        if casting_spell:
            self.creature.spell_manager.start_spell_cast(initialized_spell=casting_spell)

        return casting_spell is not None

    def _perform_auto_cast(self):
        if self.creature.spell_manager.is_casting():
            return

        charmer_or_summoner = self.creature.get_charmer_or_summoner()
        if not charmer_or_summoner:
            return

        controlled_pet = charmer_or_summoner.pet_manager.get_active_controlled_pet()
        if not controlled_pet:
            return

        spell_set = controlled_pet.get_pet_data().get_autocast_spells()
        for spell_data in spell_set:
            spell = DbcDatabaseManager.SpellHolder.spell_get_by_id(spell_data & 0xFFFF)
            target = self.creature.combat_target if self.creature.combat_target else \
                self.creature.get_charmer_or_summoner()
            casting_spell = self.creature.spell_manager.try_initialize_spell(spell, target, SpellTargetMask.UNIT, 
                                                                             validate=False, hide_result=True)

            if casting_spell.has_only_harmful_effects() != bool(self.creature.combat_target):
                continue  # Cast harmful spells when attacking, helpful when not.

            # Implement some basic checks so pet spells work as expected when set on autocast.
            if (casting_spell.has_effect_of_type(SpellEffects.SPELL_EFFECT_APPLY_AURA,
                                                 SpellEffects.SPELL_EFFECT_APPLY_AREA_AURA) and
                    target.aura_manager.has_aura_by_spell_id(spell.ID)):
                continue  # Aura already applied (Flameblade, Blood Pact etc.)

            if casting_spell.has_effect_of_type(SpellEffects.SPELL_EFFECT_INSTAKILL):
                continue  # Never autocast Sacrificial Shield.

            if casting_spell.has_effect_of_type(SpellEffects.SPELL_EFFECT_HEAL) and \
                target.health == target.max_health:
                continue  # Only heal targets not at full health.

            # Check resources before choosing to cast this spell.
            if not self.creature.spell_manager.meets_casting_requisites(casting_spell):
                continue

            self.do_spell_cast(spell, target, autocast=True)

    def command_state_update(self):
        self.creature.spell_manager.remove_casts()
        self.pending_spell_cast = None
        self.creature.movement_manager.reset(clean_behaviors=True)
        pet_movement = self._get_pet_movement_behavior()

        # TODO Stay shouldn't cause pet to stop attacking, only stop chasing.
        self.creature.attack_stop()

        if pet_movement and self._get_command_state() == PetCommandState.COMMAND_STAY:
            pet_movement.stay(state=True)

        if pet_movement and self._get_command_state() == PetCommandState.COMMAND_FOLLOW:
            pet_movement.stay(state=False)

    def react_state_update(self):
        if self._get_react_state() == PetReactState.REACT_PASSIVE:
            self.creature.attack_stop()

    def _get_pet_movement_behavior(self):
        return self.creature.movement_manager.get_move_behavior_by_type(MoveType.PET)

    def _get_command_state(self):
        charmer_or_summoner = self.creature.get_charmer_or_summoner()
        if not charmer_or_summoner:
            return PetCommandState.COMMAND_STAY

        controlled_pet = charmer_or_summoner.pet_manager.get_active_controlled_pet()
        if not controlled_pet:
            return PetCommandState.COMMAND_FOLLOW

        return controlled_pet.get_pet_data().command_state

    def _get_react_state(self):
        charmer_or_summoner = self.creature.get_charmer_or_summoner()
        if not charmer_or_summoner:
            return PetReactState.REACT_PASSIVE

        controlled_pet = charmer_or_summoner.pet_manager.get_active_controlled_pet()
        if not controlled_pet:
            return PetReactState.REACT_PASSIVE

        return controlled_pet.get_pet_data().react_state
