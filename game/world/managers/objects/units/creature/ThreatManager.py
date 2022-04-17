from dataclasses import dataclass
from typing import Optional

from game.world.managers.objects.units.UnitManager import UnitManager


@dataclass
class ThreatHolder:
    unit: UnitManager
    threat: float


class ThreatManager:
    def __init__(self,
                 owner: UnitManager):
        self.owner = owner
        self.holders: dict[int, ThreatHolder] = {}
        self.current_holder: Optional[ThreatHolder] = None

    def add_threat(self, source: UnitManager, threat: float):
        if source != self:
            source_holder = self.holders.get(source.guid)
            if source_holder:
                source_holder.threat += threat
            else:
                self.holders[source.guid] = ThreatHolder(source, threat)

    def get_hostile_target(self) -> Optional[UnitManager]:
        max_threat_holder = self._get_max_threat_holder()

        if max_threat_holder:
            # TODO Meele/outside of meele range reach
            exceed_meele_range = max_threat_holder.threat >= self._get_current_threat() * 1.1
            if exceed_meele_range:
                self.current_holder = max_threat_holder

        return self._get_current_target()

    def reset(self):
        self.holders.clear()
        self.current_holder = None

    # TODO: Optimize this method?
    def _get_max_threat_holder(self) -> Optional[ThreatHolder]:
        relevant_holders = [holder for holder
                            in self.holders.values()
                            if holder.unit.is_alive and not holder.unit.is_evading]
        relevant_holders.sort(key=lambda holder: holder.threat)

        return None if not relevant_holders else relevant_holders[-1]

    def _get_current_threat(self) -> float:
        return 0 if not self.current_holder else self.current_holder.threat

    def _get_current_target(self) -> Optional[UnitManager]:
        return None if not self.current_holder else self.current_holder.unit
