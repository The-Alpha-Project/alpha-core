from game.world.managers.objects.units.player.StatManager import UnitStats
from game.world.managers.objects.spell import ExtendedSpellData
from utils.Logger import Logger
from utils.constants.MiscCodes import ObjectTypes, MoveFlags
from utils.constants.SpellCodes import ShapeshiftForms, AuraTypes, SpellSchoolMask
from utils.constants.UnitCodes import UnitFlags
from utils.constants.UpdateFields import UnitFields


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

        faction = aura.target.team if effect_target.get_type() == ObjectTypes.TYPE_PLAYER else 0
        model_info = ExtendedSpellData.ShapeshiftInfo.get_form_model_info(form, faction)

        if remove or not model_info[0]:
            effect_target.reset_display_id()
            effect_target.reset_scale()
            effect_target.set_dirty()
            return

        effect_target.set_display_id(model_info[0])
        effect_target.set_scale(model_info[1])
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
    def handle_periodic_trigger_spell(aura, effect_target, remove):
        if not aura.is_past_next_period() or remove:
            return
        new_spell_entry = aura.spell_effect.trigger_spell_entry
        spell = effect_target.spell_manager.try_initialize_spell(new_spell_entry, effect_target, aura.source_spell.initial_target,
                                                                 aura.source_spell.spell_target_mask, validate=False)
        effect_target.spell_manager.start_spell_cast(initialized_spell=spell, is_trigger=True)

    @staticmethod
    def handle_periodic_healing(aura, effect_target, remove):
        if not aura.is_past_next_period() or remove:
            return
        spell = aura.source_spell
        healing = aura.get_effect_points()
        aura.caster.apply_spell_healing(effect_target, healing, spell, is_periodic=True)

    @staticmethod
    def handle_periodic_energize(aura, effect_target, remove):
        if not aura.is_past_next_period() or remove:
            return
        power_type = aura.spell_effect.misc_value

        amount = aura.get_effect_points()
        effect_target.receive_power(amount, power_type)

    @staticmethod
    def handle_periodic_damage(aura, effect_target, remove):
        if not aura.is_past_next_period() or remove:
            return
        spell = aura.source_spell
        damage = aura.get_effect_points()
        aura.caster.apply_spell_damage(effect_target, damage, spell, is_periodic=True)

    @staticmethod
    def handle_periodic_leech(aura, effect_target, remove):
        if not aura.is_past_next_period() or remove:
            return
        spell = aura.source_spell
        damage = aura.get_effect_points()
        aura.caster.apply_spell_damage(effect_target, damage, spell, is_periodic=True)
        effect_target.receive_healing(damage, aura.caster)

    # Proc effects are called each time the proc condition is met.
    @staticmethod
    def handle_proc_trigger_spell(aura, effect_target, remove):
        if remove:
            return

        proc_chance = aura.source_spell.spell_entry.ProcChance
        if not aura.target.stat_manager.roll_proc_chance(proc_chance):
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

        effect_target.spell_manager.start_spell_cast(initialized_spell=spell, is_trigger=True)

    @staticmethod
    def handle_proc_trigger_damage(aura, effect_target, remove):
        if remove:
            return

        proc_chance = aura.source_spell.spell_entry.ProcChance
        if not aura.target.stat_manager.roll_proc_chance(proc_chance):
            return

        damage = aura.get_effect_points()
        aura.target.apply_spell_damage(effect_target, damage, aura.source_spell)

    @staticmethod
    def handle_feign_death(aura, effect_target, remove):
        effect_target.mirror_timers_manager.feign_death = not remove

    @staticmethod
    def handle_mod_stun(aura, effect_target, remove):
        # TODO Finish implementing stun effect:
        #    - Interrupt spell casting.
        #    - Prevent units from attacking while stunned.
        #    - UnitStates in 0.5.3? (UNIT_STAT_STUNNED in VMaNGOS).

        # Player specific.
        if effect_target.get_type() == ObjectTypes.TYPE_PLAYER:
            # Don't stun if player is flying.
            if effect_target.pending_taxi_destination:
                return

            # Root player.
            effect_target.set_root(not remove)
            # Release loot if any.
            if effect_target.current_loot_selection != 0:
                effect_target.send_loot_release()

        if not remove:
            effect_target.unit_flags |= UnitFlags.UNIT_FLAG_DISABLE_ROTATE
            effect_target.movement_flags |= MoveFlags.MOVEFLAG_ROOTED
            effect_target.movement_manager.send_move_stop()
        else:
            effect_target.movement_flags &= ~MoveFlags.MOVEFLAG_ROOTED
            effect_target.unit_flags &= ~UnitFlags.UNIT_FLAG_DISABLE_ROTATE

        effect_target.set_uint32(UnitFields.UNIT_FIELD_FLAGS, effect_target.unit_flags)

    @staticmethod
    def handle_mod_resistance(aura, effect_target, remove):
        if remove:
            effect_target.stat_manager.remove_aura_stat_bonus(aura.index)
            return

        if aura.spell_effect.misc_value == -1:
            stat_type = UnitStats.ALL_RESISTANCES
        else:
            # Shift RESISTANCE_START to get the proper flag value
            stat_type = UnitStats.RESISTANCE_START << aura.spell_effect.misc_value

        amount = aura.get_effect_points()
        effect_target.stat_manager.apply_aura_stat_bonus(aura.index, stat_type, amount)

    @staticmethod
    def handle_mod_base_resistance(aura, effect_target, remove):
        # This handler is a slight exception to the usual handling of aura stat modifiers.
        # Only this effect modifies base stats and is used by the Toughness talent which increases armor.
        # Since this is a slight exception, handle this case more specifically by changing *one* base stat of the unit.

        amount = aura.get_effect_points()
        if aura.spell_effect.misc_value == -1:
            # stat_type = UnitStats.ALL_RESISTANCES
            stat_type = UnitStats.RESISTANCE_PHYSICAL

            # This case shouldn't exist with an unmodified database.
            Logger.warning("[AuraEffectHandler]: Unsupported behaviour in handle_mod_base_resistance.")
        else:
            stat_type = UnitStats.RESISTANCE_START << aura.spell_effect.misc_value

        base_stat = effect_target.stat_manager.get_base_stat(stat_type)

        if remove:
            new_value = max(base_stat - amount, 0)  # Avoid <0, though it should never occur.
        else:
            new_value = base_stat + amount

        effect_target.stat_manager.base_stats[stat_type] = new_value

    @staticmethod
    def handle_mod_stat(aura, effect_target, remove):
        if remove:
            effect_target.stat_manager.remove_aura_stat_bonus(aura.index)
            return

        if aura.spell_effect.misc_value == -1:
            stat_type = UnitStats.ALL_ATTRIBUTES
        else:
            stat_type = UnitStats.ATTRIBUTE_START << aura.spell_effect.misc_value

        amount = aura.get_effect_points()
        effect_target.stat_manager.apply_aura_stat_bonus(aura.index, stat_type, amount)

    @staticmethod
    def handle_mod_percent_stat(aura, effect_target, remove):
        if remove:
            effect_target.stat_manager.remove_aura_stat_bonus(aura.index, percentual=True)
            return
        stat_type = aura.spell_effect.misc_value
        amount = aura.get_effect_points()
        effect_target.stat_manager.apply_aura_stat_bonus(aura.index, stat_type, amount, percentual=True)

    @staticmethod
    def handle_mod_regen(aura, effect_target, remove):
        if remove:
            effect_target.stat_manager.remove_aura_stat_bonus(aura.index)
            return
        amount = aura.get_effect_points()
        effect_target.stat_manager.apply_aura_stat_bonus(aura.index, UnitStats.HEALTH_REGENERATION_PER_5, amount)

    @staticmethod
    def handle_mod_health_regen_percent(aura, effect_target, remove):
        if remove:
            effect_target.stat_manager.remove_aura_stat_bonus(aura.index, percentual=True)
            return
        amount = aura.get_effect_points()
        effect_target.stat_manager.apply_aura_stat_bonus(aura.index, UnitStats.HEALTH_REGENERATION_PER_5, amount, percentual=True)

    @staticmethod
    def handle_mod_power_regen(aura, effect_target, remove):
        if remove:
            effect_target.stat_manager.remove_aura_stat_bonus(aura.index)
            return
        amount = aura.get_effect_points()
        effect_target.stat_manager.apply_aura_stat_bonus(aura.index, UnitStats.POWER_REGENERATION_PER_5, amount)

    @staticmethod
    def handle_mod_skill(aura, effect_target, remove):
        if remove:
            effect_target.stat_manager.remove_aura_stat_bonus(aura.index)
            return
        amount = aura.get_effect_points()
        skill_type = aura.spell_effect.misc_value
        effect_target.stat_manager.apply_aura_stat_bonus(aura.index, UnitStats.SKILL, amount, misc_value=skill_type)

    @staticmethod
    def handle_increase_health(aura, effect_target, remove):
        if remove:
            effect_target.stat_manager.remove_aura_stat_bonus(aura.index)
            return
        amount = aura.get_effect_points()
        effect_target.stat_manager.apply_aura_stat_bonus(aura.index, UnitStats.HEALTH, amount)

    @staticmethod
    def handle_increase_mana(aura, effect_target, remove):
        if remove:
            effect_target.stat_manager.remove_aura_stat_bonus(aura.index)
            return
        amount = aura.get_effect_points()
        effect_target.stat_manager.apply_aura_stat_bonus(aura.index, UnitStats.MANA, amount)

    @staticmethod
    def handle_mod_power_cost_school(aura, effect_target, remove):
        if remove:
            effect_target.stat_manager.remove_aura_stat_bonus(aura.index)
            return
        amount = aura.get_effect_points()
        effect_target.stat_manager.apply_aura_stat_bonus(aura.index, UnitStats.SCHOOL_POWER_COST, amount, misc_value=aura.spell_effect.misc_value)

    @staticmethod
    def handle_increase_speed(aura, effect_target, remove):
        if remove:
            effect_target.stat_manager.remove_aura_stat_bonus(aura.index, percentual=True)
            return
        amount = aura.get_effect_points()
        effect_target.stat_manager.apply_aura_stat_bonus(aura.index, UnitStats.SPEED_RUNNING, amount, percentual=True)

    @staticmethod
    def handle_decrease_speed(aura, effect_target, remove):
        if remove:
            effect_target.stat_manager.remove_aura_stat_bonus(aura.index, percentual=True)
            return
        # Points are positive in dbc
        amount = -aura.get_effect_points()
        effect_target.stat_manager.apply_aura_stat_bonus(aura.index, UnitStats.SPEED_RUNNING, amount, percentual=True)

    @staticmethod
    def handle_increase_swim_speed(aura, effect_target, remove):
        if remove:
            effect_target.stat_manager.remove_aura_stat_bonus(aura.index, percentual=True)
            return
        amount = aura.get_effect_points()
        effect_target.stat_manager.apply_aura_stat_bonus(aura.index, UnitStats.SPEED_SWIMMING, amount, percentual=True)

    @staticmethod
    def handle_mod_damage_done(aura, effect_target, remove):
        # Note: These bonuses are all flat
        if remove:
            effect_target.stat_manager.remove_aura_stat_bonus(aura.index, percentual=False)
            return
        amount = aura.get_effect_points()

        # Weapon specializations. All of these auras have either -1 or 2 as item class.
        if aura.source_spell.spell_entry.EquippedItemClass == 2:
            misc_value = aura.source_spell.spell_entry.EquippedItemSubclass  # Weapon type mask
            effect_target.stat_manager.apply_aura_stat_bonus(aura.index, UnitStats.DAMAGE_DONE_WEAPON, amount,
                                                             percentual=False, misc_value=misc_value)
            return

        misc_value = aura.spell_effect.misc_value  # Spell school

        effect_target.stat_manager.apply_aura_stat_bonus(aura.index, UnitStats.DAMAGE_DONE_SCHOOL, amount,
                                                         percentual=False, misc_value=misc_value)

    @staticmethod
    def handle_mod_damage_taken(aura, effect_target, remove):
        if remove:
            effect_target.stat_manager.remove_aura_stat_bonus(aura.index, percentual=False)
            return
        amount = aura.get_effect_points()
        misc_value = aura.spell_effect.misc_value  # Spell school

        # Fatigued (3271) is the only spell with a negative misc value (-2).
        # There are no descriptions, but in VMaNGOS this is handled as all schools.
        # -1 is handled as all magic schools, but doesn't exist in the database.
        if misc_value == -2:
            spell_school = SpellSchoolMask.SPELL_SCHOOL_MASK_ALL
        elif misc_value == -1:
            spell_school = SpellSchoolMask.SPELL_SCHOOL_MASK_SPELL
        else:
            spell_school = 1 << misc_value

        effect_target.stat_manager.apply_aura_stat_bonus(aura.index, UnitStats.DAMAGE_TAKEN_SCHOOL, amount,
                                                         percentual=False, misc_value=spell_school)

    @staticmethod
    def handle_mod_damage_done_creature(aura, effect_target, remove):
        if remove:
            effect_target.stat_manager.remove_aura_stat_bonus(aura.index, percentual=False)
            return
        amount = aura.get_effect_points()
        misc_value = aura.spell_effect.misc_value  # CreatureTypes

        effect_target.stat_manager.apply_aura_stat_bonus(aura.index, UnitStats.DAMAGE_DONE_CREATURE_TYPE, amount,
                                                         percentual=False, misc_value=misc_value)


