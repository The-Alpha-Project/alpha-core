from game.world.managers.objects.ai.CreatureAI import CreatureAI
from utils.constants.CustomCodes import Permits


class CritterAI(CreatureAI):
    def __init__(self, creature):
        super().__init__(creature)
        self.combat_timer = 0

    # override
    def update_ai(self, elapsed, now):
        pass

    # override
    def permissible(self, creature):
        if creature.is_critter():
            return Permits.PERMIT_BASE_SPECIAL
        return Permits.PERMIT_BASE_NO

    # override
    def damage_taken(self, attacker, damage):
        pass

    # override
    def spell_hit(self, caster, casting_spell):
        pass
