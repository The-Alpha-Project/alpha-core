from game.world.managers.objects.ai.CreatureAI import CreatureAI


class GameObjectAI(CreatureAI):
    def __init__(self, creature):
        super().__init__(creature)

    # override
    def update_ai(self, elapsed, now):
        pass

    # override
    def permissible(self, creature):
        pass

    # override
    def set_data(self, _id, value):
        pass

    # override
    def on_use(self, user):
        pass

    # override
    def just_summoned(self, world_object):
        pass

    # override
    def summoned_creature_just_died(self, creature):
        pass

    # override
    def summoned_movement_inform(self, creature, motion_type, point_id):
        pass

    # override
    def on_remove_from_world(self):
        pass
