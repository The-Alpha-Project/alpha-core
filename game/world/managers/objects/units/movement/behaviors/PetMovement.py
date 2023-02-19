import math
from game.world.managers.objects.units.movement.SplineBuilder import SplineBuilder
from utils.constants.MiscCodes import MoveType
from game.world.managers.objects.units.movement.behaviors.BaseMovement import BaseMovement


class PetMovement(BaseMovement):
    PET_FOLLOW_DISTANCE = 2.0
    PET_FOLLOW_ANGLE = math.pi / 2

    def __init__(self, spline_callback, is_default):
        super().__init__(move_type=MoveType.PET, spline_callback=spline_callback, is_default=is_default)
        self.stay_position = None
        self.home_position = None

    # override
    def update(self, now, elapsed):
        should_move, location = self._should_move()
        if should_move:
            self._move(location)

        super().update(now, elapsed)

    # override
    def on_new_position(self, new_position, waypoint_completed):
        super().on_new_position(new_position, waypoint_completed)
        self.unit.object_ai.movement_inform(move_type=1 if new_position == self.home_position else None)

    # override
    def reset(self):
        self.spline = None

    def stay(self, state):
        self.stay_position = None if not state else self.unit.location.copy()

    def _move(self, location):
        speed = self.unit.running_speed
        spline = SplineBuilder.build_normal_spline(self.unit, points=[location], speed=speed)
        self.spline_callback(spline, movement_behavior=self)

    def _should_move(self):
        target_location = self.stay_position if self.stay_position else self.unit.get_charmer_or_summoner().location
        current_distance = self.unit.location.distance(target_location)

        # If target point is within expected distance, don't move.
        if current_distance <= PetMovement.PET_FOLLOW_DISTANCE:
            return False, None

        self.home_position = target_location.get_point_in_radius_and_angle(PetMovement.PET_FOLLOW_DISTANCE,
                                                                           PetMovement.PET_FOLLOW_ANGLE)
        return True, self.home_position
