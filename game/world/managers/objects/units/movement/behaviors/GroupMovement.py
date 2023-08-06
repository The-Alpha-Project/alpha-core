from game.world.managers.maps.helpers import CellUtils
from utils.ConfigManager import config
from utils.constants.MiscCodes import MoveType, ScriptTypes, MoveFlags

from game.world.managers.objects.units.movement.helpers.SplineBuilder import SplineBuilder
from game.world.managers.objects.units.movement.behaviors.BaseMovement import BaseMovement


class GroupMovement(BaseMovement):
    def __init__(self, spline_callback, is_default):
        super().__init__(move_type=MoveType.WAYPOINTS, spline_callback=spline_callback, is_default=is_default)
        self.creature_movement = None
        self.last_waypoint_movement = 0
        self.wait_time_seconds = 0
        self._is_lagging = False

    # override
    def initialize(self, unit):
        super().initialize(unit)
        # Use either walk or run speed by default.
        self.unit.set_move_flag(MoveFlags.MOVEFLAG_WALK, active=not self.unit.should_always_run_ooc())
        return True

    # override
    def update(self, now, elapsed):
        # We require a leader, always.
        if self.unit.creature_group.leader:
            if self._can_perform_waypoint(now):
                # Only the leader leads the way.
                self._perform_waypoint()
                self._set_last_movement(now)
            elif self._can_perform_follow_movement(now) and self._perform_follow_movement(elapsed):
                self._set_last_movement(now)

        super().update(now, elapsed)

    def _set_last_movement(self, now):
        self.last_waypoint_movement = now
        self.wait_time_seconds = self.spline.get_total_time_secs()

    # override
    def on_new_position(self, new_position, waypoint_completed, remaining_waypoints):
        super().on_new_position(new_position, waypoint_completed, remaining_waypoints)
        # Always update home position.
        self.unit.spawn_position = new_position.copy()
        if not waypoint_completed or not self.unit.creature_group.is_leader(self.unit):
            return
        current_wp = self._get_waypoint()
        self._waypoint_push_back()
        if not current_wp.script_id:
            return
        self.unit.get_map().enqueue_script(source=self.unit, target=self.unit,
                                           script_type=ScriptTypes.SCRIPT_TYPE_CREATURE_MOVEMENT,
                                           script_id=current_wp.script_id)

    # override
    def reset(self):
        self.spline = None
        self.wait_time_seconds = 0
        self.last_waypoint_movement = 0

    def _can_perform_waypoint(self, now):
        return self.unit.creature_group.waypoints and not self.spline and self.unit.creature_group.is_leader(self.unit)\
            and now > self.last_waypoint_movement + self.wait_time_seconds

    def _can_perform_follow_movement(self, now):
        return self._is_lagging or not self.spline and not self.unit.creature_group.is_leader(self.unit) and \
            self.unit.creature_group.leader and now > self.last_waypoint_movement + self.wait_time_seconds

    def _perform_waypoint(self):
        creature_group = self.unit.creature_group
        waypoint = self._get_waypoint()
        speed = self._get_speed(creature_group)
        spline = SplineBuilder.build_normal_spline(self.unit, points=[waypoint.location], speed=speed,
                                                   extra_time_seconds=waypoint.wait_time_seconds)
        self.spline_callback(spline, movement_behavior=self)

    def _perform_follow_movement(self, elapsed):
        location, speed = self._get_follow_position_and_speed(self.unit, elapsed)
        if not location:
            return False
        spline = SplineBuilder.build_normal_spline(self.unit, points=[location], speed=speed)
        self.spline_callback(spline, movement_behavior=self)

    def _get_speed(self, creature_group):
        force_running = not creature_group.leader.movement_flags & MoveFlags.MOVEFLAG_WALK
        # If the leader is running, use running for group members.
        if force_running:
            return self.unit.running_speed
        return config.Unit.Defaults.walk_speed if \
            self.unit.movement_flags & MoveFlags.MOVEFLAG_WALK else self.unit.running_speed

    def _get_follow_position_and_speed(self, creature_mgr, elapsed):
        creature_group = self.unit.creature_group
        if creature_mgr.guid not in creature_group.members or not creature_group.leader:
            return None, 0
        group_member = creature_group.members[creature_mgr.guid]
        speed = self._get_speed(creature_group)
        leader_distance = max(0.2, group_member.distance_leader - (elapsed * speed))
        location = creature_group.leader.location.get_point_in_radius_and_angle(leader_distance, group_member.angle)
        creature_distance = group_member.creature.location.distance(location) - (elapsed * speed)

        # Check if unit is lagging.
        if creature_distance > group_member.distance_leader:
            # If distance is greater than current cell size, teleport the unit to the location.
            if creature_distance > CellUtils.CELL_SIZE:
                self.unit.near_teleport(location)
                return None, 0
            if not self._is_lagging:
                self._is_lagging = creature_distance > group_member.distance_leader * 2
        else:
            self._is_lagging = False

        # Catch up if lagging behind.
        if self._is_lagging:
            speed += 0.05 * creature_distance * creature_distance * elapsed

        return location, speed

    def _get_waypoint(self):
        return self.unit.creature_group.waypoints[0]

    def _waypoint_push_back(self):
        waypoint = self.unit.creature_group.waypoints[0]
        self.unit.creature_group.waypoints.remove(waypoint)
        self.unit.creature_group.waypoints.append(waypoint)
