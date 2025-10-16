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

    @staticmethod
    def handle_transform_moonstalker(casting_spell, effect, caster, target):
        if not target.is_unit(by_mask=True):
            return

        target.set_display_id(2279)


DUMMY_SPELL_EFFECTS = {
    6245: SpellEffectDummyHandler.handle_force_target_salute,  # Force Target - Salute
    6655: SpellEffectDummyHandler.handle_force_target_bow,  # Force Target - Bow
    6236: SpellEffectDummyHandler.handle_transform_moonstalker
}
