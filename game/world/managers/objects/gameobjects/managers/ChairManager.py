from math import pi, cos, sin

from game.world.managers.abstractions.Vector import Vector
from game.world.managers.objects.gameobjects.GameObjectManager import GameObjectManager
from game.world.managers.objects.units.movement.helpers.Spline import Spline
from utils.ConfigManager import config
from utils.constants.UnitCodes import StandState, SplineFlags, SplineType


class ChairManager(GameObjectManager):

    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        self.slots = 0
        self.height = 0

    # override
    def initialize_from_gameobject_template(self, gobject_template):
        super().initialize_from_gameobject_template(gobject_template)
        self.slots = self.get_data_field(0, int)
        self.height = self.get_data_field(1, int)

    # override
    def use(self, unit=None, target=None, from_script=False):
        if self.slots:
            target = self._get_target_location(unit)
            if config.World.Gameplay.use_spline_for_chairs:
                self._move_to_chair_by_spline(unit, target)
            else:
                unit.teleport(unit.map_id, target)
            unit.set_stand_state(StandState.UNIT_SITTINGCHAIRLOW.value + self.height)

        super().use(unit, target, from_script)

    def _get_target_location(self, unit, lowest_distance=90.0):
        x_lowest = self.location.x
        y_lowest = self.location.y

        orthogonal_orientation = self.location.o + pi * 0.5
        for x in range(self.slots):
            relative_distance = (self.current_scale * x) - (self.current_scale * (self.slots - 1) / 2.0)
            x_i = self.location.x + relative_distance * cos(orthogonal_orientation)
            y_i = self.location.y + relative_distance * sin(orthogonal_orientation)

            unit_slot_distance = unit.location.distance(Vector(x_i, y_i, unit.location.z))
            if unit_slot_distance <= lowest_distance:
                lowest_distance = unit_slot_distance
                x_lowest = x_i
                y_lowest = y_i

        return Vector(x_lowest, y_lowest, self.location.z, self.location.o)

    def _move_to_chair_by_spline(self, unit, target):
        speed = max(unit.running_speed * 20, 1000.0)
        spline = Spline(
            unit=unit,
            spline_type=SplineType.SPLINE_TYPE_FACING_ANGLE,
            spline_flags=(
                    SplineFlags.SPLINEFLAG_FACING
                    | SplineFlags.SPLINEFLAG_FLYING
                    | SplineFlags.SPLINEFLAG_RUNMODE
            ),
            facing=target.o,
            speed=speed,
            points=[target],
        )
        unit.movement_manager.stop(force=True)
        unit.movement_manager.spline_callback(spline)
