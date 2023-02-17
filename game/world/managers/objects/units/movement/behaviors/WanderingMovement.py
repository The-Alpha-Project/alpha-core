import time
from random import randint

from game.world.managers.maps.MapManager import MapManager
from game.world.managers.objects.units.movement.SplineBuilder import SplineBuilder
from utils.ConfigManager import config
from utils.constants.MiscCodes import MoveType
from game.world.managers.objects.units.movement.behaviors.BaseMovement import BaseMovement


# TODO: Namigator: FindRandomPointAroundCircle (Detour)
class WanderingMovement(BaseMovement):
    def __init__(self, spline_callback, is_default):
        super().__init__(move_type=MoveType.WANDER, spline_callback=spline_callback, is_default=is_default)
        self.wandering_distance = 0
        self.last_wandering_movement = 0
        self.wait_time_seconds = 0

    # override
    def initialize(self, unit):
        self.wandering_distance = unit.wander_distance
        self.reset()
        super().initialize(unit)

    # override
    def update(self, now, elapsed):
        if self._can_wander(now):
            self._wander(now)

        super().update(now, elapsed)

    def reset(self):
        self.wait_time_seconds = randint(1, 12)
        self.last_wandering_movement = time.time()

    def _wander(self, now):
        self.last_wandering_movement = now
        position = self._get_wandering_point()
        speed = config.Unit.Defaults.walk_speed
        spline = SplineBuilder.build_normal_spline(self.unit, points=[position], speed=speed)
        self.wait_time_seconds = randint(1, 12) + spline.get_total_time_secs()
        self.spline_callback(spline, movement_behavior=self)

    def _can_wander(self, now):
        return not self.spline and now > self.last_wandering_movement + self.wait_time_seconds

    def _get_wandering_point(self):
        start_point = self.unit.location
        random_point = start_point.get_random_point_in_radius(self.wandering_distance, map_id=self.unit.map_id)
        failed, in_place, path = MapManager.calculate_path(self.unit.map_id, start_point, random_point)
        if failed or len(path) > 1 or in_place:
            return start_point

        map_ = MapManager.get_map(self.unit.map_id, self.unit.instance_id)
        if not map_.is_active_cell_for_location(random_point):
            return start_point

        return random_point
