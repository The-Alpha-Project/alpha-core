from game.world.managers.objects.ai.BasicCreatureAI import BasicCreatureAI
from utils.constants.CustomCodes import Permits


class GuardianAI(BasicCreatureAI):
    def __init__(self, creature):
        super().__init__(creature)

    # override
    def update_ai(self, elapsed, now):
        super().update_ai(elapsed, now)

    # override
    def owner_attacked_by(self, attacker, proximity_aggro=False):
        if not self.is_ready_for_new_attack():
            return
        self.creature.attack(attacker)

    # override
    def owner_attacked(self, target):
        if not self.is_ready_for_new_attack():
            return
        owner = self.creature.get_charmer_or_summoner()
        if not owner:
            return
        # Defensive creature should not engage until it or its owner is damaged by the enemy.
        if not self.creature.threat_manager.has_aggro_from(target) and not owner.threat_manager.has_aggro_from(target):
            return
        self.creature.attack(target)

    # override
    def permissible(self, creature):
        if creature.is_guardian():
            return Permits.PERMIT_BASE_SPECIAL
        return Permits.PERMIT_BASE_NO
