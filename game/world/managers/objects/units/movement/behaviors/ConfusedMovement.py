import math
import time

from game.world.managers.objects.units.movement.behaviors.BaseMovement import BaseMovement
from game.world.managers.objects.units.movement.helpers.SplineBuilder import SplineBuilder
from utils.ConfigManager import config
from utils.constants.MiscCodes import MoveType
from utils.constants.UnitCodes import UnitStates, UnitFlags


# TODO: When applying mod_fear on a confused target, confused aura does not get removed, so once fear ends,
#  the mob stands still until confused aura expires.
class ConfusedMovement(BaseMovement):
    def __init__(self, spline_callback, is_default=False, duration_seconds=0.0):
        super().__init__(move_type=MoveType.CONFUSED, spline_callback=spline_callback, is_default=is_default)
        self.home_position = None
        self.duration_seconds = duration_seconds
        self.last_confused_movement = 0
        self.confused_distance = 4.0
        self.wait_time_seconds = 1.0
        self.until_canceled = duration_seconds < 0
        self.expected_confused_end_timestamp = time.time() + duration_seconds

    # override
    def initialize(self, unit):
        unit.set_unit_flag(UnitFlags.UNIT_FLAG_CONFUSED, True)
        unit.movement_manager.stop()
        unit.combat_target = None
        self.home_position = unit.location
        self.last_confused_movement = time.time()
        return super().initialize(unit)

    # override
    def update(self, now, elapsed):
        if self._can_move_confused(now):
            self.last_confused_movement = now
            if self._move():
                self.wait_time_seconds = self.get_total_time_secs() + 1.0

        if not self.until_canceled:
            self.duration_seconds = max(0, self.duration_seconds - elapsed)
        super().update(now, elapsed)

    def _move(self):
        # Attack stop if needed, else unit will keep trying to turn towards target.
        if self.unit.combat_target:
            target_guid = self.unit.combat_target.guid
            self.unit.combat_target = None
            self.unit.send_attack_stop(target_guid)

        success, position = self._get_confused_move_point()

        # Unable to resolve a valid random point, do nothing and wait for next trigger.
        if not success:
            return False

        speed = config.Unit.Defaults.walk_speed
        spline = SplineBuilder.build_normal_spline(self.unit, points=[position], speed=speed)
        position.face_angle(self.unit.location.o)
        self.spline_callback(spline, movement_behavior=self)

        return True

    def _can_move_confused(self, now):
        return not self.spline and self.duration_seconds and now > self.last_confused_movement + self.wait_time_seconds

    # override
    def can_remove(self):
        return (not self.unit.is_alive or not self.duration_seconds or not self.unit.unit_state & UnitStates.CONFUSED
                or self.unit.unit_flags & UnitFlags.UNIT_FLAG_FLEEING or
                (not self.until_canceled and time.time() >= self.expected_confused_end_timestamp))

    # override
    def on_removed(self):
        self.unit.remove_all_movement_flags()
        self.unit.set_unit_flag(UnitFlags.UNIT_FLAG_CONFUSED, False)

    def _get_confused_move_point(self):
        start_point = self.home_position
        random_point = start_point.get_random_point_in_radius(self.confused_distance, self.unit.map_id)
        map_ = self.unit.get_map()
        # Check line of sight.
        if not map_.los_check(self.unit.get_ray_position(), random_point.get_ray_vector(is_terrain=True)):
            return False, start_point

        # Validate a path to the random point.
        failed, in_place, path = map_.calculate_path(self.unit.location, random_point, los=True)
        if failed or len(path) > 1 or in_place or start_point.distance(random_point) < 1:
            return False, start_point

        # Ignore point if 'slope' above 2.5.
        diff = math.fabs(random_point.z - self.unit.location.z)
        if diff > 2.5:
            return False, start_point

        # Do not move into inactive cells.
        if not map_.is_active_cell_for_location(random_point):
            return False, start_point

        return True, random_point
