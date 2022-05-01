from game.world.managers.objects.units.ai.CreatureAI import CreatureAI
from utils.constants.CustomCodes import Permits


class BasicCreatureAI(CreatureAI):
    def __init__(self, creature):
        super().__init__(creature)
        self.can_summon_guards = creature.can_summon_guards()

    # override
    def update_ai(self, elapsed):
        if self.has_spell_list():
            self.update_spell_list(elapsed)

    # override
    def permissible(self, creature):
        return Permits.PERMIT_BASE_NORMAL

    # override
    def move_in_line_of_sight(self, unit):
        pass

    # override
    def just_respawned(self):
        if self.creature.can_summon_guards():
            self.can_summon_guards = True
        super().just_respawned()

    # override
    def summoned_creatures_despawn(self, creature):
        if self.creature.can_summon_guards() and creature.is_guard():
            self.can_summon_guards = True

    def is_proximity_aggro_allowed_for(self, target):
        pass

    def summon_guard(self, enemy):
        pass
