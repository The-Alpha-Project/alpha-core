import time
from utils.ConfigManager import config
from utils.constants.MiscCodes import MoveType, ScriptTypes, MoveFlags

from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.objects.units.movement.helpers.MovementWaypoint import MovementWaypoint
from game.world.managers.objects.units.movement.helpers.SplineBuilder import SplineBuilder
from game.world.managers.objects.units.movement.behaviors.BaseMovement import BaseMovement


class WaypointMovement(BaseMovement):
    def __init__(self, spline_callback, is_default=False, waypoints=None, speed=0, command_move_info=None,
                 is_single=False):
        super().__init__(move_type=MoveType.WAYPOINTS, spline_callback=spline_callback, is_default=is_default)
        self.creature_movement = None
        self.is_single = is_single
        self.command_move_info = command_move_info
        self.speed = speed
        self.should_repeat = is_default
        self.points = waypoints
        self.waypoints: list[MovementWaypoint] = []
        self.initial_wait_time_seconds = 0

    # override
    def initialize(self, unit):
        super().initialize(unit)

        # Triggered from scripts.
        if self.command_move_info:
            return self._initialize_from_script(unit)

        # Default behaviors.
        if self.points:
            self.waypoints = self._movement_waypoints_from_vectors(self.points)
            return True
        self.creature_movement = WorldDatabaseManager.CreatureMovementHolder.get_waypoints_for_creature(unit.entry,
                                                                                                        unit.spawn_id)
        if self.creature_movement:
            self.creature_movement.sort(key=lambda wp: wp.point)
            self.waypoints = self._get_sorted_waypoints_by_distance(self.creature_movement)
            return True

        return False

    def _initialize_from_script(self, unit):
        movement_holder = WorldDatabaseManager.CreatureMovementHolder
        entry = unit.entry if not self.command_move_info.overwrite_entry else self.command_move_info.overwrite_entry
        guid = unit.spawn_id if not self.command_move_info.overwrite_guid else self.command_move_info.overwrite_guid
        movement_waypoints = movement_holder.get_waypoints_for_creature(entry, guid, self.command_move_info.wp_source)
        self.creature_movement = movement_waypoints

        # Update should repeat.
        self.should_repeat = self.is_default and self.command_move_info.repeat

        # Set initial delay if needed.
        if self.command_move_info.initial_delay:
            self.initial_wait_time_seconds = self.command_move_info.initial_delay / 1000

        # We found waypoints data according to script provided data.
        if self.creature_movement:
            self.creature_movement.sort(key=lambda wp: wp.point)
            start_points = 0 if not self.command_move_info.start_point else self.command_move_info.start_point
            self.waypoints = self._get_sorted_waypoints_by_start_point(self.creature_movement, start_points)
            return True

        return False

    # override
    def update(self, now, elapsed):
        # Initial delay provided by script.
        if self.initial_wait_time_seconds:
            self.initial_wait_time_seconds = max(0, self.initial_wait_time_seconds - elapsed)

        if not self.initial_wait_time_seconds:
            waypoint = self._get_waypoint()
            if waypoint:
                # Ongoing waypoint, update.
                if waypoint.initialized:
                    waypoint.update(elapsed)

                if self._can_perform_waypoint(waypoint):
                    self.speed_dirty = False
                    self._perform_waypoint()

        super().update(now, elapsed)

    # override
    def on_new_position(self, new_position, waypoint_completed, remaining_waypoints):
        super().on_new_position(new_position, waypoint_completed, remaining_waypoints)
        # Always update home position.
        self.unit.spawn_position = new_position.copy()
        if not waypoint_completed:
            return

        current_wp = self._get_waypoint()
        if not current_wp:
            return

        current_behavior = self.unit.movement_manager.get_current_behavior()
        if current_behavior and current_behavior.move_type != self.move_type:
            return

        if self._should_use_facing(current_wp):
            self.unit.movement_manager.face_angle(current_wp.orientation)

        if current_wp.script_id:
            self.unit.get_map().enqueue_script(source=self.unit, target=self.unit,
                                               script_type=ScriptTypes.SCRIPT_TYPE_CREATURE_MOVEMENT,
                                               script_id=current_wp.script_id)

        # If this is a default behavior, make it cyclic.
        if self.should_repeat:
            self._waypoint_push_back()
        # Not default, pop.
        else:
            self.waypoints.remove(current_wp)

    # override
    def reset(self):
        current_wp = self._get_waypoint()
        if current_wp:
            current_wp.reset()
        if not self.spline:
            return
         # Make sure the last known position gets updated.
        self.spline.update_to_now()
        self.spline = None

    # override
    def can_remove(self):
        return not self.unit.is_alive or (not self.waypoints and not self.spline)

    def _can_perform_waypoint(self, waypoint):
        return self.waypoints and not self.spline and (waypoint.completed or not waypoint.initialized or self.speed_dirty)

    def _perform_waypoint(self):
        waypoint = self._get_waypoint()
        waypoint.initialized = True
        speed = self._get_speed()
        spline = SplineBuilder.build_normal_spline(self.unit, points=[waypoint.location], speed=speed,
                                                   extra_time_seconds=waypoint.wait_time_seconds)
        self.spline_callback(spline, movement_behavior=self)
        waypoint.set_total_wait_time_seconds(self.get_total_time_secs())

    # TODO: We are missing a lot of code regarding speed handling.
    #  VMaNGOS - Unit::UpdateSpeed(UnitMoveType mtype, bool forced, float ratio)
    #  VMaNGOS - SetWalk() / UnitStates.
    #  Probably all speeds should go through StatsManager.
    def _get_speed(self):
        return self.speed if self.speed else config.Unit.Defaults.walk_speed if \
            self.unit.movement_flags & MoveFlags.MOVEFLAG_WALK else self.unit.running_speed

    # noinspection PyMethodMayBeStatic
    def _movement_waypoints_from_vectors(self, points):
        movement_waypoints = []
        for index, point in enumerate(points):
            wp = MovementWaypoint(index, point.x, point.y, point.z, point.o, wait_time_seconds=0)
            movement_waypoints.append(wp)
        return movement_waypoints

    def _get_sorted_waypoints_by_start_point(self, movement_waypoints, start_index) -> list[MovementWaypoint]:
        points = [MovementWaypoint(wp.point, wp.position_x, wp.position_y, wp.position_z, wp.orientation,
                                   wp.waittime / 1000, wp.script_id) for wp in movement_waypoints]  # Wrap them.
        if not start_index:
            return points
        return points[start_index:] + points[0:start_index]

    def _get_sorted_waypoints_by_distance(self, movement_waypoints) -> list[MovementWaypoint]:
        points = [MovementWaypoint(wp.point, wp.position_x, wp.position_y, wp.position_z, wp.orientation,
                                   wp.waittime / 1000, wp.script_id) for wp in movement_waypoints]  # Wrap them.
        closest = min(points, key=lambda wp: self.unit.spawn_position.distance(wp.location))
        index = points.index(closest)
        if index:
            points = points[index:] + points[0:index]
        return points

    def _should_use_facing(self, waypoint: MovementWaypoint):
        return waypoint.orientation and waypoint.orientation != 100 and \
            (waypoint.wait_time_seconds or self.is_single)

    def _get_waypoint(self):
        if not self.waypoints:
            return None      
        return self.waypoints[0]

    def _waypoint_push_back(self):
        waypoint = self.waypoints[0]
        waypoint.reset()
        self.waypoints.remove(waypoint)
        self.waypoints.append(waypoint)
