import math
import time
from random import randint

from game.world.managers.maps.MapManager import MapManager
from game.world.managers.objects.units.movement.MovementSpline import MovementSpline
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
        self.last_random_movement = 0
        self.random_wait_time = randint(1, 12)

    def update(self, now, elapsed):
        if self._should_remove_distracted(elapsed):
            self.set_distracted(0)

        if self._can_perform_wandering(self.unit, now):
            self._perform_random_movement(self.unit, now)
        elif self._can_perform_combat_chase(self.unit):
            self._perform_combat_chase_movement(self.unit)
        elif self._can_perform_fear(self.unit, now):
            self._perform_fear_movement(now)

        if not self.pending_splines:
            return

        pending_spline = self.pending_splines[0]
        position_changed, new_position = pending_spline.update(elapsed)

        if position_changed:
            self.unit.location = new_position
            self.unit.set_has_moved(has_moved=True, has_turned=False)
            if self.is_player and self.unit.pending_taxi_destination:
                self.unit.taxi_manager.update_flight_state()

        if pending_spline.is_complete():
            self.pending_splines.pop(0)
            self._handle_flight_end(pending_spline)
            self._handle_spline_end(pending_spline)

    def _perform_fear_movement(self, now):
        if self._move_fear():
            self.random_wait_time = self.pending_splines[0].total_time
            self.last_random_movement = now
            self.fear_timer = 0

    def _perform_random_movement(self, unit, now):
        if self._move_random(unit.spawn_position, unit.wander_distance):
            self.random_wait_time = randint(1, 12)
            self.last_random_movement = now

    def _move_fear(self, speed=config.Unit.Defaults.run_speed):
        fear_point = self.unit.location.get_point_in_radius_and_angle(speed * self.fear_timer, 0)
        self.send_move_normal([fear_point], speed, SplineFlags.SPLINEFLAG_RUNMODE)
        return True

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

    # noinspection PyMethodMayBeStatic
    def _can_perform_fear(self, unit, now):
        return self.fear_timer and unit.unit_flags & UnitFlags.UNIT_FLAG_FLEEING \
            and now > self.last_random_movement + self.random_wait_time

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
            and now > self.last_random_movement + self.random_wait_time \
            and not unit.unit_state & UnitStates.DISTRACTED \
            and not unit.unit_flags & UnitFlags.UNIT_FLAG_FLEEING

    def _should_remove_distracted(self, elapsed):
        if not self.unit.unit_state & UnitStates.DISTRACTED:
            return False
        self.distracted_timer = max(0, self.distracted_timer - elapsed)
        return self.unit.combat_target or not self.distracted_timer

    def set_feared(self, duration=0):
        self.fear_timer = duration

    def set_distracted(self, duration, source_unit=None):
        if duration:
            self.distracted_timer = duration
            self.unit.unit_state |= UnitStates.DISTRACTED
            self.send_face_target(source_unit)
        else:
            self.unit.unit_state &= ~UnitStates.DISTRACTED
            # Restore original spawn orientation.
            if not self.is_player and not self.unit.has_wander_type():
                self.unit.location.o = self.unit.spawn_position.o
                self.send_face_target(self.unit)

    def reset(self):
        # If currently moving, update the current spline before flushing.
        if self.pending_splines:
            self.pending_splines[0].update(time.time() - self.unit.last_tick)
        self.pending_splines.clear()
        self.unit.movement_spline = None

    def get_pending_waypoints_length(self):
        return 0 if not self.pending_splines else self.pending_splines[0].get_pending_waypoints_length()

    def get_waypoint_location(self):
        if not self.pending_splines:
            return self.unit.location
        return self.pending_splines[0].get_waypoint_location()

    def unit_is_moving(self):
        if self.is_player:
            return self.pending_splines and self.unit.pending_taxi_destination is not None
        return self.pending_splines

    def try_build_movement_packet(self, waypoints=None, is_initial=False):
        if not self.pending_splines:
            return None
        return self.pending_splines[0].try_build_movement_packet(waypoints, is_initial)

    def _handle_spline_end(self, spline):
        if self.is_player:
            return
        if self.unit.is_evading:
            self.unit.is_evading = False
        if self.unit.is_at_home() and spline.is_type(SplineType.SPLINE_TYPE_NORMAL):
            self.unit.on_at_home()

    def _handle_flight_end(self, spline):
        if not spline.is_flight() or (not self.is_player and not self.unit.pending_taxi_destination):
            return
        self.unit.set_taxi_flying_state(False)
        self.unit.teleport(self.unit.map_id, self.unit.pending_taxi_destination, is_instant=True)
        self.unit.pending_taxi_destination = None
        self.unit.taxi_manager.update_flight_state()

    def send_move_normal(self, waypoints, speed, spline_flag, spline_type=SplineType.SPLINE_TYPE_NORMAL):
        if self.unit.movement_flags & MoveFlags.MOVEFLAG_ROOTED:
            return

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

    def send_face_target(self, target):
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

        self._send_move_to(spline)

    def send_face_angle(self, angle):
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

    def _send_move_to(self, spline):
        # Reset old waypoints (if any) before sending new waypoints.
        self.reset()

        # Set spline and last position.
        self.unit.movement_spline = spline

        packet = spline.try_build_movement_packet(waypoints=spline.points, is_initial=True)
        if packet:
            MapManager.send_surrounding(packet, self.unit, include_self=self.is_player)
            self.pending_splines.append(spline)
