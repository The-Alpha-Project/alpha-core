from game.world.managers.objects.ai.CreatureAI import CreatureAI
from utils.constants.CustomCodes import Permits


class GuardAI(CreatureAI):
    def __init__(self, creature):
        super().__init__(creature)

    # override
    def update_ai(self, elapsed, now):
        super().update_ai(elapsed, now)
        if not self.creature or not self.creature.combat_target:
            return

        if self.has_spell_list():
            self.update_spell_list(elapsed)

        self.do_melee_attack_if_ready()

    # override
    def permissible(self, creature):
        if creature.is_guard():
            return Permits.PERMIT_BASE_SPECIAL
        return Permits.PERMIT_BASE_NO

    # override
    def move_in_line_of_sight(self, unit, ai_event=False):
        super().move_in_line_of_sight(unit, ai_event=ai_event)
        if ai_event or not self.is_ready_for_new_attack():
            return
        if self.creature.threat_manager.has_aggro_from(unit):
            return
        self.creature.object_ai.attacked_by(unit)

    # override
    def enter_combat(self, source=None):
        pass

    # Returns whether the Unit is currently attacking other players or friendly units.
    def is_attacking_friendly_or_player(self, unit):
        pass
