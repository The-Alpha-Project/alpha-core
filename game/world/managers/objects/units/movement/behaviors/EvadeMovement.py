from game.world.managers.objects.units.movement.helpers.SplineBuilder import SplineBuilder
from utils.constants.MiscCodes import MoveType
from game.world.managers.objects.units.movement.behaviors.BaseMovement import BaseMovement


class EvadeMovement(BaseMovement):
    def __init__(self, waypoints, spline_callback):
        super().__init__(move_type=MoveType.EVADE, spline_callback=spline_callback)
        self.waypoints = waypoints
        self.unit = None
        self.wait_time_seconds = 0
        self.last_movement = 0
        self.path_ended = False

    # override
    def update(self, now, elapsed):
        if self._can_begin_evade(now):
            self._begin_evade()
            self.last_movement = now
            self.wait_time_seconds = self.get_total_time_secs()

        super().update(now, elapsed)

    # override
    def on_new_position(self, new_position, waypoint_completed, remaining_waypoints):
        super().on_new_position(new_position, waypoint_completed, remaining_waypoints)
        # Move to next waypoint.
        if waypoint_completed and self.waypoints:
            self.waypoints.pop(0)

    # override
    def on_spline_finished(self):
        # If remaining waypoints, return.
        if self.waypoints:
            return
        self.unit.on_at_home()
        self.unit.attack_stop()
        self.unit.threat_manager.reset()
        self.unit.is_evading = False
        self.path_ended = True

    # override
    def can_remove(self):
        return not self.unit.is_alive or self.path_ended

    def _can_begin_evade(self, now):
        return self.waypoints and now > self.last_movement + self.wait_time_seconds

    def _begin_evade(self):
        speed = self.unit.running_speed
        spline = SplineBuilder.build_normal_spline(self.unit, [self.waypoints[0]], speed)
        self.spline_callback(spline, movement_behavior=self)
