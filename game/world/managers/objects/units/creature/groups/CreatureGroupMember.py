from database.world.WorldModels import CreatureGroup
from utils.Logger import Logger


class CreatureGroupMember:
    def __init__(self, creature_mgr, creature_group: CreatureGroup, dist=None, angle=None, flags=None):
        self.creature = creature_mgr
        self.distance_leader = creature_group.dist if dist is None else dist
        self.angle = creature_group.angle if angle is None else angle
        self.flags = creature_group.flags if flags is None else flags
        Logger.debug(f'Group member {creature_mgr.get_name()}, Distance {self.distance_leader}, Angle {self.angle},'
                     f' Flags {self.flags}')
