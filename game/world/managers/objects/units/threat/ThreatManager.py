from operator import attrgetter
from typing import Dict, NamedTuple, Optional

from game.world.managers.objects.units.UnitManager import UnitManager


class ThreatHolder(NamedTuple):
    unit: UnitManager
    threat: float

    def plus_threat(self, threat):
        return ThreatHolder(self.unit, self.threat + threat)


class ThreatManager:
    def __init__(self,
                 owner: UnitManager):
        self.owner = owner
        self.threats: Dict[int, ThreatHolder] = {}

    def add_threat(self, victim: UnitManager, threat: float):
        if victim != self:
            holder = self.threats[victim.guid]
            if holder:
                self.threats[victim.guid] = holder.plus_threat(threat)
            else:
                self.threats[victim.guid] = ThreatHolder(victim, threat)

    def get_hostile_target(self) -> Optional[UnitManager]:
        holders = list(self.threats.values())
        holders.sort(key=attrgetter("threat"))
        return holders[-1].unit
