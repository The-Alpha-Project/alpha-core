from utils.ConfigManager import config
from utils.Logger import Logger
from utils.constants.MiscCodes import MoveType

from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.objects.units.movement.MovementWaypoint import MovementWaypoint
from game.world.managers.objects.units.movement.SplineBuilder import SplineBuilder
from game.world.managers.objects.units.movement.behaviors.BaseMovement import BaseMovement


class GroupMovement(BaseMovement):
    def __init__(self, spline_callback, is_default):
        super().__init__(move_type=MoveType.WAYPOINTS, spline_callback=spline_callback, is_default=is_default)
        self.creature_movement = None
        self.waypoints: list[MovementWaypoint] = []
        self.last_waypoint_movement = 0
        self.wait_time_seconds = 0

    # override
    def initialize(self, unit):
        super().initialize(unit)
        if not unit.creature_group.leader:
            return
        group_leader = unit.creature_group.leader
        self.creature_movement = WorldDatabaseManager.CreatureMovementHolder.get_waypoints_by_entry(group_leader.entry)
        if self.creature_movement:
            self.creature_movement.sort(key=lambda wp: wp.point)
            self.waypoints = self._get_sorted_waypoints_by_distance(self.creature_movement)

    # override
    def update(self, now, elapsed):
        if self._can_perform_waypoint(now):
            self._perform_waypoint()
            self._set_last_movement(now)
        elif self._can_perform_follow_movement(now):
            self._perform_follow_movement(elapsed)
            self._set_last_movement(now)

        super().update(now, elapsed)

    def _set_last_movement(self, now):
        self.last_waypoint_movement = now
        self.wait_time_seconds = self.spline.get_total_time_secs()

    # override
    def on_new_position(self, new_position, waypoint_completed):
        super().on_new_position(new_position, waypoint_completed)
        # Always update home position.
        self.unit.spawn_position = new_position.copy()
        if waypoint_completed:
            self._waypoint_push_back()
            if self.waypoints[-1].script_id():
                Logger.warning(f'{self.unit.get_name()},  movement script id {self.waypoints[-1].script_id()} missing.')

    def reset(self):
        self.spline = None
        self.wait_time_seconds = 0
        self.last_waypoint_movement = 0

    def _can_perform_waypoint(self, now):
        return self.waypoints and not self.spline and self.unit.creature_group.is_leader(self.unit) and \
            now > self.last_waypoint_movement + self.wait_time_seconds

    def _can_perform_follow_movement(self, now):
        return self.waypoints and not self.spline and not self.unit.creature_group.is_leader(self.unit) and \
            now > self.last_waypoint_movement + self.wait_time_seconds

    def _perform_waypoint(self):
        waypoint = self._get_waypoint()
        speed = config.Unit.Defaults.walk_speed
        spline = SplineBuilder.build_normal_spline(self.unit, points=[waypoint.location()], speed=speed,
                                                   extra_time_seconds=waypoint.wait_time_seconds())
        self.spline_callback(spline, movement_behavior=self)

    def _perform_follow_movement(self, elapsed):
        location, speed = self.unit.creature_group.get_follow_position_and_speed(self.unit, elapsed)
        if not location:
            return
        spline = SplineBuilder.build_normal_spline(self.unit, points=[location], speed=speed)
        self.spline_callback(spline, movement_behavior=self)

    def _get_sorted_waypoints_by_distance(self, movement_waypoints) -> list[MovementWaypoint]:
        points = [MovementWaypoint(wp) for wp in movement_waypoints]  # Wrap them.
        closest = min(points, key=lambda wp: self.unit.spawn_position.distance(wp.location()))
        index = points.index(closest)
        if index:
            points = points[index:] + points[0:index]
        return points

    def _get_waypoint(self):
        return self.waypoints[0]

    def _waypoint_push_back(self):
        waypoint = self.waypoints[0]
        self.waypoints.remove(waypoint)
        self.waypoints.append(waypoint)
