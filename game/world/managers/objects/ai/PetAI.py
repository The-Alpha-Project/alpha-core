import math

from game.world.managers.objects.ai.CreatureAI import CreatureAI
from utils.constants.CustomCodes import Permits
from utils.constants.MiscCodes import ObjectTypeIds
from utils.constants.PetCodes import PetCommandState, PetReactState, PetFollowState
from utils.constants.UnitCodes import UnitStates


class PetAI(CreatureAI):
    def __init__(self, creature):
        super().__init__(creature)
        self.follow_state = PetFollowState.AT_HOME
        if creature:
            self.update_allies_timer = 0
            self.allies = ()
            self.update_allies()

    # override
    def update_ai(self, elapsed):
        owner = self.creature.get_charmer_or_summoner()
        if not self.creature or not owner:
            return

        if owner.get_type_id() == ObjectTypeIds.ID_PLAYER:
            if self.creature.combat_target and not self.creature.combat_target.is_alive:
                self.creature.combat_target = None

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
        super().attacked_by(target)

    def _can_attack(self, target):
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
        if self.follow_state == PetFollowState.RETURNING:
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
            return self.follow_state != PetFollowState.RETURNING

        return False

    # Called from Unit::Kill() in case where pet or owner kills something.
    # If owner killed this victim, pet may still be attacking something else.
    # override
    def killed_unit(self, unit):
        pass

    # Receives notification when pet reaches stay or follow owner.
    # override
    def movement_inform(self, move_type=None, data=None):
        self.follow_state = data

    # Called when owner takes damage. This function helps keep pets from running off simply due to owner gaining aggro.
    # override
    def owner_attacked_by(self, attacker):
        pass

    # Called when owner attacks something.
    # override
    def owner_attacked(self, target):
        pass

    # Provides next target selection after current target death.
    # This function should only be called internally by the AI.
    # Targets are not evaluated here for being valid targets, that is done in _CanAttack().
    # The parameter: allowAutoSelect lets us disable aggressive pet auto targeting for certain situations.
    def select_next_target(self, allow_auto_select):
        pass

    # Handles attack with or without chase and also resets flags for next update / creature kill.
    def do_attack(self, target, chase):
        pass

    # Evaluates whether a pet can attack a specific target based on CommandState, ReactState and other flags.
    # IMPORTANT: The order in which things are checked is important, be careful if you add or remove checks.
    def can_attack(self, target):
        pass

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

    def command_state_update(self):
        self.creature.movement_manager.reset(clean_behaviors=True)

        if self._get_command_state() == PetCommandState.COMMAND_STAY:
            self.creature.movement_manager.move_stay(state=True)

        if self._get_command_state() == PetCommandState.COMMAND_FOLLOW:
            self.creature.movement_manager.move_stay(state=False)

    def react_state_update(self):
        if self._get_react_state() == PetReactState.REACT_PASSIVE:
            self.creature.attack_stop()

    def _get_command_state(self):
        controlled_pet = self.creature.get_charmer_or_summoner().pet_manager.get_active_controlled_pet()
        if not controlled_pet:
            return PetCommandState.COMMAND_FOLLOW
        return controlled_pet.get_pet_data().command_state

    def _get_react_state(self):
        controlled_pet = self.creature.get_charmer_or_summoner().pet_manager.get_active_controlled_pet()
        if not controlled_pet:
            return PetReactState.REACT_PASSIVE
        return controlled_pet.get_pet_data().react_state
