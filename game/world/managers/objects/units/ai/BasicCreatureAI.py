from game.world.managers.objects.units.ai.CreatureAI import CreatureAI


class BasicCreatureAI(CreatureAI):
    def __init__(self, can_summon_guards, creature):
        super().__init__(creature)
        self.can_summon_guards = can_summon_guards

    # override
    def update_ai(self, elapsed):
        pass

    # override
    def permissible(self, creature):
        pass

    # override
    def move_in_line_of_sight(self, unit):
        pass

    # override
    def just_respawned(self):
        # TODO
        super().just_respawned()
        pass

    # override
    def summoned_creatures_despawn(self, creature):
        pass

    def is_proximity_aggro_allowed_for(self, target):
        pass

    def summon_guard(self, enemy):
        pass
