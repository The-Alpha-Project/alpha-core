import math
from game.world.managers.maps.helpers import CellUtils
from game.world.managers.objects.units.movement.behaviors.PetMovement import PET_FOLLOW_ANGLE
from game.world.managers.objects.units.movement.helpers.SplineBuilder import SplineBuilder
from utils.ConfigManager import config
from utils.Logger import Logger
from utils.constants.MiscCodes import MoveType, MoveFlags
from game.world.managers.objects.units.movement.behaviors.BaseMovement import BaseMovement


class FollowMovement(BaseMovement):
    def __init__(self, spline_callback, target=None, dist=2, angle=math.pi / 2, is_default=False):
        super().__init__(move_type=MoveType.FOLLOW, spline_callback=spline_callback, is_default=is_default)
        self.target = target
        self.follow_dist = dist
        self.follow_angle = angle
        self._is_lagging = False

    def initialize(self, unit):
        if not super().initialize(unit):
            return False
        # Behavior was created with a target set, most likely from scripts.
        if self.target:
            return True
        self.target = self.unit.get_charmer_or_summoner()
        if not self.target:
            Logger.warning(f"FollowMovement: Unable to resolve target.")
            return False
        # Calculate follow angle for guardian.
        if unit.is_guardian():
            guardian_count = self.target.pet_manager.get_guardian_count()
            self.follow_angle = PET_FOLLOW_ANGLE + (math.pi / 6) * (guardian_count if guardian_count else 1)
            self.follow_angle %= 2 * math.pi
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
        follow_target = self._get_follow_target()
        if not follow_target:
            return
        tmp_home = follow_target.location.get_point_in_radius_and_angle(self.follow_dist, self.follow_angle)
        self.unit.tmp_home_position = tmp_home
        if waypoint_completed and not follow_target.is_moving():
            self.unit.movement_manager.face_angle(follow_target.location.o)

    # override
    def can_remove(self):
        follow_target = self._get_follow_target()
        if not follow_target:
            return True
        return not self.unit.is_alive or not follow_target.is_alive

    # override
    def reset(self):
        if not self.spline:
            return
        # Make sure the last known position gets updated.
        self.spline.update_to_now()
        self.spline = None

    def _move(self, location):
        follow_target = self._get_follow_target()
        if not follow_target:
            return

        if follow_target.is_player():
            speed = self.unit.running_speed
        else:
            speed = config.Unit.Defaults.walk_speed if (self.unit.movement_flags & MoveFlags.MOVEFLAG_WALK
                                                        and not self._is_lagging) else self.unit.running_speed

        spline = SplineBuilder.build_normal_spline(self.unit, points=[location], speed=speed)
        self.spline_callback(spline, movement_behavior=self)

    def _get_follow_target(self):
        charmer_or_summoner = self.unit.get_charmer_or_summoner()
        return charmer_or_summoner if charmer_or_summoner else self.target

    def _should_move(self):
        follow_target = self._get_follow_target()
        if not follow_target or self.unit.is_casting():
            return False, None

        current_distance = self.unit.location.distance(follow_target.location)

        if current_distance <= self.follow_dist and not follow_target.is_moving():
            self._is_lagging = False
            return False, None

        move_location = follow_target.location.get_point_in_radius_and_angle(self.follow_dist, self.follow_angle)

        # Near teleport if lagging above one third of view distance.
        if current_distance > CellUtils.VIEW_DISTANCE / 3.0:
            self.unit.near_teleport(move_location)
            return False, None

        self._is_lagging = current_distance > self.follow_dist * 2
        return True, move_location
