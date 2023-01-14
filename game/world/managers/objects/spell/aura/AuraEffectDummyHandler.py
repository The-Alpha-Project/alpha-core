from random import randint

from game.world.managers.objects.farsight.FarSightManager import FarSightManager
from utils.constants import CustomCodes
from utils.constants.MiscCodes import Emotes, ObjectTypeIds, ObjectTypeFlags
from utils.constants.SpellCodes import SpellTargetMask
from utils.constants.UnitCodes import StandState


class AuraEffectDummyHandler:
    @staticmethod
    def is_periodic(spell_id):
        return spell_id in PERIODIC_DUMMY_AURAS

    @staticmethod
    def get_period(spell_id):
        return PERIODIC_DUMMY_AURAS[spell_id]

    @staticmethod
    def handle_killrogg_eye(aura, effect_target, remove):
        if not remove:
            return
        if aura.caster.possessed_unit:
            aura.caster.possessed_unit.set_charmed_by(aura.caster,
                                                      CustomCodes.CreatureSubtype.SUBTYPE_TEMP_SUMMON,
                                                      remove=True)
            aura.caster.possessed_unit.destroy()
            aura.caster.possessed_unit = None

    @staticmethod
    def handle_party_fever(aura, effect_target, remove):
        if remove or effect_target.get_type_id() != ObjectTypeIds.ID_PLAYER:
            return

        # TODO: This does not play the emote.
        if not effect_target.in_combat:
            effect_target.play_emote(Emotes.DANCE)

    @staticmethod
    def handle_haunting_spirit(aura, effect_target, remove):
        if not aura.is_past_next_period() or remove:
            return

        if not effect_target.get_type_mask() & ObjectTypeFlags.TYPE_UNIT:
            return

        roll = randint(1, 100)
        if roll < 5:
            aura.caster.spell_manager.handle_cast_attempt(7067, effect_target, SpellTargetMask.UNIT, validate=False)

    @staticmethod
    # This does not display an aura, it can't be cancelled.
    def handle_sleep(aura, effect_target, remove):
        if not effect_target.get_type_mask() & ObjectTypeFlags.TYPE_UNIT:
            return

        if remove:
            effect_target.set_stand_state(StandState.UNIT_STANDING)
            effect_target.play_emote(Emotes.NONE)
            return

        effect_target.set_stand_state(StandState.UNIT_SLEEPING)
        effect_target.play_emote(Emotes.SLEEP)

    @staticmethod
    def handle_sentry_totem(aura, effect_target, remove):
        if remove or effect_target.get_type_id() != ObjectTypeIds.ID_PLAYER:
            return
        totem_slot = aura.source_spell.get_totem_slot_type()
        totem = effect_target.pet_manager.get_active_totem(totem_slot)
        aura.caster = totem.creature  # Set the totem as the caster of the aura so it can be removed when the totem dies.
        if totem:
            FarSightManager.add_camera(totem.creature, effect_target)


PERIODIC_DUMMY_AURAS = {
    7057: 5000  # Haunting Spirits, 5 second tick.
}

DUMMY_AURA_EFFECTS = {
    126:  AuraEffectDummyHandler.handle_killrogg_eye,
    6606: AuraEffectDummyHandler.handle_sleep,  # Self Visual - Sleep Until Cancelled.
    6495: AuraEffectDummyHandler.handle_sentry_totem,
    6758: AuraEffectDummyHandler.handle_party_fever,  # Party Fever.
    7057: AuraEffectDummyHandler.handle_haunting_spirit,  # Haunting Spirit.
}
