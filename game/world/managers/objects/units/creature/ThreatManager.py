import random
from dataclasses import dataclass
from typing import Optional

from game.world.managers.maps.MapManager import MapManager
from game.world.managers.objects.units.UnitManager import UnitManager
from utils.Logger import Logger
from utils.constants.MiscCodes import HighGuid
from utils.constants.ScriptCodes import AttackingTarget
from utils.constants.UnitCodes import CreatureReactStates


@dataclass
class ThreatHolder:
    unit: UnitManager
    total_threat: float


class ThreatManager:
    THREAT_NOT_TO_LEAVE_COMBAT = 1E-4

    def __init__(self, owner: UnitManager, call_for_help_range=0):
        self.owner = owner
        self.holders: dict[int, ThreatHolder] = {}
        self.current_holder: Optional[ThreatHolder] = None
        self._call_for_help_range = call_for_help_range

    def reset(self):
        self.holders.clear()
        self.current_holder = None

    def add_threat(self, source: UnitManager, threat: float, is_call_for_help=False):
        if source is not self.owner:
            source_holder = self.holders.get(source.guid)
            if source_holder:
                new_threat = source_holder.total_threat + threat
                source_holder.total_threat = max(new_threat, 0.0)
            elif threat > 0.0:
                if not is_call_for_help:
                    self._call_for_help(source, threat)
                self.holders[source.guid] = ThreatHolder(source, threat)
                self._update_attackers_collection(source)
            else:
                Logger.warning(f'Passed non positive threat {threat} from {source.guid & ~HighGuid.HIGHGUID_UNIT}')

    def resolve_target(self):
        if any(self.holders):
            return self.get_hostile_target()
        return None

    def get_hostile_target(self) -> Optional[UnitManager]:
        max_threat_holder = self._get_max_threat_holder()

        # Threat target switching.
        if max_threat_holder != self.current_holder:
            if not self.current_holder or self.can_attack_target(self.current_holder.unit) or \
                    self._is_exceeded_current_threat_melee_range(max_threat_holder.total_threat):
                self.current_holder = max_threat_holder

        return None if not self.current_holder else self.current_holder.unit

    def select_attacking_target(self, attacking_target: AttackingTarget) -> Optional[UnitManager]:
        if not any(self.holders):
            return None

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
                    return random.choice(relevant_holders[:-2]).unit if len(relevant_holders) > 1 else None
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

    # Make sure both involved units update their attackers' collection if hostility did not begin from a melee swing.
    def _update_attackers_collection(self, attacker):
        if attacker.guid not in self.owner.attackers:
            self.owner.attackers[attacker.guid] = attacker
        if self.owner.guid not in attacker.attackers:
            attacker.attackers[self.owner.guid] = self.owner

    def _call_for_help(self, source, threat):
        if self._call_for_help_range:
            units = MapManager.get_surrounding_units_by_location(self.owner.location,
                                                                 self.owner.map_,
                                                                 self._call_for_help_range)[0].values()

            helping_units = [unit for unit in units if self.unit_can_assist_help_call(unit, source)]

            for unit in helping_units:
                unit.threat_manager.add_threat(source, threat, is_call_for_help=True)

    # TODO: Missing faction template flags, charmed, pacified.
    def unit_can_assist_help_call(self, unit, source):
        if unit == self.owner:
            return False
        elif unit.is_pet() or unit.is_evading:
            return False
        elif not unit.threat_manager.can_attack_target(source):
            return False
        elif unit.in_combat:
            return False
        elif unit.react_state == CreatureReactStates.REACT_PASSIVE:
            return False
        elif not unit.can_assist_help_calls():
            return False
        return True

    # TODO: Optimize this method?
    def _get_max_threat_holder(self) -> Optional[ThreatHolder]:
        relevant_holders = self._get_sorted_threat_collection()
        return None if not relevant_holders else relevant_holders[-1]

    def _get_sorted_threat_collection(self) -> Optional[list[ThreatHolder]]:
        relevant_holders = []
        for holder in list(self.holders.values()):
            # No reason to keep targets we cannot longer attack.
            if not self.owner.can_attack_target(holder.unit):
                self.current_holder = None if self.current_holder == holder else self.current_holder
                self.holders.pop(holder.unit.guid)
            else:
                relevant_holders.append(holder)

        # Sort by threat.
        relevant_holders.sort(key=lambda h: h.total_threat)
        return relevant_holders

    # TODO Checking pet relation until friendliness can be evaluated properly.
    def can_attack_target(self, unit: UnitManager):
        return self.owner.can_attack_target(unit) and unit != self.owner.summoner

    # TODO Melee/outside of melee range reach
    def _is_exceeded_current_threat_melee_range(self, threat: float):
        current_threat = 0.0 if not self.current_holder else self.current_holder.total_threat
        return threat >= current_threat * 1.1
