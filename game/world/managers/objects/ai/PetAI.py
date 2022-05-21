import math

from game.world.managers.objects.ai.CreatureAI import CreatureAI
from utils.Formulas import UnitFormulas
from utils.constants.CustomCodes import Permits
from utils.constants.PetCodes import PetCommandState
from utils.constants.UnitCodes import SplineFlags, CreatureStaticFlags


class PetAI(CreatureAI):
    def __init__(self, creature):
        super().__init__(creature)
        if creature:
            self.update_allies_timer = 0
            self.allies = ()
            self.update_allies()

            self.has_melee = self.creature.static_flags & CreatureStaticFlags.NO_MELEE != 0

            # TODO Current pet behavior is quite temporary.
            # Pets are still controlled by the existing combat behavior in CreatureManager,
            # and all movement logic is contained in PetAI.
            # These may all still change, but the current handling in PetAI is fitting for the time being.
            self.stay_position = None
            self.is_at_home = False

    # override
    def update_ai(self, elapsed):
        # Set spawn point to the owner's location. This fixes issues with evading and returning after charm.
        self.creature.spawn_position = self.creature.summoner.location.copy()

        if self.is_at_home or self.creature.combat_target:
            return

        self.handle_return_movement()

    # override
    def permissible(self, creature):
        if creature.is_pet():
            return Permits.PERMIT_BASE_SPECIAL
        return Permits.PERMIT_BASE_NO

    # override
    def attack_start(self, victim):
        self.creature.attack(victim)
        # TODO This is bad, but a workaround for now until a valid solution is discussed.
        self.creature.threat_manager.add_threat(victim, 10)
        self.is_at_home = False

    # Called when pet takes damage. This function helps keep pets from running off simply due to gaining aggro.
    # override
    def attacked_by(self, attacker):
        pass

    # Called from Unit::Kill() in case where pet or owner kills something.
    # If owner killed this victim, pet may still be attacking something else.
    # override
    def killed_unit(self, unit):
        pass

    # Receives notification when pet reaches stay or follow owner.
    # override
    def movement_inform(self, move_type=None, data=None):
        pass

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

    # Handles moving the pet back to stay or owner.
    # Prevent activating movement when under control of spells.
    def handle_return_movement(self):
        owner = self.creature.summoner
        target_location = self.stay_position if self.stay_position else owner.location

        combat_position_distance = UnitFormulas.combat_distance(self.creature, owner)
        current_distance = self.creature.location.distance(target_location)

        # If target point is within combat distance, don't move.
        if current_distance <= combat_position_distance:
            return

        max_distance_loc = target_location.get_point_in_between(combat_position_distance, vector=self.creature.location)
        self.creature.movement_manager.send_move_normal([max_distance_loc], self.creature.running_speed, SplineFlags.SPLINEFLAG_RUNMODE)

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
        self.handle_return_movement()
        pass

    def command_state_update(self):
        if not self.creature.combat_target:
            self.creature.movement_manager.send_move_stop()
            self.creature.movement_manager.pending_waypoints.clear()

        if self._get_command_state() != PetCommandState.COMMAND_ATTACK:
            self.creature.attack_stop()  # Always stop attacking if new state isn't attack.

        if self._get_command_state() == PetCommandState.COMMAND_STAY:
            # Stop in place place and update stay position.
            if not self.creature.combat_target:
                self.is_at_home = True
            self.stay_position = self.creature.location.copy()

        if self._get_command_state() == PetCommandState.COMMAND_FOLLOW:
            # Clear stay position, constantly follow player.
            self.stay_position = None
            self.is_at_home = False

    def _get_command_state(self):
        pet_info = self.creature.summoner.pet_manager.get_active_pet_info()
        return pet_info.command_state
