from game.world.managers.objects.ai.CreatureAI import CreatureAI
from utils.constants.CustomCodes import Permits


class NullCreatureAI(CreatureAI):
    def __init__(self, creature):
        super().__init__(creature)

    # override
    def update_ai(self, elapsed, now):
        pass

    # override
    def move_in_line_of_sight(self, unit, ai_event=False):
        pass

    # override
    def attack_start(self, victim, chase=True):
        pass

    # override
    def attacked_by(self, attacker):
        pass

    # override
    def permissible(self, creature):
        return Permits.PERMIT_BASE_IDLE
