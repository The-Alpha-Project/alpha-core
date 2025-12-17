import random
import time
from dataclasses import dataclass
from typing import Optional

from game.world.managers.objects.units.UnitManager import UnitManager
from game.world.managers.objects.units.player.StatManager import UnitStats
from utils.ConfigManager import config
from utils.constants.ScriptCodes import AttackingTarget
from utils.constants.UnitCodes import CreatureReactStates, UnitStates, UnitFlags


@dataclass
class ThreatHolder:
    unit: UnitManager
    total_raw_threat: float
    threat_mod: float
    time_added: float

    def get_total_threat(self):
        return self.total_raw_threat + self.threat_mod


class ThreatManager:
    THREAT_NOT_TO_LEAVE_COMBAT = 1E-4

    def __init__(self, owner: UnitManager, call_for_help_range=0):
        self.unit = owner
        self.holders: dict[int, ThreatHolder] = {}
        self.current_holder: Optional[ThreatHolder] = None
        self._call_for_help_range = call_for_help_range

    def has_aggro_from(self, target):
        return target.guid in self.holders

    def has_aggro(self):
        return bool(self.holders)

    def get_targets_count(self):
        return len(self.holders)

    def get_threat_holder_units(self):
        return [holder.unit for holder in list(self.holders.values())]

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

    def modify_thread_percent(self, unit_mgr, percent):
        holder = self.holders.get(unit_mgr.guid)
        if not holder:
            return

        current_threat = holder.get_total_threat()
        if not current_threat:
            return

        threat = -current_threat if percent == -100 else current_threat * percent / 100.0
        self.add_threat(unit_mgr, threat)

    def reset(self):
        # Remove threat between self and attackers.
        for unit in self.get_threat_holder_units():
            self.remove_unit_threat(unit)

        self.holders.clear()
        self.current_holder = None

    def remove_unit_threat(self, unit):
        had_aggro = self.has_aggro()

        if unit.guid in self.holders:
            duel_arbiter = self.unit.get_duel_arbiter()
            from_duel = duel_arbiter and duel_arbiter.is_unit_involved(unit)
            # Reset current holder if needed.
            if self.current_holder == self.holders[unit.guid]:
                self.current_holder = None
            # Pop unit from threat holders.
            self.holders.pop(unit.guid)
            # Remove from self casts if needed.
            if not unit.is_alive or from_duel or unit.unit_state & UnitStates.SANCTUARY:
                self.unit.spell_manager.remove_unit_from_all_cast_targets(unit.guid)
                if from_duel:
                    self.unit.aura_manager.remove_harmful_auras_by_caster(unit.guid)
            # Remove from unit casts if needed.
            if not self.unit.is_alive or from_duel or self.unit.unit_state & UnitStates.SANCTUARY:
                unit.spell_manager.remove_unit_from_all_cast_targets(self.unit.guid)
                if from_duel:
                    unit.aura_manager.remove_harmful_auras_by_caster(self.unit.guid)
            # Remove from unit aggro table if needed.
            if unit.threat_manager.has_aggro_from(self.unit):
                unit.threat_manager.remove_unit_threat(self.unit)

        if had_aggro and not self.has_aggro():
            self.unit.leave_combat()

    def add_threat(self, source, threat: float = THREAT_NOT_TO_LEAVE_COMBAT, threat_mod: int = 0,
                   is_call_for_help: bool = False):
        # Only players/units.
        if not source.is_unit(by_mask=True):
            return

        if not self.unit.is_alive or not self.unit.is_spawned or not source.is_alive:
            return

        if self.has_aggro_from(source) and threat == ThreatManager.THREAT_NOT_TO_LEAVE_COMBAT:
            return

        threat = self._calculate_threat_for_self(threat, attacker=source)

        # Notify pet that owner has been attacked.
        for pet_or_guardian in self.unit.pet_manager.get_pet_and_guardians():
            proximity_aggro = ThreatManager.THREAT_NOT_TO_LEAVE_COMBAT == threat
            pet_or_guardian.object_ai.owner_attacked_by(source, proximity_aggro)

        if source is not self.unit:
            self.unit.enter_combat(source)
            source_holder = self.holders.get(source.guid)
            # Update existent holder.
            if source_holder:
                new_threat = source_holder.total_raw_threat + threat
                source_holder.total_raw_threat = max(new_threat, 0.0)
                if threat_mod:
                    source_holder.threat_mod = threat_mod
            # New holder.
            elif threat >= 0.0:
                if not is_call_for_help:
                    self.call_for_help(source, threat)
                self.holders[source.guid] = ThreatHolder(source, threat, threat_mod, time.time())
                # Force both units to be linked through threat.
                if not source.threat_manager.has_aggro_from(self.unit):
                    source.threat_manager.add_threat(self.unit)

        # If the threat comes from a pet, owner should be added to this unit threat list.
        charmer_or_summoner = source.get_charmer_or_summoner()
        if charmer_or_summoner and not self.has_aggro_from(charmer_or_summoner):
            # Set pet owner in combat as well.
            self.add_threat(charmer_or_summoner)

    def get_hostile_target(self) -> Optional[UnitManager]:
        if not self.can_resolve_target():
            return None

        threat_holder = self._get_max_threat_holder()
        if not threat_holder:
            return None

        # Threat target switching.
        if threat_holder != self.current_holder:
            if not self.current_holder or self._is_exceeded_current_threat_melee_range(threat_holder.get_total_threat()):
                self.current_holder = threat_holder

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
            surrounding_units = self.unit.get_map().get_surrounding_units(self.unit, include_players=True)
            units_in_range = list(surrounding_units[0].values()) + list(surrounding_units[1].values())
            units_in_aggro_list = [h.unit for h in relevant_holders if h.unit in units_in_range]
            if len(units_in_aggro_list) > 0:
                # Sort found units by distance.
                units_in_aggro_list.sort(key=lambda player: player.location.distance(self.unit.location))
                if attacking_target == AttackingTarget.ATTACKING_TARGET_NEAREST:
                    return units_in_aggro_list[0]
                elif attacking_target == AttackingTarget.ATTACKING_TARGET_FARTHEST:
                    return units_in_aggro_list[-1]

        # No suitable target found.
        return None

    # Creatures only.
    def call_for_help(self, source, threat=THREAT_NOT_TO_LEAVE_COMBAT, radius=0):
        if not self._call_for_help_range and not radius:
            return

        # Until 0.5.4, creatures didn't call for help when fleeing, make it configurable.
        if self.unit.unit_flags & UnitFlags.UNIT_FLAG_FLEEING and not config.World.Gameplay.enable_call_for_help:
            return

        if not radius:
            radius = self._call_for_help_range

        units = self.unit.get_map().get_surrounding_units_by_location(self.unit.location, self.unit.map_id,
                                                                      self.unit.instance_id,
                                                                      radius)[0].values()

        helping_units = [unit for unit in units if unit.threat_manager.unit_can_assist_help_call(self.unit, source)]
        [unit.threat_manager.add_threat(source, threat, is_call_for_help=True) for unit in helping_units]

    def can_resolve_target(self):
        if not self.unit.is_alive:
            return False
        if not self.unit.is_pet() and self.unit.is_evading:
            return False
        if self.unit.unit_state & UnitStates.STUNNED:
            return False
        if self.unit.unit_state & UnitStates.CONFUSED:
            return False
        elif self.unit.unit_flags & UnitFlags.UNIT_FLAG_FLEEING:
            return False
        elif self.unit.unit_flags & UnitFlags.UNIT_FLAG_POSSESSED:
            return False
        elif self.unit.unit_flags & UnitFlags.UNIT_FLAG_PACIFIED:
            return False

        return True

    # 0.5.3 has no faction template flags.
    def unit_can_assist_help_call(self, caller_unit, source):
        if caller_unit == self.unit:
            return False
        elif self.unit.is_pet() or caller_unit.is_pet() or self.unit.is_evading:
            return False
        elif self.unit.unit_flags & UnitFlags.UNIT_FLAG_PACIFIED:
            return False
        elif self.unit.unit_state & UnitStates.STUNNED:
            return False
        elif self.unit.unit_state & UnitStates.CONFUSED:
            return False
        elif self.unit.unit_flags & UnitFlags.UNIT_FLAG_FLEEING:
            return False
        elif self.unit.faction != caller_unit.faction and self.unit.is_hostile_to(caller_unit):
            return False
        elif not self.unit.can_attack_target(source) or not self.unit.is_hostile_to(source):
            return False
        elif self.unit.in_combat:
            return False
        elif (self.unit.get_creature_family() != caller_unit.get_creature_family()
              and not self.unit.get_map().is_dungeon()):
            return False
        elif not self.unit.get_map().los_check(self.unit.get_ray_position(), caller_unit.get_ray_position()):
            return False

        from game.world.managers.objects.units.creature.CreatureManager import CreatureManager
        if isinstance(self.unit, CreatureManager):
            if self.unit.get_react_state() == CreatureReactStates.REACT_PASSIVE:
                return False
            elif not self.unit.can_assist_help_calls():
                return False

        return True

    # noinspection PyMethodMayBeStatic
    def _calculate_threat_for_self(self, threat, attacker):
        if not threat or threat == ThreatManager.THREAT_NOT_TO_LEAVE_COMBAT:
            return threat
        threat_mod = attacker.stat_manager.get_aura_stat_bonus(UnitStats.THREAT_GENERATION, percentual=True)
        if not threat_mod:
            return threat
        return threat * threat_mod

    def _get_max_threat_holder(self) -> Optional[ThreatHolder]:
        relevant_threat_holders = self._get_sorted_threat_collection()
        if not relevant_threat_holders:
            return None
        return relevant_threat_holders[0]

    def _get_sorted_threat_collection(self) -> Optional[list[ThreatHolder]]:
        relevant_holders = []
        if not self.holders:
            return relevant_holders

        # Sort by threat and time added, to avoid unstable sorting when more than 1 unit have the same threat.
        return sorted(self._resolve_holders_list(), key=lambda h: (h.get_total_threat(), -h.time_added), reverse=True)

    def _resolve_holders_list(self):
        return [holder for holder in list(self.holders.values()) if self._can_resolve_holder(holder)]

    def _can_resolve_holder(self, holder):
        if not holder.unit.is_alive:
            return False
        can_attack_target = self.unit.can_attack_target(holder.unit)
        if not can_attack_target:
            return False
        if not self.unit.is_hostile_to(holder.unit) and not can_attack_target:
            return False
        return True

    # TODO Melee/outside of melee range reach. What does this mean?
    def _is_exceeded_current_threat_melee_range(self, threat: float):
        current_threat = 0.0 if not self.current_holder else self.current_holder.get_total_threat()
        return threat >= current_threat * 1.1