AURA_EFFECTS = {
    AuraTypes.SPELL_AURA_MOD_SHAPESHIFT: AuraEffectHandler.handle_shapeshift,
    AuraTypes.SPELL_AURA_MOUNTED: AuraEffectHandler.handle_mounted,
    AuraTypes.SPELL_AURA_PERIODIC_TRIGGER_SPELL: AuraEffectHandler.handle_periodic_trigger_spell,
    AuraTypes.SPELL_AURA_PERIODIC_HEAL: AuraEffectHandler.handle_periodic_healing,
    AuraTypes.SPELL_AURA_PERIODIC_ENERGIZE: AuraEffectHandler.handle_periodic_energize,
    AuraTypes.SPELL_AURA_PERIODIC_DAMAGE: AuraEffectHandler.handle_periodic_damage,
    AuraTypes.SPELL_AURA_PERIODIC_LEECH: AuraEffectHandler.handle_periodic_leech,
    AuraTypes.SPELL_AURA_PROC_TRIGGER_SPELL: AuraEffectHandler.handle_proc_trigger_spell,
    AuraTypes.SPELL_AURA_PROC_TRIGGER_DAMAGE: AuraEffectHandler.handle_proc_trigger_damage,
    AuraTypes.SPELL_AURA_FEIGN_DEATH: AuraEffectHandler.handle_feign_death,
    AuraTypes.SPELL_AURA_MOD_STUN: AuraEffectHandler.handle_mod_stun,

    AuraTypes.SPELL_AURA_MOD_RESISTANCE: AuraEffectHandler.handle_mod_resistance,
    AuraTypes.SPELL_AURA_MOD_BASE_RESISTANCE: AuraEffectHandler.handle_mod_base_resistance,
    AuraTypes.SPELL_AURA_MOD_STAT: AuraEffectHandler.handle_mod_stat,
    AuraTypes.SPELL_AURA_MOD_REGEN: AuraEffectHandler.handle_mod_regen,
    AuraTypes.SPELL_AURA_MOD_HEALTH_REGEN_PERCENT: AuraEffectHandler.handle_mod_health_regen_percent,
    AuraTypes.SPELL_AURA_MOD_POWER_REGEN: AuraEffectHandler.handle_mod_power_regen,
    AuraTypes.SPELL_AURA_MOD_SKILL: AuraEffectHandler.handle_mod_skill,
    AuraTypes.SPELL_AURA_MOD_INCREASE_HEALTH: AuraEffectHandler.handle_increase_health,
    AuraTypes.SPELL_AURA_MOD_INCREASE_MANA: AuraEffectHandler.handle_increase_mana,
    AuraTypes.SPELL_AURA_MOD_PERCENT_STAT: AuraEffectHandler.handle_mod_percent_stat,
    AuraTypes.SPELL_AURA_MOD_POWER_COST_SCHOOL: AuraEffectHandler.handle_mod_power_cost_school,
    AuraTypes.SPELL_AURA_MOD_INCREASE_SPEED: AuraEffectHandler.handle_increase_speed,
    AuraTypes.SPELL_AURA_MOD_INCREASE_MOUNTED_SPEED: AuraEffectHandler.handle_increase_speed,
    AuraTypes.SPELL_AURA_MOD_DECREASE_SPEED: AuraEffectHandler.handle_decrease_speed,
    AuraTypes.SPELL_AURA_MOD_INCREASE_SWIM_SPEED: AuraEffectHandler.handle_increase_swim_speed,

    AuraTypes.SPELL_AURA_MOD_DAMAGE_TAKEN: AuraEffectHandler.handle_mod_damage_taken,

    AuraTypes.SPELL_AURA_MOD_DAMAGE_DONE: AuraEffectHandler.handle_mod_damage_done,
    AuraTypes.SPELL_AURA_MOD_DAMAGE_DONE_CREATURE: AuraEffectHandler.handle_mod_damage_done_creature
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
