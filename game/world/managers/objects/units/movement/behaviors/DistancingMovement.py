import math

from game.world.managers.abstractions.Vector import Vector
from game.world.managers.objects.units.movement.behaviors.BaseMovement import BaseMovement
from game.world.managers.objects.units.movement.helpers.SplineBuilder import SplineBuilder
from utils.Logger import Logger
from utils.constants.MiscCodes import MoveType


class DistancingMovement(BaseMovement):
    MAX_VERTICAL_DELTA = 10.0
    MIN_DISTANCE_EPSILON = 0.05

    def __init__(self, target, distance, spline_callback):
        super().__init__(move_type=MoveType.DISTANCING, spline_callback=spline_callback)
        self.target = target
        self.distance = max(0.0, distance)
        self.waypoints = []

    def initialize(self, unit):
        super().initialize(unit)

        if not self.target or not self.target.is_alive or self.distance <= 0.0:
            return False

        destination = self._get_destination()
        if not destination:
            return False

        self.waypoints = self._get_path(destination)
        return len(self.waypoints) > 0

    def update(self, now, elapsed):
        if self.unit.current_target:
            self.unit.set_current_target(0)

        if self._can_perform_waypoint():
            self.speed_dirty = False
            self._perform_waypoint()

        super().update(now, elapsed)

    def on_spline_finished(self):
        if not self.waypoints and not self.unit.is_player() and self.unit.object_ai.has_spell_list():
            self.unit.object_ai.do_spell_list_cast(ui_diff=1)

    def can_remove(self):
        return not self.unit.is_alive or (not self.waypoints and not self.spline)

    def _can_perform_waypoint(self):
        return self.waypoints and (not self.spline or self.speed_dirty)

    def _perform_waypoint(self):
        waypoint = self.waypoints.pop(0)
        spline = SplineBuilder.build_normal_spline(self.unit, points=[waypoint], speed=self.unit.running_speed)
        self.spline_callback(spline, movement_behavior=self)

    def _get_destination(self):
        delta_x = self.unit.location.x - self.target.location.x
        delta_y = self.unit.location.y - self.target.location.y
        planar_distance = math.hypot(delta_x, delta_y)

        if planar_distance <= DistancingMovement.MIN_DISTANCE_EPSILON:
            return None

        factor = self.distance / planar_distance
        target_x = self.target.location.x + delta_x * factor
        target_y = self.target.location.y + delta_y * factor
        target_z, z_source = Vector.calculate_z(target_x, target_y, self.unit.map_id, self.unit.location.z,
                                                is_rand_point=True)

        if target_z > self.unit.location.z + DistancingMovement.MAX_VERTICAL_DELTA:
            return None

        destination = Vector(target_x, target_y, target_z, z_source=z_source)
        if self.unit.location.distance_sqrd(destination) <= DistancingMovement.MIN_DISTANCE_EPSILON:
            return None

        return destination

    def _get_path(self, destination):
        failed, in_place, path = self.unit.get_map().calculate_path(self.unit.location, destination,
                                                                    smooth=True, clamp_endpoint=True)
        if in_place:
            return []

        if failed:
            return [destination]

        return path
