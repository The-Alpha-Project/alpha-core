from typing import Optional

from database.dbc.DbcModels import SpellRange
from game.world.managers.maps.MapManager import MapManager
from utils.ConfigManager import config
from utils.Logger import Logger
from game.world.managers.objects.units.movement.helpers.SplineBuilder import SplineBuilder
from utils.constants.MiscCodes import ObjectTypeIds, MoveType, MoveFlags
from utils.constants.UnitCodes import UnitStates
from game.world.managers.objects.units.movement.behaviors.BaseMovement import BaseMovement
from game.world.managers.objects.units.movement.behaviors.PetMovement import PetMovement
from game.world.managers.objects.units.movement.behaviors.GroupMovement import GroupMovement
from game.world.managers.objects.units.movement.behaviors.WaypointMovement import WaypointMovement
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
        self.default_behavior_type = None
        self.active_behavior_type = None
        # Available move behaviors with priority.
        self.movement_behaviors = {
            MoveType.EVADE: None,
            MoveType.FLIGHT: None,
            MoveType.FEAR: None,
            MoveType.DISTRACTED: None,
            MoveType.CHASE: None,
            MoveType.PET: None,
            MoveType.GROUP: None,
            MoveType.WAYPOINTS: None,
            MoveType.WANDER: None,
            MoveType.IDLE: None,
        }

    def initialize(self):
        if self.is_player:
            return

        # Make sure to flush any existent behaviors if this was re-initialized.
        self.flush()

        if self.unit.is_pet():
            self.set_behavior(PetMovement(spline_callback=self.spline_callback, is_default=True))
        elif self.unit.has_wander_type():
            self.set_behavior(WanderingMovement(spline_callback=self.spline_callback, is_default=True))
        elif self.unit.creature_group and self.unit.creature_group.is_formation() and self.unit.spawn_id:
            self.set_behavior(GroupMovement(spline_callback=self.spline_callback, is_default=True))
        elif self.unit.has_waypoints_type() and self.unit.spawn_id:
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
        self._remove_invalid_expired_behaviors()
        for move_type in self.movement_behaviors.keys():
            self.movement_behaviors[move_type] = None
        self.stop()

    def reset(self, clean_behaviors=False):
        # If currently moving, update the current spline in order to have latest guessed position before flushing.
        spline = self._get_current_spline()
        if spline:
            spline.update_to_now()
            self.stop()
        self.unit.movement_spline = None
        if clean_behaviors:
            self._remove_invalid_expired_behaviors()

    def update(self, now, elapsed):
        is_resume = self._handle_out_of_combat_pause(elapsed)

        if not self._can_move():
            return

        # Check if we need to remove any movement.
        movements_removed = self._remove_invalid_expired_behaviors()
        # Grab latest, if any.
        current_behavior = self._get_current_behavior()

        if not current_behavior:
            return

        # Resuming or cascaded into a previous movement, reset.
        if is_resume or movements_removed:
            current_behavior.reset()

        current_behavior.update(now, elapsed)

    def set_speed_dirty(self):
        current_behavior = self._get_current_behavior()
        if current_behavior:
            current_behavior.set_speed_dirty()

    def get_waypoint_location(self):
        spline = self._get_current_spline()
        return spline.get_waypoint_location() if spline else self.unit.location

    def try_pause_movement(self, duration_seconds):
        current_behavior = self._get_current_behavior()
        if not self.unit.in_combat and current_behavior:
            self.pause_out_of_combat = duration_seconds
            self.stop()

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

    def move_waypoints_from_script(self):
        self.set_behavior(WaypointMovement(spline_callback=self.spline_callback))

    def move_to_point(self, location, speed=config.Unit.Defaults.walk_speed):
        self.spline_callback(SplineBuilder.build_normal_spline(self.unit, points=[location], speed=speed))

    def pet_move_in_range(self, target, range_: SpellRange, delay: int):
        pet_movement = self.movement_behaviors.get(MoveType.PET, None)
        if pet_movement:
            pet_movement.move_in_range(target=target, range_=range_, delay=delay)

    def pet_move_stay(self, state):
        pet_movement = self.movement_behaviors.get(MoveType.PET, None)
        if pet_movement:
            pet_movement.stay(state=state)

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

    def set_behavior(self, movement_behavior):
        if movement_behavior.initialize(self.unit):
            self.movement_behaviors[movement_behavior.move_type] = movement_behavior
            self._update_active_behavior_type()
            if movement_behavior.is_default:
                self.default_behavior_type = movement_behavior.move_type
        else:
            Logger.warning(f'Failied to initialize movement {movement_behavior.move_type} for unit {self.unit.entry}')

    def unit_is_moving(self):
        if self.is_player and self.unit.movement_flags & MoveFlags.MOVEFLAG_MOVE_MASK:
            return True
        return True if self._get_current_spline() else False

    def try_build_movement_packet(self):
        spline = self._get_current_spline()
        return spline.try_build_movement_packet() if spline else None

    def _handle_out_of_combat_pause(self, elapsed):
        if self.pause_out_of_combat:
            self.pause_out_of_combat = max(0, self.pause_out_of_combat - elapsed)
            if not self.pause_out_of_combat:
                return True
        return False

    def _remove_invalid_expired_behaviors(self):
        movements_removed = False
        for move_type, behavior in list(self.movement_behaviors.items()):
            if behavior and behavior.can_remove() and not behavior.is_default:
                movements_removed = True
                self._remove_behavior(behavior)
        # Check if we need to fall back to another movement behavior.
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

    def _update_active_behavior_type(self):
        for move_type, behavior in list(self.movement_behaviors.items()):
            if behavior:
                self.active_behavior_type = behavior.move_type
                break

    def _remove_behavior(self, movement_behavior):
        self.movement_behaviors[movement_behavior.move_type] = None
        self._update_active_behavior_type()
        movement_behavior.on_removed()

    def _get_current_spline(self):
        current_behavior = self._get_current_behavior()
        if not current_behavior:
            return None
        return current_behavior.spline if current_behavior.spline else None

    def _get_current_behavior(self) -> Optional[BaseMovement]:
        if not self.active_behavior_type:
            return None
        movement_behavior = self.movement_behaviors.get(self.active_behavior_type, None)
        return movement_behavior if movement_behavior else None

    def _get_default_behavior(self):
        if not self.default_behavior_type:
            return None
        movement_behavior = self.movement_behaviors.get(self.default_behavior_type, None)
        return movement_behavior if movement_behavior else None
