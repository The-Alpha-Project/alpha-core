from database.world.WorldModels import CreatureGroup


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
    def get_follow_position(creature_group):
        leader = CreatureGroupManager.get_leader(creature_group)
        creature = creature_group.owner
        final_location = leader.location.get_point_in_radius_and_angle(creature_group.dist, creature_group.angle)
        return final_location if final_location else creature.location
