from struct import pack

from database.world.WorldDatabaseManager import WorldDatabaseManager, config
from game.world.managers.GridManager import GridManager
from network.packet.PacketWriter import PacketWriter, OpCode
from utils.Logger import Logger
from utils.constants.ObjectCodes import ObjectTypes, Factions
from utils.constants.SpellCodes import AuraTypes, SpellEffects, ShapeshiftForms
from utils.constants.UnitCodes import UnitFlags
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
    def handle_aura_effect_change(aura, remove=False):
        if aura.spell_effect.effect_type != SpellEffects.SPELL_EFFECT_APPLY_AURA:
            return
        if aura.spell_effect.aura_type not in AURA_EFFECTS:
            Logger.debug(f'Unimplemented aura effect called: {aura.spell_effect.aura_type}')
            return

        AURA_EFFECTS[aura.spell_effect.aura_type](aura, remove)

    @staticmethod
    def handle_shapeshift(aura, remove):
        form = aura.spell_effect.misc_value if not remove else ShapeshiftForms.SHAPESHIFT_FORM_NONE
        aura.target.set_shapeshift_form(form)
        if not remove:
            aura.target.aura_manager.remove_auras_by_type(aura.spell_effect.aura_type)  # Remove existing shapeshift
        if remove or aura.spell_effect.misc_value not in SHAPESHIFT_MODEL_IDS:
            aura.target.reset_display_id()
            aura.target.reset_scale()
            aura.target.set_dirty()
            return

        shapeshift_display_info = SHAPESHIFT_MODEL_IDS[aura.spell_effect.misc_value]
        display_index = 1 if aura.target.faction == Factions.HORDE else 0
        model_scale = shapeshift_display_info[2]
        aura.target.set_display_id(shapeshift_display_info[display_index])
        aura.target.set_scale(model_scale)
        aura.target.set_dirty()

    @staticmethod
    def handle_mounted(aura, remove):
        if remove:
            aura.target.unmount()
            aura.target.set_dirty()
        elif aura.target.unit_flags & UnitFlags.UNIT_MASK_MOUNTED:
            aura.target.aura_manager.remove_auras_by_type(AuraTypes.SPELL_AURA_MOUNTED)
            aura.target.aura_manager.remove_auras_by_type(AuraTypes.SPELL_AURA_MOD_INCREASE_MOUNTED_SPEED)
        else:
            aura.target.aura_manager.remove_auras_by_type(aura.spell_effect.aura_type)  # Remove existing mount aura TODO Exclusive effects?

            creature_entry = aura.spell_effect.misc_value
            if not aura.target.summon_mount(creature_entry):
                Logger.error(f'SPELL_AURA_MOUNTED: Creature template ({creature_entry}) not found in database.')

    @staticmethod
    def handle_increase_mounted_speed(aura, remove):
        # TODO: Should handle for creatures too? (refactor all change speed methods?)
        if aura.target.get_type() != ObjectTypes.TYPE_PLAYER:
            return

        if remove:
            aura.target.change_speed()
            return

        # TODO Not properly being removed when you cast another mount
        aura.target.aura_manager.remove_auras_by_type(aura.spell_effect.aura_type)

        default_speed = config.Unit.Defaults.run_speed
        speed_percentage = aura.spell_effect.get_effect_points(aura.target.level) / 100.0
        aura.target.change_speed(default_speed + (default_speed * speed_percentage))


AURA_EFFECTS = {
    AuraTypes.SPELL_AURA_MOD_SHAPESHIFT: AuraEffectHandler.handle_shapeshift,
    AuraTypes.SPELL_AURA_MOUNTED: AuraEffectHandler.handle_mounted,
    AuraTypes.SPELL_AURA_MOD_INCREASE_MOUNTED_SPEED: AuraEffectHandler.handle_increase_mounted_speed
}

# Alliance / Default display_id, Horde display_id, Scale
SHAPESHIFT_MODEL_IDS = {
    ShapeshiftForms.SHAPESHIFT_FORM_CAT: (892, 892, 0.8),
    ShapeshiftForms.SHAPESHIFT_FORM_TREE: (864, 864, 1.0),
    ShapeshiftForms.SHAPESHIFT_FORM_AQUATIC: (2428, 2428, 0.8),
    ShapeshiftForms.SHAPESHIFT_FORM_BEAR: (2281, 2289, 1.0)
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
        AuraEffectHandler.handle_aura_effect_change(aura)

        aura.index = self.get_next_aura_index()
        self.active_auras[aura.index] = aura

        self.write_aura_to_unit(aura)
        self.write_aura_flag_to_unit(aura)
        self.send_aura_duration(aura)

        self.unit_mgr.set_dirty()

    def can_apply_aura(self, aura):
        if aura.spell_effect.aura_type == AuraTypes.SPELL_AURA_MOD_SHAPESHIFT and \
                len(self.get_auras_by_spell_id(aura.spell_id)) > 0:
            return False  # Don't apply shapeshift effect if it already exists

        return True

    def get_auras_by_spell_id(self, spell_id):
        auras = []
        for aura in self.active_auras.values():
            if aura.spell_id != spell_id:
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
        self.write_aura_to_unit(aura, clear=True)
        self.write_aura_flag_to_unit(aura, clear=True)

        data = pack('<Bi', aura.index, 0)

        self.active_auras.pop(aura.index)

        self.unit_mgr.set_dirty()

    def cancel_auras_by_spell_id(self, spell_id):
        auras = self.get_auras_by_spell_id(spell_id)

        for aura in auras:
            self.remove_aura(aura)

    def send_aura_duration(self, aura):
        if self.unit_mgr.get_type() != ObjectTypes.TYPE_PLAYER:
            return

        data = pack('<Bi', aura.index, aura.duration_entry.Duration)
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

    def get_next_aura_index(self):
        for i in range(0, 30):
            if i not in self.active_auras:
                return i
        return None
