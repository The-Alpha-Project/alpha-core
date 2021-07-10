import random

from utils.ConfigManager import config
from utils.Logger import Logger
from utils.constants.MiscCodes import Factions, ObjectTypes
from utils.constants.SpellCodes import ShapeshiftForms, AuraTypes
from utils.constants.UnitCodes import Teams


class AuraEffectHandler:
    @staticmethod
    def handle_aura_effect_change(aura, effect_target, remove=False, is_proc=False):
        aura_type = aura.spell_effect.aura_type
        if aura_type not in AURA_EFFECTS:
            Logger.debug(f'Unimplemented aura effect called: {aura.spell_effect.aura_type}')
            return

        if not is_proc and aura_type in PROC_AURA_EFFECTS:
            return  # Only call proc effects when a proc happens.

        AURA_EFFECTS[aura.spell_effect.aura_type](aura, effect_target, remove)

    @staticmethod
    def handle_shapeshift(aura, effect_target, remove):
        form = aura.spell_effect.misc_value if not remove else ShapeshiftForms.SHAPESHIFT_FORM_NONE
        effect_target.set_shapeshift_form(form)
        if remove or aura.spell_effect.misc_value not in SHAPESHIFT_MODEL_IDS:
            effect_target.reset_display_id()
            effect_target.reset_scale()
            effect_target.set_dirty()
            return

        shapeshift_display_info = SHAPESHIFT_MODEL_IDS[aura.spell_effect.misc_value]
        if effect_target.get_type() == ObjectTypes.TYPE_PLAYER:
            display_index = 1 if aura.target.team == Teams.TEAM_HORDE else 0
        else:  # For creatures default to Alliance form for now.
            display_index = 0
        model_scale = shapeshift_display_info[2]
        effect_target.set_display_id(shapeshift_display_info[display_index])
        effect_target.set_scale(model_scale)
        effect_target.set_dirty()

    @staticmethod
    def handle_mounted(aura, effect_target, remove):  # TODO Summon Nightmare (5784) does not apply for other players ?
        if remove:
            effect_target.unmount()
            effect_target.set_dirty()
            return

        creature_entry = aura.spell_effect.misc_value
        if not effect_target.summon_mount(creature_entry):
            Logger.error(f'SPELL_AURA_MOUNTED: Creature template ({creature_entry}) not found in database.')

    @staticmethod
    def handle_increase_mounted_speed(aura, effect_target, remove):
        # TODO: Should handle for creatures too? (refactor all change speed methods?)
        if effect_target.get_type() != ObjectTypes.TYPE_PLAYER:
            return
        effect_target.change_speed()
        if remove:
            return

        default_speed = config.Unit.Defaults.run_speed
        speed_percentage = aura.spell_effect.get_effect_points(aura.effective_level) / 100.0
        effect_target.change_speed(default_speed + (default_speed * speed_percentage))

    @staticmethod
    def handle_periodic_trigger_spell(aura, effect_target, remove):
        if not aura.is_past_next_period() or remove:
            return
        new_spell_entry = aura.spell_effect.trigger_spell_entry
        spell = effect_target.spell_manager.try_initialize_spell(new_spell_entry, effect_target, aura.source_spell.initial_target,
                                                                 aura.source_spell.spell_target_mask, validate=False)
        effect_target.spell_manager.start_spell_cast(None, None, None, None, initialized_spell=spell, is_trigger=True)

    @staticmethod
    def handle_periodic_healing(aura, effect_target, remove):
        if not aura.is_past_next_period() or remove:
            return
        spell = aura.source_spell
        healing = aura.spell_effect.get_effect_points(aura.spell_effect.caster_effective_level)
        aura.caster.apply_spell_healing(effect_target, healing, spell, is_periodic=True)

    @staticmethod
    def handle_periodic_energize(aura, effect_target, remove):
        if not aura.is_past_next_period() or remove:
            return
        power_type = aura.spell_effect.misc_value

        amount = aura.spell_effect.get_effect_points(aura.spell_effect.caster_effective_level)
        effect_target.receive_power(amount, power_type)

    @staticmethod
    def handle_periodic_damage(aura, effect_target, remove):
        if not aura.is_past_next_period() or remove:
            return
        spell = aura.source_spell
        damage = aura.spell_effect.get_effect_points(aura.spell_effect.caster_effective_level)
        aura.caster.apply_spell_damage(effect_target, damage, spell, is_periodic=True)

    @staticmethod
    def handle_periodic_leech(aura, effect_target, remove):
        if not aura.is_past_next_period() or remove:
            return
        spell = aura.source_spell
        damage = aura.spell_effect.get_effect_points(aura.spell_effect.caster_effective_level)
        aura.caster.apply_spell_damage(effect_target, damage, spell, is_periodic=True)
        effect_target.receive_healing(damage, aura.caster)

    # Proc effects are called each time the proc condition is met.
    @staticmethod
    def handle_proc_trigger_spell(aura, effect_target, remove):
        if remove:
            return

        proc_chance = aura.source_spell.spell_entry.ProcChance
        if random.randint(1, 100) > proc_chance:
            return

        new_spell_entry = aura.spell_effect.trigger_spell_entry

        # Before choosing the initial target for the spell, it will need to be initialized so we can use EffectTargets methods.
        # This is fine since targets are resolved on cast, not on initialization.
        caster = aura.target
        spell = caster.spell_manager.try_initialize_spell(new_spell_entry, caster, caster,
                                                          aura.source_spell.spell_target_mask, validate=False)

        # If an effect of this spell can't target friendly, set the cast target to the effect target.
        # Effect target will be set to the second (non-self) target in the proc call. (see AuraManager.check_aura_procs)
        for effect in spell.effects:
            if not effect.targets.can_target_friendly():
                spell.initial_target = effect_target
                break

        effect_target.spell_manager.start_spell_cast(None, None, None, None, initialized_spell=spell, is_trigger=True)

    @staticmethod
    def handle_proc_trigger_damage(aura, effect_target, remove):
        if remove:
            return

        proc_chance = aura.source_spell.spell_entry.ProcChance
        if random.randint(1, 100) > proc_chance:
            return

        damage = aura.spell_effect.get_effect_points(aura.source_spell.caster_effective_level)
        aura.target.apply_spell_damage(effect_target, damage, aura.source_spell)


