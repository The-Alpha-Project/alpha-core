from random import randint

from game.world.managers.objects.farsight.FarSightManager import FarSightManager
from utils.constants import CustomCodes
from utils.constants.MiscCodes import Emotes, ObjectTypeIds, ObjectTypeFlags
from utils.constants.SpellCodes import SpellTargetMask, AuraState
from utils.constants.UnitCodes import StandState


class AuraEffectDummyHandler:
    @staticmethod
    def is_periodic(spell_id):
        return spell_id in PERIODIC_DUMMY_AURAS

    @staticmethod
    def get_period(spell_id):
        return PERIODIC_DUMMY_AURAS[spell_id]

    @staticmethod
    def handle_killrogg_eye(aura, _effect_target, remove):
        if not remove:
            return
        if not aura.caster.possessed_unit:
            return
        sub_type = CustomCodes.CreatureSubtype.SUBTYPE_TEMP_SUMMON
        aura.caster.possessed_unit.set_charmed_by(aura.caster, sub_type, remove=True)
        aura.caster.possessed_unit.despawn()
        aura.caster.possessed_unit = None

    @staticmethod
    def handle_aura_state_defensive(aura, effect_target, remove):
        aura.caster.aura_manager.modify_aura_state(AuraState.AURA_STATE_DEFENSE, apply=not remove)

    @staticmethod
    def handle_party_fever(aura, effect_target, remove):
        effect_target.set_emote_state(10 if not remove else 0, is_temporal=True)

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
        if totem:
            # Set the totem as the caster of the aura so it can easily be removed when the totem is destroyed.
            aura.caster = totem.creature
            FarSightManager.add_camera(totem.creature, effect_target)

    @staticmethod
    def handle_salt_flats_racer_normal(aura, effect_target, remove):
        # Dummy aura used by the Salt Flats cars.
        # Does nothing except signify the car is going at normal speed.
        return


PERIODIC_DUMMY_AURAS = {
    7057: 5000  # Haunting Spirits, 5 second tick.
}

DUMMY_AURA_EFFECTS = {
    126:  AuraEffectDummyHandler.handle_killrogg_eye,
    5302: AuraEffectDummyHandler.handle_aura_state_defensive,
    6606: AuraEffectDummyHandler.handle_sleep,  # Self Visual - Sleep Until Cancelled.
    6495: AuraEffectDummyHandler.handle_sentry_totem,
    6758: AuraEffectDummyHandler.handle_party_fever,  # Party Fever.
    7057: AuraEffectDummyHandler.handle_haunting_spirit,  # Haunting Spirit.
    6602: AuraEffectDummyHandler.handle_salt_flats_racer_normal  # Salt Flats Racer Normal.
}
