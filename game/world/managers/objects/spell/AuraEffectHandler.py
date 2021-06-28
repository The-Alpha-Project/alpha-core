from utils.ConfigManager import config
from utils.Logger import Logger
from utils.constants.MiscCodes import Factions, ObjectTypes
from utils.constants.SpellCodes import ShapeshiftForms, AuraTypes


class AuraEffectHandler:
    @staticmethod
    def handle_aura_effect_change(aura, remove=False):
        # if aura.spell_effect.effect_type != SpellEffects.SPELL_EFFECT_APPLY_AURA:
        #     return  # TODO check all effects that apply auras
        if aura.spell_effect.aura_type not in AURA_EFFECTS:
            Logger.debug(f'Unimplemented aura effect called: {aura.spell_effect.aura_type}')
            return

        AURA_EFFECTS[aura.spell_effect.aura_type](aura, remove)

    @staticmethod
    def handle_shapeshift(aura, remove):
        form = aura.spell_effect.misc_value if not remove else ShapeshiftForms.SHAPESHIFT_FORM_NONE
        aura.target.set_shapeshift_form(form)
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
    def handle_mounted(aura, remove):  # TODO Summon Nightmare (5784) does not apply for other players ?
        if remove:
            aura.target.unmount()
            aura.target.set_dirty()
            return

        creature_entry = aura.spell_effect.misc_value
        if not aura.target.summon_mount(creature_entry):
            Logger.error(f'SPELL_AURA_MOUNTED: Creature template ({creature_entry}) not found in database.')

    @staticmethod
    def handle_increase_mounted_speed(aura, remove):
        # TODO: Should handle for creatures too? (refactor all change speed methods?)
        if aura.target.get_type() != ObjectTypes.TYPE_PLAYER:
            return
        aura.target.change_speed()
        if remove:
            return

        default_speed = config.Unit.Defaults.run_speed
        speed_percentage = aura.spell_effect.get_effect_points(aura.effective_level) / 100.0
        aura.target.change_speed(default_speed + (default_speed * speed_percentage))

    @staticmethod
    def handle_periodic_trigger_spell(aura, remove):
        if not aura.is_past_next_period() or remove:
            return
        new_spell_entry = aura.spell_effect.trigger_spell_entry
        spell = aura.caster.spell_manager.try_initialize_spell(new_spell_entry, aura.caster, aura.source_spell.initial_target,
                                                               aura.source_spell.spell_target_mask, validate=False)
        aura.caster.spell_manager.start_spell_cast(None, None, None, None, initialized_spell=spell, is_trigger=True)

    @staticmethod
    def handle_periodic_healing(aura, remove):
        if not aura.is_past_next_period_timestamp() or remove:
            return
        aura.pop_period_timestamp()

        spell = aura.source_spell
        healing = aura.spell_effect.get_effect_points(aura.spell_effect.caster_effective_level)
        aura.caster.apply_spell_healing(aura.target, healing, spell.spell_entry.School, spell.spell_entry.ID)

    @staticmethod
    def handle_periodic_damage(aura, remove):
        if not aura.is_past_next_period() or remove:
            return
        spell = aura.source_spell
        damage = aura.spell_effect.get_effect_points(aura.spell_effect.caster_effective_level)
        aura.caster.deal_spell_damage(aura.target, damage, spell, is_periodic=True)

    @staticmethod
    def handle_periodic_leech(aura, remove):
        if not aura.is_past_next_period() or remove:
            return
        spell = aura.source_spell
        damage = aura.spell_effect.get_effect_points(aura.spell_effect.caster_effective_level)
        aura.caster.deal_spell_damage(aura.target, damage, spell, is_periodic=True)
        # TODO Heal


AURA_EFFECTS = {
    AuraTypes.SPELL_AURA_MOD_SHAPESHIFT: AuraEffectHandler.handle_shapeshift,
    AuraTypes.SPELL_AURA_MOUNTED: AuraEffectHandler.handle_mounted,
    AuraTypes.SPELL_AURA_MOD_INCREASE_MOUNTED_SPEED: AuraEffectHandler.handle_increase_mounted_speed,
    AuraTypes.SPELL_AURA_PERIODIC_TRIGGER_SPELL: AuraEffectHandler.handle_periodic_trigger_spell,
    AuraTypes.SPELL_AURA_PERIODIC_HEAL: AuraEffectHandler.handle_periodic_healing,
    AuraTypes.SPELL_AURA_PERIODIC_DAMAGE: AuraEffectHandler.handle_periodic_damage,
    AuraTypes.SPELL_AURA_PERIODIC_LEECH: AuraEffectHandler.handle_periodic_leech,
}

# Alliance / Default display_id, Horde display_id, Scale
SHAPESHIFT_MODEL_IDS = {
    ShapeshiftForms.SHAPESHIFT_FORM_CAT: (892, 892, 0.8),
    ShapeshiftForms.SHAPESHIFT_FORM_TREE: (864, 864, 1.0),
    ShapeshiftForms.SHAPESHIFT_FORM_AQUATIC: (2428, 2428, 0.8),
    ShapeshiftForms.SHAPESHIFT_FORM_BEAR: (2281, 2289, 1.0)
}