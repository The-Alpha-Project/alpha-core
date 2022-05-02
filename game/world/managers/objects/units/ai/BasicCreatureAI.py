from game.world.managers.objects.units.ai.CreatureAI import CreatureAI
from utils.constants.CustomCodes import Permits


class BasicCreatureAI(CreatureAI):
    def __init__(self, creature):
        super().__init__(creature)
        self.can_summon_guards = creature.can_summon_guards() if creature else False

    # override
    def update_ai(self, elapsed):
        if not self.creature or not self.creature.combat_target:
            return

        if self.has_spell_list():
            self.update_spell_list(elapsed)

        self.do_melee_attack_if_ready()

    # override
    def permissible(self, creature):
        return Permits.PERMIT_BASE_NORMAL

    # override
    def move_in_line_of_sight(self, unit):
        pass

    # override
    def just_respawned(self):
        self.can_summon_guards = self.creature.can_summon_guards() if self.creature else False
        super().just_respawned()

    # override
    def summoned_creatures_despawn(self, creature):
        self.can_summon_guards = self.creature.can_summon_guards() if self.creature else False

    def is_proximity_aggro_allowed_for(self, target):
        pass

    def summon_guard(self, enemy):
        pass
