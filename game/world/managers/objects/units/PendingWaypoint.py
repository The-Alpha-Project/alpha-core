from typing import NamedTuple

from game.world.managers.abstractions.Vector import Vector


class PendingWaypoint(NamedTuple):
    id_: int
    expected_timestamp: int
    location: Vector
