from __future__ import annotations
from typing import TYPE_CHECKING, Optional
from game.world.managers.objects.ai.CreatureAI import CreatureAI
from utils.constants.CustomCodes import Permits

if TYPE_CHECKING:
    from game.world.managers.objects.units.creature.CreatureManager import CreatureManager


class BasicCreatureAI(CreatureAI):
    def __init__(self, creature: Optional[CreatureManager]):
        super().__init__(creature)
        self.can_summon_guards = creature.can_summon_guards() if creature else False

    # override
    def update_ai(self, elapsed, now):
        super().update_ai(elapsed, now)
        if not self.creature:
            return

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
    def link_player(self, player_mgr=None):
        pass

    # override
    def movement_inform(self, move_type=None, data=None, units=None):
        pass

    # override
    def move_in_line_of_sight(self, unit, ai_event=False):
        super().move_in_line_of_sight(unit, ai_event=ai_event)
        if ai_event or not self.is_ready_for_new_attack():
            return
        self.creature.attack(unit)

    # override
    def just_respawned(self):
        self.can_summon_guards = self.creature.can_summon_guards() if self.creature else False
        super().just_respawned()

    # override
    def summoned_creatures_despawn(self, creature):
        self.can_summon_guards = self.creature.can_summon_guards() if self.creature else False

    def summon_guard(self, enemy):
        pass

