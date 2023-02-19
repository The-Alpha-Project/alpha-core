from game.world.managers.objects.ai.CreatureAI import CreatureAI
from utils.constants.CustomCodes import Permits


class NullCreatureAI(CreatureAI):
    def __init__(self, creature):
        super().__init__(creature)

    # override
    def update_ai(self, elapsed):
        pass

    # override
    def move_in_line_of_sight(self, unit=None):
        pass

    # override
    def attack_start(self, victim):
        pass

    # override
    def attacked_by(self, attacker):
        pass

    # override
    def permissible(self, creature):
        return Permits.PERMIT_BASE_IDLE
