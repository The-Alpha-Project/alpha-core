from game.world.managers.objects.ai.BasicCreatureAI import BasicCreatureAI
from utils.constants.CustomCodes import Permits
from utils.constants.UnitCodes import UnitStates, UnitFlags, CreatureReactStates


class GuardianAI(BasicCreatureAI):
    def __init__(self, creature):
        super().__init__(creature)

    # override
    def update_ai(self, elapsed, now):
        super().update_ai(elapsed, now)

    # override
    def owner_attacked_by(self, attacker, proximity_aggro=False):
        if self.creature.react_state == CreatureReactStates.REACT_PASSIVE:
            return
        if not self.is_ready_for_new_attack():
            return
        self.creature.attack(attacker)

    # override
    def owner_attacked(self, target):
        if self.creature.react_state in {CreatureReactStates.REACT_AGGRESSIVE, CreatureReactStates.REACT_PASSIVE}:
            return
        owner = self.creature.get_charmer_or_summoner()
        if not owner:
            return
        # Defensive creature should not engage until it or its owner is damaged by the enemy.
        if not self.creature.threat_manager.has_aggro_from(target) and not owner.threat_manager.has_aggro_from(target):
            return
        if not self.is_ready_for_new_attack():
            return
        self.creature.attack(target)

    # override
    def permissible(self, creature):
        if creature.is_guardian():
            return Permits.PERMIT_BASE_SPECIAL
        return Permits.PERMIT_BASE_NO

    # override
    def is_ready_for_new_attack(self):
        return self.creature.is_alive and self.creature.is_active_object() \
               and not self.creature.is_evading \
               and not self.creature.unit_state & UnitStates.STUNNED \
               and not self.creature.unit_flags & UnitFlags.UNIT_FLAG_PACIFIED \
               and not self.creature.combat_target
