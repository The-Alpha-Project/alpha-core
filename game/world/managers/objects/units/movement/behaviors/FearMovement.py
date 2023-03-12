import math
import random
import time

from game.world.managers.abstractions.Vector import Vector
from game.world.managers.maps.MapManager import MapManager
from game.world.managers.objects.units.movement.helpers.SplineBuilder import SplineBuilder
from utils.ConfigManager import config
from utils.constants.MiscCodes import MoveType, MoveFlags
from game.world.managers.objects.units.movement.behaviors.BaseMovement import BaseMovement
from utils.constants.UnitCodes import UnitFlags


SEARCH_RANDOM_RADIUS = 5.0
MIN_QUIET_DISTANCE = 28.0
MAX_QUIET_DISTANCE = 43.0 - SEARCH_RANDOM_RADIUS


# TODO: Namigator: FindRandomPointAroundCircle (Detour)
#  We need a valid path for fear else unexpected collisions can mess things up.
class FearMovement(BaseMovement):
    def __init__(self, fear_duration_secs, spline_callback):
        super().__init__(move_type=MoveType.FEAR, spline_callback=spline_callback)
        self.fear_duration = fear_duration_secs
        self.waypoints: list[Vector] = []
        self.can_move = True
        self.expected_fear_end_timestamp = time.time() + fear_duration_secs

    # override
    def update(self, now, elapsed):
        if self._can_trigger_fear():
            self.speed_dirty = False
            self._trigger_fear()

        self.fear_duration = max(0, self.fear_duration - elapsed)

        super().update(now, elapsed)

    def on_spline_finished(self):
        self.can_move = True

    def _trigger_fear(self):
        speed = self.unit.running_speed
        if not self.waypoints:
            fear_point = self._get_fear_point()
            self.waypoints = self._get_path(fear_point)
        self.can_move = False
        waypoint = self._get_waypoint()
        # If this is the end of a path, wait extra 0.5.
        extra_wait = 0.5 if not self.waypoints else 0.0
        spline = SplineBuilder.build_normal_spline(self.unit, points=[waypoint], speed=speed,
                                                   extra_time_seconds=extra_wait)
        self.spline_callback(spline, movement_behavior=self)

    def _can_trigger_fear(self):
        return (self.fear_duration and self.can_move) or self.speed_dirty

    # override
    def can_remove(self):
        return not self.unit.is_alive or not self.fear_duration \
            or not self.unit.unit_flags & UnitFlags.UNIT_FLAG_FLEEING or time.time() >= self.expected_fear_end_timestamp

    # override
    def on_removed(self):
        self.unit.movement_flags = MoveFlags.MOVEFLAG_NONE
        MapManager.send_surrounding(self.unit.get_heartbeat_packet(), self.unit, include_self=False)
        # Remove fleeing flag if not caused by auras (ie. scripted flee).
        self.unit.set_unit_flag(UnitFlags.UNIT_FLAG_FLEEING, False)

    def _get_waypoint(self):
        waypoint = self.waypoints[0]
        self.waypoints.remove(waypoint)
        return waypoint

    def _get_path(self, fear_point):
        if not config.Server.Settings.use_nav_tiles:
            return [fear_point]
        for search_range in range(0, int(SEARCH_RANDOM_RADIUS)):
            destination = fear_point.get_random_point_in_radius(search_range, self.unit.map_id)
            failed, in_place, path = MapManager.calculate_path(self.unit.map_id, self.unit.location, destination)
            if not failed:
                return path
        return [fear_point]

    def _get_fear_point(self):
        attacker = self.unit.combat_target
        if attacker:
            distance_from_caster = self.unit.location.distance(attacker.location)
            if distance_from_caster > 0.2:
                angle_to_caster = self.unit.location.angle(vector=attacker.location)
            else:
                angle_to_caster = random.uniform(0, 2 * math.pi)
        else:
            distance_from_caster = 0.0
            angle_to_caster = random.uniform(0, 2 * math.pi)

        if distance_from_caster < MIN_QUIET_DISTANCE:
            dist = random.uniform(0.4, 1.3) * (MIN_QUIET_DISTANCE - distance_from_caster)
            angle = angle_to_caster + random.uniform(-math.pi / 8, math.pi / 8)
        elif distance_from_caster > MAX_QUIET_DISTANCE:
            dist = random.uniform(0.4, 1.0) * (MAX_QUIET_DISTANCE - MIN_QUIET_DISTANCE)
            angle = -angle_to_caster + random.uniform(-math.pi / 4, math.pi / 4)
        else:
            dist = random.uniform(0.6, 1.2) * (MAX_QUIET_DISTANCE - MIN_QUIET_DISTANCE)
            angle = random.uniform(0, 2 * math.pi)

        x = self.unit.location.x + (dist * math.cos(angle))
        y = self.unit.location.y + (dist * math.sin(angle))
        z = MapManager.calculate_z(self.unit.map_id, x, y, self.unit.location.z)[0]
        return Vector(x, y, z)
