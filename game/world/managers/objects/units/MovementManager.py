from game.world.managers.maps.MapManager import MapManager
from game.world.managers.objects.units.movement.MovementWaypoint import MovementWaypoint
from game.world.managers.objects.units.movement.SplineBuilder import SplineBuilder
from game.world.managers.objects.units.movement.behaviors.ChaseMovement import ChaseMovement
from game.world.managers.objects.units.movement.behaviors.DistractedMovement import DistractedMovement
from game.world.managers.objects.units.movement.behaviors.EvadeMovement import EvadeMovement
from game.world.managers.objects.units.movement.behaviors.FlightMovement import FlightMovement
from game.world.managers.objects.units.movement.behaviors.WanderingMovement import WanderingMovement
from utils.ConfigManager import config
from utils.constants.MiscCodes import ObjectTypeIds, MoveType
from utils.constants.UnitCodes import UnitStates, UnitFlags


class MovementManager:
    def __init__(self, unit):
        self.unit = unit
        self.is_player = self.unit.get_type_id() == ObjectTypeIds.ID_PLAYER
        self.movement_behaviors = []
        # self.pending_splines: list[Spline] = []
        # self.distracted_timer = 0
        # self.fear_timer = 0
        # self.last_movement = 0  # Wandering, Waypoint.
        # self.wait_time_seconds = randint(1, 12)  # Wandering, Fear, Waypoint.
        # self.halt_movement_timer = 0
        # self.movement_waypoints = []  # Used for MovementType.WAYPOINT
        # self.return_home_waypoints = []  # Used for evade.

    def initialize(self):
        if self.unit.has_wander_type():
            self.set_behavior(WanderingMovement(is_default=True, spline_callback=self.spline_callback))

    # Receives a new spline from an active movement behavior.
    def spline_callback(self, spline):
        spline.initialize()
        self.unit.movement_spline = spline
        movement_packet = spline.try_build_movement_packet()
        if movement_packet:
            MapManager.send_surrounding(movement_packet, self.unit, include_self=self.is_player)

    def flush(self):
        self.movement_behaviors.clear()
        self.unit = None

    def update(self, now, elapsed):
        # Short circuit.
        if not self._can_move():
            return

        current_movement = self._get_current_movement()
        # Check if we need to fall back to another movement behavior.
        while current_movement and current_movement.can_remove():
            print(f'Remove movement behavior {MoveType(current_movement.move_type).name}.')
            self.movement_behaviors.remove(current_movement)
            current_movement.on_removed()
            current_movement = self._get_current_movement()
            if current_movement:
                current_movement.reset()

        if not current_movement:
            return

        current_movement.update(now, elapsed)

        # self.halt_movement_timer = 0 if self.unit.combat_target else max(0, self.halt_movement_timer - elapsed)
        # # Skip updates while waiting.
        # if self.halt_movement_timer:
        #     return
        #
        # spline = self.get_current_spline()
        # # Update any pending spline first.
        # if spline:
        #     position_changed, new_position, wp_complete = spline.update(elapsed)
        #
        #     if position_changed:
        #         self._handle_position_change(spline, new_position, wp_complete)
        #
        #     if spline.is_complete():
        #         self.pending_splines.pop(0)
        #
        # # Remove distracted if necessary.
        # # TODO: Find a better way to remove this, maybe based on mod stun removal.
        # if self._should_remove_distracted(elapsed):
        #     self.set_distracted(0)
        #
        # # Check if we need to trigger any type of new movement.
        # if self._can_perform_move_home_movement(self.unit, now):
        #     self._perform_move_home_movement(now)
        # elif self._can_perform_creature_waypoints(self.unit, now):
        #     self._perform_waypoints_movement(now)
        # elif self._can_perform_follow_group(self.unit, now):
        #     self._perform_follow_group(now, elapsed)
        # elif self._can_perform_wandering(self.unit, now):
        #     self._perform_random_movement(self.unit, now)
        # elif self._can_perform_combat_chase(self.unit):
        #     self._perform_combat_chase_movement(self.unit)
        # elif self._can_perform_fear(self.unit, elapsed, now):
        #     self._perform_fear_movement(now)
        #
        # if not self.pending_splines:
        #     self.unit.movement_flags &= ~MoveFlags.MOVEFLAG_MOVED
        # else:
        #     self.unit.movement_flags |= MoveFlags.MOVEFLAG_WALK

    def _get_current_movement(self):
        return self.movement_behaviors[0] if self.movement_behaviors else None

    def _can_move(self):
        if not self.movement_behaviors:
            return False
        if not self.unit.is_alive:
            return False
        if self.unit.unit_state & UnitStates.STUNNED:
            return False
        if not self.is_player and self.unit.is_casting():
            return False
        return True

    def _perform_follow_group(self, now, elapsed):
        location, speed = self.unit.creature_group.get_follow_position_and_speed(self.unit, elapsed)
        if not location:
            return
        self.send_move_normal([location], speed, MoveType.WAYPOINTS)
        self.wait_time_seconds = self.pending_splines[-1].get_total_time_secs()
        self.last_movement = now

    # TODO: No scripts.
    def _perform_waypoints_movement(self, now):
        speed = config.Unit.Defaults.walk_speed
        # Initialize waypoints if needed.
        if not self.movement_waypoints:
            self.movement_waypoints = self._get_sorted_waypoints_by_distance()

        waypoint = self.movement_waypoints[0]
        self.send_move_normal([waypoint.location()], speed, MoveType.WAYPOINTS)
        self.wait_time_seconds = self.pending_splines[-1].get_total_time_secs(offset_milliseconds=waypoint.wait_time())
        self.last_movement = now

    # TODO: Namigator: FindRandomPointAroundCircle (Detour)
    #  We need a valid path for fear else unexpected collisions can mess things up.
    def _perform_fear_movement(self, now):
        speed = self.unit.running_speed
        fear_point = self.unit.location.get_point_in_radius_and_angle(speed * self.fear_timer, 0)
        self.send_move_normal([fear_point], speed, MoveType.FEAR)
        self.wait_time_seconds = self.pending_splines[-1].get_total_time_secs()
        self.last_movement = now

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
            and not unit.default_waypoints and self.unit.creature_group and self.unit.creature_group.leader \
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
            self.stop()

    def set_distracted(self, duration, location=None):
        if duration:
            self.distracted_timer = duration
            self.unit.unit_state |= UnitStates.DISTRACTED
            # TODO: Use spot SplineType, currently crashes.
            self.face_angle(self.unit.location.angle(location))
        else:

            self.unit.unit_state &= ~UnitStates.DISTRACTED
            # Restore original spawn orientation.
            if not self.is_player and not self.unit.has_wander_type():
                self.face_angle(self.unit.location.angle(self.unit.spawn_position.o))

    def reset(self):
        # If currently moving, update the current spline in order to have latest guessed position before flushing.
        spline = self.get_current_spline()
        if spline:
            spline.update_to_now()
        #self.last_movement = 0
        #self.wait_time_seconds = 0
        #self.pending_splines.clear()
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

    def move_distracted(self, duration_seconds, location):
        angle = self.unit.location.angle(location)
        self.set_behavior(DistractedMovement(duration_seconds, angle, spline_callback=self.spline_callback))

    def move_chase(self):
        self.set_behavior(ChaseMovement(spline_callback=self.spline_callback))

    def move_home(self, waypoints):
        self.set_behavior(EvadeMovement(waypoints, self.spline_callback))

    def move_flight(self, waypoints):
        self.set_behavior(FlightMovement(waypoints, self.spline_callback))

    def set_behavior(self, movement_behavior):
        print(f'Set movement behavior {MoveType(movement_behavior.move_type).name}')
        movement_behavior.initialize(self.unit)
        self.movement_behaviors.insert(0, movement_behavior)

    def unit_is_moving(self):
        return len(self.movement_behaviors) > 0 and self.movement_behaviors[0].spline

    def try_build_movement_packet(self):
        spline = self.get_current_spline()
        if spline:
            return spline.try_build_movement_packet()
        return None

    def get_current_spline(self):
        if not self.movement_behaviors:
            return None
        return self.movement_behaviors[0].spline

    def _handle_position_change(self, spline, new_position, waypoint_complete):
        # Waypoint type movement, set home position upon waypoint reached.
        # This is where the unit will return if the path is interrupted.
        if spline.move_type == MoveType.WAYPOINTS:
            self.unit.spawn_position = new_position.copy()  # Set new home.
            if waypoint_complete and self.movement_waypoints:  # Not guessed location.
                current_waypoints = self.movement_waypoints[0]
                # Handle as circular buffer.
                self.movement_waypoints.pop(0)
                self.movement_waypoints.append(current_waypoints)
        elif spline.move_type == MoveType.EVADE:
            if waypoint_complete:
                self.unit.spawn_position = new_position.copy()  # Set new home.
                self.return_home_waypoints.pop(0)
                # This was the last wp, set at home.
                if not self.return_home_waypoints:
                    self.unit.is_evading = False
                    self.unit.on_at_home()
        # Common.
        self.unit.location = new_position
        self.unit.set_has_moved(has_moved=True, has_turned=False)

    # Instant.
    def stop(self):
        self.spline_callback(SplineBuilder.build_stop_spline(self.unit))

    # Instant.
    def face_target(self, target):
        self.spline_callback(SplineBuilder.build_face_target_spline(self.unit, target))

    # Instant.
    def face_angle(self, angle):
        self.spline_callback(SplineBuilder.build_face_angle_spline(self.unit, angle))

    # Instant.
    def face_spot(self, spot):
        self.spline_callback(SplineBuilder.build_face_spot_spline(self.unit, spot))
