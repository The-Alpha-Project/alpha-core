from game.world.managers.objects.units.ai.CreatureAI import CreatureAI


class PetAI(CreatureAI):
    def __init__(self, **kwargs):
        super().__init__(**kwargs)

    # override
    def update_ai(self, elapsed):
        pass

    # override
    def permissible(self, creature):
        pass

    # Overrides Unit::AttackStart to correctly evaluate Pet states.
    # override
    def attack_start(self, victim):
        pass

    # Called when pet takes damage. This function helps keep pets from running off simply due to gaining aggro.
    # override
    def attacked_by(self, attacker):
        pass

    # Called from Unit::Kill() in case where pet or owner kills something.
    # If owner killed this victim, pet may still be attacking something else.
    # override
    def killed_unit(self):
        pass

    # Receives notification when pet reaches stay or follow owner.
    # override
    def movement_inform(self, move_type, data):
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

    def update_allies(self):
        pass

    def _need_to_stop(self):
        pass

    def _stop_attack(self):
        pass
