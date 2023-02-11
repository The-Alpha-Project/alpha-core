from random import choice

from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.objects.units.creature.groups.CreatureGroupMember import CreatureGroupMember
from utils.ConfigManager import config
from utils.constants.MiscCodes import CreatureGroupFlags


CREATURE_GROUPS = {}


class CreatureGroupManager:
    def __init__(self):
        self.original_leader_id = 0
        self.leader = None
        self.members: dict[int, CreatureGroupMember] = {}
        self.group_flags = 0

    @staticmethod
    def get_create_group(creature_group):
        if creature_group.leader_guid not in CREATURE_GROUPS:
            CREATURE_GROUPS[creature_group.leader_guid] = CreatureGroupManager()
        return CREATURE_GROUPS[creature_group.leader_guid]

    def add_member(self, creature_mgr, creature_group):
        if creature_mgr.guid not in self.members:
            self.members[creature_mgr.guid] = CreatureGroupMember(creature_mgr, creature_group)
        # Set leader.
        if creature_group.leader_guid == creature_mgr.spawn_id:
            # Load waypoints.
            waypoints = WorldDatabaseManager.CreatureMovementHolder.get_waypoints_by_entry(creature_mgr.entry)
            creature_mgr.default_waypoints = waypoints
            self.leader = creature_mgr
            self.original_leader_id = creature_mgr.guid
        self.group_flags |= creature_group.flags

    def remove_member(self, creature_mgr):
        if creature_mgr.guid in self.members:
            self.members.pop(creature_mgr.guid)
        if self.leader == creature_mgr.guid:
            if len(self.members) > 0:
                self.leader = list[self.members.values()][0]
            else:
                self.leader = None

    def on_members_attack_start(self, creature_mgr, target):
        if not self.group_flags & CreatureGroupFlags.OPTION_AGGRO_TOGETHER:
            return

        for guid, member in self.members.items():
            if guid == creature_mgr.guid:
                continue
            self._assist_member(member.creature, target)

    def on_member_died(self, creature_mgr):
        is_leader = creature_mgr.guid == self.leader.guid

        if self.group_flags & CreatureGroupFlags.OPTION_INFORM_LEADER_ON_MEMBER_DIED:
            if self.leader and self.leader.is_alive:
                self.leader.object_ai.group_member_just_died(creature_mgr, is_leader=is_leader)
        if self.group_flags & CreatureGroupFlags.OPTION_INFORM_MEMBERS_ON_ANY_DIED:
            for guid, member in self.members.items():
                if guid == creature_mgr.guid or not member.creature.is_alive:
                    continue
                member.creature.object_ai.group_member_just_died(creature_mgr, is_leader=is_leader)

        if is_leader and self.group_flags & CreatureGroupFlags.OPTION_FORMATION_MOVE:
            alive = [member.creature for member in self.members.values() if member.creature.is_alive
                     and member.creature.guid != self.leader.guid]
            if alive:
                alive.default_waypoints = self.leader.default_waypoints
                self.leader = choice(alive)
                self.leader.movement_manager.reset()
            # All death.
            else:
                self.disband()

    def on_leave_combat(self, creature_mgr):
        leader_evade = creature_mgr.guid == self.leader.guid

        if self.group_flags & CreatureGroupFlags.OPTION_RESPAWN_ALL_ON_ANY_EVADE or \
                (self.group_flags & CreatureGroupFlags.OPTION_RESPAWN_ALL_ON_MASTER_EVADE and leader_evade):
            for guid, member in self.members.items():
                member.creature.destroy()
            self.disband()
        elif self.group_flags & CreatureGroupFlags.OPTION_EVADE_TOGETHER:
            for guid, member in self.members.items():
                if guid == creature_mgr.guid or not member.creature.is_alive or not member.creature.combat_target:
                    continue
                member.creature.leave_combat()

    def disband(self):
        for guid, member in self.members.items():
            member.creature_group = None
        self.members.clear()
        CREATURE_GROUPS.pop(self.original_leader_id)

    def get_follow_position_and_speed(self, creature_mgr, elapsed):
        if creature_mgr.guid not in self.members or not self.leader:
            return None, 0
        group_member = self.members[creature_mgr.guid]
        speed = config.Unit.Defaults.walk_speed
        leader_distance = max(0.2, group_member.distance_leader - (elapsed * speed))
        location = self.leader.location.get_point_in_radius_and_angle(leader_distance, group_member.angle)
        creature_distance = group_member.creature.location.distance(location) - (elapsed * speed)
        # Catch up if lagging behind. Gibberish maths here.
        if creature_distance > group_member.distance_leader:
            speed += (creature_distance - group_member.distance_leader) * elapsed
        return location, speed

    # noinspection PyMethodMayBeStatic
    def _assist_member(self, creature, target):
        if not creature.is_alive:
            return

        if creature.combat_target:
            return

        if not creature.object_ai:
            return

        creature.object_ai.attacked_by(target)
