import math
from random import randint

from game.world.managers.maps.MapManager import MapManager
from game.world.managers.objects.units.movement.CreatureGroupManager import CreatureGroupManager
from game.world.managers.objects.units.movement.MovementSpline import MovementSpline
from game.world.managers.objects.units.movement.MovementWaypoint import MovementWaypoint
from utils.ConfigManager import config
from utils.Formulas import UnitFormulas, Distances
from utils.Logger import Logger
from utils.constants.MiscCodes import MoveFlags, ObjectTypeIds
from utils.constants.UnitCodes import SplineFlags, SplineType, UnitStates, UnitFlags


class MovementManager:
    def __init__(self, unit):
        self.unit = unit
        self.is_player = self.unit.get_type_id() == ObjectTypeIds.ID_PLAYER
        self.pending_splines: list[MovementSpline] = []
        self.distracted_timer = 0
        self.fear_timer = 0
        self.last_movement = 0  # Wandering, Waypoint.
        self.wait_time_seconds = randint(1, 12)  # Wandering, Fear, Waypoint.
        self.halt_movement_timer = 0
        self.movement_waypoints = []  # Used for MovementType.WAYPOINT
        self.return_home_waypoints = []  # Used for evade.

    def update(self, now, elapsed):
        self.halt_movement_timer = max(0, self.halt_movement_timer - elapsed)
        # Skip updates while waiting.
        if self.halt_movement_timer:
            return

        spline = self.get_current_spline()
        # Update any pending spline first.
        if spline:
            position_changed, new_position = spline.update(elapsed)

            if position_changed:
                self._handle_position_change(new_position)

            if spline.is_complete():
                self.pending_splines.pop(0)
                self._handle_flight_end(spline)

        # Remove distracted if necessary.
        # TODO: Find a better way to remove this, maybe based on mod stun removal.
        if self._should_remove_distracted(elapsed):
            self.set_distracted(0)

        # Check if we need to trigger any type of new movement.
        if self._can_perform_move_home_movement(self.unit, now):
            self._perform_move_home_movement(now)
        elif self._can_perform_creature_waypoints(self.unit, now):
            self._perform_waypoints_movement(now)
        elif self._can_perform_follow_group(self.unit, now):
            self._perform_follow_group(now)
        elif self._can_perform_wandering(self.unit, now):
            self._perform_random_movement(self.unit, now)
        elif self._can_perform_combat_chase(self.unit):
            self._perform_combat_chase_movement(self.unit)
        elif self._can_perform_fear(self.unit, elapsed, now):
            self._perform_fear_movement(now)

        if not self.pending_splines:
            self.unit.movement_flags &= ~MoveFlags.MOVEFLAG_MOVED
        else:
            self.unit.movement_flags |= MoveFlags.MOVEFLAG_WALK

    def _perform_move_home_movement(self, now):
        speed = self.unit.running_speed
        self.send_move_normal([self.return_home_waypoints[0]], speed, SplineFlags.SPLINEFLAG_RUNMODE)
        self.wait_time_seconds = self.pending_splines[-1].get_total_time_secs()
        self.last_movement = now

    def _perform_follow_group(self, now):
        speed = config.Unit.Defaults.walk_speed
        location = CreatureGroupManager.get_follow_position(self.unit.creature_group)
        self.send_move_normal([location], speed, SplineFlags.SPLINEFLAG_RUNMODE)
        self.wait_time_seconds = self.pending_splines[-1].get_total_time_secs()
        self.last_movement = now

    # TODO: No scripts, no wait times, etc.
    def _perform_waypoints_movement(self, now):
        speed = config.Unit.Defaults.walk_speed
        # Initialize waypoints if needed.
        if not self.movement_waypoints:
            self.movement_waypoints = self._get_sorted_waypoints_by_distance()

        waypoint = self.movement_waypoints[0]
        self.send_move_normal([waypoint.location()], speed, SplineFlags.SPLINEFLAG_RUNMODE)
        self.wait_time_seconds = self.pending_splines[-1].get_total_time_secs(offset_milliseconds=waypoint.wait_time())
        self.last_movement = now

    # TODO: Namigator: FindRandomPointAroundCircle (Detour)
    #  We need a valid path for fear else unexpected collisions can mess things up.
    def _perform_fear_movement(self, now):
        speed = self.unit.running_speed
        fear_point = self.unit.location.get_point_in_radius_and_angle(speed * self.fear_timer, 0)
        self.send_move_normal([fear_point], speed, SplineFlags.SPLINEFLAG_RUNMODE)
        self.wait_time_seconds = self.pending_splines[-1].get_total_time_secs()
        self.last_movement = now

    def _perform_random_movement(self, unit, now):
        if self._move_random(unit.spawn_position, unit.wander_distance):
            self.wait_time_seconds = randint(1, 12)
            self.last_movement = now

    # TODO: Namigator: FindRandomPointAroundCircle (Detour)
    def _move_random(self, start_position, radius, speed=config.Unit.Defaults.walk_speed):
        random_point = start_position.get_random_point_in_radius(radius, map_id=self.unit.map_id)
        failed, in_place, path = MapManager.calculate_path(self.unit.map_id, start_position, random_point)
        if failed or len(path) > 1 or in_place:
            return False

        map_ = MapManager.get_map(self.unit.map_id, self.unit.instance_id)
        if not map_.is_active_cell_for_location(random_point):
            return False

        self.send_move_normal([random_point], speed, SplineFlags.SPLINEFLAG_RUNMODE)
        return True

    # TODO: There are some creatures like crabs or murlocs that apparently couldn't swim in earlier versions
    #  but are spawned inside the water at this moment since most spawns come from Vanilla data. These mobs
    #  will currently bug out when you try to engage in combat with them. Also seems like a lot of humanoids
    #  couldn't swim before patch 1.3.0:
    #  World of Warcraft Client Patch 1.3.0 (2005-03-22)
    #   - Most humanoids NPCs have gained the ability to swim.
    #  This might only refer to creatures not having swimming animations.
    def _perform_combat_chase_movement(self, unit):
        # Check if target is player and is online.
        target_is_player = unit.combat_target.get_type_id() == ObjectTypeIds.ID_PLAYER
        if target_is_player and not unit.combat_target.online:
            unit.threat_manager.remove_unit_threat(unit.combat_target)
            return

        spawn_distance = unit.location.distance(unit.spawn_position)
        target_distance = unit.location.distance(unit.combat_target.location)
        combat_position_distance = UnitFormulas.combat_distance(unit, unit.combat_target)
        target_under_water = unit.combat_target.is_under_water()

        if not unit.is_pet():
            # In 0.5.3, evade mechanic was only based on distance, the correct distance remains unknown.
            # From 0.5.4 patch notes:
            #     "Creature pursuit is now timer based rather than distance based."
            if spawn_distance > Distances.CREATURE_EVADE_DISTANCE \
                    or target_distance > Distances.CREATURE_EVADE_DISTANCE:
                unit.threat_manager.remove_unit_threat(unit.combat_target)
                return

            # TODO: There are some creatures like crabs or murlocs that apparently couldn't swim in earlier versions
            #  but are spawned inside the water at this moment since most spawns come from Vanilla data. These mobs
            #  will currently bug out when you try to engage in combat with them. Also seems like a lot of humanoids
            #  couldn't swim before patch 1.3.0:
            #  World of Warcraft Client Patch 1.3.0 (2005-03-22)
            #   - Most humanoids NPCs have gained the ability to swim.
            if unit.is_under_water():
                if not unit.can_swim():
                    unit.threat_manager.remove_unit_threat(unit.combat_target)
                    return
                if not unit.can_exit_water() and not target_under_water:
                    unit.threat_manager.remove_unit_threat(unit.combat_target)
                    return

        # If this creature is not facing the attacker, update its orientation.
        if not unit.location.has_in_arc(unit.combat_target.location, math.pi):
            unit.movement_manager.send_face_target(unit.combat_target)

        combat_location = unit.combat_target.location.get_point_in_between(combat_position_distance, vector=unit.location)
        if not combat_location:
            return

        # Target is within combat distance or already in combat location, don't move.
        if round(target_distance) <= round(combat_position_distance) or unit.location == combat_location:
            return

        if unit.is_moving():
            if unit.movement_manager.get_waypoint_location().distance(combat_location) < 0.1:
                return

        # Use direct combat location if target is over water.
        if not target_under_water:
            failed, in_place, path = MapManager.calculate_path(unit.map_id, unit.location.copy(), combat_location)
            if not failed and not in_place:
                combat_location = path[0]
            elif in_place:
                return
            # Unable to find a path while Namigator is enabled, log warning and use combat location directly.
            elif MapManager.NAMIGATOR_LOADED:
                Logger.warning(f'Unable to find navigation path, map {unit.map_id} loc {unit.location} end {combat_location}')

        self.send_move_normal([combat_location], unit.running_speed, SplineFlags.SPLINEFLAG_RUNMODE)

    def _can_perform_move_home_movement(self, unit, now):
        return not self.is_player and unit.is_alive and not unit.is_casting() and not unit.is_moving() \
            and unit.is_evading and self.return_home_waypoints \
            and not unit.unit_state & UnitStates.STUNNED and not unit.unit_flags & UnitFlags.UNIT_FLAG_POSSESSED \
            and now > self.last_movement + self.wait_time_seconds \
            and not unit.unit_state & UnitStates.DISTRACTED \
            and not unit.unit_flags & UnitFlags.UNIT_FLAG_FLEEING

    def _can_perform_follow_group(self, unit, now):
        return not self.is_player and unit.is_alive and not unit.is_casting() and not unit.is_moving() \
            and not unit.combat_target and not unit.is_evading and unit.has_waypoints_type() \
            and not unit.default_waypoints and self.unit.creature_group \
            and not unit.unit_state & UnitStates.STUNNED and not unit.unit_flags & UnitFlags.UNIT_FLAG_POSSESSED \
            and now > self.last_movement + self.wait_time_seconds \
            and not unit.unit_state & UnitStates.DISTRACTED \
            and not unit.unit_flags & UnitFlags.UNIT_FLAG_FLEEING

    def _can_perform_creature_waypoints(self, unit, now):
        return not self.is_player and unit.is_alive and not unit.is_casting() and not unit.is_moving() \
            and not unit.combat_target and not unit.is_evading and unit.has_waypoints_type() \
            and unit.default_waypoints \
            and not unit.unit_state & UnitStates.STUNNED and not unit.unit_flags & UnitFlags.UNIT_FLAG_POSSESSED \
            and now > self.last_movement + self.wait_time_seconds \
            and not unit.unit_state & UnitStates.DISTRACTED \
            and not unit.unit_flags & UnitFlags.UNIT_FLAG_FLEEING

    # noinspection PyMethodMayBeStatic
    def _can_perform_fear(self, unit, elapsed, now):
        self.fear_timer = max(0, self.fear_timer - elapsed)
        return self.fear_timer and unit.unit_flags & UnitFlags.UNIT_FLAG_FLEEING \
            and now > self.last_movement + self.wait_time_seconds

    # noinspection PyMethodMayBeStatic
    def _can_perform_combat_chase(self, unit):
        return not self.is_player and unit.is_alive and not unit.is_casting() and not unit.is_totem() \
            and unit.combat_target and not unit.is_evading and unit.combat_target.is_alive \
            and not unit.unit_state & UnitStates.STUNNED and not unit.unit_flags & UnitFlags.UNIT_FLAG_POSSESSED \
            and not unit.unit_state & UnitStates.DISTRACTED \
            and not unit.unit_flags & UnitFlags.UNIT_FLAG_FLEEING

    # noinspection PyMethodMayBeStatic
    def _can_perform_wandering(self, unit, now):
        return not self.is_player and unit.is_alive and not unit.is_casting() and not unit.is_moving() \
            and not unit.combat_target and not unit.is_evading and unit.has_wander_type() \
            and not unit.unit_state & UnitStates.STUNNED and not unit.unit_flags & UnitFlags.UNIT_FLAG_POSSESSED \
            and now > self.last_movement + self.wait_time_seconds \
            and not unit.unit_state & UnitStates.DISTRACTED \
            and not unit.unit_flags & UnitFlags.UNIT_FLAG_FLEEING

    def _should_remove_distracted(self, elapsed):
        if not self.unit.unit_state & UnitStates.DISTRACTED:
            return False
        self.distracted_timer = max(0, self.distracted_timer - elapsed)
        return self.unit.combat_target or not self.distracted_timer

    def _get_sorted_waypoints_by_distance(self) -> list[MovementWaypoint]:
        points = [MovementWaypoint(wp) for wp in self.unit.default_waypoints]  # Wrap them.
        closest = min(points, key=lambda wp: self.unit.spawn_position.distance(wp.location()))
        index = points.index(closest)
        if index:
            points = points[index:] + points[0:index]
        return points

    def update_speed(self):
        # This will automatically trigger a new spline heading on the same direction with updated speed.
        self.fear_timer = 0
        self.wait_time_seconds = 0

    def set_feared(self, duration=0):
        self.fear_timer = duration
        self.reset()
        if not duration:
            self.send_move_stop()

    def set_distracted(self, duration, location=None):
        if duration:
            self.distracted_timer = duration
            self.unit.unit_state |= UnitStates.DISTRACTED
            # TODO: Use spot SplineType, currently crashes.
            self.send_face_angle(self.unit.location.angle(location))
        else:

            self.unit.unit_state &= ~UnitStates.DISTRACTED
            # Restore original spawn orientation.
            if not self.is_player and not self.unit.has_wander_type():
                self.send_face_angle(self.unit.location.angle(self.unit.spawn_position.o))

    def reset(self):
        # If currently moving, update the current spline in order to have latest guessed position before flushing.
        spline = self.get_current_spline()
        if spline:
            spline.update_to_now()
        self.last_movement = 0
        self.wait_time_seconds = 0
        self.pending_splines.clear()
        self.unit.movement_spline = None

    def get_pending_waypoints_length(self):
        spline = self.get_current_spline()
        if not spline:
            return 0
        return spline.get_pending_waypoints_length()

    def get_waypoint_location(self):
        spline = self.get_current_spline()
        if not spline:
            return self.unit.location
        return spline.get_waypoint_location()

    def move_home(self, waypoints):
        self.return_home_waypoints = waypoints

    def unit_is_moving(self):
        if self.is_player:
            return self.pending_splines or self.unit.pending_taxi_destination is not None
        return self.pending_splines

    def try_build_movement_packet(self):
        spline = self.get_current_spline()
        if spline:
            return spline.try_build_movement_packet()
        return None

    def get_current_spline(self):
        if not self.pending_splines:
            return None
        return self.pending_splines[0]

    def _handle_position_change(self, new_position):
        # Waypoint type movement, set home position upon waypoint reached.
        # This is where the unit will return if the path is interrupted.
        if self.movement_waypoints and new_position == self.movement_waypoints[0].location():
            self.unit.spawn_position = new_position.copy()  # Set new home.
            current_waypoints = self.movement_waypoints[0]
            # Handle as circular buffer.
            self.movement_waypoints.pop(0)
            self.movement_waypoints.append(current_waypoints)
        # Return home.
        elif self.return_home_waypoints and new_position == self.return_home_waypoints[0]:
            self.return_home_waypoints.pop(0)
            # This was the last wp, set at home.
            if not self.return_home_waypoints:
                self.unit.is_evading = False
                self.unit.on_at_home()
        # Common.
        self.unit.location = new_position
        self.unit.set_has_moved(has_moved=True, has_turned=False)
        if self.is_player and self.unit.pending_taxi_destination:
            self.unit.taxi_manager.update_flight_state()

    def _handle_flight_end(self, spline):
        if not self.is_player or not spline.is_flight():
            return
        if self.unit.pending_taxi_destination:
            self.unit.set_taxi_flying_state(False)
            self.unit.teleport(self.unit.map_id, self.unit.pending_taxi_destination, is_instant=True)
            self.unit.pending_taxi_destination = None
            self.unit.taxi_manager.update_flight_state()

    def send_move_normal(self, waypoints, speed, spline_flag, spline_type=SplineType.SPLINE_TYPE_NORMAL):
        if self.unit.movement_flags & MoveFlags.MOVEFLAG_ROOTED:
            return

        # Face destination vector.
        self.unit.location.face_point(waypoints[0])

        # Generate movement spline.
        spline = MovementSpline(
            unit=self.unit,
            spline_type=spline_type,
            flags=spline_flag,
            spot=self.unit.location,
            guid=self.unit.guid,
            facing=self.unit.location.o,
            speed=speed,
            elapsed=0,
            points=waypoints
        )

        self._send_move_to(spline)

    def send_move_stop(self):
        # Generate stop spline.
        spline = MovementSpline(
            unit=self.unit,
            spline_type=SplineType.SPLINE_TYPE_STOP,
            flags=SplineFlags.SPLINEFLAG_NONE,
            spot=self.unit.location,
            guid=self.unit.guid,
            facing=self.unit.location.o,
            points=[self.unit.location]
        )

        self._send_move_to(spline)

    def send_face_spot(self, spot):
        # Generate face spot spline.
        spline = MovementSpline(
            unit=self.unit,
            spline_type=SplineType.SPLINE_TYPE_FACING_SPOT,
            flags=SplineFlags.SPLINEFLAG_SPOT,
            spot=spot,
            guid=self.unit.guid,
            facing=spot.o,
            points=[spot]
        )

        self._send_move_to(spline)

    def send_face_target(self, target, halt_seconds=0.0):
        if not target:
            return

        # Server side.
        self.unit.location.face_point(target.location)

        # Generate face target spline
        spline = MovementSpline(
            unit=self.unit,
            spline_type=SplineType.SPLINE_TYPE_FACING_TARGET,
            flags=SplineFlags.SPLINEFLAG_TARGET,
            spot=target.location,
            guid=target.guid,
            facing=target.location.o,
            points=[self.unit.location]  # On its own axis.
        )

        self._send_move_to(spline, halt_seconds=halt_seconds)

    def send_face_angle(self, angle):
        # Server side.
        self.unit.location.o = angle

        # Generate face angle spline
        spline = MovementSpline(
            unit=self.unit,
            spline_type=SplineType.SPLINE_TYPE_FACING_ANGLE,
            flags=SplineFlags.SPLINEFLAG_FACING,
            spot=self.unit.location,
            guid=self.unit.guid,
            facing=angle,
            points=[self.unit.location]
        )

        self._send_move_to(spline)

    def _send_move_to(self, spline, halt_seconds=0.0):
        # Reset old waypoints (if any) before sending new waypoints.
        self.reset()

        # Set spline and last position.
        self.unit.movement_spline = spline

        spline.initialize()

        # Avoid halting movement if unit is in combat.
        if not self.unit.combat_target:
            self.halt_movement_timer = halt_seconds  # Seconds.

        movement_packet = spline.try_build_movement_packet()
        if movement_packet:
            MapManager.send_surrounding(movement_packet, self.unit, include_self=self.is_player)
            self.pending_splines.append(spline)
