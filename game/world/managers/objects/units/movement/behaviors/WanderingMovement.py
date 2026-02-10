import math
import time
from random import randint

from game.world.managers.objects.units.movement.helpers.SplineBuilder import SplineBuilder
from utils.ConfigManager import config
from utils.constants.MiscCodes import MoveType, ZSource
from game.world.managers.maps.helpers.Constants import ADT_SIZE, RESOLUTION_ZMAP, UNIT_SIZE
from game.world.managers.objects.units.movement.behaviors.BaseMovement import BaseMovement


class WanderingMovement(BaseMovement):
    _MAX_SLOPE_NORMAL_Z = 0.64278764  # Client walkable threshold (cos 50 deg).
    _MAX_SLOPE = math.tan(math.acos(_MAX_SLOPE_NORMAL_Z))
    _RELAXED_SLOPE = _MAX_SLOPE * 1.5  # Allow brief spikes if overall slope is ok.

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
        random_point = start_point.get_random_point_in_radius(
            self.wandering_distance,
            self.unit.map_id,
            min_distance=0.1,
        )
        map_ = self.unit.get_map()

        # No navs but have maps, try to validate the segment between self and random point.
        if not config.Server.Settings.use_nav_tiles and config.Server.Settings.use_map_tiles:
            if not self._is_walkable_segment_map_tiles(self.unit.location, random_point):
                return False, start_point

        # Do not wander into inactive cells.
        if not map_.is_active_cell_for_location(random_point):
            return False, start_point

        # Unable to calculate height.
        z, z_source = map_.calculate_z(random_point.x, random_point.y, current_z=random_point.z, is_rand_point=True)
        if z_source == ZSource.CURRENT_Z:
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

    def _is_walkable_segment_map_tiles(self, start_point, end_point):
        if start_point is None or end_point is None:
            return False

        dx = end_point.x - start_point.x
        dy = end_point.y - start_point.y
        dist = math.hypot(dx, dy)
        if dist <= 0.1:
            return True
        dir_x = dx / dist
        dir_y = dy / dist

        map_ = self.unit.get_map()
        base_source = start_point.z_source
        if base_source == ZSource.CURRENT_Z:
            # Ensure we have a real map-backed Z source to validate against.
            _, base_source = map_.calculate_z(start_point.x, start_point.y, current_z=start_point.z, is_rand_point=True)
            if base_source == ZSource.CURRENT_Z:
                return False

        # Sample along the straight line to detect cliffs or invalid heights.
        cell_step = ADT_SIZE / (RESOLUTION_ZMAP - 1)
        step_size = max(2.0, cell_step)
        # Limit samples for performance but keep enough to catch abrupt Z changes.
        samples = max(2, min(16, int(dist / step_size)))
        step_dist = dist / samples
        overall_slope = abs(end_point.z - start_point.z) / dist

        prev_z = start_point.z
        steep_spikes = 0
        for i in range(1, samples + 1):
            current_dist = step_dist * i
            sx = start_point.x + dir_x * current_dist
            sy = start_point.y + dir_y * current_dist
            z, z_source = map_.calculate_z(sx, sy, current_z=prev_z, is_rand_point=True)
            # Reject if the map can't resolve a height or flips source mid-segment.
            if z_source == ZSource.CURRENT_Z:
                return False
            if z_source != base_source:
                return False

            # Reject steep steps while allowing a couple of brief spikes if the overall slope is ok.
            dz = abs(z - prev_z)
            slope = dz / step_dist
            if slope > self._MAX_SLOPE:
                if slope <= self._RELAXED_SLOPE and overall_slope <= self._MAX_SLOPE and steep_spikes < 2:
                    steep_spikes += 1
                else:
                    return False
            prev_z = z

        # Probe a bit beyond the target to catch nearby walls or sharp transitions.
        extra_dist = UNIT_SIZE * 5.0
        extra_x = start_point.x + dir_x * (dist + extra_dist)
        extra_y = start_point.y + dir_y * (dist + extra_dist)
        _, extra_source = map_.calculate_z(extra_x, extra_y, current_z=prev_z, is_rand_point=True)
        if extra_source == ZSource.CURRENT_Z:
            return False
        if extra_source != base_source:
            return False

        return True
