import math

from game.world.managers.maps.helpers import CellUtils
from game.world.managers.objects.units.movement.helpers.PetRangeMove import PetRangeMove
from game.world.managers.objects.units.movement.helpers.SplineBuilder import SplineBuilder
from utils.constants.MiscCodes import MoveType
from game.world.managers.objects.units.movement.behaviors.BaseMovement import BaseMovement
from utils.constants.PetCodes import PetMoveState


class PetMovement(BaseMovement):
    PET_FOLLOW_DISTANCE = 2.0
    PET_FOLLOW_ANGLE = math.pi / 2

    def __init__(self, spline_callback, is_default):
        super().__init__(move_type=MoveType.PET, spline_callback=spline_callback, is_default=is_default)
        self.follow_state: PetMoveState = PetMoveState.AT_HOME
        self.stay_position = None
        self.pet_range_move = None

    # override
    def update(self, now, elapsed):

        should_move_range, location = self._should_move_range()
        if should_move_range:
            self._move_range(location)
        # Do not trigger normal movement while range move is active.
        elif not self.pet_range_move:
            should_move, location = self._should_move()
            if should_move:
                self._move(location)

        super().update(now, elapsed)

    # override
    def on_new_position(self, new_position, waypoint_completed, remaining_waypoints):
        super().on_new_position(new_position, waypoint_completed, remaining_waypoints)
        self.follow_state = self.get_move_state_for_position(new_position)
        self.unit.object_ai.movement_inform(data=self.follow_state)
        if self.follow_state == PetMoveState.AT_HOME and not self.stay_position:
            charmer_or_summoner = self.unit.get_charmer_or_summoner()
            if self.unit.location.o == charmer_or_summoner.location.o:
                return
            self.unit.movement_manager.face_angle(charmer_or_summoner.location.o)

    # override
    def on_spline_finished(self):
        # Spline finished after reaching point and cast time ending.
        if self.follow_state == PetMoveState.AT_RANGE:
            self.pet_range_move = None

    # override
    def reset(self):
        self.spline = None
        self.pet_range_move = None

    # External call.
    def move_in_range(self, target, range_, delay):
        self.pet_range_move = PetRangeMove(target, range_, delay)

    # External call.
    def stay(self, state):
        self.reset()
        self.stay_position = None if not state else self.unit.location.copy()

    def get_move_state_for_position(self, new_position):
        if self.pet_range_move:
            return PetMoveState.MOVE_RANGE if new_position != self.pet_range_move.location else PetMoveState.AT_RANGE
        return PetMoveState.RETURNING if new_position != self.home_position else PetMoveState.AT_HOME

    def _move(self, location):
        speed = self.unit.running_speed
        spline = SplineBuilder.build_normal_spline(self.unit, points=[location], speed=speed)
        self.spline_callback(spline, movement_behavior=self)

    def _move_range(self, location):
        speed = self.unit.running_speed
        spline = SplineBuilder.build_normal_spline(self.unit, points=[location], speed=speed,
                                                   extra_time_seconds=self.pet_range_move.delay)
        self.spline_callback(spline, movement_behavior=self)

    def _should_move_range(self):
        if not self.pet_range_move:
            return False, None

        # Should not probably use RangeMax, but RangeMin can be 0. Ideas?.
        target_location = self.pet_range_move.target.location.get_point_in_between(self.pet_range_move.range_,
                                                                                   vector=self.unit.location)

        # At position or heading in that direction.
        if self.unit.location == self.pet_range_move.location \
                or (self.spline and self.spline.get_waypoint_location() == target_location):
            return False, None

        # get_point_in_between can return None.
        if not target_location:
            return False, None

        self.pet_range_move.location = target_location

        return True, self.pet_range_move.location

    def _should_move(self):
        charmer_or_summoner = self.unit.get_charmer_or_summoner()
        if not charmer_or_summoner:
            return False, None

        target_location = self.stay_position if self.stay_position else charmer_or_summoner.location
        current_distance = self.unit.location.distance(target_location)

        # Stay.
        if self.stay_position and target_location == self.stay_position:
            return False, None
        elif self.stay_position:
            self.home_position = self.stay_position
            return True, self.stay_position

        # Return home.
        if current_distance <= PetMovement.PET_FOLLOW_DISTANCE and not charmer_or_summoner.is_moving():
            return False, None

        self.home_position = target_location.get_point_in_radius_and_angle(PetMovement.PET_FOLLOW_DISTANCE,
                                                                           PetMovement.PET_FOLLOW_ANGLE)

        # Near teleport if lagging above cell size, this can probably be less or half cell.
        if current_distance > CellUtils.CELL_SIZE:
            self.unit.near_teleport(self.home_position)
            return False, None

        return True, self.home_position
