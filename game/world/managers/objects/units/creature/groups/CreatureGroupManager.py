import math

from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.abstractions.Vector import Vector
from game.world.managers.objects.units.creature.groups.CreatureGroupMember import CreatureGroupMember
from game.world.managers.objects.units.movement.helpers.MovementWaypoint import MovementWaypoint
from utils.Logger import Logger
from utils.constants.MiscCodes import ZSource
from utils.constants.MiscCodes import CreatureGroupFlags


CREATURE_GROUPS = {}


class CreatureGroupManager:
    def __init__(self):
        self.original_leader_spawn_id = 0
        self.waypoints: list[MovementWaypoint] = []
        self.leader = None
        self.creature_group = None
        self.members: dict[int, CreatureGroupMember] = {}
        self.member_configs: dict[int, tuple[float, float, int]] = {}
        self.group_flags = 0
        self._respawn_guard = False

    @staticmethod
    def get_create_group(creature_group):
        if creature_group.leader_guid not in CREATURE_GROUPS:
            creature_group_mgr = CreatureGroupManager()
            creature_group_mgr.creature_group = creature_group
            creature_group_mgr.original_leader_spawn_id = creature_group.leader_guid
            CREATURE_GROUPS[creature_group.leader_guid] = creature_group_mgr
        return CREATURE_GROUPS[creature_group.leader_guid]

    def is_leader(self, creature_mgr):
        return self.leader and self.leader.guid == creature_mgr.guid

    def get_leader(self):
        if not self.leader or self.leader.guid not in self.members:
            return None
        return self.members[self.leader.guid]

    def add_member(self, creature_mgr, dist=None, angle=None, flags=None):
        if creature_mgr.creature_group and creature_mgr.creature_group is not self:
            Logger.warning(f'{creature_mgr.get_name()} attempted to join another group without leaving first.')
            return False

        if creature_mgr.guid not in self.members:
            self.members[creature_mgr.guid] = CreatureGroupMember(creature_mgr, self.creature_group, dist, angle, flags)
        member = self.members[creature_mgr.guid]
        self.member_configs[creature_mgr.spawn_id] = (member.distance_leader, member.angle, member.flags)
        # Set leader.
        if self.creature_group.leader_guid == creature_mgr.spawn_id:
            self.leader = creature_mgr
            self.original_leader_spawn_id = creature_mgr.spawn_id
            # Generate waypoints that will be used by the current/temporary leader.
            creature_movement = WorldDatabaseManager.CreatureMovementHolder.get_waypoints_for_creature(
                creature_mgr.entry, creature_mgr.spawn_id)
            if creature_movement:
                creature_movement.sort(key=lambda wp: wp.point)
                self.waypoints = self._get_sorted_waypoints_by_distance(creature_movement)

        self.group_flags |= member.flags

        if not creature_mgr.creature_group:
            creature_mgr.creature_group = self

        if self.creature_group.leader_guid != creature_mgr.spawn_id:
            creature_mgr.movement_manager.initialize_or_reset()

        Logger.debug(f'{creature_mgr.get_name()} joined group.')
        return True

    def remove_member(self, creature_mgr, disband_if_original_leader=False, forget_member=False):
        if creature_mgr.guid not in self.members:
            if creature_mgr.creature_group is self:
                creature_mgr.creature_group = None
            if forget_member:
                self.member_configs.pop(creature_mgr.spawn_id, None)
            return
        was_current_leader = self.is_leader(creature_mgr)
        is_original_leader = self.original_leader_spawn_id == creature_mgr.spawn_id
        self.members.pop(creature_mgr.guid)
        if forget_member:
            self.member_configs.pop(creature_mgr.spawn_id, None)
        disbanded = False

        if creature_mgr.creature_group is self:
            creature_mgr.creature_group = None

        if not self.members or (disband_if_original_leader and is_original_leader):
            self.disband()
            disbanded = True
        elif was_current_leader and self.is_formation():
            # Script-command leave from a temporary leader should restore original leader when possible.
            new_leader = None
            if disband_if_original_leader:
                original_leader = self._get_original_leader_member()
                if original_leader and original_leader.is_alive:
                    new_leader = original_leader
            if not new_leader:
                new_leader = self._pick_new_leader()
            self.leader = new_leader if new_leader else None
            self._reinitialize_alive_members()
        elif was_current_leader:
            self.leader = None

        # Member left the group but group still exists, reset leaver movement behavior.
        if not disbanded and not is_original_leader:
            creature_mgr.movement_manager.initialize_or_reset()

        if not disbanded:
            Logger.debug(f'{creature_mgr.get_name()} left creature group.')

    def on_members_attack_start(self, creature_mgr, target):
        if not target or not self.group_flags & CreatureGroupFlags.OPTION_AGGRO_TOGETHER:
            return

        for guid, member in self.members.items():
            if guid == creature_mgr.guid:
                continue
            self._assist_member(member.creature, target)

    def on_member_died(self, creature_mgr):
        is_original_leader = self.original_leader_spawn_id == creature_mgr.spawn_id

        if self.group_flags & CreatureGroupFlags.OPTION_INFORM_LEADER_ON_MEMBER_DIED:
            # Mirrors VMaNGOS behavior: only inform the original leader if a non-original member dies.
            if not is_original_leader:
                original_leader = self._get_original_leader_member()
                if original_leader and original_leader.is_alive and original_leader.object_ai:
                    original_leader.object_ai.group_member_just_died(creature_mgr, is_leader=False)
        if self.group_flags & CreatureGroupFlags.OPTION_INFORM_MEMBERS_ON_ANY_DIED:
            for guid, member in self.members.items():
                if guid == creature_mgr.guid or not member.creature.is_alive:
                    continue
                if member.creature.object_ai:
                    member.creature.object_ai.group_member_just_died(creature_mgr, is_leader=is_original_leader)

        # We don't re-use creatures instances, remove.
        self.remove_member(creature_mgr)

    def on_leave_combat(self, creature_mgr):
        master_evade = self.original_leader_spawn_id == creature_mgr.spawn_id

        if self.group_flags & CreatureGroupFlags.OPTION_EVADE_TOGETHER:
            for guid, member in self.members.items():
                if guid == creature_mgr.guid or not member.creature.is_alive or not member.creature.combat_target:
                    continue
                if member.creature.in_combat:
                    member.creature.leave_combat()

            # If a non-original member evades, force the original leader to evade too when possible.
            if not master_evade:
                original_leader = self._get_original_leader_member()
                if original_leader and original_leader.is_alive:
                    master_evade = True
                    if original_leader.in_combat:
                        original_leader.leave_combat()

        if self.group_flags & CreatureGroupFlags.OPTION_RESPAWN_ALL_ON_ANY_EVADE or \
                (self.group_flags & CreatureGroupFlags.OPTION_RESPAWN_ALL_ON_MASTER_EVADE and master_evade):
            self._respawn_all_except(creature_mgr, except_spawn_id=creature_mgr.spawn_id)

    def on_member_respawn(self, creature_mgr):
        if self._respawn_guard:
            return

        if self.is_formation() and creature_mgr.spawn_id == self.original_leader_spawn_id:
            self.leader = creature_mgr
            self._reinitialize_alive_members()

        if self.group_flags & CreatureGroupFlags.OPTION_RESPAWN_TOGETHER:
            self._respawn_all_except(creature_mgr, except_spawn_id=creature_mgr.spawn_id)

    def disband(self):
        Logger.debug(f'Disbanding creature group.')
        for member in self.members.values():
            member.creature.creature_group = None
            if self.is_formation() and member.creature.is_alive and not member.creature.in_combat:
                member.creature.movement_manager.initialize_or_reset()
            Logger.debug(f'{member.creature.get_name()} left creature group.')
        self.members.clear()
        self.member_configs.clear()
        self.leader = None
        self.group_flags = 0
        if not self.original_leader_spawn_id:
            Logger.error(f'Orphan creature group with no leader. Leader Spawn ID: {self.creature_group.leader_guid}.')
            return
        CREATURE_GROUPS.pop(self.original_leader_spawn_id, None)

    def get_alive_count(self):
        alive = 0
        for guid, member in self.members.items():
            if member.creature.is_alive:
                alive += 1
        return alive

    def is_formation(self):
        return (self.group_flags & CreatureGroupFlags.OPTION_FORMATION_MOVE) != 0

    def compute_relative_position(self, group_member, distance=0.0):
        leader = self.get_leader()
        if not leader or not self.leader:
            return None
        leader_creature = leader.creature
        return self.compute_relative_position_from(group_member, leader_creature, leader_creature.location,
                                                   distance=distance)

    def compute_relative_position_from(self, group_member, leader_creature, leader_location, distance=0.0):
        distance = distance if distance else group_member.distance_leader
        angle = group_member.angle
        # Database values are often in degrees; normalize to radians if needed.
        if abs(angle) > (math.pi * 2):
            angle = math.radians(angle)
        leader_angle = leader_location.o
        off_angle = angle + leader_angle
        off_x = (math.cos(off_angle) * distance) + leader_location.x
        off_y = (math.sin(off_angle) * distance) + leader_location.y
        off_z = leader_location.z + (group_member.creature.location.z - leader_location.z) * 0.5

        # Try to find precise Z.
        z, z_source = leader_creature.get_map().calculate_z(off_x, off_y, off_z, is_rand_point=True)
        if z_source != ZSource.CURRENT_Z:
            off_z = z
        return Vector(off_x, off_y, off_z)

    def _get_sorted_waypoints_by_distance(self, movement_waypoints) -> list[MovementWaypoint]:
        points = [MovementWaypoint(wp.point, wp.position_x, wp.position_y, wp.position_z, wp.orientation,
                                   wp.waittime / 1000, wp.script_id) for wp in movement_waypoints]  # Wrap them.
        closest = min(points, key=lambda wp: self.leader.spawn_position.distance(wp.location))
        index = points.index(closest)
        if index:
            points = points[index:] + points[0:index]
        return points

    def _pick_new_leader(self):
        for member in self.members.values():
            creature = member.creature
            if creature.is_alive and (not self.leader or creature.guid != self.leader.guid):
                return creature

        # Fallback in case the current leader is still alive and no alternative candidate exists.
        if self.leader and self.leader.guid in self.members and self.leader.is_alive:
            return self.leader
        return None

    def _get_original_leader_member(self):
        for member in self.members.values():
            if member.creature.spawn_id == self.original_leader_spawn_id:
                return member.creature
        return None

    def _reinitialize_alive_members(self):
        if not self.is_formation():
            return
        for member in self.members.values():
            if member.creature.is_alive and not member.creature.in_combat:
                member.creature.movement_manager.initialize_or_reset()

    def _respawn_all_except(self, source_creature, except_spawn_id):
        if self._respawn_guard:
            return

        self._respawn_guard = True
        try:
            member_spawn_ids = set(self.member_configs.keys())
            member_spawn_ids.add(self.original_leader_spawn_id)

            for spawn_id in member_spawn_ids:
                if not spawn_id or spawn_id == except_spawn_id:
                    continue
                self._respawn_member_by_spawn_id(source_creature, spawn_id)
        finally:
            self._respawn_guard = False

    def _respawn_member_by_spawn_id(self, source_creature, spawn_id):
        for member in self.members.values():
            creature = member.creature
            if creature.spawn_id == spawn_id and creature.initialized and not creature.is_alive:
                creature.respawn()
                return

        map_ = source_creature.get_map()
        spawn = map_.get_creature_spawn_by_id(spawn_id)
        if not spawn or not spawn.creature_instance:
            return

        creature = spawn.creature_instance
        if creature.initialized and not creature.is_alive:
            creature.respawn()

    # noinspection PyMethodMayBeStatic
    def _assist_member(self, creature, target):
        if creature.combat_target:
            return
        if not creature.object_ai:
            return
        creature.object_ai.attacked_by(target)
