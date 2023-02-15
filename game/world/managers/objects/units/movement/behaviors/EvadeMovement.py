from game.world.managers.objects.units.movement.SplineBuilder import SplineBuilder
from utils.constants.MiscCodes import MoveType
from game.world.managers.objects.units.movement.behaviors.BaseMovement import BaseMovement


class EvadeMovement(BaseMovement):
    def __init__(self, waypoints, spline_callback):
        super().__init__(is_default=False, move_type=MoveType.EVADE, spline_callback=spline_callback)
        self.waypoints = waypoints
        self.unit = None
        self.wait_time_seconds = 0
        self.last_movement = 0
        self.path_ended = False

    # override
    def initialize(self, unit):
        super().initialize(unit)
        self.waypoints = self.waypoints

    # override
    def update(self, now, elapsed):
        if self._can_begin_evade(now):
            self._begin_evade()
            self.last_movement = now
            self.wait_time_seconds = self.spline.get_total_time_secs()
            print(f'Waiting {self.wait_time_seconds}')

        super().update(now, elapsed)

    def on_new_position(self, new_position, waypoint_completed):
        super().on_new_position(new_position, waypoint_completed)
        # Move to next waypoint.
        if waypoint_completed and self.waypoints:
            self.waypoints.pop(0)

    def on_spline_finished(self):
        # If remaining waypoints, return.
        if self.waypoints:
            return
        print('At home')
        self.unit.is_evading = False
        self.unit.on_at_home()
        self.path_ended = True

    def can_remove(self):
        return self.path_ended

    def _can_begin_evade(self, now):
        return self.waypoints and now > self.last_movement + self.wait_time_seconds

    def _begin_evade(self):
        print(f'Moving to {self.waypoints[0]}')
        speed = self.unit.running_speed
        self.spline = SplineBuilder.build_normal_spline(self.unit, [self.waypoints[0]], speed)
        self.spline_callback(self.spline)
