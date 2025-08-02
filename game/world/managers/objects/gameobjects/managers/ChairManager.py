from math import pi, cos, sin

from game.world.managers.abstractions.Vector import Vector
from game.world.managers.objects.gameobjects.GameObjectManager import GameObjectManager
from utils.constants.UnitCodes import StandState


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
        lowest_distance = 90.0
        x_lowest = self.location.x
        y_lowest = self.location.y

        if self.slots:
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

            unit.teleport(unit.map_id, Vector(x_lowest, y_lowest, self.location.z, self.location.o))
            unit.set_stand_state(StandState.UNIT_SITTINGCHAIRLOW.value + self.height)

        super().use(unit, target, from_script)
