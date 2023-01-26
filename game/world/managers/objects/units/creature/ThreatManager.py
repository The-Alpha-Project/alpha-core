import random
from dataclasses import dataclass
from typing import Optional

from game.world.managers.maps.MapManager import MapManager
from game.world.managers.objects.units.UnitManager import UnitManager
from utils.Logger import Logger
from utils.constants.MiscCodes import ObjectTypeIds, ObjectTypeFlags
from utils.constants.ScriptCodes import AttackingTarget
from utils.constants.UnitCodes import CreatureReactStates, UnitStates, UnitFlags


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

    def has_aggro_from(self, target):
        return target.guid in self.holders

    def has_aggro(self):
        return self.get_targets_count() > 0

    def get_targets_count(self):
        return len(self.holders)

    def get_threat_holder_units(self):
        return [holder.unit for holder in self.holders.values()]

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

    def reset(self):
        # Remove threat between self and attackers.
        for unit in self.get_threat_holder_units():
            if not unit.threat_manager.has_aggro_from(self.owner):
                continue
            self.remove_unit_threat(unit)
            unit.threat_manager.remove_unit_threat(self.owner)

        self.holders.clear()
        self.current_holder = None

    def remove_unit_threat(self, unit):
        if unit.guid in self.holders:
            # Reset current holder if needed.
            if self.current_holder == self.holders[unit.guid]:
                self.current_holder = None
            # Pop unit from threat holders.
            self.holders.pop(unit.guid)
            # Remove from self casts if needed.
            if not unit.is_alive:
                self.owner.spell_manager.remove_unit_from_all_cast_targets(unit.guid)
            # Remove from unit casts if needed.
            if not self.owner.is_alive:
                unit.spell_manager.remove_unit_from_all_cast_targets(self.owner.guid)
            if unit.threat_manager.has_aggro_from(self.owner):
                unit.threat_manager.remove_unit_threat(self.owner)

        if not self.has_aggro():
            self.owner.leave_combat()

    def add_threat(self, source, threat: float = THREAT_NOT_TO_LEAVE_COMBAT, threat_mod: int = 0,
                   is_call_for_help: bool = False):
        # Only players/units.
        if not source.get_type_mask() & ObjectTypeFlags.TYPE_UNIT:
            return False

        if not self.owner.is_alive or not self.owner.is_spawned or not source.is_alive:
            return False

        # If the threat comes from a pet, owner should be added to this unit threat list.
        charmer_or_summoner = source.get_charmer_or_summoner()
        if charmer_or_summoner and not self.has_aggro_from(charmer_or_summoner):
            # If the charmer/summoner is a player, set him in combat as well.
            if charmer_or_summoner.get_type_id() == ObjectTypeIds.ID_PLAYER:
                charmer_or_summoner.attack(self.owner)
            self.add_threat(charmer_or_summoner)

        if threat < 0.0:
            Logger.warning(f'Passed non positive threat {threat} from {source.get_low_guid()}')

        if source is not self.owner:
            self.owner.enter_combat()
            source_holder = self.holders.get(source.guid)
            # Update existent holder.
            if source_holder:
                new_threat = source_holder.total_raw_threat + threat
                source_holder.total_raw_threat = max(new_threat, 0.0)
                source_holder.threat_mod = threat_mod
                return True
            # New holder.
            elif threat >= 0.0:
                if not is_call_for_help:
                    self._call_for_help(source, threat)
                self.holders[source.guid] = ThreatHolder(source, threat, threat_mod)
                # If source is a player, force it to be linked to the other unit through threat.
                source_is_player = source.get_type_id() == ObjectTypeIds.ID_PLAYER
                if source_is_player and not source.threat_manager.has_aggro_from(self.owner):
                    source.threat_manager.add_threat(self.owner)
                return True

        return False

    def resolve_target(self):
        if not self.can_resolve_target():
            return None
        if len(self.holders) > 0:
            return self.get_hostile_target()
        return None

    def get_hostile_target(self) -> Optional[UnitManager]:
        max_threat_holder = self._get_max_threat_holder()
        if not max_threat_holder:
            return None

        # Threat target switching.
        if max_threat_holder != self.current_holder:
            if not self.current_holder or self.owner.can_attack_target(self.current_holder.unit) or \
                    self._is_exceeded_current_threat_melee_range(max_threat_holder.get_total_threat()):
                self.current_holder = max_threat_holder

        return None if not self.current_holder else self.current_holder.unit

    def select_attacking_target(self, attacking_target: AttackingTarget) -> Optional[UnitManager]:
        if len(self.holders) == 0:
            return None

        relevant_holders = self._get_sorted_threat_collection()
        if not relevant_holders:
            return None

        if attacking_target == AttackingTarget.ATTACKING_TARGET_TOPAGGRO:
            return relevant_holders[-1].unit
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

    # Creatures only.
    def _call_for_help(self, source, threat):
        if self._call_for_help_range:
            units = MapManager.get_surrounding_units_by_location(self.owner.location,
                                                                 self.owner.map_id,
                                                                 self.owner.instance_id,
                                                                 self._call_for_help_range)[0].values()

            helping_units = [unit for unit in units if self.unit_can_assist_help_call(unit, source)]

            for unit in helping_units:
                unit.threat_manager.add_threat(source, threat, is_call_for_help=True)

    def can_resolve_target(self):
        if self.owner.unit_state & UnitStates.STUNNED:
            return False
        elif self.owner.unit_flags & UnitFlags.UNIT_FLAG_FLEEING:
            return False
        elif self.owner.unit_flags & UnitFlags.UNIT_FLAG_POSSESSED:
            return False
        elif self.owner.unit_flags & UnitFlags.UNIT_FLAG_PACIFIED:
            return False

        return True

    # 0.5.3 has no faction template flags.
    def unit_can_assist_help_call(self, unit, source):
        if unit == self.owner:
            return False
        elif unit.is_pet() or unit.is_evading:
            return False
        elif unit.unit_flags & UnitFlags.UNIT_FLAG_PACIFIED:
            return False
        elif unit.unit_state & UnitStates.STUNNED:
            return False
        elif unit.unit_flags & UnitFlags.UNIT_FLAG_FLEEING:
            return False
        elif self.owner.faction != unit.faction and self.owner.is_hostile_to(unit):
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
            if not holder.unit.is_alive:
                continue
            if self.owner.can_attack_target(holder.unit) or holder.unit.is_hostile_to(self.owner):
                relevant_holders.append(holder)

        # Sort by threat.
        relevant_holders.sort(key=lambda h: h.get_total_threat())
        return relevant_holders

    # TODO Melee/outside of melee range reach
    def _is_exceeded_current_threat_melee_range(self, threat: float):
        current_threat = 0.0 if not self.current_holder else self.current_holder.get_total_threat()
        return threat >= current_threat * 1.1
