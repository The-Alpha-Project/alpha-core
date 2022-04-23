from dataclasses import dataclass
from typing import Optional

from game.world.managers.objects.units.UnitManager import UnitManager


@dataclass
class ThreatHolder:
    unit: UnitManager
    total_threat: float


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
                new_threat = source_holder.total_threat + threat
                if new_threat > 0.0:
                    source_holder.total_threat = new_threat
            elif threat > 0.0:
                self.holders[source.guid] = ThreatHolder(source, threat)

    def get_hostile_target(self) -> Optional[UnitManager]:
        max_threat_holder = self._get_max_threat_holder()

        if max_threat_holder:
            if not self.current_holder or \
                    not ThreatManager._is_dangerous(self.current_holder.unit) or \
                    self._is_exceeded_current_threat_melee_range(max_threat_holder.total_threat):
                self.current_holder = max_threat_holder

        return None if not self.current_holder else self.current_holder.unit

    def reset(self):
        self.holders.clear()
        self.current_holder = None

    # TODO: Optimize this method?
    def _get_max_threat_holder(self) -> Optional[ThreatHolder]:
        relevant_holders = [holder for holder
                            in self.holders.values()
                            if ThreatManager._is_dangerous(holder.unit)]
        relevant_holders.sort(key=lambda holder: holder.total_threat)

        return None if not relevant_holders else relevant_holders[-1]

    @staticmethod
    def _is_dangerous(unit: UnitManager):
        return unit.is_alive and not unit.is_evading

    # TODO Melee/outside of melee range reach
    def _is_exceeded_current_threat_melee_range(self, threat: float):
        current_threat = 0.0 if not self.current_holder else self.current_holder.total_threat
        return threat >= current_threat * 1.1
