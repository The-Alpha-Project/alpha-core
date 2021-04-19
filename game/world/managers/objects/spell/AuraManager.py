from struct import pack

from game.world.managers.GridManager import GridManager
from network.packet.PacketWriter import PacketWriter, OpCode
from utils.Logger import Logger
from utils.constants.ObjectCodes import ObjectTypes
from utils.constants.SpellCodes import AuraTypes, SpellEffects, ShapeshiftForms
from utils.constants.UpdateFields import UnitFields


class AppliedAura:
    def __init__(self, target, caster, spell_id, duration_entry, spell_effect):
        self.target = target
        self.caster = caster
        self.index = -1  # Set on application
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
        aura.target.aura_manager.remove_auras_by_type(aura.spell_effect.aura_type)  # Remove existing shapeshift
        aura.target.set_shapeshift_form(aura.spell_effect.misc_value)
        if aura.spell_effect.misc_value not in SHAPESHIFT_MODEL_IDS:
            return
        aura.target.set_display_id(SHAPESHIFT_MODEL_IDS[aura.spell_effect.misc_value])


AURA_EFFECTS = {
    AuraTypes.SPELL_AURA_MOD_SHAPESHIFT: AuraEffectHandler.handle_shapeshift
}

SHAPESHIFT_MODEL_IDS = {  # Ugly solution but there doesn't seem to be a connection in databases
    ShapeshiftForms.SHAPESHIFT_FORM_CAT: 892,
    ShapeshiftForms.SHAPESHIFT_FORM_TREE: 864,
    ShapeshiftForms.SHAPESHIFT_FORM_AQUATIC: 2428,
    ShapeshiftForms.SHAPESHIFT_FORM_BEAR: 2281
}


class AuraManager:
    def __init__(self, unit_mgr):
        self.unit_mgr = unit_mgr
        self.active_auras = {}  # (int: Aura) to have persistent indices
        self.current_flags = 0x0

    def apply_spell_effect_aura(self, caster, casting_spell, spell_effect):
        aura = AppliedAura(casting_spell.initial_target_unit, caster,
                           casting_spell.spell_entry.ID, casting_spell.duration_entry, spell_effect)
        self.add_aura(aura)

    def add_aura(self, aura):
        if not self.can_apply_aura(aura):
            return
        AuraEffectHandler.handle_aura_effect(aura)

        aura.index = self.get_next_aura_index()
        self.active_auras[aura.index] = aura

        self.write_aura_to_unit(aura)
        self.write_aura_flag_to_unit(aura)

        self.unit_mgr.set_dirty()

    def can_apply_aura(self, aura):
        if aura.spell_effect.aura_type == AuraTypes.SPELL_AURA_MOD_SHAPESHIFT and \
                self.get_aura_by_spell_id(aura.spell_id) is not None:
            return False  # Don't apply shapeshift effect if it already exists

        return True

    def get_aura_by_spell_id(self, spell_id):
        for aura in list(self.active_auras.values()):
            if aura.spell_id is not spell_id:
                continue
            return aura
        return None

    def remove_auras_by_type(self, aura_type):
        for aura in list(self.active_auras.values()):
            if aura.spell_effect.aura_type != aura_type:
                continue
            self.remove_aura(aura)

    def remove_aura(self, aura):
        self.write_aura_to_unit(aura, clear=True)
        self.write_aura_flag_to_unit(aura, clear=False)

        data = pack('<Bi', aura.index, 0)
        GridManager.send_surrounding(PacketWriter.get_packet(OpCode.SMSG_UPDATE_AURA_DURATION, data), self.unit_mgr,
                                     include_self=self.unit_mgr.get_type() == ObjectTypes.TYPE_PLAYER)
        self.active_auras.pop(aura.index)

        self.unit_mgr.set_dirty()

    def send_aura_duration(self, aura):
        if self.unit_mgr.get_type() != ObjectTypes.TYPE_PLAYER:
            return

        data = pack('<Bi', aura.index, aura.duration_entry.Duration)
        self.unit_mgr.session.send_message(PacketWriter.get_packet(OpCode.SMSG_UPDATE_AURA_DURATION, data))

    def write_aura_to_unit(self, aura, clear=False):
        field_index = UnitFields.UNIT_FIELD_AURA + aura.index
        self.unit_mgr.set_uint32(field_index, aura.spell_id if not clear else 0)

    def write_aura_flag_to_unit(self, aura, clear=False):
        if not aura:
            return
        byte = (aura.index & 7) << 2  # magic value for AuraFlags
        if not clear:
            self.current_flags |= 0x9 << byte  # OR to current flags - from other server's source
        else:
            self.current_flags &= ~(0x9 << byte)

        self.unit_mgr.set_uint32(UnitFields.UNIT_FIELD_AURAFLAGS + (aura.index >> 3), self.current_flags)

    def get_next_aura_index(self):
        for i in range(0, 30):
            if i not in self.active_auras:
                return i
        return None
