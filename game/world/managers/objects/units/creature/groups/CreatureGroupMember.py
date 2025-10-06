from database.world.WorldModels import CreatureGroup
from utils.Logger import Logger


class CreatureGroupMember(object):
    def __init__(self, creature_mgr, creature_group: CreatureGroup, dist: int = 0, angle: int = 0, flags: int = 0):
        self.creature = creature_mgr
        self.distance_leader = dist if dist else creature_group.dist
        self.angle = angle
        self.flags = flags if flags else creature_group.flags
        Logger.debug(f'Group member {creature_mgr.get_name()}, Distance {self.distance_leader}, Angle {self.angle},'
                     f' Flags {self.flags}')
