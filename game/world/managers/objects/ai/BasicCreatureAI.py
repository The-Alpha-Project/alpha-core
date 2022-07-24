from __future__ import annotations

from typing import TYPE_CHECKING, Optional

from game.world.managers.objects.ai.CreatureAI import CreatureAI
from utils.constants.CustomCodes import Permits
from utils.constants.MiscCodes import ObjectTypeIds
from utils.constants.UnitCodes import CreatureReactStates, AIReactionStates

if TYPE_CHECKING:
    from game.world.managers.objects.units.creature.CreatureManager import CreatureManager


class BasicCreatureAI(CreatureAI):
    def __init__(self, creature: Optional[CreatureManager]):
        super().__init__(creature)
        self.can_summon_guards = creature.can_summon_guards() if creature else False

    # override
    def update_ai(self, elapsed):
        if not self.creature or not self.creature.combat_target:
            return

        if self.has_spell_list():
            self.update_spell_list(elapsed)

        self.do_melee_attack_if_ready()

    # override
    def permissible(self, creature):
        return Permits.PERMIT_BASE_NORMAL

    # override
    def movement_inform(self, move_type=None, data=None):
        if self._is_ready_for_new_attack():
            max_distance = self.creature.creature_template.detection_range
            aggro_players = self.creature.known_players
            for guid, victim in aggro_players.items():
                distance = victim.location.distance(self.creature.location)
                if self.creature.can_attack_target(victim) and distance <= max_distance:
                    if self._start_proximity_aggro_attack(victim, target_is_player=True):
                        break

    # override
    def move_in_line_of_sight(self, unit):
        if self._is_ready_for_new_attack() and self.creature.can_attack_target(unit):
            target_is_player = unit.get_type_id() == ObjectTypeIds.ID_PLAYER
            on_same_map = self.creature.map_ == unit.map_
            target_distance = self.creature.location.distance(unit.location)
            detection_range = self.creature.creature_template.detection_range
            in_detection_range = target_distance <= detection_range
            if target_is_player and on_same_map and in_detection_range:
                self._start_proximity_aggro_attack(unit, target_is_player=target_is_player)

    # override
    def just_respawned(self):
        self.can_summon_guards = self.creature.can_summon_guards() if self.creature else False
        super().just_respawned()

    # override
    def summoned_creatures_despawn(self, creature):
        self.can_summon_guards = self.creature.can_summon_guards() if self.creature else False

    def _is_ready_for_new_attack(self):
        return self.creature.is_alive and self.creature.is_spawned and len(self.creature.known_players) > 0 \
               and self._is_aggressive() and not self.creature.combat_target and not self.creature.is_evading

    def _is_aggressive(self):
        return self.creature.react_state == CreatureReactStates.REACT_AGGRESSIVE

    def _start_proximity_aggro_attack(self, victim, target_is_player=False):
        # Avoid attacks on characters with BeastMaster flag on.
        if target_is_player and victim.beast_master:
            return False

        self.send_ai_reaction(victim, AIReactionStates.AI_REACT_HOSTILE)
        threat_not_to_leave_combat = 1E-4
        self.creature.threat_manager.add_threat(victim, threat_not_to_leave_combat)

    def summon_guard(self, enemy):
        pass
