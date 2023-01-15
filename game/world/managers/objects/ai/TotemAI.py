from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from game.world.managers.objects.ai.CreatureAI import CreatureAI
from utils.constants.CustomCodes import Permits


class TotemAI(CreatureAI):
    def __init__(self, creature):
        super().__init__(creature)

    # override
    def update_ai(self, elapsed):
        super().update_ai(elapsed)
        if not self.creature:
            return

        owner = self.creature.get_charmer_or_summoner()
        if not owner:
            return

        self.creature.threat_manager.holders = owner.threat_manager.holders.copy()

        if self.has_spell_list():
            self.update_spell_list(elapsed)

    # override
    def permissible(self, creature):
        if creature.is_totem():
            return Permits.PERMIT_BASE_SPECIAL
        return Permits.PERMIT_BASE_NO

    # override
    def just_respawned(self):
        for spell_id in self.creature.get_template_spells():
            spell = DbcDatabaseManager.SpellHolder.spell_get_by_id(spell_id)
            # Apply totem passives.
            self.creature.spell_manager.apply_passive_spell_effects(spell)
        super().just_respawned()

    # override
    def just_despawned(self):
        self.just_died()  # Handle same as dead for now.
        super().just_despawned()

    # override
    def move_in_line_of_sight(self, unit):
        pass

    # override
    def handle_return_movement(self):
        pass

    # override
    def attack_start(self, victim):
        pass
