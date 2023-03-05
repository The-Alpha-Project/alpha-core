from random import choice

from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.objects.units.creature.groups.CreatureGroupMember import CreatureGroupMember
from game.world.managers.objects.units.movement.helpers.MovementWaypoint import MovementWaypoint
from utils.constants.MiscCodes import CreatureGroupFlags


CREATURE_GROUPS = {}


class CreatureGroupManager:
    def __init__(self):
        self.original_leader_spawn_id = 0
        self.waypoints = []
        self.leader = None
        self.members: dict[int, CreatureGroupMember] = {}
        self.group_flags = 0

    @staticmethod
    def get_create_group(creature_group):
        if creature_group.leader_guid not in CREATURE_GROUPS:
            CREATURE_GROUPS[creature_group.leader_guid] = CreatureGroupManager()
        return CREATURE_GROUPS[creature_group.leader_guid]

    def is_leader(self, creature_mgr):
        return self.leader and self.leader.guid == creature_mgr.guid

    def add_member(self, creature_mgr, creature_group):
        if creature_mgr.guid not in self.members:
            self.members[creature_mgr.guid] = CreatureGroupMember(creature_mgr, creature_group)
        # Set leader.
        if creature_group.leader_guid == creature_mgr.spawn_id:
            self.leader = creature_mgr
            self.original_leader_spawn_id = creature_mgr.spawn_id
            # Generate waypoints that will be used by the current/temporary leader.
            creature_movement = WorldDatabaseManager.CreatureMovementHolder.get_waypoints_for_creature(creature_mgr)
            if creature_movement:
                creature_movement.sort(key=lambda wp: wp.point)
                self.waypoints = self._get_sorted_waypoints_by_distance(creature_movement)

        self.group_flags |= creature_group.flags

    def remove_member(self, creature_mgr):
        if creature_mgr.guid not in self.members:
            return
        if not self.members:
            self.disband()
        elif self.is_leader(creature_mgr) and self.is_formation():
            new_leader = self._pick_new_leader()
            self.leader = new_leader if new_leader else None

    def on_members_attack_start(self, creature_mgr, target):
        if not target or not self.group_flags & CreatureGroupFlags.OPTION_AGGRO_TOGETHER:
            return

        for guid, member in self.members.items():
            if guid == creature_mgr.guid:
                continue
            self._assist_member(member.creature, target)

    def on_member_died(self, creature_mgr):
        is_leader = self.leader and creature_mgr.guid == self.leader.guid

        if self.group_flags & CreatureGroupFlags.OPTION_INFORM_LEADER_ON_MEMBER_DIED:
            if self.leader and self.leader.is_alive:
                self.leader.object_ai.group_member_just_died(creature_mgr, is_leader=is_leader)
        if self.group_flags & CreatureGroupFlags.OPTION_INFORM_MEMBERS_ON_ANY_DIED:
            for guid, member in self.members.items():
                if guid == creature_mgr.guid or not member.creature.is_alive:
                    continue
                member.creature.object_ai.group_member_just_died(creature_mgr, is_leader=is_leader)

        # We don't re use creatures instances, remove.
        self.remove_member(creature_mgr)

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
        CREATURE_GROUPS.pop(self.original_leader_spawn_id)

    def is_formation(self):
        return self.group_flags & CreatureGroupFlags.OPTION_FORMATION_MOVE

    def _get_sorted_waypoints_by_distance(self, movement_waypoints) -> list[MovementWaypoint]:
        points = [MovementWaypoint(wp) for wp in movement_waypoints]  # Wrap them.
        closest = min(points, key=lambda wp: self.leader.spawn_position.distance(wp.location()))
        index = points.index(closest)
        if index:
            points = points[index:] + points[0:index]
        return points

    def _pick_new_leader(self):
        alive = [member.creature for member in self.members.values() if member.creature.is_alive
                 and member.creature.guid != self.leader.guid]
        return choice(alive) if alive else None

    # noinspection PyMethodMayBeStatic
    def _assist_member(self, creature, target):
        if creature.combat_target:
            return
        if not creature.object_ai:
            return
        creature.object_ai.attacked_by(target)