AURA_EFFECTS = {
    AuraTypes.SPELL_AURA_MOD_SHAPESHIFT: AuraEffectHandler.handle_shapeshift,
    AuraTypes.SPELL_AURA_MOUNTED: AuraEffectHandler.handle_mounted,
    AuraTypes.SPELL_AURA_MOD_INCREASE_MOUNTED_SPEED: AuraEffectHandler.handle_increase_mounted_speed,
    AuraTypes.SPELL_AURA_PERIODIC_TRIGGER_SPELL: AuraEffectHandler.handle_periodic_trigger_spell,
    AuraTypes.SPELL_AURA_PERIODIC_HEAL: AuraEffectHandler.handle_periodic_healing,
    AuraTypes.SPELL_AURA_PERIODIC_ENERGIZE: AuraEffectHandler.handle_periodic_energize,
    AuraTypes.SPELL_AURA_PERIODIC_DAMAGE: AuraEffectHandler.handle_periodic_damage,
    AuraTypes.SPELL_AURA_PERIODIC_LEECH: AuraEffectHandler.handle_periodic_leech,
    AuraTypes.SPELL_AURA_PROC_TRIGGER_SPELL: AuraEffectHandler.handle_proc_trigger_spell,
    AuraTypes.SPELL_AURA_PROC_TRIGGER_DAMAGE: AuraEffectHandler.handle_proc_trigger_damage
}

PROC_AURA_EFFECTS = [
    AuraTypes.SPELL_AURA_PROC_TRIGGER_SPELL,
    AuraTypes.SPELL_AURA_PROC_TRIGGER_DAMAGE
]

# Alliance / Default display_id, Horde display_id, Scale
SHAPESHIFT_MODEL_IDS = {
    ShapeshiftForms.SHAPESHIFT_FORM_CAT: (892, 892, 0.8),
    ShapeshiftForms.SHAPESHIFT_FORM_TREE: (864, 864, 1.0),
    ShapeshiftForms.SHAPESHIFT_FORM_AQUATIC: (2428, 2428, 0.8),
    ShapeshiftForms.SHAPESHIFT_FORM_BEAR: (2281, 2289, 1.0)
}
