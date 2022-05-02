from game.world.managers.objects.units.ai.CreatureAI import CreatureAI
from utils.constants.CustomCodes import Permits


class TotemAI(CreatureAI):
    def __init__(self, creature):
        super().__init__(creature)

    # override
    def update_ai(self, elapsed):
        pass

    # override
    def permissible(self, creature):
        if creature.is_totem():
            return Permits.PERMIT_BASE_SPECIAL
        return Permits.PERMIT_BASE_NO

    # override
    def move_in_line_of_sight(self, unit):
        pass

    # override
    def attack_start(self, victim):
        pass
