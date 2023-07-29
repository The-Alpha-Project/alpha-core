from game.world.managers.objects.ai.CreatureAI import CreatureAI
from utils.constants.CustomCodes import Permits


class GuardAI(CreatureAI):
    def __init__(self, creature):
        super().__init__(creature)

    # override
    def update_ai(self, elapsed):
        super().update_ai(elapsed)
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
    def move_in_line_of_sight(self, unit):
        self.creature.object_ai.attacked_by(unit)

    # override
    def enter_combat(self, source=None):
        pass

    # Returns whether the Unit is currently attacking other players or friendly units.
    def is_attacking_friendly_or_player(self, unit):
        pass
