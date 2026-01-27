import math
from typing import Optional

from game.world.managers.objects.units.movement.behaviors.FollowMovement import FollowMovement
from utils.ConfigManager import config
from utils.Logger import Logger
from game.world.managers.objects.units.movement.helpers.SplineBuilder import SplineBuilder
from utils.constants.MiscCodes import MoveType, MoveFlags
from utils.constants.ScriptCodes import MoveOptions
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
from game.world.managers.objects.units.movement.behaviors.ConfusedMovement import ConfusedMovement


class MovementManager:
    def __init__(self, unit):
        self.unit = unit
        self.is_player = self.unit.is_player()
        self.pause_ooc_timer = 0
        self.default_behavior_type = None
        self.active_behavior_type = None
        # Available move behaviors with priority.
        self.movement_behaviors = {
            MoveType.EVADE: None,
            MoveType.FLIGHT: None,
            MoveType.FEAR: None,
            MoveType.CONFUSED: None,
            MoveType.DISTRACTED: None,
            MoveType.CHASE: None,
            MoveType.PET: None,
            MoveType.FOLLOW: None,
            MoveType.GROUP: None,
            MoveType.WAYPOINTS: None,
            MoveType.WANDER: None,
            MoveType.IDLE: None
        }
        self.spline_events = []

    def initialize_or_reset(self):
        if self.is_player:
            return

        # Make sure to flush any existent behaviors if this was re-initialized.
        self.flush()

        if self.unit.is_guardian():
            self.set_behavior(FollowMovement(spline_callback=self.spline_callback, is_default=True))
        elif self.unit.is_controlled():
            is_default = self.unit.is_pet()
            self.set_behavior(PetMovement(spline_callback=self.spline_callback, is_default=is_default))
        elif self.unit.creature_group and self.unit.creature_group.is_formation():
            self.set_behavior(GroupMovement(spline_callback=self.spline_callback, is_default=False))
        elif self.unit.has_wander_type():
            self.set_behavior(WanderingMovement(spline_callback=self.spline_callback, is_default=True))
        elif self.unit.has_waypoints_type():
            self.set_behavior(WaypointMovement(spline_callback=self.spline_callback, is_default=True))

    # Broadcast a new spline from an active movement behavior.
    def spline_callback(self, spline, movement_behavior=None):
        # Update to the latest position if necessary.
        current_spline = self.unit.movement_spline
        if current_spline and current_spline is not spline and not current_spline.is_complete():
            current_spline.update_to_now()
        spline.initialize()
        self.unit.movement_spline = spline
        movement_packet = spline.try_build_movement_packet()
        if movement_behavior:
            movement_behavior.spline = spline
        if movement_packet:
            self.unit.get_map().send_surrounding(movement_packet, self.unit, include_self=self.is_player)

    def flush(self):
        self.reset(clean_behaviors=True)
        for move_type in self.movement_behaviors.keys():
            self.movement_behaviors[move_type] = None
        if not self.unit.is_alive:
            self.stop(force=True)

    def reset(self, clean_behaviors=False):
        self.pause_ooc_timer = 0
        # If currently moving, update the current spline in order to have latest guessed position before flushing.
        spline = self._get_current_spline()
        if spline:
            self.stop(force=True)
        self.unit.movement_spline = None
        self.spline_events.clear()
        if clean_behaviors:
            self._remove_invalid_expired_behaviors()

    def update(self, now, elapsed):
        is_resume = self._handle_ooc_pause(elapsed)

        self._update_spline_events(elapsed)

        if not self._can_move():
            if self._get_current_spline():
                self.stop()
            return

        # Check if we need to remove any movement.
        movements_removed = self._remove_invalid_expired_behaviors()
        # Grab latest, if any.
        current_behavior = self.get_current_behavior()

        if not current_behavior:
            return

        # Resuming or cascaded into a previous movement, reset.
        if is_resume or movements_removed:
            current_behavior.reset()

        current_behavior.update(now, elapsed)

    def set_speed_dirty(self):
        current_behavior = self.get_current_behavior()
        if current_behavior:
            current_behavior.set_speed_dirty()

    def get_waypoint_location(self):
        spline = self._get_current_spline()
        return spline.get_waypoint_location() if spline else self.unit.location

    def try_pause_ooc_movement(self, duration_seconds):
        current_behavior = self.get_current_behavior()
        if not self.unit.in_combat and current_behavior:
            self.pause_ooc_timer = duration_seconds
            self.stop()

    def move_distracted(self, duration_seconds, angle=0):
        self.set_behavior(DistractedMovement(duration_seconds, angle, spline_callback=self.spline_callback))

    def move_chase(self):
        # Evade upon die (leave_combat) should not set a behavior.
        if not self.unit.is_alive or self.movement_behaviors[MoveType.CHASE]:
            return
        self.set_behavior(ChaseMovement(spline_callback=self.spline_callback))

    def move_home(self, waypoints):
        if not self.unit.is_alive or self.movement_behaviors[MoveType.EVADE]:
            return
        self.set_behavior(EvadeMovement(waypoints, self.spline_callback))

    def move_flight(self, waypoints):
        self.set_behavior(FlightMovement(waypoints, self.spline_callback))

    def move_fear(self, duration_seconds, target=None, seek_assist=False):
        current_fear_behavior = self.movement_behaviors.get(MoveType.FEAR, None)
        # Do not allow shorter fear to override a current fear.
        if current_fear_behavior and current_fear_behavior.fear_duration > duration_seconds:
            return
        self.set_behavior(FearMovement(duration_seconds, spline_callback=self.spline_callback,
                                       target=target, seek_assist=seek_assist))

    def move_follow(self, target, dist=2, angle=math.pi / 2):
        self.set_behavior(FollowMovement(spline_callback=self.spline_callback, target=target, dist=dist, angle=angle))

    def move_confused(self, duration_seconds=-1):
        self.set_behavior(ConfusedMovement(spline_callback=self.spline_callback, duration_seconds=duration_seconds))

    def move_automatic_waypoints_from_script(self, command_move_info=None):
        self.set_behavior(WaypointMovement(spline_callback=self.spline_callback, command_move_info=command_move_info))

    def move_to_point(self, location, speed=config.Unit.Defaults.walk_speed, move_options=0):
        # TODO: Handle more move options.
        if move_options:
            if move_options & MoveOptions.MOVE_RUN_MODE:
                speed = config.Unit.Defaults.run_speed
            if move_options & MoveOptions.MOVE_WALK_MODE:
                speed = config.Unit.Defaults.walk_speed

        self.set_behavior(WaypointMovement(spline_callback=self.spline_callback, waypoints=[location], speed=speed,
                                           is_single=True))

    def move_wander(self, use_current_position=False, wandering_distance=0.0):
        self.set_behavior(WanderingMovement(spline_callback=self.spline_callback, is_default=False,
                                            use_current_position=use_current_position,
                                            wandering_distance=wandering_distance))

    def get_move_behavior_by_type(self, move_type) -> Optional[BaseMovement]:
        return self.movement_behaviors.get(move_type, None)

    # TODO: Unused atm, lacking many specific move types from VMaNGOS and some refactoring to our current move behaviors.
    #  For now, attempt to resolve to the closest types in order to trigger some creature ai events.
    def _translate_to_vmangos_move_type(self):
        current_behavior = self.get_current_behavior()
        if current_behavior.move_type == MoveType.IDLE or not current_behavior:
            return [0]  # Idle.
        elif current_behavior.move_type == MoveType.WANDER:
            return [1]  # Random.
        elif current_behavior.move_type == MoveType.WAYPOINTS:
            return [2, 3, 9]  # Waypoint / Cyclic / Point.
        elif current_behavior.move_type == MoveType.CONFUSED:
            return [5]  # Confused.
        elif current_behavior.move_type == MoveType.CHASE:
            return [6]
        elif current_behavior.move_type == MoveType.EVADE:
            return [7]  # Home.
        elif current_behavior.move_type == MoveType.FLIGHT:
            return [8]
        elif current_behavior.move_type == MoveType.FEAR:
            return [10]
        elif current_behavior.move_type == MoveType.DISTRACTED:
            return [11]
        elif current_behavior.move_type == MoveType.GROUP:
            return [2, 15, 17]

    # Instant.
    def stop(self, force=False):
        if not force and not self.unit.is_moving():
            return
        if self.unit.is_sessile():
            return
        current_behavior = self.get_current_behavior()
        # Make sure the current behavior spline does not update an extra tick.
        if current_behavior:
            current_behavior.reset()
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
        if self.unit.is_sessile():
            return

        if movement_behavior.initialize(self.unit):
            self.stop()  # Stop the current behavior if needed.
            self.unit.spell_manager.remove_casts()  # Remove any cast when switching behaviors.
            self.movement_behaviors[movement_behavior.move_type] = movement_behavior
            self._update_active_behavior_type()
            if movement_behavior.is_default:
                self.default_behavior_type = movement_behavior.move_type
        else:
            Logger.warning(f'Failed to initialize movement {movement_behavior.move_type} for unit {self.unit.entry}')

    def unit_is_moving(self):
        if self.is_player and (self.unit.movement_flags & MoveFlags.MOVEFLAG_MOVE_MASK or self.unit.has_moved):
            return True
        spline = self._get_current_spline()
        return True if spline and not spline.is_complete() else False

    def try_build_movement_packet(self):
        spline = self._get_current_spline()
        return spline.try_build_movement_packet() if spline else None

    def add_spline_event(self, spline_event):
        self.spline_events.append(spline_event)

    def add_spline_events(self, events):
        # Prevent events aggregation if someone spam emote events.
        if self.spline_events:
            self.spline_events.clear()
        [self.add_spline_event(event) for event in events]

    def has_spline_events(self):
        return len(self.spline_events) > 0

    def _update_spline_events(self, elapsed):
        if not self.spline_events:
            return

        for idx, spline_event in enumerate(list(self.spline_events)):
            if spline_event.update(elapsed):
                self.spline_events.pop(idx)

    def _handle_ooc_pause(self, elapsed):
        if self.pause_ooc_timer:
            self.pause_ooc_timer = max(0, self.pause_ooc_timer - elapsed)
            if not self.pause_ooc_timer or self.unit.in_combat:
                self.pause_ooc_timer = 0 if self.unit.in_combat else self.pause_ooc_timer
                return True
        return False

    def _remove_invalid_expired_behaviors(self):
        movements_removed = False
        for move_type, behavior in list(self.movement_behaviors.items()):
            if not isinstance(behavior, BaseMovement):
                continue
            if behavior and behavior.can_remove() and not behavior.is_default:
                movements_removed = True
                self._remove_behavior(behavior)
        # Check if we need to fall back to another movement behavior.
        return movements_removed

    def _can_move(self):
        if self.pause_ooc_timer:
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
            if not isinstance(behavior, BaseMovement):
                continue
            self.active_behavior_type = behavior.move_type
            break

    def _remove_behavior(self, movement_behavior):
        self.movement_behaviors[movement_behavior.move_type] = None
        self._update_active_behavior_type()
        movement_behavior.on_removed()

    def _get_current_spline(self):
        current_behavior = self.get_current_behavior()
        if not current_behavior:
            return None
        return current_behavior.spline if current_behavior.spline else None

    def get_current_behavior(self) -> Optional[BaseMovement]:
        if not self.active_behavior_type:
            return None
        movement_behavior = self.movement_behaviors.get(self.active_behavior_type, None)
        return movement_behavior if movement_behavior else None

    def get_current_behavior_name(self):
        if not self.active_behavior_type:
            return 'None'
        return MoveType(self.active_behavior_type).name

    def _get_default_behavior(self):
        if not self.default_behavior_type:
            return None
        movement_behavior = self.movement_behaviors.get(self.default_behavior_type, None)
        return movement_behavior if movement_behavior else None
