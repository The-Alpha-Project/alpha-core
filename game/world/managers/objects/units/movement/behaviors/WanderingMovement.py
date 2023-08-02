import math
import time
from random import randint

from game.world.managers.objects.units.movement.helpers.SplineBuilder import SplineBuilder
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
        return super().initialize(unit)

    # override
    def update(self, now, elapsed):
        if self._can_wander(now):
            self.last_wandering_movement = now
            if self._wander():
                self.wait_time_seconds = randint(1, 12) + self.spline.get_total_time_secs()
            else:
                self.wait_time_seconds = randint(1, 4)

        super().update(now, elapsed)

    # override
    def reset(self):
        self.spline = None
        self.wait_time_seconds = randint(1, 12)
        self.last_wandering_movement = time.time()

    def _wander(self):
        success, position = self._get_wandering_point()

        # Unable to resolve a valid wandering point, do nothing and wait for next trigger.
        if not success:
            return False

        speed = config.Unit.Defaults.walk_speed
        spline = SplineBuilder.build_normal_spline(self.unit, points=[position], speed=speed)
        position.face_angle(self.unit.location.o)
        self.spline_callback(spline, movement_behavior=self)

        return True

    def _can_wander(self, now):
        return not self.spline and now > self.last_wandering_movement + self.wait_time_seconds

    def _get_wandering_point(self):
        start_point = self.unit.spawn_position
        random_point = start_point.get_random_point_in_radius(self.wandering_distance, map_id=self.unit.map_id)
        map_ = self.unit.get_map()
        # Check line of sight.
        if not map_.los_check(self.unit.map_id, self.unit.location, random_point.get_ray_vector(is_terrain=True)):
            return False, start_point

        # Validate a path to the wandering point.
        failed, in_place, path = map_.calculate_path(self.unit.map_id, self.unit.location, random_point)
        if failed or len(path) > 1 or in_place or start_point.distance(random_point) < 1:
            return False, start_point

        # Ignore point if 'slope' above 2.5.
        diff = math.fabs(random_point.z - self.unit.location.z)
        if diff > 2.5:
            return False, start_point
        
        # Do not wander into inactive cells.
        if not map_.is_active_cell_for_location(random_point):
            return False, start_point

        return True, random_point
