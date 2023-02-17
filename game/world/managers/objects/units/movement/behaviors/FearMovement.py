import time

from game.world.managers.maps.MapManager import MapManager
from game.world.managers.objects.units.movement.SplineBuilder import SplineBuilder
from utils.constants.MiscCodes import MoveType, MoveFlags
from game.world.managers.objects.units.movement.behaviors.BaseMovement import BaseMovement
from utils.constants.UnitCodes import UnitFlags


# TODO: Namigator: FindRandomPointAroundCircle (Detour)
#  We need a valid path for fear else unexpected collisions can mess things up.
# TODO: Feared units will run way beyond their home position, forcing them to automatically
#  evade upon fear ending.
class FearMovement(BaseMovement):
    def __init__(self, fear_duration_secs, spline_callback):
        super().__init__(move_type=MoveType.FEAR, spline_callback=spline_callback)
        self.fear_duration = fear_duration_secs
        self.expected_timestamp = time.time() + fear_duration_secs
        self.started = False

    # override
    def update(self, now, elapsed):
        if self._can_trigger_fear():
            self.speed_dirty = False
            self._trigger_fear()

        self.fear_duration = max(0, self.fear_duration - elapsed)

        super().update(now, elapsed)

    def _trigger_fear(self):
        self.started = True
        speed = self.unit.running_speed
        fear_point = self.unit.location.get_point_in_radius_and_angle(speed * self.fear_duration, 0)
        spline = SplineBuilder.build_normal_spline(self.unit, points=[fear_point], speed=speed)
        self.spline_callback(spline, movement_behavior=self)

    def _can_trigger_fear(self):
        return (self.speed_dirty or not self.started) and self.fear_duration

    # override
    def can_remove(self):
        return not self.fear_duration or not self.unit.unit_flags & UnitFlags.UNIT_FLAG_FLEEING \
            or time.time() >= self.expected_timestamp

    # override
    def on_spline_finished(self):
        self.unit.movement_flags = MoveFlags.MOVEFLAG_NONE
        MapManager.send_surrounding(self.unit.get_heartbeat_packet(), self.unit, include_self=False)
