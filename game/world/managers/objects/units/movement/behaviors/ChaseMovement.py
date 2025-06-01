import math

from game.world.managers.objects.units.movement.helpers.SplineBuilder import SplineBuilder
from utils.Formulas import UnitFormulas, Distances
from utils.constants.MiscCodes import MoveType
from game.world.managers.objects.units.movement.behaviors.BaseMovement import BaseMovement


class ChaseMovement(BaseMovement):
    def __init__(self, spline_callback):
        super().__init__(move_type=MoveType.CHASE, spline_callback=spline_callback)
        self.unit = None

    # override
    def update(self, now, elapsed):
        if self._can_chase():
            self._chase(self.unit)

        super().update(now, elapsed)

    # TODO: There are some creatures like crabs or murlocs that apparently couldn't swim in earlier versions
    #  but are spawned inside the water at this moment since most spawns come from Vanilla data. These mobs
    #  will currently bug out when you try to engage in combat with them. Also seems like a lot of humanoids
    #  couldn't swim before patch 1.3.0:
    #  World of Warcraft Client Patch 1.3.0 (2005-03-22)
    #   - Most humanoids NPCs have gained the ability to swim.
    #  This might only refer to creatures not having swimming animations.
    def _chase(self, unit):
        # Check if target is player and is online.
        target_is_player = unit.combat_target.is_player()
        if target_is_player and not unit.combat_target.online:
            unit.threat_manager.remove_unit_threat(unit.combat_target)
            return

        target_is_moving = unit.combat_target.is_moving()
        spawn_distance = unit.location.distance(unit.spawn_position)
        target_distance = unit.location.distance(unit.combat_target.location)
        target_to_spawn_distance = unit.combat_target.location.distance(unit.spawn_position)
        combat_distance = UnitFormulas.combat_distance(unit, unit.combat_target)
        evade_distance = Distances.CREATURE_EVADE_DISTANCE
        combat_target = unit.combat_target

        if not combat_target:
            return

        if not unit.is_pet():
            # In 0.5.3, evade mechanic was only based on distance, the correct distance remains unknown.
            # From 0.5.4 patch notes:
            #     "Creature pursuit is now timer based rather than distance based."
            if (spawn_distance > evade_distance or target_distance > evade_distance) \
                    and target_to_spawn_distance > evade_distance:
                unit.threat_manager.remove_unit_threat(combat_target)
                return

            if unit.is_swimming() or combat_target.is_swimming() and not unit.can_swim():
                unit.threat_manager.remove_unit_threat(combat_target)
                return
            elif unit.is_swimming() and not combat_target.is_swimming() and not unit.can_exit_water():
                unit.threat_manager.remove_unit_threat(combat_target)
                return

        # Face the target if necessary.
        if not unit.location.has_in_arc(combat_target.location, math.pi):
            unit.movement_manager.face_target(unit.combat_target)

        # Use less distance if target is moving.
        combat_distance = combat_distance / 1.1 if target_is_moving else combat_distance

        is_within_distance = round(target_distance) <= round(combat_distance)
        # Target is within combat distance, don't move.
        if is_within_distance:
            self.unit.movement_manager.stop()
            return

        final_location = combat_target.location
        # Use direct combat location if target is over water.
        if not combat_target.is_swimming():
            failed, in_place, path = self.unit.get_map().calculate_path(unit.location, final_location)
            if not failed and not in_place:
                final_location = path[0]
            elif in_place:
                return

        speed = self.unit.running_speed
        spline = SplineBuilder.build_normal_spline(unit, points=[final_location], speed=speed)
        self.spline_callback(spline, movement_behavior=self)

    def _can_chase(self):
        return (not self.unit.is_casting() and self.unit.is_alive and self.unit.combat_target
                and self.unit.combat_target.is_alive
                and (True if not self.unit.object_ai else self.unit.object_ai.is_combat_movement_enabled()))

    # override
    def can_remove(self):
        return (not self.unit.combat_target and not self.unit.in_combat) \
            or self.unit.is_evading or not self.unit.is_alive

    # override
    def reset(self):
        if self.spline:
            # Make sure the last known position gets updated.
            self.spline.update_to_now()
            self.spline = None
