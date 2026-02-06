from game.world.managers.maps.helpers import CellUtils
from utils.ConfigManager import config
from utils.constants.MiscCodes import MoveType, ScriptTypes, MoveFlags

from game.world.managers.objects.units.movement.helpers.SplineBuilder import SplineBuilder
from game.world.managers.objects.units.movement.behaviors.BaseMovement import BaseMovement


class GroupMovement(BaseMovement):
    def __init__(self, spline_callback, is_default):
        super().__init__(move_type=MoveType.GROUP, spline_callback=spline_callback, is_default=is_default)
        self.creature_movement = None
        self.last_waypoint_movement = 0
        self.wait_time_seconds = 0
        self._is_lagging = False
        self._lagging_speed_mod = 0
        self._in_formation = False

    # override
    def initialize(self, unit):
        super().initialize(unit)
        return True

    # override
    def update(self, now, elapsed):
        # We require a leader, always.
        if not self.unit.creature_group or not self.unit.creature_group.leader:
            return

        if self._can_perform_waypoint(now):
            # Only the leader leads the way.
            self._perform_waypoint()
            self._set_last_movement(now)
            self.speed_dirty = False
        elif self._can_perform_follow_movement(now) and self._perform_follow_movement(elapsed, now):
            self._set_last_movement(now)

        super().update(now, elapsed)

    def _set_last_movement(self, now):
        self.last_waypoint_movement = now
        self.wait_time_seconds = self.get_total_time_secs()

    # override
    def on_new_position(self, new_position, waypoint_completed, remaining_waypoints):
        super().on_new_position(new_position, waypoint_completed, remaining_waypoints)
        # Always update tmp home position.
        self.unit.tmp_home_position = new_position.copy()
        if not waypoint_completed:
            return
        self.handle_waypoint_complete()

    def handle_waypoint_complete(self):
        # Leader.
        if self.unit.creature_group and self.unit.creature_group.is_leader(self.unit):
            current_wp = self._get_waypoint()
            self._waypoint_push_back()
            if current_wp.script_id:
                self.unit.get_map().enqueue_script(source=self.unit, target=self.unit,
                                                   script_type=ScriptTypes.SCRIPT_TYPE_CREATURE_MOVEMENT,
                                                   script_id=current_wp.script_id)
        # Follower.
        else:
            leader = self.unit.creature_group.leader
            # Face in the same angle as the leader if needed.
            if not self.unit.location.has_in_arc(leader.location):
                self.unit.movement_manager.face_angle(leader.location.o)

    # override
    def reset(self):
        if self.spline:
            # Make sure the last known position gets updated.
            self.spline.update_to_now()
            self.spline = None
        self.wait_time_seconds = 0
        self.last_waypoint_movement = 0
        self._in_formation = False

    def can_remove(self):
        return not self.unit.creature_group or not self.unit.is_alive

    def _can_perform_waypoint(self, now):
        if self.speed_dirty and self.unit.creature_group.waypoints and self.unit.creature_group.is_leader(self.unit):
            return True
        return self.unit.creature_group.waypoints and not self.spline and self.unit.creature_group.is_leader(self.unit)\
            and now > self.last_waypoint_movement + self.wait_time_seconds

    def _can_perform_follow_movement(self, now):
        return self._is_lagging or not self.spline and not self.unit.creature_group.is_leader(self.unit) and \
            self.unit.creature_group.leader and now > self.last_waypoint_movement + self.wait_time_seconds

    def _perform_waypoint(self):
        creature_group = self.unit.creature_group
        waypoint = self._get_waypoint()
        speed = self._get_speed(creature_group)
        spline = SplineBuilder.build_normal_spline(self.unit, points=[waypoint.location], speed=speed,
                                                   extra_time_seconds=waypoint.wait_time_seconds)
        self.spline_callback(spline, movement_behavior=self)

    def _perform_follow_movement(self, elapsed, now):
        location, speed = self._get_follow_position_and_speed(self.unit, elapsed, now)
        if not location:
            return False
        spline = SplineBuilder.build_normal_spline(self.unit, points=[location], speed=speed)
        self.spline_callback(spline, movement_behavior=self)
        return True

    def _get_speed(self, creature_group):
        leader_speed = creature_group.leader.movement_manager.get_speed()
        if leader_speed:
            return leader_speed
        force_running = not creature_group.leader.movement_flags & MoveFlags.MOVEFLAG_WALK
        # If the leader is running, use running for group members.
        if force_running:
            return self.unit.running_speed
        return config.Unit.Defaults.walk_speed if \
            self.unit.movement_flags & MoveFlags.MOVEFLAG_WALK else self.unit.running_speed

    def _get_follow_position_and_speed(self, creature_mgr, elapsed, now):
        creature_group = self.unit.creature_group
        if creature_mgr.guid not in creature_group.members or not creature_group.leader:
            return None, 0
        group_member = creature_group.members[creature_mgr.guid]
        base_speed = self._get_speed(creature_group)
        full_distance = group_member.distance_leader

        # Maintain the configured formation distance from the leader.
        target_distance = max(0.2, full_distance)
        leader_creature = creature_group.leader
        leader_location = leader_creature.location
        leader_spline = leader_creature.movement_spline
        # If the leader is moving, look ahead slightly along the spline so followers expect
        # where the leader will be on the next tick. Use leader.last_tick to tighten the window
        # when the leader is already updated in the current frame.
        if leader_spline and leader_creature.is_moving():
            waypoint = leader_spline.get_waypoint_location()
            if waypoint and waypoint != leader_location:
                leader_tick_delta = now - leader_creature.last_tick if leader_creature.last_tick else elapsed
                lookahead_time = min(elapsed, leader_tick_delta, 0.2)
                lead_distance = min(leader_location.distance(waypoint), base_speed * lookahead_time)
                leader_location = leader_location.get_point_in_between(leader_creature, lead_distance,
                                                                       waypoint, map_id=leader_creature.map_id)

        # Compute the desired formation point relative to the leader (or predicted leader position).
        location = creature_group.compute_relative_position_from(group_member, leader_creature,
                                                                 leader_location, target_distance)
        if not location:
            return None, 0

        # Distance from the follower to its desired formation position.
        creature_distance = group_member.creature.location.distance(location)

        # If the follower gets far behind, snap it back to avoid long catch-up walks.
        if creature_distance > CellUtils.FOLLOW_LAG_CORRECTION_DISTANCE:
            self.unit.near_teleport(location)
            self._in_formation = False
            return None, 0

        # Deadband to avoid stop/resume jitter near the target position. When inside the band,
        # keep the follower still unless it drifts far enough out.
        enter_threshold = 0.35
        exit_threshold = 0.6
        if self._in_formation:
            if creature_distance <= exit_threshold:
                self._is_lagging = False
                self._lagging_speed_mod = 0
                return None, 0
            self._in_formation = False
        elif creature_distance <= enter_threshold:
            self._in_formation = True
            self._is_lagging = False
            self._lagging_speed_mod = 0
            return None, 0

        # Check if the unit is lagging significantly behind its formation spot.
        self._is_lagging = creature_distance > group_member.distance_leader * 2

        # Adjust speed if lagging.
        if self._is_lagging:
            self._lagging_speed_mod = 0.05 * creature_distance * creature_distance * elapsed
        else:
            self._lagging_speed_mod = 0

        # Smoothing factor (adjust for desired smoothness; lower is smoother)
        smooth_factor = min(1, elapsed / 0.1)
        # Interpolate between current position and target position.
        new_location = self.unit.location.lerp(location, smooth_factor)

        return new_location, base_speed + self._lagging_speed_mod

    def _get_waypoint(self):
        # Updating ongoing wp.
        if self.speed_dirty:
            self._waypoint_push_front()

        return self.unit.creature_group.waypoints[0]

    def _waypoint_push_back(self):
        waypoint = self.unit.creature_group.waypoints[0]
        self.unit.creature_group.waypoints.remove(waypoint)
        self.unit.creature_group.waypoints.append(waypoint)

    def _waypoint_push_front(self):
        waypoint = self.unit.creature_group.waypoints[-1]
        self.unit.creature_group.waypoints.remove(waypoint)
        self.unit.creature_group.waypoints.insert(0, waypoint)
