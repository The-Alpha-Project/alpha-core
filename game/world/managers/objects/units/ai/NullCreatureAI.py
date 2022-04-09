from game.world.managers.objects.units.ai.CreatureAI import CreatureAI


class NullCreatureAI(CreatureAI):
    def __init__(self, **kwargs):
        super().__init__(**kwargs)

    # override
    def update_ai(self, elapsed):
        pass
