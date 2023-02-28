import math
from game.world.managers.objects.units.movement.SplineBuilder import SplineBuilder
from utils.constants.MiscCodes import MoveType
from game.world.managers.objects.units.movement.behaviors.BaseMovement import BaseMovement
from utils.constants.PetCodes import PetFollowState


class PetMovement(BaseMovement):
    PET_FOLLOW_DISTANCE = 2.0
    PET_FOLLOW_ANGLE = math.pi / 2

    def __init__(self, spline_callback, is_default):
        super().__init__(move_type=MoveType.PET, spline_callback=spline_callback, is_default=is_default)
        self.stay_position = None
        self.follow_state: PetFollowState = PetFollowState.AT_HOME

    # override
    def update(self, now, elapsed):
        should_move, location = self._should_move()
        if should_move:
            self._move(location)

        super().update(now, elapsed)

    # override
    def on_new_position(self, new_position, waypoint_completed, remaining_waypoints):
        super().on_new_position(new_position, waypoint_completed, remaining_waypoints)
        self.follow_state = PetFollowState.RETURNING if new_position != self.home_position else PetFollowState.AT_HOME
        self.unit.object_ai.movement_inform(data=self.follow_state)
        if self.follow_state == PetFollowState.AT_HOME and not self.stay_position:
            charmer_or_summoner = self.unit.get_charmer_or_summoner()
            self.unit.movement_manager.face_angle(charmer_or_summoner.location.o)

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
        charmer_or_summoner = self.unit.get_charmer_or_summoner()
        target_location = self.stay_position if self.stay_position else charmer_or_summoner.location
        current_distance = self.unit.location.distance(target_location)

        # If target point is within expected distance, don't move.
        if current_distance <= PetMovement.PET_FOLLOW_DISTANCE and not charmer_or_summoner.is_moving():
            return False, None

        self.home_position = target_location.get_point_in_radius_and_angle(PetMovement.PET_FOLLOW_DISTANCE,
                                                                           PetMovement.PET_FOLLOW_ANGLE)
        return True, self.home_position
