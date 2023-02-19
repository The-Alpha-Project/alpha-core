import math

from game.world.managers.maps.MapManager import MapManager
from game.world.managers.objects.units.movement.SplineBuilder import SplineBuilder
from utils.Formulas import UnitFormulas, Distances
from utils.Logger import Logger
from utils.constants.MiscCodes import MoveType, ObjectTypeIds
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
        target_is_player = unit.combat_target.get_type_id() == ObjectTypeIds.ID_PLAYER
        if target_is_player and not unit.combat_target.online:
            unit.threat_manager.remove_unit_threat(unit.combat_target)
            return

        spawn_distance = unit.location.distance(unit.spawn_position)
        target_distance = unit.location.distance(unit.combat_target.location)
        target_to_spawn_distance = unit.combat_target.location.distance(unit.spawn_position)
        combat_position_distance = UnitFormulas.combat_distance(unit, unit.combat_target)
        target_under_water = unit.combat_target.is_under_water()
        evade_distance = Distances.CREATURE_EVADE_DISTANCE

        if not unit.is_pet():
            # In 0.5.3, evade mechanic was only based on distance, the correct distance remains unknown.
            # From 0.5.4 patch notes:
            #     "Creature pursuit is now timer based rather than distance based."
            if (spawn_distance > evade_distance or target_distance > evade_distance) \
                    and target_to_spawn_distance > evade_distance:
                unit.threat_manager.remove_unit_threat(unit.combat_target)
                return

            if unit.is_under_water():
                if not unit.can_swim():
                    unit.threat_manager.remove_unit_threat(unit.combat_target)
                    return
                if not unit.can_exit_water() and not target_under_water:
                    unit.threat_manager.remove_unit_threat(unit.combat_target)
                    return

        # If this creature is not facing the attacker, update its orientation.
        if not unit.location.has_in_arc(unit.combat_target.location, math.pi):
            unit.movement_manager.face_target(unit.combat_target)

        combat_location = unit.combat_target.location.get_point_in_between(combat_position_distance,
                                                                           vector=unit.location)
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
                Logger.warning(f'Unable to find path, map {unit.map_id} loc {unit.location} end {combat_location}')

        speed = self.unit.running_speed
        spline = SplineBuilder.build_normal_spline(unit, points=[combat_location], speed=speed)
        self.spline_callback(spline, movement_behavior=self)

    def _can_chase(self):
        return self.unit.is_alive and self.unit.combat_target

    def can_remove(self):
        return not self.unit.combat_target or self.unit.is_evading or not self.unit.is_alive
