from utils.ConfigManager import config
from utils.constants.MiscCodes import MoveType, ScriptTypes

from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.objects.units.movement.helpers.MovementWaypoint import MovementWaypoint
from game.world.managers.objects.units.movement.helpers.SplineBuilder import SplineBuilder
from game.world.managers.objects.units.movement.behaviors.BaseMovement import BaseMovement


class WaypointMovement(BaseMovement):
    def __init__(self, spline_callback, is_default=False, waypoints=None, speed=0):
        super().__init__(move_type=MoveType.WAYPOINTS, spline_callback=spline_callback, is_default=is_default)
        self.creature_movement = None
        self.speed = speed
        self.points = waypoints
        self.waypoints: list[MovementWaypoint] = []
        self.last_waypoint_movement = 0
        self.wait_time_seconds = 0

    # override
    def initialize(self, unit):
        super().initialize(unit)
        if self.points:
            self.waypoints = self._movement_waypoints_from_vectors(self.points)
            return True
        self.creature_movement = WorldDatabaseManager.CreatureMovementHolder.get_waypoints_for_creature(unit)
        if self.creature_movement:
            self.creature_movement.sort(key=lambda wp: wp.point)
            self.waypoints = self._get_sorted_waypoints_by_distance(self.creature_movement)
            return True

        return False

    # override
    def update(self, now, elapsed):
        if self._can_perform_waypoint(now):
            self._perform_waypoint()
            self.last_waypoint_movement = now
            self.wait_time_seconds = self.spline.get_total_time_secs()

        super().update(now, elapsed)

    # override
    def on_new_position(self, new_position, waypoint_completed, remaining_waypoints):
        super().on_new_position(new_position, waypoint_completed, remaining_waypoints)
        # Always update home position.
        self.unit.spawn_position = new_position.copy()
        if waypoint_completed:
            current_wp = self._get_waypoint()
            if current_wp.orientation and (current_wp.wait_time_seconds or not self.is_default):
                self.unit.movement_manager.face_angle(current_wp.orientation)
            if current_wp.script_id:
                self.unit.script_handler.enqueue_script(self.unit, self.unit, ScriptTypes.SCRIPT_TYPE_CREATURE_MOVEMENT,
                                                        current_wp.script_id)
            # If this is a default behavior, make it cyclic.
            if self.is_default:
                self._waypoint_push_back()
            # Not default, pop.
            else:
                self.waypoints.remove(current_wp)

    # override
    def reset(self):
        self.spline = None
        self.wait_time_seconds = 0
        self.last_waypoint_movement = 0

    # override
    def can_remove(self):
        return not self.unit.is_alive or (not self.waypoints and not self.spline)

    def _can_perform_waypoint(self, now):
        return self.waypoints and not self.spline and now > self.last_waypoint_movement + self.wait_time_seconds

    def _perform_waypoint(self):
        waypoint = self._get_waypoint()
        speed = config.Unit.Defaults.walk_speed if not self.speed else self.speed
        spline = SplineBuilder.build_normal_spline(self.unit, points=[waypoint.location], speed=speed,
                                                   extra_time_seconds=waypoint.wait_time_seconds)
        self.spline_callback(spline, movement_behavior=self)

    # noinspection PyMethodMayBeStatic
    def _movement_waypoints_from_vectors(self, points):
        movement_waypoints = []
        for index, point in enumerate(points):
            wp = MovementWaypoint(index, point.x, point.y, point.z, point.o, wait_time_seconds=0)
            movement_waypoints.append(wp)
        return movement_waypoints

    def _get_sorted_waypoints_by_distance(self, movement_waypoints) -> list[MovementWaypoint]:
        points = [MovementWaypoint(wp.point, wp.position_x, wp.position_y, wp.position_z, wp.orientation,
                                   wp.waittime / 1000, wp.script_id) for wp in movement_waypoints]  # Wrap them.
        closest = min(points, key=lambda wp: self.unit.spawn_position.distance(wp.location))
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

