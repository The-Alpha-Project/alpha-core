from game.world.managers.objects.units.movement.helpers.SplineBuilder import SplineBuilder
from utils.ConfigManager import config
from utils.constants.MiscCodes import MoveType
from game.world.managers.objects.units.movement.behaviors.BaseMovement import BaseMovement
from utils.constants.UnitCodes import SplineFlags


class FlightMovement(BaseMovement):
    def __init__(self, waypoints, spline_callback):
        super().__init__(move_type=MoveType.FLIGHT, spline_callback=spline_callback)
        self.waypoints = waypoints
        self.flight_ended = False

    # override
    def update(self, now, elapsed):
        if self._can_begin_flight():
            self._begin_flight()

        super().update(now, elapsed)

    def _can_begin_flight(self):
        return not self.spline

    def _begin_flight(self):
        speed = config.Unit.Player.Defaults.flight_speed
        spline_flags = SplineFlags.SPLINEFLAG_FLYING
        spline = SplineBuilder.build_normal_spline(self.unit, self.waypoints, speed,
                                                   spline_flags=spline_flags, extra_time_seconds=1.0)
        self.spline_callback(spline, movement_behavior=self)

    # override
    def on_new_position(self, new_position, waypoint_completed, remaining_waypoints):
        super().on_new_position(new_position, waypoint_completed, remaining_waypoints)
        # Not a guessed position, update flight state.
        if waypoint_completed:
            self.unit.taxi_manager.update_partial_flight_state(current_waypoint=new_position,
                                                               remaining_waypoints_count=remaining_waypoints)

    # override
    def on_spline_finished(self):
        self.unit.taxi_manager.flight_end()
        self.flight_ended = True

    # override
    def can_remove(self):
        return not self.unit.is_alive or self.flight_ended
