import math

from game.world.managers.maps.helpers import CellUtils
from game.world.managers.objects.units.movement.helpers.PetRangeMove import PetRangeMove
from game.world.managers.objects.units.movement.helpers.SplineBuilder import SplineBuilder
from utils.ConfigManager import config
from utils.constants.MiscCodes import MoveType, MoveFlags
from game.world.managers.objects.units.movement.behaviors.BaseMovement import BaseMovement
from utils.constants.PetCodes import PetMoveState

PET_FOLLOW_DISTANCE = 2.0
PET_FOLLOW_ANGLE = math.pi / 2


class PetMovement(BaseMovement):
    def __init__(self, spline_callback, is_default):
        super().__init__(move_type=MoveType.PET, spline_callback=spline_callback, is_default=is_default)
        self.follow_state: PetMoveState = PetMoveState.AT_HOME
        self.home_position = None
        self.stay_position = None
        self.pet_range_move = None
        self._clear_range_move_next_tick = False
        self._is_lagging = False
        self.follow_angle = math.pi / 2

    def initialize(self, unit):
        if not super().initialize(unit):
            return False
        return True

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
            else:
                self._check_facing()

        super().update(now, elapsed)

        if self._clear_range_move_next_tick:
            self.pet_range_move = None
            self._clear_range_move_next_tick = False

    # override
    def on_new_position(self, new_position, waypoint_completed, remaining_waypoints):
        super().on_new_position(new_position, waypoint_completed, remaining_waypoints)
        self.follow_state = self.get_move_state_for_position(new_position)
        self.unit.object_ai.movement_inform(data=self.follow_state)

    # override
    def on_spline_finished(self):
        # Spline finished after reaching point and cast time ending.
        if self.follow_state == PetMoveState.AT_RANGE:
            from game.world.managers.objects.ai.PetAI import PetAI
            pending_spell_cast = self.unit.object_ai.pending_spell_cast if isinstance(self.unit.object_ai, PetAI) else None
            if (not pending_spell_cast or not pending_spell_cast.spell) and not self._clear_range_move_next_tick:
                self.pet_range_move = None
        # Always update tmp home position.
        self.unit.tmp_home_position = self.home_position

    def _check_facing(self):
        if self.follow_state != PetMoveState.AT_HOME or self.stay_position or self.spline:
            return
        charmer_or_summoner = self.unit.get_charmer_or_summoner()
        if not charmer_or_summoner:
            return

        if self.unit.location.o == charmer_or_summoner.location.o:
            return
        self.unit.movement_manager.face_angle(charmer_or_summoner.location.o)

    # override
    def can_remove(self):
        return not self.unit.is_alive or not self.unit.get_charmer_or_summoner()

    # override
    def reset(self):
        if self.spline:
            # Make sure the last known position gets updated.
            self.spline.update_to_now()
            self.spline = None
        self.pet_range_move = None

    # External call.
    def move_in_range(self, target, range_, delay):
        self.pet_range_move = PetRangeMove(target, range_, delay)

    # External call.
    def stay(self, state):
        self.reset()
        if self.unit.object_ai:
            self.unit.object_ai.set_combat_movement(enabled=not state)
        self.stay_position = None if not state else self.unit.location.copy()

    def request_clear_range_move_next_tick(self):
        self._clear_range_move_next_tick = True

    def get_move_state_for_position(self, new_position):
        if self.pet_range_move:
            return PetMoveState.MOVE_RANGE if new_position != self.pet_range_move.location else PetMoveState.AT_RANGE
        return PetMoveState.RETURNING if new_position != self.home_position else PetMoveState.AT_HOME

    def _move(self, location):
        charmer_or_summoner = self.unit.get_charmer_or_summoner()
        if not charmer_or_summoner:
            return

        if charmer_or_summoner.is_player():
            speed = self.unit.running_speed
        else:
            speed = config.Unit.Defaults.walk_speed if (self.unit.movement_flags & MoveFlags.MOVEFLAG_WALK
                                                        and not self._is_lagging) else self.unit.running_speed

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
        if not self.pet_range_move.target or not self.pet_range_move.target.is_alive:
            self.pet_range_move = None
            return False, None

        distance = self.unit.location.distance(self.pet_range_move.target.location)
        if distance <= self.pet_range_move.range_:
            if self.spline:
                self.unit.movement_manager.stop()
                self.spline = None
            if self.follow_state != PetMoveState.AT_RANGE:
                self.follow_state = PetMoveState.AT_RANGE
                if self.unit.object_ai:
                    self.unit.object_ai.movement_inform(data=self.follow_state)
            return False, None

        # Should not probably use RangeMax, but RangeMin can be 0. Ideas?.
        target_location = self.pet_range_move.target.location.get_point_in_between(self.unit,
                                                                                   self.pet_range_move.range_,
                                                                                   vector=self.unit.location)
        # At position or already heading in that direction.
        if self.unit.location == target_location \
                or (self.spline and self.spline.get_waypoint_location() == target_location):
            self.pet_range_move.location = target_location
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
        if current_distance <= PET_FOLLOW_DISTANCE and not charmer_or_summoner.is_moving():
            self._is_lagging = False
            return False, None

        orientation = self.unit.location.get_angle_towards_vector(target_location)
        self.home_position = target_location.get_point_in_radius_and_angle(PET_FOLLOW_DISTANCE,
                                                                           self.follow_angle,
                                                                           final_orientation=orientation)

        # Near teleport if lagging above defined lag correction distance.
        if current_distance > CellUtils.FOLLOW_LAG_CORRECTION_DISTANCE:
            self.unit.near_teleport(self.home_position)
            return False, None

        self._is_lagging = current_distance > PET_FOLLOW_DISTANCE * 2
        return True, self.home_position
