import math

from game.world.managers.objects.units.movement.helpers.SplineBuilder import SplineBuilder
from utils.Formulas import UnitFormulas, Distances
from utils.constants.MiscCodes import MoveType
from game.world.managers.objects.units.movement.behaviors.BaseMovement import BaseMovement
from utils.constants.UnitCodes import SplineFlags
from utils.constants.CustomCodes import RelativeChaseState


# TODO: There are some creatures like crabs or murlocs that apparently couldn't swim in earlier versions
#  but are spawned inside the water at this moment since most spawns come from Vanilla data. These mobs
#  will currently bug out when you try to engage in combat with them. Also seems like a lot of humanoids
#  couldn't swim before patch 1.3.0:
#  World of Warcraft Client Patch 1.3.0 (2005-03-22)
#   - Most humanoids NPCs have gained the ability to swim.
#  This might only refer to creatures not having swimming animations.
class ChaseMovement(BaseMovement):
    def __init__(self, spline_callback):
        super().__init__(move_type=MoveType.CHASE, spline_callback=spline_callback)
        self.unit = None
        self.combat_target = None
        self.waypoints = []
        self._last_path_endpoint = None
        self._last_path_target_location = None
        self._force_repath = False
        self._last_target_guid = 0
        self._last_target_distance = None
        self._relative_speed = 0.0
        self._relative_state = RelativeChaseState.NEUTRAL

    # override
    def update(self, now, elapsed):
        super().update(now, elapsed)
        self.combat_target = self.unit.combat_target

        can_process = self.combat_target and self.combat_target.is_alive
        if not can_process:
            self._last_target_distance = None
            self._relative_speed = 0.0
            self._relative_state = RelativeChaseState.NEUTRAL
            self._last_target_guid = 0
            return

        if self.combat_target.guid != self._last_target_guid:
            self._last_target_guid = self.combat_target.guid
            self._last_target_distance = None
            self._relative_speed = 0.0
            self._relative_state = RelativeChaseState.NEUTRAL
            self._last_path_target_location = None
            self._force_repath = False

        current_distance = self.unit.location.distance(self.combat_target.location)
        if elapsed > 0:
            if self._last_target_distance is not None:
                self._relative_speed = (current_distance - self._last_target_distance) / elapsed
            self._last_target_distance = current_distance
            self._relative_state = self._resolve_relative_state(self._relative_speed)

        if self._is_within_combat_distance():
            if self.spline:
                self.stop()
            # Face the target if necessary.
            if not self.unit.location.has_in_arc(self.combat_target.location, arc=math.pi / 2):
                self.unit.movement_manager.face_target(self.combat_target)
        else:
            # Avoid units trying to turn and face the target as they run.
            if self.unit.current_target:
                self.unit.set_current_target(0)

            if self._should_regenerate_path():
                self.waypoints = self._regenerate_path()
                if self.waypoints:
                    self._last_path_endpoint = self.waypoints[-1]
                    # Track target location used for this path to refresh if the target moves significantly.
                    self._last_path_target_location = self.combat_target.location.copy()
                    # Override active spline so we can react to target direction changes immediately.
                    self._force_repath = True
                else:
                    self._force_repath = False

            if self._can_chase():
                self.speed_dirty = False
                self._perform_waypoint()

    def _perform_waypoint(self):
        spline = self._build_chase_spline()
        if not spline:
            return
        self.spline_callback(spline, movement_behavior=self)
        self._force_repath = False

    def _build_chase_spline(self):
        if not self.waypoints:
            return None
        speed, spline_flags = self._get_chase_spline_params()
        full_path = self.waypoints.copy()
        if len(full_path) > 1:
            packed_spline = self._build_packed_spline(full_path, speed, spline_flags)
            if packed_spline:
                self._last_path_endpoint = full_path[-1]
                self.waypoints.clear()
                return packed_spline
        return self._build_single_point_spline(speed, spline_flags)

    def _get_chase_spline_params(self):
        swimming = self.unit.is_swimming()
        speed = self.unit.running_speed if not swimming else self.unit.swim_speed
        spline_flags = SplineFlags.SPLINEFLAG_RUNMODE if not swimming else SplineFlags.SPLINEFLAG_NONE
        return speed, spline_flags

    def _build_packed_spline(self, points, speed, spline_flags):
        # Client packed-delta format caps x/y to +/-255.875 and z to +/-15.875 from the endpoint.
        # Only non-flying splines can use packed deltas.
        spline = SplineBuilder.build_normal_spline(
            self.unit,
            points=points,
            speed=speed,
            spline_flags=spline_flags,
            use_packed_deltas=True,
        )
        return spline if spline.can_pack_deltas() else None

    def _build_single_point_spline(self, speed, spline_flags):
        waypoint = self._get_waypoint()
        if not waypoint:
            return None
        self._last_path_endpoint = waypoint
        return SplineBuilder.build_normal_spline(
            self.unit,
            points=[waypoint],
            speed=speed,
            spline_flags=spline_flags,
        )

    # Build a fresh chase path with evade/swim checks and optional nav pathing.
    def _regenerate_path(self):
        if not self.combat_target:
            return None

        # Check if target is player and is online.
        target_is_player = self.combat_target.is_player()
        if target_is_player and not self.combat_target.online:
            self.unit.threat_manager.remove_unit_threat(self.combat_target)
            return None

        home_position = self.unit.get_home_position()  # Either spawn_position or tmp_home_position.
        home_distance = self.unit.location.distance(home_position)
        target_distance = self.unit.location.distance(self.combat_target.location)
        target_to_home_distance = self.combat_target.location.distance(home_position)
        evade_distance = Distances.CREATURE_EVADE_DISTANCE
        self_swimming = self.unit.is_swimming()
        target_swimming = self.combat_target.is_swimming()

        if not self.unit.is_pet():
            # In 0.5.3, evade mechanic was only based on distance, the correct distance remains unknown.
            # From 0.5.4 patch notes:
            #     "Creature pursuit is now timer based rather than distance based."
            if (home_distance > evade_distance or target_distance > evade_distance) \
                    and target_to_home_distance > evade_distance:
                self.unit.threat_manager.remove_unit_threat(self.combat_target)
                return None

            if (self_swimming or target_swimming) and not self.unit.can_swim():
                self.unit.threat_manager.remove_unit_threat(self.combat_target)
                return None
            elif self_swimming and not target_swimming and not self.unit.can_exit_water():
                self.unit.threat_manager.remove_unit_threat(self.combat_target)
                return None

        # Target is within combat distance.
        if self._is_within_combat_distance():
            return None

        target_location = self.combat_target.location.copy()
        if not self.unit.is_player() and not self.combat_target.is_player():
            distance = self.unit.location.distance(target_location) - self._get_combat_stop_distance()
            distance = max(distance, 0.0)
            target_location = self.unit.location.get_point_in_between(self.unit,
                                                                      distance,
                                                                      target_location,
                                                                      map_id=self.unit.map_id)

        final_path = [target_location]
        # Use direct combat location if target is over water.
        if not target_swimming:
            failed, in_place, path = self.unit.get_map().calculate_path(self.unit.location, final_path[0],
                                                                        smooth=True, clamp_endpoint=True)
            if not failed and not in_place:
                final_path = path
            elif in_place:
                return None

        return final_path

    def _is_within_combat_distance(self, source_vector=None):
        if not self.combat_target:
            return False

        combat_distance = self._get_combat_stop_distance()

        # From a given point.
        if source_vector:
            return source_vector.distance(self.combat_target.location) < combat_distance

        #  From self-unit to combat target.
        return self.unit.location.distance(self.combat_target.location) < combat_distance

    def _get_combat_stop_distance(self):
        base_distance = UnitFormulas.combat_distance(self.unit, self.combat_target)
        # Add a small buffer to reduce overlaps during chase.
        base_distance += 0.3
        moving_away = self._relative_state == RelativeChaseState.AWAY
        moving_towards = self._relative_state == RelativeChaseState.CLASH
        # If both are moving fast, add a bit more space to avoid overshooting.
        if not moving_away:
            self_speed = self.unit.movement_manager.get_speed()
            target_speed = self.combat_target.movement_manager.get_speed() if self.combat_target.is_unit() else 0
            base_distance += min(1.0, (self_speed + target_speed) * 0.05)
        # Both units running towards each other, use a bit more distance to avoid overlap.
        if moving_towards and self.combat_target.is_moving() and self.combat_target.is_unit():
            base_distance = base_distance * 1.3
        return base_distance

    # Track whether the target is moving away, towards, or neutral to adjust stop distance.
    def _resolve_relative_state(self, relative_speed):
        dir_state = self._resolve_directional_state()
        if dir_state:
            return dir_state

        # Hysteresis to avoid rapid state flipping on small oscillations.
        if self._relative_state == RelativeChaseState.AWAY:
            return RelativeChaseState.AWAY if relative_speed > 0.05 else RelativeChaseState.NEUTRAL
        if self._relative_state == RelativeChaseState.CLASH:
            return RelativeChaseState.CLASH if relative_speed < -0.05 else RelativeChaseState.NEUTRAL

        if relative_speed > 0.2:
            return RelativeChaseState.AWAY
        if relative_speed < -0.2:
            return RelativeChaseState.CLASH
        return RelativeChaseState.NEUTRAL

    # Resolve a directional state based on the target move direction relative to the chaser.
    def _resolve_directional_state(self):
        if not self.combat_target or not self.combat_target.is_moving():
            return None

        dir_vector = self._get_target_move_dir()
        if not dir_vector:
            return None

        to_chaser_x = self.unit.location.x - self.combat_target.location.x
        to_chaser_y = self.unit.location.y - self.combat_target.location.y
        to_chaser_len = math.hypot(to_chaser_x, to_chaser_y)
        if to_chaser_len == 0:
            return None

        to_chaser_x /= to_chaser_len
        to_chaser_y /= to_chaser_len

        dot = (dir_vector[0] * to_chaser_x) + (dir_vector[1] * to_chaser_y)
        if dot > 0.3:
            return RelativeChaseState.CLASH
        if dot < -0.3:
            return RelativeChaseState.AWAY
        return RelativeChaseState.NEUTRAL

    # Use target spline waypoint direction when available; fall back to facing orientation.
    def _get_target_move_dir(self):
        waypoint = self.combat_target.movement_manager.get_waypoint_location()
        if waypoint and waypoint != self.combat_target.location:
            dx = waypoint.x - self.combat_target.location.x
            dy = waypoint.y - self.combat_target.location.y
            length = math.hypot(dx, dy)
            if length > 0:
                return dx / length, dy / length

        # Fallback to orientation if moving but no spline waypoint.
        orientation = self.combat_target.location.o
        return math.sin(orientation), math.cos(orientation)

    # Decide if we should rebuild the chase path to avoid overshooting stale endpoints.
    def _should_regenerate_path(self):
        if not self.combat_target:
            return False
        # Already in close combat.
        if self._is_within_combat_distance():
            return False
        if self.unit.object_ai and not self.unit.object_ai.is_combat_movement_enabled():
            return False
        if self.speed_dirty:
            return True
        if not self.waypoints and not self.spline:
            return True
        # The last known endpoint is beyond combat distance, regenerate.
        last_endpoint = self.waypoints[-1] if self.waypoints else self._last_path_endpoint
        if not last_endpoint:
            return False
        if self._last_path_target_location:
            target_moved = self._last_path_target_location.distance(self.combat_target.location)
            if target_moved > self._get_path_refresh_distance():
                return True
            if self._has_target_direction_shifted():
                return True
            if self._has_target_heading_shifted_from_endpoint():
                return True
        return not self._is_within_combat_distance(source_vector=last_endpoint)

    # Minimum distance the target must drift before we force a repath.
    def _get_path_refresh_distance(self):
        # Refresh path sooner when the target drifts away from the original endpoint.
        return max(0.5, self._get_combat_stop_distance() * 0.35)

    # Detect a significant target direction swing relative to the original chase endpoint.
    def _has_target_direction_shifted(self):
        # If the target swings direction relative to the original endpoint, refresh the path early.
        to_last = self._last_path_target_location
        to_now = self.combat_target.location
        dir_x = to_now.x - to_last.x
        dir_y = to_now.y - to_last.y
        dir_len = math.hypot(dir_x, dir_y)
        if dir_len <= 0.001:
            return False
        dir_x /= dir_len
        dir_y /= dir_len

        to_chaser_x = self.unit.location.x - to_last.x
        to_chaser_y = self.unit.location.y - to_last.y
        to_chaser_len = math.hypot(to_chaser_x, to_chaser_y)
        if to_chaser_len <= 0.001:
            return False
        to_chaser_x /= to_chaser_len
        to_chaser_y /= to_chaser_len

        dot = (dir_x * to_chaser_x) + (dir_y * to_chaser_y)
        # Cosine threshold: ~18 degrees.
        return dot < 0.95

    # If the target is moving away from the last endpoint, refresh the path immediately.
    def _has_target_heading_shifted_from_endpoint(self):
        if not self._last_path_target_location or not self.combat_target.is_moving():
            return False
        dir_vector = self._get_target_move_dir()
        if not dir_vector:
            return False
        to_endpoint_x = self._last_path_target_location.x - self.combat_target.location.x
        to_endpoint_y = self._last_path_target_location.y - self.combat_target.location.y
        to_endpoint_len = math.hypot(to_endpoint_x, to_endpoint_y)
        if to_endpoint_len <= 0.001:
            return False
        to_endpoint_x /= to_endpoint_len
        to_endpoint_y /= to_endpoint_len
        dot = (dir_vector[0] * to_endpoint_x) + (dir_vector[1] * to_endpoint_y)
        return dot < self._get_target_heading_refresh_dot()

    # Dot threshold for heading change detection (higher = more sensitive).
    def _get_target_heading_refresh_dot(self):
        # Tight dot threshold to react quickly when the target veers away from the last endpoint.
        return 0.98

    # Gate chase spline generation; may override active spline when we need to repath quickly.
    def _can_chase(self):
        if not self.waypoints:
            return False
        if not self.combat_target:
            return False
        if not self.combat_target.is_alive:
            return False
        if self.unit.object_ai and not self.unit.object_ai.is_combat_movement_enabled():
            return False
        if self._force_repath:
            return True
        if self.speed_dirty:
            return True
        if self.spline:
            return False
        return True

    def on_new_position(self, new_position, waypoint_completed, remaining_waypoints):
        super().on_new_position(new_position, waypoint_completed, remaining_waypoints)

        if not self.combat_target:
            return

        if not self._is_within_combat_distance():
            return

        # Already within combat distance, stop.
        self.stop()

    def stop(self):
        if self.waypoints:
            self.waypoints.clear()
        self.unit.movement_manager.stop()
        self._last_path_endpoint = None
        # Restore current target.
        if self.combat_target and not self.unit.current_target:
            self.unit.set_current_target(self.combat_target.guid)

    def on_movement_paused(self):
        if self.waypoints:
            self.waypoints.clear()
        self.speed_dirty = True
        self._last_path_endpoint = None

    # override
    def on_removed(self):
        self.waypoints = None

    # override
    def can_remove(self):
        return (not self.unit.combat_target and not self.unit.in_combat and not self.unit.threat_manager.has_aggro()) \
            or self.unit.is_evading or not self.unit.is_alive

    # override
    def reset(self):
        if not self.spline:
            return
        # Make sure the last known position gets updated.
        self.spline.update_to_now()
        self.spline = None

    def _get_waypoint(self):
        if not self.waypoints:
            return None
        wp = self.waypoints.pop(0)
        return wp
