import math
from game.world.managers.maps.helpers import CellUtils
from game.world.managers.objects.units.movement.helpers.SplineBuilder import SplineBuilder
from utils.ConfigManager import config
from utils.constants.MiscCodes import MoveType, MoveFlags
from game.world.managers.objects.units.movement.behaviors.BaseMovement import BaseMovement


class FollowMovement(BaseMovement):
    def __init__(self, spline_callback, target, dist=2, angle=math.pi / 2):
        super().__init__(move_type=MoveType.FOLLOW, spline_callback=spline_callback, is_default=False)
        self.target = target
        self.follow_dist = dist
        self.follow_angle = angle
        self._is_lagging = False

    def initialize(self, unit):
        if not super().initialize(unit):
            return False
        return True

    # override
    def update(self, now, elapsed):
        should_move, location = self._should_move()
        if should_move:
            self._move(location)

        super().update(now, elapsed)

    # override
    def on_new_position(self, new_position, waypoint_completed, remaining_waypoints):
        super().on_new_position(new_position, waypoint_completed, remaining_waypoints)
        # Always update tmp home position.
        tmp_home = self.target.location.get_point_in_radius_and_angle(self.follow_dist, self.follow_angle)
        self.unit.tmp_home_position = tmp_home

    # override
    def can_remove(self):
        return not self.unit.is_alive or not self.target or not self.target.is_alive

    # override
    def reset(self):
        if self.spline:
            # Make sure the last known position gets updated.
            self.spline.update_to_now()
            self.spline = None

    def _move(self, location):
        if not self.target:
            return

        if self.target.is_player():
            speed = self.unit.running_speed
        else:
            speed = config.Unit.Defaults.walk_speed if (self.unit.movement_flags & MoveFlags.MOVEFLAG_WALK
                                                        and not self._is_lagging) else self.unit.running_speed

        spline = SplineBuilder.build_normal_spline(self.unit, points=[location], speed=speed)
        self.spline_callback(spline, movement_behavior=self)

    def _should_move(self):
        if not self.target:
            return False, None

        current_distance = self.unit.location.distance(self.target.location)

        if current_distance <= self.follow_dist and not self.target.is_moving():
            self._is_lagging = False
            return False, None

        move_location = self.target.location.get_point_in_radius_and_angle(self.follow_dist, self.follow_angle)

        # Near teleport if lagging above view distance, this can probably be less or half cell.
        if current_distance > CellUtils.VIEW_DISTANCE:
            self.unit.near_teleport(move_location)
            return False, None

        self._is_lagging = current_distance > self.follow_dist * 2
        return True, move_location
