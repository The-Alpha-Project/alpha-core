import math

from game.world.managers.objects.units.movement.helpers.SplineBuilder import SplineBuilder
from utils.Formulas import UnitFormulas, Distances
from utils.constants.MiscCodes import MoveType
from game.world.managers.objects.units.movement.behaviors.BaseMovement import BaseMovement
from utils.constants.UnitCodes import SplineFlags


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
        self.waypoints = []

    # override
    def update(self, now, elapsed):
        super().update(now, elapsed)

        if self._should_regenerate_path():
            self.waypoints = self._regenerate_path()

        if self._can_chase():
            self.speed_dirty = False
            self._perform_waypoint()
        # Face the target if necessary.
        elif (not self.spline and self.unit.combat_target
              and not self.unit.location.has_in_arc(self.unit.combat_target.location, math.pi)):
            self.unit.movement_manager.face_target(self.unit.combat_target)

    def _perform_waypoint(self):
        # Avoid units trying to turn and face the target as they run.
        if self.unit.current_target:
            self.unit.set_current_target(0)

        waypoint = self._get_waypoint()
        swimming = self.unit.is_swimming()
        speed = self.unit.running_speed if not swimming else self.unit.swim_speed
        spline_flags = SplineFlags.SPLINEFLAG_RUNMODE if not swimming else SplineFlags.SPLINEFLAG_NONE
        spline = SplineBuilder.build_normal_spline(self.unit, points=[waypoint], speed=speed, spline_flags=spline_flags)
        self.spline_callback(spline, movement_behavior=self)

    def _regenerate_path(self):
        combat_target = self.unit.combat_target
        if not combat_target:
            return None

        # Check if target is player and is online.
        target_is_player = combat_target.is_player()
        if target_is_player and not combat_target.online:
            self.unit.threat_manager.remove_unit_threat(combat_target)
            return None

        home_position = self.unit.get_home_position()  # Either spawn_position or tmp_home_position.
        home_distance = self.unit.location.distance(home_position)
        target_distance = self.unit.location.distance(combat_target.location)
        target_to_home_distance = combat_target.location.distance(home_position)
        evade_distance = Distances.CREATURE_EVADE_DISTANCE

        if not combat_target:
            return None

        self_swimming = self.unit.is_swimming()
        target_swimming = combat_target.is_swimming()

        if not self.unit.is_pet():
            # In 0.5.3, evade mechanic was only based on distance, the correct distance remains unknown.
            # From 0.5.4 patch notes:
            #     "Creature pursuit is now timer based rather than distance based."
            if (home_distance > evade_distance or target_distance > evade_distance) \
                    and target_to_home_distance > evade_distance:
                self.unit.threat_manager.remove_unit_threat(combat_target)
                return None

            if (self_swimming or target_swimming) and not self.unit.can_swim():
                self.unit.threat_manager.remove_unit_threat(combat_target)
                return None
            elif self_swimming and not target_swimming and not self.unit.can_exit_water():
                self.unit.threat_manager.remove_unit_threat(combat_target)
                return None

        # Target is within combat distance.
        if self._is_within_combat_distance():
            return None

        final_path = [combat_target.location]
        # Use direct combat location if target is over water.
        if not target_swimming:
            failed, in_place, path = self.unit.get_map().calculate_path(self.unit.location, final_path[0])
            if not failed and not in_place:
                final_path = path
            elif in_place:
                return None

        return final_path

    def _is_within_combat_distance(self, source_vector=None):
        combat_target = self.unit.combat_target
        if not combat_target:
            return False

        combat_distance = UnitFormulas.combat_distance(self.unit, combat_target)
        if combat_target.is_moving():
            # Use less distance if target is moving.
            combat_distance = combat_distance / 1.1

        # From a given point.
        if source_vector:
            return source_vector.distance(combat_target.location) < combat_distance

        #  From self unit to combat target.
        return self.unit.location.distance(combat_target.location) < combat_distance


    def _should_regenerate_path(self):
        combat_target = self.unit.combat_target
        if not combat_target:
            return False
        # Already in close combat.
        if self._is_within_combat_distance():
            return False
        if self.speed_dirty or not self.waypoints:
            return True
        if combat_target.is_moving():
            return True
        # The last known waypoint is beyond combat distance, regenerate.
        return not self._is_within_combat_distance(source_vector=self.waypoints[-1])

    def _can_chase(self):
        if not self.waypoints:
            return False
        if not self.unit.combat_target:
            return False
        if not self.unit.combat_target.is_alive:
            return False
        if self.speed_dirty:
            return True
        if self.spline:
            return False
        return True if not self.unit.object_ai else self.unit.object_ai.is_combat_movement_enabled()

    def on_new_position(self, new_position, waypoint_completed, remaining_waypoints):
        super().on_new_position(new_position, waypoint_completed, remaining_waypoints)

        combat_target = self.unit.combat_target
        if not combat_target:
            return

        if not self._is_within_combat_distance():
            return

        # Already within combat distance, stop.
        self.waypoints.clear()
        self.unit.movement_manager.stop()

        # Restore current target.
        if not self.unit.current_target:
            self.unit.set_current_target(combat_target.guid)

    # override
    def on_removed(self):
        self.waypoints = None

    # override
    def can_remove(self):
        return (not self.unit.combat_target and not self.unit.in_combat) \
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
