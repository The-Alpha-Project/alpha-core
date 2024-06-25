from database.world.WorldModels import CreatureGroup


class CreatureGroupMember(object):
    def __init__(self, creature_mgr, creature_group: CreatureGroup):
        self.creature = creature_mgr
        self.distance_leader = creature_group.dist
        self.angle = creature_group.angle
        self.flags = creature_group.flags
