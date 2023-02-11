from database.world.WorldModels import CreatureGroup
from utils.constants.MiscCodes import CreatureGroupFlags


class CreatureGroupMember(object):
    def __init__(self, creature_mgr, creature_group: CreatureGroup):
        self.creature = creature_mgr
        self.distance_leader = creature_group.dist
        self.angle = creature_group.angle
        self.flags: CreatureGroupFlags = creature_group.flags
