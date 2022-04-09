from game.world.managers.objects.units.ai.CreatureAI import CreatureAI


class GuardAI(CreatureAI):
    def __init__(self, **kwargs):
        super().__init__(**kwargs)

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
    def enter_combat(self, unit):
        pass

    # Returns whether the Unit is currently attacking other players or friendly units.
    def is_attacking_friendly_or_player(self, unit):
        pass
