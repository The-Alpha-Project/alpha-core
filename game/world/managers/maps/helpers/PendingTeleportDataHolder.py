from dataclasses import dataclass
from game.world.managers.abstractions.Vector import Vector


@dataclass
class PendingTeleportDataHolder:
    recovery_percentage: float
    origin_location: Vector
    origin_map: int
    destination_location: Vector
    destination_map: int
    execute_time: float

    def can_trigger(self, now):
        return now > self.execute_time

    def is_long_teleport(self):
        return self.origin_map != self.destination_map
