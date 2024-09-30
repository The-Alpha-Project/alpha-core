from utils.constants.MiscCodes import Emotes


class SpellEffectDummyHandler:
    @staticmethod
    def handle_force_target_salute(casting_spell, effect, caster, target):
        if not target.is_unit(by_mask=True):
            return

        target.play_emote(Emotes.SALUTE)

    @staticmethod
    def handle_force_target_bow(casting_spell, effect, caster, target):
        if not target.is_unit(by_mask=True):
            return

        target.play_emote(Emotes.BOW)


DUMMY_SPELL_EFFECTS = {
    6245: SpellEffectDummyHandler.handle_force_target_salute,  # Force Target - Salute
    6655: SpellEffectDummyHandler.handle_force_target_bow  # Force Target - Bow
}
