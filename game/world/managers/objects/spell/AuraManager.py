import time
from struct import pack

from game.world.managers.objects.spell.AppliedAura import AppliedAura
from game.world.managers.objects.spell.AuraEffectHandler import AuraEffectHandler
from network.packet.PacketWriter import PacketWriter, OpCode
from utils.constants.MiscCodes import ObjectTypes
from utils.constants.SpellCodes import AuraTypes, AuraSlots, SpellEffects, SpellCheckCastResult
from utils.constants.UnitCodes import UnitFlags
from utils.constants.UpdateFields import UnitFields


class AuraManager:
    def __init__(self, unit_mgr):
        self.unit_mgr = unit_mgr
        self.active_auras = {}  # (int: Aura) to have persistent indices
        self.current_flags = 0x0

    def apply_spell_effect_aura(self, caster, casting_spell, spell_effect):
        aura = AppliedAura(caster, casting_spell, spell_effect, self.unit_mgr)
        self.add_aura(aura)

    def add_aura(self, aura):
        # Note: This order of applying, removing colliding and then returning might be problematic if cases are added to can_apply_aura.
        # At the moment mount behaviour depends on this order
        can_apply = self.can_apply_aura(aura)
        self.remove_colliding_effects(aura)
        if not can_apply:
            return

        aura.initialize_period_timestamps()  # Initialize periodic spell timestamps on application

        AuraEffectHandler.handle_aura_effect_change(aura)
        aura.index = self.get_next_aura_index(aura)
        self.active_auras[aura.index] = aura

        if not aura.passive:
            self.write_aura_to_unit(aura)
            self.write_aura_flag_to_unit(aura)
            self.send_aura_duration(aura)

        # Aura application threat TODO handle threat elsewhere
        if aura.is_harmful() and aura.source_spell.generates_threat():
            self.unit_mgr.attack(aura.caster)

        self.unit_mgr.set_dirty()

    def update(self, elapsed):
        for aura in list(self.active_auras.values()):
            aura.update(elapsed)  # Update duration and handle periodic effects
            if aura.has_duration() and aura.duration <= 0:
                self.remove_aura(aura)

    def can_apply_aura(self, aura) -> bool:
        if aura.spell_effect.aura_type == AuraTypes.SPELL_AURA_MOD_SHAPESHIFT and \
                len(self.get_auras_by_spell_id(aura.spell_id)) > 0:
            return False  # Don't apply same shapeshift effect if it already exists

        if aura.spell_effect.aura_type == AuraTypes.SPELL_AURA_MOUNTED and \
                aura.target.unit_flags & UnitFlags.UNIT_MASK_MOUNTED:
            return False

        if aura.spell_effect.aura_type == AuraTypes.SPELL_AURA_MOD_INCREASE_MOUNTED_SPEED and \
                aura.target.unit_flags & UnitFlags.UNIT_MASK_MOUNTED == 0:
            return False
        return True

    def remove_colliding_effects(self, aura):
        # Special case with SpellEffect mounting and mounting by aura
        if aura.spell_effect.aura_type == AuraTypes.SPELL_AURA_MOUNTED and \
                aura.target.unit_flags & UnitFlags.UNIT_MASK_MOUNTED and not \
                self.get_auras_by_type(AuraTypes.SPELL_AURA_MOUNTED):
            AuraEffectHandler.handle_mounted(aura, True)  # Remove mount effect

        aura_spell_template = aura.source_spell.spell_entry
        aura_effect_index = aura.spell_effect.effect_index
        caster_guid = aura.caster.guid

        for applied_aura in list(self.active_auras.values()):
            if applied_aura.caster.guid != caster_guid or \
                    applied_aura.spell_effect.effect_index != aura_effect_index or \
                    applied_aura.source_spell.spell_entry != aura_spell_template:
                continue
            self.remove_aura(applied_aura)  # Remove identical auras the caster has applied

    def get_auras_by_spell_id(self, spell_id) -> list[AppliedAura]:
        auras = []
        for aura in self.active_auras.values():
            if aura.spell_id != spell_id:
                continue
            auras.append(aura)
        return auras

    def get_auras_by_type(self, aura_type) -> list[AppliedAura]:
        auras = []
        for aura in list(self.active_auras.values()):
            if aura.spell_effect.aura_type != aura_type:
                continue
            auras.append(aura)
        return auras

    def remove_auras_by_type(self, aura_type):
        for aura in list(self.active_auras.values()):
            if aura.spell_effect.aura_type != aura_type:
                continue
            self.remove_aura(aura)

    def remove_aura(self, aura):
        # TODO check if aura can be removed (by player)
        AuraEffectHandler.handle_aura_effect_change(aura, True)
        self.active_auras.pop(aura.index)
        # Some area effect auras (paladin auras, tranq etc.) are tied to spell effects. Cancel cast on aura cancel, canceling the auras as well.
        self.unit_mgr.spell_manager.remove_cast_by_spell_id(aura.spell_id, SpellCheckCastResult.SPELL_FAILED_DONT_REPORT)

        if aura.passive:
            return  # Passive auras aren't written to unit

        self.write_aura_to_unit(aura, clear=True)
        self.write_aura_flag_to_unit(aura, clear=True)
        self.unit_mgr.set_dirty()

    def cancel_auras_by_spell_id(self, spell_id):
        auras = self.get_auras_by_spell_id(spell_id)

        for aura in auras:
            self.remove_aura(aura)

    def send_aura_duration(self, aura):
        if self.unit_mgr.get_type() != ObjectTypes.TYPE_PLAYER:
            return

        data = pack('<Bi', aura.index, aura.duration)
        self.unit_mgr.session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_UPDATE_AURA_DURATION, data))

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

    def get_next_aura_index(self, aura) -> int:
        if aura.passive:
            min_index = AuraSlots.AURA_SLOT_PASSIVE_AURA_START
            max_index = AuraSlots.AURA_SLOT_END
        elif aura.is_harmful():
            min_index = AuraSlots.AURA_SLOT_HARMFUL_AURA_START
            max_index = AuraSlots.AURA_SLOT_PASSIVE_AURA_START
        else:
            min_index = AuraSlots.AURA_SLOT_POSITIVE_AURA_START
            max_index = AuraSlots.AURA_SLOT_HARMFUL_AURA_START

        for i in range(min_index, max_index):
            if i not in self.active_auras:
                return i
        return min_index  # No aura slots free, return first possible. TODO Some kind of priority system?
