from game.world.managers.objects.units.movement.behaviors.PetMovement import PetMovement
from utils.constants.MiscCodes import ObjectTypeIds, MoveType, MoveFlags
from utils.constants.UnitCodes import UnitStates

from game.world.managers.objects.units.movement.behaviors.GroupMovement import GroupMovement
from game.world.managers.objects.units.movement.behaviors.WaypointMovement import WaypointMovement
from game.world.managers.maps.MapManager import MapManager
from game.world.managers.objects.units.movement.SplineBuilder import SplineBuilder
from game.world.managers.objects.units.movement.behaviors.ChaseMovement import ChaseMovement
from game.world.managers.objects.units.movement.behaviors.DistractedMovement import DistractedMovement
from game.world.managers.objects.units.movement.behaviors.EvadeMovement import EvadeMovement
from game.world.managers.objects.units.movement.behaviors.FearMovement import FearMovement
from game.world.managers.objects.units.movement.behaviors.FlightMovement import FlightMovement
from game.world.managers.objects.units.movement.behaviors.WanderingMovement import WanderingMovement


class MovementManager:
    def __init__(self, unit):
        self.unit = unit
        self.is_player = self.unit.get_type_id() == ObjectTypeIds.ID_PLAYER
        self.pause_out_of_combat = 0
        self.movement_behaviors = []

    def initialize(self):
        if self.is_player:
            return

        # Make sure to flush any existent behaviors if this was re-initialized.
        self.flush()

        if self.unit.is_pet():
            self.set_behavior(PetMovement(spline_callback=self.spline_callback, is_default=True))
        elif self.unit.has_wander_type():
            self.set_behavior(WanderingMovement(spline_callback=self.spline_callback, is_default=True))
        elif self.unit.has_waypoints_type() and self.unit.spawn_id:
            if self.unit.creature_group:
                self.set_behavior(GroupMovement(spline_callback=self.spline_callback, is_default=True))
            else:
                self.set_behavior(WaypointMovement(spline_callback=self.spline_callback, is_default=True))

    # Broadcast a new spline from an active movement behavior.
    def spline_callback(self, spline, movement_behavior=None):
        spline.initialize()
        self.unit.movement_spline = spline
        movement_packet = spline.try_build_movement_packet()
        if movement_behavior:
            movement_behavior.spline = spline
        if movement_packet:
            MapManager.send_surrounding(movement_packet, self.unit, include_self=self.is_player)

    def flush(self):
        self.movement_behaviors.clear()

    def reset(self, clean_behaviors=False):
        # If currently moving, update the current spline in order to have latest guessed position before flushing.
        spline = self.get_current_spline()
        if spline:
            spline.update_to_now()
            self.stop()
        self.unit.movement_spline = None
        if clean_behaviors:
            [self._remove_behavior(behavior) for behavior
             in list(self.movement_behaviors) if not behavior.is_default]

    def update(self, now, elapsed):
        is_resume = self._handle_out_of_combat_pause(elapsed)

        if not self._can_move():
            return

        # Check if we need to remove any movement.
        movements_removed = self._clean_movement_behaviors()
        # Grab latest, if any.
        current_movement = self._get_current_movement()

        if not current_movement:
            return

        # Resuming or cascaded into a previous movement, reset.
        if is_resume or movements_removed:
            current_movement.reset()

        current_movement.update(now, elapsed)

    def _handle_out_of_combat_pause(self, elapsed):
        if self.pause_out_of_combat:
            self.pause_out_of_combat = max(0, self.pause_out_of_combat - elapsed)
            if not self.pause_out_of_combat:
                return True
        return False

    def _get_default_movement(self):
        return self.movement_behaviors[-1] if self.movement_behaviors else None

    def _get_current_movement(self):
        return self.movement_behaviors[0] if self.movement_behaviors else None

    def _clean_movement_behaviors(self, force_default=False):
        movements_removed = False
        # Check if we need to fall back to another movement behavior.
        while self.movement_behaviors and self.movement_behaviors[0].can_remove():
            movements_removed = True
            self._remove_behavior(self.movement_behaviors[0])
        return movements_removed

    def _can_move(self):
        if self.pause_out_of_combat and not self.unit.in_combat:
            return False
        if not self.movement_behaviors:
            return False
        if not self.unit.is_alive:
            return False
        if self.unit.unit_state & UnitStates.STUNNED or self.unit.movement_flags & MoveFlags.MOVEFLAG_ROOTED:
            return False
        if not self.is_player and self.unit.is_casting():
            return False
        return True

    def set_speed_dirty(self):
        current_movement = self._get_current_movement()
        if current_movement:
            current_movement.set_speed_dirty()

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

    def try_pause_movement(self, duration_seconds):
        current_movement = self._get_current_movement()
        if not self.unit.in_combat and current_movement:
            self.pause_out_of_combat = duration_seconds
            self.stop()

    def move_stay(self, state):
        current_behavior = self._get_default_movement()
        if not current_behavior or current_behavior.move_type != MoveType.PET:
            return
        current_behavior.stay(state=state)

    def move_distracted(self, duration_seconds, angle):
        self.set_behavior(DistractedMovement(duration_seconds, angle, spline_callback=self.spline_callback))

    def move_chase(self):
        self.set_behavior(ChaseMovement(spline_callback=self.spline_callback))

    def move_home(self, waypoints):
        self.set_behavior(EvadeMovement(waypoints, self.spline_callback))

    def move_flight(self, waypoints):
        self.set_behavior(FlightMovement(waypoints, self.spline_callback))

    def move_fear(self, duration_seconds):
        self.set_behavior(FearMovement(duration_seconds, spline_callback=self.spline_callback))

    def set_behavior(self, movement_behavior):
        movement_behavior.initialize(self.unit)
        self.movement_behaviors.insert(0, movement_behavior)

    def _remove_behavior(self, movement_behavior):
        if movement_behavior in self.movement_behaviors:
            self.movement_behaviors.remove(movement_behavior)
            movement_behavior.on_removed()

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
        return self.movement_behaviors[0].spline if self.movement_behaviors[0].spline else None

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
