import random
from dataclasses import dataclass
from typing import Optional

from game.world.managers.maps.MapManager import MapManager
from game.world.managers.objects.units.UnitManager import UnitManager
from utils.Logger import Logger
from utils.constants.MiscCodes import HighGuid, ObjectTypeIds
from utils.constants.ScriptCodes import AttackingTarget
from utils.constants.UnitCodes import CreatureReactStates


@dataclass
class ThreatHolder:
    unit: UnitManager
    total_raw_threat: float
    threat_mod: float

    def get_total_threat(self):
        return self.total_raw_threat + self.threat_mod


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

    def update_unit_threat_modifier(self, unit_mgr, remove=False):
        max_holder = self._get_max_threat_holder()
        threat = 0  # Modifier does not affect current raw threat.
        threat_mod = max_holder.total_raw_threat if max_holder and not remove else 0
        holder = self.holders.get(unit_mgr.guid)
        # Add or update threat and modifier.
        if not remove:
            self.add_threat(unit_mgr, threat, threat_mod)
        # Remove modifier if player exist as a threat holder.
        elif holder:
            holder.threat_mod = threat_mod

    def remove_unit_threat(self, unit_guid):
        if unit_guid in self.holders:
            # Reset current holder if needed.
            if self.current_holder == self.holders[unit_guid]:
                self.current_holder = None
            # Pop unit from threat holders.
            self.holders.pop(unit_guid)

    def add_threat(self, source: UnitManager, threat: float, threat_mod=0, is_call_for_help=False):
        if not self.owner.is_alive or not self.owner.is_spawned or not source.is_alive:
            return

        if source is not self.owner:
            source_holder = self.holders.get(source.guid)
            if source_holder:
                new_threat = source_holder.total_raw_threat + threat
                source_holder.total_raw_threat = max(new_threat, 0.0)
                source_holder.threat_mod = threat_mod
            elif threat >= 0.0:
                if not is_call_for_help:
                    self._call_for_help(source, threat)
                self.holders[source.guid] = ThreatHolder(source, threat, threat_mod)
                self._update_attackers_collection(source)
            else:
                Logger.warning(f'Passed non positive threat {threat} from {source.guid & ~HighGuid.HIGHGUID_UNIT}')

    def resolve_target(self):
        if len(self.holders) > 0:
            return self.get_hostile_target()
        return None

    def get_hostile_target(self) -> Optional[UnitManager]:
        max_threat_holder = self._get_max_threat_holder()

        # Threat target switching.
        if max_threat_holder != self.current_holder:
            if not self.current_holder or self.owner.can_attack_target(self.current_holder.unit) or \
                    self._is_exceeded_current_threat_melee_range(max_threat_holder.get_total_threat()):
                self.current_holder = max_threat_holder

        return None if not self.current_holder else self.current_holder.unit

    def select_attacking_target(self, attacking_target: AttackingTarget) -> Optional[UnitManager]:
        if len(self.holders) == 0:
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
                    # Only top available, return None.
                    if len(relevant_holders) == 1:
                        return None
                    # Random, not top.
                    return random.choice(relevant_holders[:-1]).unit
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
        elif not unit.threat_manager:  # TODO: Might be better to just prevent threat manager to be None at any point.
            return False
        elif not unit.can_attack_target(source) or not unit.is_hostile_to(source):
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
        relevant_holders.sort(key=lambda h: h.get_total_threat())
        return relevant_holders

    # TODO Melee/outside of melee range reach
    def _is_exceeded_current_threat_melee_range(self, threat: float):
        current_threat = 0.0 if not self.current_holder else self.current_holder.get_total_threat()
        return threat >= current_threat * 1.1
