from dataclasses import dataclass
from game.world.managers.abstractions.Vector import Vector


@dataclass
class ResurrectionRequestDataHolder:
    resuscitator_guid: int
    recovery_percentage: float
    resurrect_location: Vector
    resurrect_map: int
