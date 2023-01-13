from game.world.managers.objects.ai.CreatureAI import CreatureAI
from game.world.managers.objects.spell.ExtendedSpellData import TotemHelpers
from utils.constants.CustomCodes import Permits
from utils.constants.MiscCodes import ObjectTypeFlags
from utils.constants.SpellCodes import SpellTargetMask


class TotemAI(CreatureAI):
    def __init__(self, creature):
        super().__init__(creature)

    # override
    def update_ai(self, elapsed):
        pass

    # override
    def permissible(self, creature):
        if creature.is_totem():
            return Permits.PERMIT_BASE_SPECIAL
        return Permits.PERMIT_BASE_NO

    # override
    def just_respawned(self):
        for spell_id in self.creature.get_template_spells():
            self.creature.spell_manager.handle_cast_attempt(spell_id, self.creature, SpellTargetMask.UNIT,
                                                            validate=False)
        super().just_respawned()

    # override
    def just_despawned(self):
        self.just_died()  # Handle same as dead for now.
        super().just_despawned()

    # override
    def just_died(self):
        charmer_or_summoner = self.creature.get_charmer_or_summoner()
        if charmer_or_summoner and charmer_or_summoner.get_type_mask() & ObjectTypeFlags.TYPE_UNIT:
            charmer_or_summoner.pet_manager.detach_totem_by_guid(self.creature.guid)
        super().just_died()

    # override
    def move_in_line_of_sight(self, unit):
        pass

    # override
    def attack_start(self, victim):
        pass
