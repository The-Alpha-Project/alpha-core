import math
import random
import time

from game.world.managers.abstractions.Vector import Vector
from game.world.managers.objects.units.movement.helpers.SplineBuilder import SplineBuilder
from utils.ConfigManager import config
from utils.constants.MiscCodes import MoveType, MoveFlags
from game.world.managers.objects.units.movement.behaviors.BaseMovement import BaseMovement
from utils.constants.UnitCodes import UnitFlags


SEARCH_RANDOM_RADIUS = 5.0
MIN_QUIET_DISTANCE = 28.0
MAX_QUIET_DISTANCE = 43.0 - SEARCH_RANDOM_RADIUS
FLEE_ASSISTANCE_RADIUS = 30.0


# TODO: Namigator: FindRandomPointAroundCircle (Detour)
#  We need a valid path for fear else unexpected collisions can mess things up.
class FearMovement(BaseMovement):
    def __init__(self, fear_duration_secs, spline_callback, seek_assist=False):
        super().__init__(move_type=MoveType.FEAR, spline_callback=spline_callback)
        self.fear_duration = fear_duration_secs
        self.seek_assist = seek_assist
        self.assist_unit = None
        self.waypoints: list[Vector] = []
        self.can_move = True
        self.expected_fear_end_timestamp = time.time() + fear_duration_secs

    def initialize(self, unit):
        super().initialize(unit)
        unit.set_unit_flag(UnitFlags.UNIT_FLAG_FLEEING, True)
        if not self.seek_assist or not unit.combat_target:
            return True
        # Should search assistance, search for a friendly unit.
        units = unit.get_map().get_surrounding_units_by_location(unit.location, unit.map_id, unit.instance_id,
                                                                 FLEE_ASSISTANCE_RADIUS)[0].values()
        for unit in units:
            if not unit.threat_manager.unit_can_assist_help_call(unit, unit.combat_target):
                continue
            self.assist_unit = unit
            break
        return True

    # override
    def update(self, now, elapsed):
        if self._can_trigger_fear():
            self.speed_dirty = False
            self._trigger_fear()

        self.fear_duration = max(0, self.fear_duration - elapsed)

        super().update(now, elapsed)

    def on_new_position(self, new_position, waypoint_completed, remaining_waypoints):
        super().on_new_position(new_position, waypoint_completed, remaining_waypoints)
        # Was seeking for assist and found it, end timer.
        if self.assist_unit and self.assist_unit.combat_target.guid == self.unit.combat_target.guid:
            self.fear_duration = 0

    def on_spline_finished(self):
        self.can_move = self.fear_duration > 0

    def _trigger_fear(self):
        # Attack stop if needed, else unit will keep trying to turn towards target.
        if self.unit.combat_target:
            self.unit.send_attack_stop(self.unit.combat_target.guid)
        speed = self.unit.running_speed
        if not self.waypoints:
            self.waypoints = self._get_path(self._get_fear_point())
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
        self.unit.get_map().send_surrounding(self.unit.get_heartbeat_packet(), self.unit, include_self=False)
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
            failed, in_place, path = self.unit.get_map().calculate_path(self.unit.map_id, self.unit.location, destination)
            if not failed:
                return path
        return [fear_point]

    def _get_fear_point(self):
        # Looking for assist.
        if self.assist_unit:
            return self.assist_unit.location

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
        z = self.unit.get_map().calculate_z(self.unit.map_id, x, y, self.unit.location.z)[0]
        return Vector(x, y, z)
