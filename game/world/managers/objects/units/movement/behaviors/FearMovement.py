import math
import random
import time

from game.world.managers.abstractions.Vector import Vector
from game.world.managers.objects.units.movement.helpers.SplineBuilder import SplineBuilder
from utils.ConfigManager import config
from utils.Logger import Logger
from utils.constants.MiscCodes import MoveType
from game.world.managers.objects.units.movement.behaviors.BaseMovement import BaseMovement
from utils.constants.UnitCodes import UnitFlags


SEARCH_RANDOM_RADIUS = 5.0
MIN_QUIET_DISTANCE = 28.0
MAX_QUIET_DISTANCE = 43.0 - SEARCH_RANDOM_RADIUS
FLEE_ASSISTANCE_RADIUS = 30.0


class FearMovement(BaseMovement):
    def __init__(self, fear_duration_secs, spline_callback, target=None, seek_assist=False):
        super().__init__(move_type=MoveType.FEAR, spline_callback=spline_callback)
        self.fear_duration = fear_duration_secs
        self.seek_assist = seek_assist
        self.assist_unit = None
        self.target = target
        self.waypoints: list[Vector] = []
        self.can_move = True
        self.expected_fear_end_timestamp = time.time() + fear_duration_secs

    def initialize(self, unit):
        super().initialize(unit)
        unit.set_unit_flag(UnitFlags.UNIT_FLAG_FLEEING, True)
        return True

    # override
    def update(self, now, elapsed):
        # Avoid units trying to turn and face the target as they run.
        if self.unit.current_target:
            self.unit.set_current_target(0)

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
        if self.unit.combat_target:
            target_guid = self.unit.combat_target.guid
            self.unit.combat_target = None
            self.unit.send_attack_stop(target_guid)
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
        self.unit.set_unit_flag(UnitFlags.UNIT_FLAG_FLEEING, False)

        if self.unit.is_alive and self.unit.in_combat and not self.unit.combat_target:
            target = self.unit.threat_manager.get_hostile_target()
            if target and target.is_alive:
                self.unit.attack(target)

    def _get_waypoint(self):
        waypoint = self.waypoints[0]
        self.waypoints.remove(waypoint)
        return waypoint

    def _get_path(self, fear_point):
        if not config.Server.Settings.use_nav_tiles:
            return [fear_point]

        _map = self.unit.get_map()

        # See if we can reach the first calculated random fear point.
        failed, path = _map.can_reach_location(src_vector=self.unit.location, dst_vector=fear_point,
                                               smooth=True, clamp_endpoint=True)
        if not failed:
            return path

        # Above failed, search for random points using fear point as source.
        for search_range in range(0, int(SEARCH_RANDOM_RADIUS)):
            destination = fear_point.get_random_point_in_radius(search_range, self.unit.map_id)

            # Avoid slopes above 2.5 (Units running off cliffs).
            diff = math.fabs(destination.z - self.unit.location.z)
            if diff > 2.5:
                continue

            failed, path = _map.can_reach_location(src_vector=self.unit.location, dst_vector=fear_point,
                                                   smooth=True, clamp_endpoint=True)
            if not failed:
                return path

        # Everything failed, search for a random point using namigator.
        random_point = _map.find_random_point_around_circle(self.unit.location, radius=10.0)
        failed, path = _map.can_reach_location(src_vector=self.unit.location, dst_vector=random_point,
                                               smooth=True, clamp_endpoint=True)
        if not failed:
            return path

        Logger.warning('Unable to calculate valid fear point vector.')
        return [fear_point]

    def _get_fear_point(self):
        self.assist_unit = self._seek_assistance_unit()
        if self.assist_unit:
            return self.assist_unit.location

        attacker = self.target if self.target else self.unit.combat_target
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
        z = self.unit.get_map().calculate_z(x, y, self.unit.location.z, is_rand_point=True)[0]
        return Vector(x, y, z)

    def _seek_assistance_unit(self):
        if self.assist_unit:
            return self.assist_unit

        # Until 0.5.4, creatures didn't call for help when fleeing, make it configurable.
        if not config.World.Gameplay.enable_call_for_help:
            return None

        if not self.seek_assist or not self.unit.combat_target:
            return None

        # Should search assistance, search for a friendly unit.
        units = self.unit.get_map().get_surrounding_units_by_location(self.unit.location, self.unit.map_id,
                                                                      self.unit.instance_id,
                                                                      FLEE_ASSISTANCE_RADIUS)[0].values()
        for unit in units:
            if not unit.threat_manager.unit_can_assist_help_call(self.unit, self.unit.combat_target):
                continue
            return unit

        return None
