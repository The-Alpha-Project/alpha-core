from database.world.WorldModels import CreatureGroup
from utils.ConfigManager import config

CREATURE_GROUPS: [int, CreatureGroup] = {}


class CreatureGroupManager:

    @staticmethod
    def add_member(creature_mgr, creature_group: CreatureGroup):
        creature_group.owner = creature_mgr
        if creature_group.leader_guid not in CREATURE_GROUPS:
            CREATURE_GROUPS[creature_group.leader_guid] = {}
        CREATURE_GROUPS[creature_group.leader_guid][creature_mgr.spawn_id] = creature_group

    @staticmethod
    def get_leader(creature_group):
        if creature_group.leader_guid not in CREATURE_GROUPS:
            return None
        if creature_group.leader_guid not in CREATURE_GROUPS[creature_group.leader_guid]:
            return None
        return CREATURE_GROUPS[creature_group.leader_guid][creature_group.leader_guid].owner

    @staticmethod
    def get_follow_position_and_speed(creature_group):
        speed = config.Unit.Defaults.walk_speed
        leader = CreatureGroupManager.get_leader(creature_group)
        final_location = leader.location.get_point_in_radius_and_angle(creature_group.dist, creature_group.angle)
        return final_location, speed

    @staticmethod
    def should_move(creature_group):
        leader = CreatureGroupManager.get_leader(creature_group)
        final_location = leader.location.get_point_in_radius_and_angle(creature_group.dist, creature_group.angle)
        return creature_group.owner.location.distance(final_location) >= creature_group.dist
