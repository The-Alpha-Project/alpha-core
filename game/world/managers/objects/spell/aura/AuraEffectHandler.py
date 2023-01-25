from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.objects.farsight.FarSightManager import FarSightManager
from game.world.managers.objects.spell.aura import AuraEffectDummyHandler
from game.world.managers.objects.units.player.StatManager import UnitStats
from game.world.managers.objects.spell import ExtendedSpellData
from utils.Logger import Logger
from utils.constants.ItemCodes import InventoryError
from utils.constants.MiscCodes import ObjectTypeIds, UnitDynamicTypes, ProcFlags, ObjectTypeFlags
from utils.constants.PetCodes import PetSlot
from utils.constants.SpellCodes import ShapeshiftForms, AuraTypes, SpellSchoolMask, SpellImmunity
from utils.constants.UnitCodes import UnitFlags, UnitStates, PowerTypes
from utils.constants.UpdateFields import UnitFields, PlayerFields, ObjectFields


class AuraEffectHandler:
    @staticmethod
    def handle_aura_effect_change(aura, effect_target, remove=False, is_proc=False):
        if not effect_target:
            return

        aura_type = aura.spell_effect.aura_type
        if aura_type not in AURA_EFFECTS:
            Logger.debug(f'Unimplemented aura effect called ({AuraTypes(aura.spell_effect.aura_type).name}: '
                         f'{aura.spell_effect.aura_type}) from spell {aura.source_spell.spell_entry.ID}.')
            return

        if not remove and not is_proc and aura_type in PROC_AURA_EFFECTS:
            return  # Only call proc effects when a proc happens.

        AURA_EFFECTS[aura.spell_effect.aura_type](aura, effect_target, remove)

    @staticmethod
    def handle_bind_sight(aura, effect_target, remove):
        if not effect_target.get_type_mask() & ObjectTypeFlags.TYPE_UNIT:
            return

        if remove:
            FarSightManager.remove_camera(effect_target)
            aura.caster.set_far_sight(0)
            return

        FarSightManager.add_camera(effect_target, aura.caster)

    @staticmethod
    def handle_aura_dummy(aura, effect_target, remove):
        if aura.source_spell.spell_entry.ID not in AuraEffectDummyHandler.DUMMY_AURA_EFFECTS:
            Logger.warning(f'Unimplemented dummy aura effect for spell {aura.source_spell.spell_entry.ID}.')
            return

        AuraEffectDummyHandler.DUMMY_AURA_EFFECTS[aura.source_spell.spell_entry.ID](aura, effect_target, remove)

    @staticmethod
    def handle_mod_scale(aura, effect_target, remove):
        if not remove:
            scale = effect_target.get_float(ObjectFields.OBJECT_FIELD_SCALE_X) * (100.0+aura.get_effect_points())/100.0
            effect_target.set_scale(scale)
        else:
            scale = effect_target.get_float(ObjectFields.OBJECT_FIELD_SCALE_X) * 100.0/(100.0 + aura.get_effect_points())
            effect_target.set_scale(scale)

    @staticmethod
    def handle_shapeshift(aura, effect_target, remove):
        form = aura.spell_effect.misc_value if not remove else ShapeshiftForms.SHAPESHIFT_FORM_NONE
        effect_target.set_shapeshift_form(form)

        # Upon shapeshift set, we need to force the update upon player(s), else client action bars will misbehave.
        # TODO: Forcing an update goes outside our normal UpdateSystem work flow, this needs further investigation.
        if effect_target.get_type_id() == ObjectTypeIds.ID_PLAYER and effect_target.online and not remove:
            effect_target.force_fields_update()

        faction = aura.target.team if effect_target.get_type_id() == ObjectTypeIds.ID_PLAYER else 0
        model_info = ExtendedSpellData.ShapeshiftInfo.get_form_model_info(form, faction)

        # Shapeshifting can affect current power type and stats (druid shapeshift powers/attack values).
        effect_target.update_power_type()

        # Apply passives associated with this shapeshift.
        passive_spell_ids = ExtendedSpellData.ShapeshiftInfo.SHAPESHIFT_PASSIVE_SPELLS.get(aura.spell_effect.misc_value, {})
        if passive_spell_ids:
            for passive_spell_id in passive_spell_ids:
                if not remove:
                    passive_spell = DbcDatabaseManager.SpellHolder.spell_get_by_id(passive_spell_id)
                    effect_target.spell_manager.apply_passive_spell_effects(passive_spell)
                else:
                    effect_target.aura_manager.cancel_auras_by_spell_id(passive_spell_id)

        effect_target.stat_manager.apply_bonuses()

        if remove or not model_info[0]:
            effect_target.reset_display_id()
            effect_target.reset_scale()
            return

        effect_target.set_display_id(model_info[0])
        effect_target.set_scale(model_info[1])

    @staticmethod
    def handle_mounted(aura, effect_target, remove):  # TODO Summon Nightmare (5784) does not apply for other players ?
        if remove:
            effect_target.unmount()
            return

        creature_entry = aura.spell_effect.misc_value
        if not effect_target.summon_mount(creature_entry):
            Logger.error(f'SPELL_AURA_MOUNTED: Creature template ({creature_entry}) not found in database.')

    @staticmethod
    def handle_periodic_trigger_spell(aura, effect_target, remove):
        if not aura.is_past_next_period() or remove:
            return
        trigger_spell_id = aura.spell_effect.trigger_spell_id
        spell = aura.source_spell
        effect_target.spell_manager.handle_cast_attempt(trigger_spell_id, spell.initial_target, spell.spell_target_mask,
                                                        validate=False, triggered=True)

    @staticmethod
    def handle_periodic_mana_leech(aura, effect_target, remove):
        if not aura.is_past_next_period() or remove:
            return
        amount = aura.get_effect_points()

        amount = min(amount, effect_target.get_power_value(PowerTypes.TYPE_MANA))
        effect_target.receive_power(-amount, PowerTypes.TYPE_MANA)
        aura.caster.receive_power(amount, PowerTypes.TYPE_MANA, source=effect_target)

    @staticmethod
    def handle_periodic_healing(aura, effect_target, remove):
        if not aura.is_past_next_period() or remove:
            return

        spell = aura.source_spell
        healing = aura.get_effect_points()

        # Health Funnel is a periodic healing spell, but should act as a leech from the pet owner.
        if effect_target.get_charmer_or_summoner() == aura.caster:
            new_source_health = aura.caster.health - healing
            if new_source_health <= 0:
                aura.caster.spell_manager.remove_cast_by_id(spell.spell_entry.ID, interrupted=True)
                return
            aura.caster.set_health(new_source_health)

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
        damage = aura.get_effect_points()
        aura.caster.apply_spell_damage(effect_target, damage, aura.spell_effect)

    @staticmethod
    def handle_periodic_leech(aura, effect_target, remove):
        if not aura.is_past_next_period() or remove:
            return
        damage = aura.get_effect_points()
        aura.caster.receive_healing(damage, aura.caster)
        aura.caster.apply_spell_damage(effect_target, damage, aura.spell_effect)

    @staticmethod
    def handle_channel_death_item(aura, effect_target, remove):
        if effect_target.is_alive or aura.caster.get_type_id() != ObjectTypeIds.ID_PLAYER:
            return

        item_template = WorldDatabaseManager.ItemTemplateHolder.item_template_get_by_entry(aura.spell_effect.item_type)
        if not item_template:
            aura.caster.inventory.send_equip_error(InventoryError.BAG_UNKNOWN_ITEM)
            return

        amount = aura.get_effect_points()
        # Validate amount, at least 1 item should be created.
        if amount < 1:
            amount = 1
        if amount > item_template.stackable:
            amount = item_template.stackable

        can_store_item = aura.caster.inventory.can_store_item(item_template, amount)
        if can_store_item != InventoryError.BAG_OK:
            aura.caster.inventory.send_equip_error(can_store_item)
            return

        # Add the item to player inventory.
        aura.caster.inventory.add_item(item_template.entry, count=amount)

    # Proc effects are called each time the proc condition is met.
    @staticmethod
    def handle_proc_trigger_spell(aura, effect_target, remove):
        if remove:
            return

        proc_chance = aura.source_spell.spell_entry.ProcChance
        if not aura.target.stat_manager.roll_proc_chance(proc_chance):
            return

        new_spell_entry = DbcDatabaseManager.SpellHolder.spell_get_by_id(aura.spell_effect.trigger_spell_id)

        # Before choosing the initial target for the spell, it will need to be initialized so we can use EffectTargets methods.
        # This is fine since targets are resolved on cast, not on initialization.
        caster = aura.target
        spell = caster.spell_manager.try_initialize_spell(new_spell_entry, caster,
                                                          aura.source_spell.spell_target_mask,
                                                          validate=False, triggered=True)

        # If an effect of this spell can't target friendly, set the cast target to the effect target.
        # Effect target will be set to the second (non-self) target in the proc call. (see AuraManager.check_aura_procs)
        for effect in spell.get_effects():
            if not effect.targets.can_target_friendly():
                spell.initial_target = effect_target
                break

        effect_target.spell_manager.start_spell_cast(initialized_spell=spell)

    @staticmethod
    def handle_track_creatures(aura, effect_target, remove):
        if effect_target.get_type_id() != ObjectTypeIds.ID_PLAYER:
            return

        flag = effect_target.get_uint32(PlayerFields.PLAYER_TRACK_CREATURES)
        if not remove:
            flag |= (1 << (aura.spell_effect.misc_value - 1))
        else:
            flag &= ~(1 << (aura.spell_effect.misc_value - 1))

        effect_target.set_uint32(PlayerFields.PLAYER_TRACK_CREATURES, flag)

    @staticmethod
    def handle_track_resources(aura, effect_target, remove):
        if effect_target.get_type_id() != ObjectTypeIds.ID_PLAYER:
            return

        flag = effect_target.get_uint32(PlayerFields.PLAYER_TRACK_RESOURCES)
        if not remove:
            flag |= (1 << (aura.spell_effect.misc_value - 1))
        else:
            flag &= ~(1 << (aura.spell_effect.misc_value - 1))

        effect_target.set_uint32(PlayerFields.PLAYER_TRACK_RESOURCES, flag)

    @staticmethod
    def handle_proc_trigger_damage(aura, effect_target, remove):
        if remove:
            return

        proc_chance = aura.source_spell.spell_entry.ProcChance
        if not aura.target.stat_manager.roll_proc_chance(proc_chance):
            return

        damage = aura.get_effect_points()
        aura.target.apply_spell_damage(effect_target, damage, aura.spell_effect)

    @staticmethod
    def handle_feign_death(aura, effect_target, remove):
        if not aura.caster.get_type_mask() & ObjectTypeFlags.TYPE_UNIT:
            return
        effect_target.mirror_timers_manager.feign_death = not remove
        if not remove:
            duration = aura.source_spell.get_duration() / 1000
            # Set sanctuary state.
            aura.caster.set_sanctuary(True, time_secs=duration)
        else:
            aura.caster.set_sanctuary(False)

    @staticmethod
    def handle_water_breathing(aura, effect_target, remove):
        effect_target.mirror_timers_manager.update_water_breathing(state=not remove)

    @staticmethod
    def handle_mod_disarm(aura, effect_target, remove):
        if not remove:
            effect_target.unit_flags |= UnitFlags.UNIT_FLAG_DISARMED
        else:
            effect_target.unit_flags &= ~UnitFlags.UNIT_FLAG_DISARMED

        effect_target.set_uint32(UnitFields.UNIT_FIELD_FLAGS, effect_target.unit_flags)
        effect_target.stat_manager.apply_bonuses()

    @staticmethod
    def handle_mod_stalked(aura, effect_target, remove):
        dyn_flags = effect_target.get_uint32(UnitFields.UNIT_DYNAMIC_FLAGS)
        if not remove:
            dyn_flags |= UnitDynamicTypes.UNIT_DYNAMIC_TRACK_UNIT
        else:
            dyn_flags &= ~ UnitDynamicTypes.UNIT_DYNAMIC_TRACK_UNIT

        effect_target.set_uint32(UnitFields.UNIT_DYNAMIC_FLAGS, dyn_flags)

    @staticmethod
    def handle_mod_fear(aura, effect_target, remove):
        if remove:
            effect_target.unit_flags &= ~UnitFlags.UNIT_FLAG_FLEEING
        else:
            if effect_target.get_type_id() == ObjectTypeIds.ID_PLAYER:
                effect_target.interrupt_looting()
            effect_target.spell_manager.remove_casts(remove_active=False)
            effect_target.unit_flags |= UnitFlags.UNIT_FLAG_FLEEING
            duration = aura.source_spell.get_duration() / 1000
            effect_target.movement_manager.set_feared(duration)

        effect_target.set_uint32(UnitFields.UNIT_FIELD_FLAGS, effect_target.unit_flags)

    @staticmethod
    def handle_mod_stun(aura, effect_target, remove):
        # Player specific.
        if not remove and effect_target.get_type_id() == ObjectTypeIds.ID_PLAYER:
            # Don't stun if player is flying.
            if effect_target.pending_taxi_destination:
                return
            # Release loot if any.
            effect_target.interrupt_looting()

        # Root (or unroot) unit.
        effect_target.set_root(not remove)

        if not remove:
            effect_target.spell_manager.remove_casts(remove_active=False)
            effect_target.set_current_target(0)
            effect_target.unit_state |= UnitStates.STUNNED
            effect_target.unit_flags |= UnitFlags.UNIT_FLAG_DISABLE_ROTATE
            effect_target.stop_movement()
        else:
            # Restore combat target if any.
            if effect_target.combat_target and effect_target.combat_target.is_alive:
                effect_target.set_current_target(effect_target.combat_target.guid)
            effect_target.unit_state &= ~UnitStates.STUNNED
            effect_target.unit_flags &= ~UnitFlags.UNIT_FLAG_DISABLE_ROTATE

        effect_target.set_uint32(UnitFields.UNIT_FIELD_FLAGS, effect_target.unit_flags)

    @staticmethod
    def handle_mod_pacify_silence(aura, effect_target, remove):
        AuraEffectHandler.handle_mod_pacify(aura, effect_target, remove)
        AuraEffectHandler.handle_mod_silence(aura, effect_target, remove)

    @staticmethod
    def handle_mod_silence(aura, effect_target, remove):
        if remove:
            effect_target.unit_state &= ~UnitStates.SILENCED
        else:
            effect_target.unit_state |= UnitStates.SILENCED

    @staticmethod
    def handle_mod_pacify(aura, effect_target, remove):
        if remove:
            effect_target.unit_flags &= ~UnitFlags.UNIT_FLAG_PACIFIED
        else:
            effect_target.unit_flags |= UnitFlags.UNIT_FLAG_PACIFIED

        effect_target.set_uint32(UnitFields.UNIT_FIELD_FLAGS, effect_target.unit_flags)

    @staticmethod
    def handle_transform(aura, effect_target, remove):
        if not remove:
            creature_entry = aura.spell_effect.misc_value
            creature = WorldDatabaseManager.CreatureTemplateHolder.creature_get_by_entry(creature_entry)
            if not creature:
                Logger.error(f'SPELL_AURA_TRANSFORM: Creature template ({creature_entry}) not found in database.')
                return

            if not effect_target.set_display_id(creature.display_id1):
                Logger.error(f'SPELL_AURA_TRANSFORM: Invalid display id ({creature.display_id1}) for creature ({creature_entry}).')
        else:
            effect_target.reset_display_id()

    @staticmethod
    def handle_mod_root(aura, effect_target, remove):
        effect_target.set_root(not remove)

    @staticmethod
    def handle_mod_stealth(aura, effect_target, remove):
        effect_target.set_stealthed(active=not remove)
        if remove:
            effect_target.stat_manager.remove_aura_stat_bonus(aura.index)
            return

        amount = aura.get_effect_points()
        effect_target.stat_manager.apply_aura_stat_bonus(aura.index, UnitStats.STEALTH, amount)

    @staticmethod
    def handle_mod_stealth_detection(aura, effect_target, remove):
        if remove:
            effect_target.stat_manager.remove_aura_stat_bonus(aura.index)
            return

        amount = aura.get_effect_points()
        effect_target.stat_manager.apply_aura_stat_bonus(aura.index, UnitStats.STEALTH_DETECTION, amount)

    @staticmethod
    def handle_mod_invisibility(aura, effect_target, remove):
        effect_target.set_stealthed(active=not remove)
        if remove:
            effect_target.stat_manager.remove_aura_stat_bonus(aura.index)
            return

        amount = aura.get_effect_points()
        effect_target.stat_manager.apply_aura_stat_bonus(aura.index, UnitStats.INVISIBILITY, amount)

    @staticmethod
    def handle_mod_invisibility_detection(aura, effect_target, remove):
        if remove:
            effect_target.stat_manager.remove_aura_stat_bonus(aura.index)
            return

        amount = aura.get_effect_points()
        effect_target.stat_manager.apply_aura_stat_bonus(aura.index, UnitStats.INVISIBILITY_DETECTION, amount)

    @staticmethod
    def handle_mod_charm(aura, effect_target, remove):
        # Player target.
        # TODO: Implement behavior for charmed players.
        if effect_target.get_type_id() == ObjectTypeIds.ID_PLAYER:
            effect_target.set_charmed_by(aura.caster, remove=remove)
            return

        # Creature.
        if remove:
            aura.caster.pet_manager.detach_pet_by_slot(PetSlot.PET_SLOT_CHARM)
            return
        aura.caster.pet_manager.set_creature_as_pet(effect_target, aura.spell_id, PetSlot.PET_SLOT_CHARM)

    @staticmethod
    def handle_taunt(aura, effect_target, remove):
        if effect_target.get_type_id() != ObjectTypeIds.ID_UNIT:
            return

        if not effect_target.is_alive:
            return

        effect_target.threat_manager.update_unit_threat_modifier(aura.caster, remove=remove)

    @staticmethod
    def handle_damage_shield(aura, effect_target, remove):
        if remove:
            return

        # Damage shields don't have proc flags assigned to them,
        # possibly because proc flags are not effect-specific in spell data.
        # Add proc flag for this aura when it's applied.
        if effect_target is aura.target:
            aura.proc_flags |= ProcFlags.TAKE_COMBAT_DMG
            return

        damage = aura.get_effect_points()
        aura.target.apply_spell_damage(effect_target, damage, aura.spell_effect)

    @staticmethod
    def handle_school_absorb(aura, effect_target, remove):
        school = aura.spell_effect.misc_value
        if school == -1:
            school_mask = SpellSchoolMask.SPELL_SCHOOL_MASK_MAGIC
        elif school == -2:
            school_mask = SpellSchoolMask.SPELL_SCHOOL_MASK_ALL
        else:
            school_mask = 1 << school

        effect_target.set_school_absorb(school_mask, aura.index, aura.get_effect_points(), absorb=not remove)

    # Immunity effects

    @staticmethod
    def handle_effect_immunity(aura, effect_target, remove):
        effect_target.set_immunity(SpellImmunity.IMMUNITY_EFFECT, aura.index,
                                   immunity_arg=aura.spell_effect.misc_value, immune=not remove)

    @staticmethod
    def handle_state_immunity(aura, effect_target, remove):
        effect_target.set_immunity(SpellImmunity.IMMUNITY_AURA, aura.index,
                                   immunity_arg=aura.spell_effect.misc_value, immune=not remove)

    @staticmethod
    def handle_school_immunity(aura, effect_target, remove):
        school = aura.spell_effect.misc_value
        if school == -1:
            school = SpellSchoolMask.SPELL_SCHOOL_MASK_MAGIC
        elif school == -2:
            school = SpellSchoolMask.SPELL_SCHOOL_MASK_ALL
        else:
            school = 1 << school

        effect_target.set_immunity(SpellImmunity.IMMUNITY_SCHOOL, aura.index, immunity_arg=school, immune=not remove)

    @staticmethod
    def handle_damage_immunity(aura, effect_target, remove):
        school = aura.spell_effect.misc_value
        if school == -1:
            school = SpellSchoolMask.SPELL_SCHOOL_MASK_MAGIC
        elif school == -2:
            # Not used in the database, but kept for consistency.
            school = SpellSchoolMask.SPELL_SCHOOL_MASK_ALL
        else:
            school = 1 << school

        effect_target.set_immunity(SpellImmunity.IMMUNITY_DAMAGE, aura.index, immunity_arg=school, immune=not remove)

    @staticmethod
    def handle_dispel_immunity(aura, effect_target, remove):
        effect_target.set_immunity(SpellImmunity.IMMUNITY_DISPEL_TYPE, aura.index,
                                   immunity_arg=aura.spell_effect.misc_value, immune=not remove)

    @staticmethod
    def handle_mechanic_immunity(aura, effect_target, remove):
        effect_target.set_immunity(SpellImmunity.IMMUNITY_MECHANIC, aura.index,
                                   immunity_arg=aura.spell_effect.misc_value, immune=not remove)

    # Stat modifiers

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

        # Update character sheet.
        effect_target.stat_manager.send_resistances()

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

        if aura.spell_effect.misc_value == -1:
            stat_type = UnitStats.ALL_ATTRIBUTES
        else:
            stat_type = UnitStats.ATTRIBUTE_START << aura.spell_effect.misc_value

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
        effect_target.stat_manager.apply_aura_stat_bonus(aura.index, UnitStats.HEALTH_REGENERATION_PER_5, amount,
                                                         percentual=True)

    @staticmethod
    def handle_mod_power_regen(aura, effect_target, remove):
        if remove:
            effect_target.stat_manager.remove_aura_stat_bonus(aura.index)
            return
        amount = aura.get_effect_points()

        # This effect is only used for mana regen by deprecated food rejuvenation spells.
        # Check provided power type regardless for consistency.
        power_type = aura.spell_effect.misc_value
        effect_target.stat_manager.apply_aura_stat_bonus(aura.index, UnitStats.POWER_REGEN_START << power_type, amount)

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
    def handle_spell_crit_percent(aura, effect_target, remove):
        if remove:
            effect_target.stat_manager.remove_aura_stat_bonus(aura.index)
            return

        amount = aura.get_effect_points() / 100
        item_class = aura.source_spell.spell_entry.EquippedItemClass
        misc_value = aura.source_spell.spell_entry.EquippedItemSubclass if item_class != -1 else -1
        effect_target.stat_manager.apply_aura_stat_bonus(aura.index, UnitStats.MELEE_CRITICAL,
                                                         amount=amount, misc_value=misc_value)

    @staticmethod
    def handle_mod_school_crit_chance(aura, effect_target, remove):
        if remove:
            effect_target.stat_manager.remove_aura_stat_bonus(aura.index)
            return
        amount = aura.get_effect_points() / 100
        effect_target.stat_manager.apply_aura_stat_bonus(aura.index, UnitStats.SPELL_SCHOOL_CRITICAL,
                                                         amount=amount,
                                                         misc_value=aura.spell_effect.misc_value)

    @staticmethod
    def handle_mod_power_cost_school(aura, effect_target, remove):
        if remove:
            effect_target.stat_manager.remove_aura_stat_bonus(aura.index)
            return
        amount = aura.get_effect_points()
        effect_target.stat_manager.apply_aura_stat_bonus(aura.index, UnitStats.SPELL_SCHOOL_POWER_COST, amount,
                                                         misc_value=aura.spell_effect.misc_value)

    @staticmethod
    def handle_increase_speed(aura, effect_target, remove):
        if remove:
            effect_target.stat_manager.remove_aura_stat_bonus(aura.index, percentual=True)
            return
        amount = aura.get_effect_points()
        effect_target.stat_manager.apply_aura_stat_bonus(aura.index, UnitStats.SPEED_RUNNING, amount, percentual=True)

    @staticmethod
    def handle_increase_mounted_speed(aura, effect_target, remove):
        if remove:
            effect_target.stat_manager.remove_aura_stat_bonus(aura.index, percentual=True)
            return
        amount = aura.get_effect_points()
        effect_target.stat_manager.apply_aura_stat_bonus(aura.index, UnitStats.SPEED_MOUNTED, amount, percentual=True)

    @staticmethod
    def handle_decrease_speed(aura, effect_target, remove):
        if remove:
            effect_target.stat_manager.remove_aura_stat_bonus(aura.index, percentual=True)
            return
        amount = aura.get_effect_points() - 100
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

    @staticmethod
    def handle_mod_attack_speed(aura, effect_target, remove):
        if remove:
            effect_target.stat_manager.remove_aura_stat_bonus(aura.index, percentual=True)
            return
        amount = aura.get_effect_points()
        effect_target.stat_manager.apply_aura_stat_bonus(aura.index,
                                                         UnitStats.MAIN_HAND_DELAY | UnitStats.OFF_HAND_DELAY,
                                                         amount, percentual=True)

    @staticmethod
    def handle_mod_casting_speed(aura, effect_target, remove):
        if remove:
            effect_target.stat_manager.remove_aura_stat_bonus(aura.index, percentual=True)
            return
        amount = aura.get_effect_points()
        effect_target.stat_manager.apply_aura_stat_bonus(aura.index, UnitStats.SPELL_CASTING_SPEED, amount,
                                                         percentual=True)

    @staticmethod
    def handle_mod_hit_chance(aura, effect_target, remove):
        if remove:
            effect_target.stat_manager.remove_aura_stat_bonus(aura.index)
            return
        amount = aura.get_effect_points() / 100
        effect_target.stat_manager.apply_aura_stat_bonus(aura.index, UnitStats.HIT_CHANCE, amount)

    @staticmethod
    def handle_mod_parry_chance(aura, effect_target, remove):
        if remove:
            effect_target.stat_manager.remove_aura_stat_bonus(aura.index, percentual=False)
            return
        amount_percent = aura.get_effect_points() / 100
        effect_target.stat_manager.apply_aura_stat_bonus(aura.index, UnitStats.PARRY_CHANCE,
                                                         amount_percent, percentual=False)

    @staticmethod
    def handle_mod_dodge_chance(aura, effect_target, remove):
        if remove:
            effect_target.stat_manager.remove_aura_stat_bonus(aura.index, percentual=False)
            return
        amount_percent = aura.get_effect_points() / 100
        effect_target.stat_manager.apply_aura_stat_bonus(aura.index, UnitStats.DODGE_CHANCE,
                                                         amount_percent, percentual=False)

    @staticmethod
    def handle_mod_block_chance(aura, effect_target, remove):
        if remove:
            effect_target.stat_manager.remove_aura_stat_bonus(aura.index, percentual=False)
            return
        amount_percent = aura.get_effect_points() / 100
        effect_target.stat_manager.apply_aura_stat_bonus(aura.index, UnitStats.BLOCK_CHANCE,
                                                         amount_percent, percentual=False)

    @staticmethod
    def handle_mod_threat(aura, effect_target, remove):
        if remove:
            effect_target.stat_manager.remove_aura_stat_bonus(aura.index, percentual=True)
            return
        amount = aura.get_effect_points()
        effect_target.stat_manager.apply_aura_stat_bonus(aura.index, UnitStats.THREAT_GENERATION, amount, percentual=True)


