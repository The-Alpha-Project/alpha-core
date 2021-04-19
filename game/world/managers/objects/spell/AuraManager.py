from struct import pack

from network.packet.PacketWriter import PacketWriter, OpCode
from utils.Logger import Logger
from utils.constants.ObjectCodes import ObjectTypes
from utils.constants.SpellCodes import AuraTypes, SpellEffects


class AppliedAura:
    def __init__(self, caster, spell_effect):
        self.caster = caster
        self.base_effect = spell_effect


class AuraEffectHandler:
    @staticmethod
    def handle_aura_effect(spell_effect):
        if spell_effect.effect_type != SpellEffects.SPELL_EFFECT_APPLY_AURA:
            return
        if spell_effect.aura_type not in AURA_EFFECTS:
            Logger.debug(f'Unimplemented effect called: {spell_effect.aura_type}')
            return
        AURA_EFFECTS[spell_effect.aura_type](spell_effect.aura_period, spell_effect.misc_value)

    @staticmethod
    def handle_shapeshift(period, misc_value):
        Logger.debug("shapeshift handle")


AURA_EFFECTS = {
    AuraTypes.SPELL_AURA_MOD_SHAPESHIFT: AuraEffectHandler.handle_shapeshift
}


class AuraManager:
    def __init__(self, unit_mgr):
        self.unit_mgr = unit_mgr
        self.active_auras = []

    def apply_spell_effect_aura(self, caster, casting_spell, spell_effect):
        effect_type = spell_effect.aura_type
        duration = casting_spell.duration_entry.Duration
        aura = AppliedAura(caster, spell_effect)
        self.active_auras.append(aura)
        AuraEffectHandler.handle_aura_effect(spell_effect)

        if self.unit_mgr.get_type() == ObjectTypes.TYPE_PLAYER:
            data = pack('<bi', len(self.active_auras), duration)
            self.unit_mgr.session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_UPDATE_AURA_DURATION, data))
