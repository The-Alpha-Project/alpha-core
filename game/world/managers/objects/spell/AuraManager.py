from struct import pack

from game.world.managers.GridManager import GridManager
from network.packet.PacketWriter import PacketWriter, OpCode
from utils.Logger import Logger
from utils.constants.ObjectCodes import ObjectTypes
from utils.constants.SpellCodes import AuraTypes, SpellEffects
from utils.constants.UpdateFields import UnitFields


class AppliedAura:
    def __init__(self, target, caster, spell_id, duration_entry, spell_effect):
        self.target = target
        self.caster = caster
        self.spell_id = spell_id
        self.spell_effect = spell_effect
        self.duration_entry = duration_entry
        self.spell_effect = spell_effect


class AuraEffectHandler:
    @staticmethod
    def handle_aura_effect(aura):
        if aura.spell_effect.effect_type != SpellEffects.SPELL_EFFECT_APPLY_AURA:
            return
        if aura.spell_effect.aura_type not in AURA_EFFECTS:
            Logger.debug(f'Unimplemented effect called: {aura.spell_effect.aura_type}')
            return
        AURA_EFFECTS[aura.spell_effect.aura_type](aura)

    @staticmethod
    def handle_shapeshift(aura):
        aura.target.aura_manager.remove_auras_by_type(
            aura.spell_effect.aura_type, exclude=aura)  # Remove existing shapeshift
        aura.target.shapeshift_form = aura.spell_effect.misc_value


AURA_EFFECTS = {
    AuraTypes.SPELL_AURA_MOD_SHAPESHIFT: AuraEffectHandler.handle_shapeshift
}


class AuraManager:
    def __init__(self, unit_mgr):
        self.unit_mgr = unit_mgr
        self.active_auras = []
        self.current_flags = 0x0

    def apply_spell_effect_aura(self, caster, casting_spell, spell_effect):
        aura = AppliedAura(casting_spell.initial_target_unit, caster, casting_spell.spell_entry.ID, casting_spell.duration_entry, spell_effect)
        self.add_aura(aura)

    def add_aura(self, aura):
        self.active_auras.append(aura)
        AuraEffectHandler.handle_aura_effect(aura)

        self.write_aura_to_unit(aura)

        data = pack('<Bi', self.get_aura_index(aura), aura.duration_entry.Duration)
        GridManager.send_surrounding(PacketWriter.get_packet(OpCode.SMSG_UPDATE_AURA_DURATION, data), self.unit_mgr,
                                     include_self=self.unit_mgr.get_type() == ObjectTypes.TYPE_PLAYER)

        for aura in self.active_auras:
            print(aura.spell_id)

    def remove_auras_by_type(self, aura_type, exclude=None):
        for aura in list(self.active_auras):
            if aura.spell_effect.aura_type != aura_type or aura is exclude:
                continue
            self.remove_aura(aura)

    def remove_aura(self, aura):
        self.write_aura_to_unit(aura, clear=True)

        data = pack('<Bi', self.get_aura_index(aura), 0)
        GridManager.send_surrounding(PacketWriter.get_packet(OpCode.SMSG_UPDATE_AURA_DURATION, data), self.unit_mgr,
                                     include_self=self.unit_mgr.get_type() == ObjectTypes.TYPE_PLAYER)
        self.active_auras.remove(aura)

    def write_aura_to_unit(self, aura, clear=False):
        index = self.active_auras.index(aura)
        field_index = UnitFields.UNIT_FIELD_AURA + index
        self.unit_mgr.set_uint32(field_index, aura.spell_id if not clear else 0)

        self.write_aura_flag_to_unit(aura, clear)

        self.unit_mgr.set_dirty()

    def write_aura_flag_to_unit(self, aura, clear=False):
        index = self.get_aura_index(aura)
        if not aura:
            return
        byte = (index & 7) << 2  # magic value for AuraFlags
        if not clear:
            self.current_flags |= 0x9 << byte  # OR to current flags - from other server's source
        else:
            self.current_flags &= ~(0x9 << byte)

        self.unit_mgr.set_uint32(UnitFields.UNIT_FIELD_AURAFLAGS + (index >> 3), self.current_flags)

    def get_aura_index(self, aura):
        return self.active_auras.index(aura) if aura in self.active_auras else None