AURA_EFFECTS = {
    AuraTypes.SPELL_AURA_BIND_SIGHT: AuraEffectHandler.handle_bind_sight,
    AuraTypes.SPELL_AURA_DUMMY: AuraEffectHandler.handle_aura_dummy,
    AuraTypes.SPELL_AURA_MOD_SHAPESHIFT: AuraEffectHandler.handle_shapeshift,
    AuraTypes.SPELL_AURA_MOD_SCALE: AuraEffectHandler.handle_mod_scale,
    AuraTypes.SPELL_AURA_MOUNTED: AuraEffectHandler.handle_mounted,
    AuraTypes.SPELL_AURA_PERIODIC_TRIGGER_SPELL: AuraEffectHandler.handle_periodic_trigger_spell,
    AuraTypes.SPELL_AURA_PERIODIC_HEAL: AuraEffectHandler.handle_periodic_healing,
    AuraTypes.SPELL_AURA_PERIODIC_MANA_LEECH: AuraEffectHandler.handle_periodic_mana_leech,
    AuraTypes.SPELL_AURA_PERIODIC_ENERGIZE: AuraEffectHandler.handle_periodic_energize,
    AuraTypes.SPELL_AURA_PERIODIC_DAMAGE: AuraEffectHandler.handle_periodic_damage,
    AuraTypes.SPELL_AURA_PERIODIC_LEECH: AuraEffectHandler.handle_periodic_leech,
    AuraTypes.SPELL_AURA_PROC_TRIGGER_SPELL: AuraEffectHandler.handle_proc_trigger_spell,
    AuraTypes.SPELL_AURA_PROC_TRIGGER_DAMAGE: AuraEffectHandler.handle_proc_trigger_damage,
    AuraTypes.SPELL_AURA_TRACK_RESOURCES: AuraEffectHandler.handle_track_resources,
    AuraTypes.SPELL_AURA_TRACK_CREATURES: AuraEffectHandler.handle_track_creatures,
    AuraTypes.SPELL_AURA_FEIGN_DEATH: AuraEffectHandler.handle_feign_death,
    AuraTypes.SPELL_AURA_MOD_STUN: AuraEffectHandler.handle_mod_stun,
    AuraTypes.SPELL_AURA_TRANSFORM: AuraEffectHandler.handle_transform,
    AuraTypes.SPELL_AURA_MOD_ROOT: AuraEffectHandler.handle_mod_root,
    AuraTypes.SPELL_AURA_MOD_STEALTH: AuraEffectHandler.handle_mod_stealth,
    AuraTypes.SPELL_AURA_MOD_STEALTH_DETECT: AuraEffectHandler.handle_mod_stealth_detection,
    AuraTypes.SPELL_AURA_MOD_INVISIBILITY: AuraEffectHandler.handle_mod_invisibility,
    AuraTypes.SPELL_AURA_MOD_INVISIBILITY_DETECTION: AuraEffectHandler.handle_mod_invisibility_detection,
    AuraTypes.SPELL_AURA_MOD_CHARM: AuraEffectHandler.handle_mod_charm,
    AuraTypes.SPELL_AURA_MOD_STALKED: AuraEffectHandler.handle_mod_stalked,
    AuraTypes.SPELL_AURA_WATER_BREATHING: AuraEffectHandler.handle_water_breathing,
    AuraTypes.SPELL_AURA_MOD_DISARM: AuraEffectHandler.handle_mod_disarm,
    AuraTypes.SPELL_AURA_DAMAGE_SHIELD: AuraEffectHandler.handle_damage_shield,
    AuraTypes.SPELL_AURA_MOD_SILENCE: AuraEffectHandler.handle_mod_silence,
    AuraTypes.SPELL_AURA_MOD_PACIFY: AuraEffectHandler.handle_mod_pacify,
    AuraTypes.SPELL_AURA_MOD_PACIFY_SILENCE: AuraEffectHandler.handle_mod_pacify_silence,
    AuraTypes.SPELL_AURA_MOD_TAUNT: AuraEffectHandler.handle_taunt,
    AuraTypes.SPELL_AURA_CHANNEL_DEATH_ITEM: AuraEffectHandler.handle_channel_death_item,
    AuraTypes.SPELL_AURA_MOD_FEAR: AuraEffectHandler.handle_mod_fear,


    # Immunity modifiers.
    AuraTypes.SPELL_AURA_EFFECT_IMMUNITY: AuraEffectHandler.handle_effect_immunity,
    AuraTypes.SPELL_AURA_STATE_IMMUNITY: AuraEffectHandler.handle_state_immunity,
    AuraTypes.SPELL_AURA_SCHOOL_IMMUNITY: AuraEffectHandler.handle_school_immunity,
    AuraTypes.SPELL_AURA_DAMAGE_IMMUNITY: AuraEffectHandler.handle_damage_immunity,
    AuraTypes.SPELL_AURA_DISPEL_IMMUNITY: AuraEffectHandler.handle_dispel_immunity,
    AuraTypes.SPELL_AURA_MECHANIC_IMMUNITY: AuraEffectHandler.handle_mechanic_immunity,

    # Stat modifiers.
    AuraTypes.SPELL_AURA_SCHOOL_ABSORB: AuraEffectHandler.handle_school_absorb,
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
    AuraTypes.SPELL_AURA_MOD_CRIT_PERCENT: AuraEffectHandler.handle_spell_crit_percent,
    AuraTypes.SPELL_AURA_MOD_SPELL_CRIT_CHANCE_SCHOOL: AuraEffectHandler.handle_mod_school_crit_chance,
    AuraTypes.SPELL_AURA_MOD_INCREASE_SPEED: AuraEffectHandler.handle_increase_speed,
    AuraTypes.SPELL_AURA_MOD_INCREASE_MOUNTED_SPEED: AuraEffectHandler.handle_increase_mounted_speed,
    AuraTypes.SPELL_AURA_MOD_DECREASE_SPEED: AuraEffectHandler.handle_decrease_speed,
    AuraTypes.SPELL_AURA_MOD_INCREASE_SWIM_SPEED: AuraEffectHandler.handle_increase_swim_speed,
    AuraTypes.SPELL_AURA_MOD_ATTACKSPEED: AuraEffectHandler.handle_mod_attack_speed,
    AuraTypes.SPELL_AURA_MOD_CASTING_SPEED_NOT_STACK: AuraEffectHandler.handle_mod_casting_speed,

    AuraTypes.SPELL_AURA_MOD_HIT_CHANCE: AuraEffectHandler.handle_mod_hit_chance,
    AuraTypes.SPELL_AURA_MOD_PARRY_PERCENT: AuraEffectHandler.handle_mod_parry_chance,
    AuraTypes.SPELL_AURA_MOD_DODGE_PERCENT: AuraEffectHandler.handle_mod_dodge_chance,
    AuraTypes.SPELL_AURA_MOD_BLOCK_PERCENT: AuraEffectHandler.handle_mod_block_chance,

    AuraTypes.SPELL_AURA_MOD_DAMAGE_TAKEN: AuraEffectHandler.handle_mod_damage_taken,

    AuraTypes.SPELL_AURA_MOD_DAMAGE_DONE: AuraEffectHandler.handle_mod_damage_done,
    AuraTypes.SPELL_AURA_MOD_DAMAGE_DONE_CREATURE: AuraEffectHandler.handle_mod_damage_done_creature,

    AuraTypes.SPELL_AURA_MOD_THREAT: AuraEffectHandler.handle_mod_threat
}

PROC_AURA_EFFECTS = [
    AuraTypes.SPELL_AURA_PROC_TRIGGER_SPELL,
    AuraTypes.SPELL_AURA_PROC_TRIGGER_DAMAGE
]

PERIODIC_AURA_EFFECTS = [
    AuraTypes.SPELL_AURA_PERIODIC_DAMAGE,
    AuraTypes.SPELL_AURA_PERIODIC_HEAL,
    AuraTypes.SPELL_AURA_PERIODIC_TRIGGER_SPELL,
    AuraTypes.SPELL_AURA_PERIODIC_ENERGIZE,
    AuraTypes.SPELL_AURA_PERIODIC_LEECH,
    AuraTypes.SPELL_AURA_PERIODIC_MANA_FUNNEL,
    AuraTypes.SPELL_AURA_PERIODIC_MANA_LEECH
]
