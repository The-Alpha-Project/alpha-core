from __future__ import annotations
from typing import TYPE_CHECKING, Optional
from game.world.managers.objects.ai.CreatureAI import CreatureAI
from utils.constants.CustomCodes import Permits

if TYPE_CHECKING:
    from game.world.managers.objects.units.creature.CreatureManager import CreatureManager


class BasicCreatureAI(CreatureAI):
    GUARD_CALL_COOLDOWN_SECS = 10.0
    FAILED_GUARD_CALL_RETRY_SECS = 1.0
    MIN_GUARD_SEARCH_RADIUS = 30.0

    def __init__(self, creature: Optional[CreatureManager]):
        super().__init__(creature)
        self.can_summon_guards = creature.can_summon_guards() if creature else False
        self.guard_call_cooldown_secs = 0.0

    # override
    def update_ai(self, elapsed, now):
        super().update_ai(elapsed, now)
        if not self.creature:
            return

        if self.guard_call_cooldown_secs > 0:
            self.guard_call_cooldown_secs = max(0.0, self.guard_call_cooldown_secs - elapsed)

        #  Update events bound to AI update calls timing, this includes OOC.
        self.ai_event_handler.update(elapsed)

        if not self.creature.combat_target:
            return

        if self.has_spell_list():
            self.update_spell_list(elapsed)

        self.do_melee_attack_if_ready()

    # override
    def permissible(self, creature):
        return Permits.PERMIT_BASE_NORMAL

    # override
    def attach_escort_link(self, player_mgr):
        pass

    # override
    def detach_escort_link(self, player_mgr=None):
        pass

    # override
    def movement_inform(self, move_type=None, data=None, units=None):
        pass

    # override
    def move_in_line_of_sight(self, unit, ai_event=False):
        super().move_in_line_of_sight(unit, ai_event=ai_event)
        if ai_event:
            return

        # Ask nearby guards to assist if needed.
        if self.can_summon_guards and unit.is_player() and not self.is_ready_for_new_attack():
            self.summon_guard(unit)
            return

        if not self.is_ready_for_new_attack():
            return

        self.creature.attack(unit)

    # override
    def just_respawned(self):
        self.can_summon_guards = self.creature.can_summon_guards() if self.creature else False
        self.guard_call_cooldown_secs = 0.0
        super().just_respawned()

    # override
    def summoned_creatures_despawn(self, creature):
        super().summoned_creatures_despawn(creature)
        self.can_summon_guards = self.creature.can_summon_guards() if self.creature else False

    # override
    def enter_combat(self, source=None):
        super().enter_combat(source)
        self.summon_guard(source)

    def summon_guard(self, enemy):
        if not self.creature or not self.can_summon_guards or not enemy:
            return

        if self.guard_call_cooldown_secs > 0:
            return

        if not enemy.is_alive or not self.creature.is_hostile_to(enemy):
            return

        player_source = enemy if enemy.is_player() else enemy.get_charmer_or_summoner()
        if not player_source or not player_source.is_player():
            return

        search_radius = max(self.MIN_GUARD_SEARCH_RADIUS,
                            self.creature.get_detection_range(player_source),
                            self.creature.creature_template.call_for_help_range)
        nearby_guards = self.creature.get_map().get_surrounding_units_by_location(
            self.creature.location,
            self.creature.map_id,
            self.creature.instance_id,
            search_radius
        )[0].values()

        called_guard = False
        for guard in nearby_guards:
            if guard == self.creature or not guard.is_alive or not guard.is_spawned or not guard.is_guard():
                continue

            if not guard.threat_manager.unit_can_assist_help_call(self.creature, enemy):
                continue

            guard.threat_manager.add_threat(enemy, is_call_for_help=True)
            called_guard = True

        self.guard_call_cooldown_secs = self.GUARD_CALL_COOLDOWN_SECS if called_guard \
            else self.FAILED_GUARD_CALL_RETRY_SECS
