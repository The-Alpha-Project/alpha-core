from game.world.managers.objects.player.DuelManager import DuelManager
from utils.Logger import Logger
from utils.constants.ObjectCodes import ObjectTypes
from utils.constants.SpellCodes import SpellCheckCastResult, AuraTypes, SpellEffects
from utils.constants.UnitCodes import PowerTypes, UnitFlags


class SpellEffectHandler(object):
    @staticmethod
    def apply_effect(casting_spell, effect, target):
        if effect.effect_type not in SPELL_EFFECTS:
            Logger.debug(f'Unimplemented effect called: {effect.effect_type}')
            return
        SPELL_EFFECTS[effect.effect_type](casting_spell, effect, casting_spell.spell_caster, target)

    @staticmethod
    def handle_school_damage(casting_spell, effect, caster, target):
        damage = effect.get_effect_points(casting_spell.caster_effective_level)
        caster.deal_spell_damage(target, damage, casting_spell.spell_entry.School, casting_spell.spell_entry.ID)

    @staticmethod
    def handle_heal(casting_spell, effect, caster, target):
        healing = effect.get_effect_points(casting_spell.caster_effective_level)

    @staticmethod
    def handle_weapon_damage(casting_spell, effect, caster, target):
        damage_info = caster.calculate_melee_damage(target, casting_spell.spell_attack_type)
        if not damage_info:
            return
        damage = damage_info.total_damage + effect.get_effect_points(casting_spell.caster_effective_level)
        caster.deal_spell_damage(target, damage, casting_spell.spell_entry.School, casting_spell.spell_entry.ID)

    @staticmethod
    def handle_weapon_damage_plus(casting_spell, effect, caster, target):
        damage_info = caster.calculate_melee_damage(target, casting_spell.spell_attack_type)
        if not damage_info:
            return
        damage = damage_info.total_damage
        damage_bonus = effect.get_effect_points(casting_spell.caster_effective_level)

        if caster.get_type() == ObjectTypes.TYPE_PLAYER and \
                casting_spell.requires_combo_points():
            damage_bonus *= caster.combo_points

        caster.deal_spell_damage(target, damage + damage_bonus, casting_spell.spell_entry.School, casting_spell.spell_entry.ID)

    @staticmethod
    def handle_add_combo_points(casting_spell, effect, caster, target):
        caster.add_combo_points_on_target(target, effect.get_effect_points(casting_spell.caster_effective_level))

    @staticmethod
    def handle_aura_application(casting_spell, effect, caster, target):
        target.aura_manager.apply_spell_effect_aura(caster, casting_spell, effect)

    @staticmethod
    def handle_request_duel(casting_spell, effect, caster, target):
        duel_result = DuelManager.request_duel(caster, target, effect.misc_value)
        if duel_result == 1:
            result = SpellCheckCastResult.SPELL_NO_ERROR
        elif duel_result == 0:
            result = SpellCheckCastResult.SPELL_FAILED_TARGET_DUELING
        else:
            result = SpellCheckCastResult.SPELL_FAILED_DONT_REPORT
        caster.spell_manager.send_cast_result(casting_spell.spell_entry.ID, result)

    @staticmethod
    def handle_energize(casting_spell, effect, caster, target):
        power_type = effect.misc_value

        if power_type != target.power_type:
            return

        new_power = target.get_power_type_value() + effect.get_effect_points(casting_spell.caster_effective_level)
        if power_type == PowerTypes.TYPE_MANA:
            target.set_mana(new_power)
        elif power_type == PowerTypes.TYPE_RAGE:
            target.set_rage(new_power)
        elif power_type == PowerTypes.TYPE_FOCUS:
            target.set_focus(new_power)
        elif power_type == PowerTypes.TYPE_ENERGY:
            target.set_energy(new_power)

    @staticmethod
    def handle_summon_mount(casting_spell, effect, caster, target):
        already_mounted = target.unit_flags & UnitFlags.UNIT_MASK_MOUNTED
        if already_mounted:
            # Remove any existing mount auras.
            target.aura_manager.remove_auras_by_type(AuraTypes.SPELL_AURA_MOUNTED)
            target.aura_manager.remove_auras_by_type(AuraTypes.SPELL_AURA_MOD_INCREASE_MOUNTED_SPEED)
            # Force dismount if target is still mounted (like a previous SPELL_EFFECT_SUMMON_MOUNT that doesn't
            # leave any applied aura).
            if target.mount_display_id > 0:
                target.unmount()
                target.set_dirty()
        else:
            creature_entry = effect.misc_value
            if not target.summon_mount(creature_entry):
                Logger.error(f'SPELL_EFFECT_SUMMON_MOUNT: Creature template ({creature_entry}) not found in database.')

    @staticmethod
    def handle_insta_kill(casting_spell, effect, caster, target):
        # No SMSG_SPELLINSTAKILLLOG in 0.5.3
        target.die(killer=caster)

    @staticmethod
    def handle_create_item(casting_spell, effect, caster, target):
        if target.get_type() != ObjectTypes.TYPE_PLAYER:
            return

        target.inventory.add_item(effect.item_type,
                                  count=effect.get_effect_points(casting_spell.caster_effective_level))

    @staticmethod
    def handle_teleport_units(casting_spell, effect, caster, target):
        teleport_info = effect.targets.implicit_target_b
        target.teleport(teleport_info[0], teleport_info[1])  # map, coordinates resolved
        # TODO Die sides are assigned for at least Word of Recall (ID 1)


SPELL_EFFECTS = {
    SpellEffects.SPELL_EFFECT_SCHOOL_DAMAGE: SpellEffectHandler.handle_school_damage,
    SpellEffects.SPELL_EFFECT_HEAL: SpellEffectHandler.handle_heal,
    SpellEffects.SPELL_EFFECT_WEAPON_DAMAGE: SpellEffectHandler.handle_weapon_damage,
    SpellEffects.SPELL_EFFECT_ADD_COMBO_POINTS: SpellEffectHandler.handle_add_combo_points,
    SpellEffects.SPELL_EFFECT_DUEL: SpellEffectHandler.handle_request_duel,
    SpellEffects.SPELL_EFFECT_WEAPON_DAMAGE_PLUS: SpellEffectHandler.handle_weapon_damage_plus,
    SpellEffects.SPELL_EFFECT_APPLY_AURA: SpellEffectHandler.handle_aura_application,
    SpellEffects.SPELL_EFFECT_ENERGIZE: SpellEffectHandler.handle_energize,
    SpellEffects.SPELL_EFFECT_SUMMON_MOUNT: SpellEffectHandler.handle_summon_mount,
    SpellEffects.SPELL_EFFECT_INSTAKILL: SpellEffectHandler.handle_insta_kill,
    SpellEffects.SPELL_EFFECT_CREATE_ITEM: SpellEffectHandler.handle_create_item,
    SpellEffects.SPELL_EFFECT_TELEPORT_UNITS: SpellEffectHandler.handle_teleport_units
}
