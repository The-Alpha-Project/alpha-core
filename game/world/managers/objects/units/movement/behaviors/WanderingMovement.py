import math
import time
from random import randint

from game.world.managers.objects.units.movement.helpers.SplineBuilder import SplineBuilder
from utils.ConfigManager import config
from utils.constants.MiscCodes import MoveType
from game.world.managers.objects.units.movement.behaviors.BaseMovement import BaseMovement


class WanderingMovement(BaseMovement):
    def __init__(self, spline_callback, is_default, use_current_position=False, wandering_distance=0.0):
        super().__init__(move_type=MoveType.WANDER, spline_callback=spline_callback, is_default=is_default)
        self.wandering_distance = wandering_distance
        self.use_current_position = use_current_position
        self.wander_home_position = None
        self.last_wandering_movement = 0
        self.wait_time_seconds = 0
        self.movements_remaining = 0

    # override
    def initialize(self, unit):
        self.wandering_distance = unit.wander_distance if not self.wandering_distance else self.wandering_distance
        self.wander_home_position = unit.spawn_position if not self.use_current_position else unit.location
        self.reset()
        return super().initialize(unit)

    # override
    def update(self, now, elapsed):
        if self._can_wander(now):
            self.last_wandering_movement = now

            if self.movements_remaining > 0:
                if self._wander():
                    self.movements_remaining -= 1
                    if self.movements_remaining == 0:
                        # Last movement, wait spline time plus random.
                        self.wait_time_seconds = self.get_total_time_secs() + randint(4, 10)
                    else:
                        self.wait_time_seconds = self.get_total_time_secs()
                else:
                    self.wait_time_seconds = randint(1, 3)
            else:
                self.movements_remaining = randint(0, 2 if self.wandering_distance <= 1.0 else 8)
                if self.movements_remaining > 0:
                    self.last_wandering_movement = 0
                    self.wait_time_seconds = 0
                else:
                    self.wait_time_seconds = randint(4, 10)

        super().update(now, elapsed)

    # override
    def reset(self):
        if self.spline:
            # Make sure the last known position gets updated.
            self.spline.update_to_now()
            self.spline = None
        self.movements_remaining = 0
        self.wait_time_seconds = randint(4, 10)
        self.last_wandering_movement = time.time()

    def _wander(self):
        success, position = self._get_wandering_point()

        # Unable to resolve a valid wandering point, do nothing and wait for next trigger.
        if not success:
            return False

        speed = config.Unit.Defaults.walk_speed
        spline = SplineBuilder.build_normal_spline(self.unit, points=[position], speed=speed)
        self.spline_callback(spline, movement_behavior=self)

        return True

    def _can_wander(self, now):
        return (self.unit.is_active_object() and not self.spline
                and now > self.last_wandering_movement + self.wait_time_seconds)

    def _get_wandering_point(self):
        start_point = self.wander_home_position
        random_point = start_point.get_random_point_in_radius(self.wandering_distance, self.unit.map_id)
        map_ = self.unit.get_map()

        # Ignore point if 'slope' above 2.5.
        if not config.Server.Settings.use_nav_tiles:
            diff = math.fabs(random_point.z - self.unit.location.z)
            if diff > 2.5:
                return False, start_point

        # Client can crash with short movements.
        if self.unit.location.distance(random_point) < 0.1:
            return False, start_point

        # Do not wander into inactive cells.
        if not map_.is_active_cell_for_location(random_point):
            return False, start_point

        # Unable to calculate height.
        z, z_locked = map_.calculate_z(random_point.x, random_point.y, current_z=random_point.z, is_rand_point=True)
        if z_locked:
            return False, start_point

        # Check line of sight for the given point and surrounding points.
        # Sometimes Namigator returns TRUE for points walls edges, which keeps units loop walking towards a wall.
        if config.Server.Settings.use_nav_tiles:
            points = random_point.get_surrounding_points_in_distance()
            for point in points:
                if not map_.los_check(self.unit.get_ray_position(), point.get_ray_vector(is_terrain=True), doodads=True):
                    return False, start_point

        # Validate a path to the wandering point, just be length 1.
        if config.Server.Settings.use_nav_tiles:
            failed, in_place, path = map_.calculate_path(self.unit.location, random_point, los=True)
            if failed or len(path) > 1 or in_place or start_point.distance(random_point) < 1:
                return False, start_point

        return True, random_point
