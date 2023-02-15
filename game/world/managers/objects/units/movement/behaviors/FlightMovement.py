from game.world.managers.objects.units.movement.SplineBuilder import SplineBuilder
from utils.ConfigManager import config
from utils.constants.MiscCodes import MoveType
from game.world.managers.objects.units.movement.behaviors.BaseMovement import BaseMovement
from utils.constants.UnitCodes import SplineFlags


class FlightMovement(BaseMovement):
    def __init__(self, waypoints, spline_callback):
        super().__init__(is_default=False, move_type=MoveType.FLIGHT, spline_callback=spline_callback)
        self.waypoints = waypoints
        self.unit = None
        self.flight_ended = False

    # override
    def initialize(self, unit):
        super().initialize(unit)

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
        self.spline = SplineBuilder.build_normal_spline(self.unit, self.waypoints, speed,
                                                        spline_flags=spline_flags, extra_time_seconds=1.0)
        self.spline_callback(self.spline)

    def on_new_position(self, new_position, waypoint_completed):
        super().on_new_position(new_position, waypoint_completed)
        # Not finished yet, update current flight state.
        self.unit.taxi_manager.update_flight_state()

    def on_spline_finished(self):
        print('Finished')
        self.unit.set_taxi_flying_state(False)
        self.unit.teleport(self.unit.map_id, self.unit.pending_taxi_destination, is_instant=True)
        self.unit.pending_taxi_destination = None
        self.unit.taxi_manager.update_flight_state()
        self.flight_ended = True

    def can_remove(self):
        return self.flight_ended
