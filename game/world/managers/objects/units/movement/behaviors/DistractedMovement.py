import time
from utils.constants.MiscCodes import MoveType, ObjectTypeIds
from game.world.managers.objects.units.movement.behaviors.BaseMovement import BaseMovement
from utils.constants.UnitCodes import UnitStates


# Distracted works alongside stunned, meaning splines are not updated, therefor we set state upon initialization
#  and remove upon behavior removal.
class DistractedMovement(BaseMovement):
    def __init__(self, wait_time_secs, angle, spline_callback):
        super().__init__(move_type=MoveType.DISTRACTED, spline_callback=spline_callback)
        self.unit = None
        self.expected_timestamp = time.time() + wait_time_secs
        self.angle = angle

    # override
    def initialize(self, unit):
        super().initialize(unit)
        self.unit.unit_state |= UnitStates.DISTRACTED
        self.unit.movement_manager.face_angle(self.angle)
        return True

    # override
    def on_removed(self):
        self.unit.unit_state &= ~UnitStates.DISTRACTED
        if self.unit.get_type_id() == ObjectTypeIds.ID_UNIT and not self.unit.has_wander_type():
            angle = self.unit.location.get_angle_towards_vector(self.unit.spawn_position)
            self.unit.movement_manager.face_angle(angle)

    # override
    def can_remove(self):
        return self.unit.is_alive or self.unit.in_combat or time.time() >= self.expected_timestamp
