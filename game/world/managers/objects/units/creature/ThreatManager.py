import random
from dataclasses import dataclass
from typing import Optional

from game.world.managers.maps.MapManager import MapManager
from game.world.managers.objects.units.UnitManager import UnitManager
from utils.constants.ScriptCodes import AttackingTarget


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

    def select_attacking_target(self, attacking_target) -> Optional[UnitManager]:
        if attacking_target == AttackingTarget.ATTACKING_TARGET_TOPAGGRO:
            return self.get_hostile_target()
        else:
            relevant_holders = self._get_sorted_threat_collection()
            if relevant_holders and len(relevant_holders) > 0:
                if attacking_target == AttackingTarget.ATTACKING_TARGET_BOTTOMAGGRO:
                    return relevant_holders[0].unit
                elif attacking_target == AttackingTarget.ATTACKING_TARGET_RANDOM:
                    return random.choice(relevant_holders).unit
                elif attacking_target == AttackingTarget.ATTACKING_TARGET_RANDOMNOTTOP:
                    return random.choice(relevant_holders[:-2]).unit
                # Farthest or Nearest targets.
                else:
                    surrounding_units = MapManager.get_surrounding_units(self.owner, include_players=True)
                    units_in_range = list(surrounding_units[0].values()) + list(surrounding_units[1].values())
                    units_in_aggro_list = [h.unit for h in relevant_holders if h.unit in units_in_range]
                    if len(units_in_aggro_list) > 0:
                        # Sort found units by distance.
                        units_in_aggro_list.sort(key=lambda player: player.location.distance(self.owner.location))
                        if attacking_target == AttackingTarget.ATTACKING_TARGET_NEAREST:
                            return units_in_aggro_list[0]
                        elif attacking_target == AttackingTarget.ATTACKING_TARGET_FARTHEST:
                            return units_in_aggro_list[-1]
        # No suitable target found.
        return None

    def reset(self):
        self.holders.clear()
        self.current_holder = None
    
    # TODO: Optimize this method?
    def _get_max_threat_holder(self) -> Optional[ThreatHolder]:
        relevant_holders = self._get_sorted_threat_collection()
        return None if not relevant_holders else relevant_holders[-1]

    def _get_sorted_threat_collection(self) -> list[ThreatHolder]:
        relevant_holders = [holder for holder
                            in self.holders.values()
                            if holder.unit.is_alive and not holder.unit.is_evading]
        relevant_holders.sort(key=lambda holder: holder.threat)
        return relevant_holders

    def _get_current_threat(self) -> float:
        return 0 if not self.current_holder else self.current_holder.threat

    def _get_current_target(self) -> Optional[UnitManager]:
        return None if not self.current_holder else self.current_holder.unit
