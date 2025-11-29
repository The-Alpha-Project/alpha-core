from random import sample
from struct import pack

from database.realm.RealmDatabaseManager import RealmDatabaseManager
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.WorldSessionStateHandler import WorldSessionStateHandler
from game.world.managers.abstractions.Vector import Vector
from game.world.managers.objects.ObjectManager import ObjectManager
from game.world.managers.objects.dynamic.DynamicObjectManager import DynamicObjectManager
from game.world.managers.objects.farsight.FarSightManager import FarSightManager
from game.world.managers.objects.gameobjects.GameObjectBuilder import GameObjectBuilder
from game.world.managers.objects.spell import SpellEffectDummyHandler, ExtendedSpellData
from game.world.managers.objects.spell.aura.AreaAuraHolder import AreaAuraHolder
from game.world.managers.objects.units.creature.CreatureBuilder import CreatureBuilder
from game.world.managers.objects.units.movement.behaviors.PetMovement import PET_FOLLOW_DISTANCE
from game.world.managers.objects.units.pet.PetData import PetData
from game.world.managers.objects.units.player.SkillManager import SkillManager
from network.packet.PacketWriter import PacketWriter
from utils.ConfigManager import config
from utils.Formulas import UnitFormulas
from utils.Logger import Logger
from utils.constants import CustomCodes
from utils.constants.ItemCodes import EnchantmentSlots, InventoryError, ItemClasses
from utils.constants.MiscCodes import AttackTypes, GameObjectStates, DynamicObjectTypes, ScriptTypes, TempSummonType
from utils.constants.OpCodes import OpCode
from utils.constants.PetCodes import PetSlot
from utils.constants.SpellCodes import AuraTypes, SpellEffects, SpellState, SpellTargetMask, DispelType
from utils.constants.UnitCodes import UnitFlags, UnitStates


class SpellEffectHandler:
    @staticmethod
    def apply_effect(casting_spell, effect, caster, target):
        if effect.effect_type not in SPELL_EFFECTS:
            Logger.warning(f'Unimplemented spell effect called ({SpellEffects(effect.effect_type).name}: '
                           f'{effect.effect_type}) from spell {casting_spell.spell_entry.ID}.')
            return

        from game.world.managers.objects.units.UnitManager import UnitManager
        if target and isinstance(target, UnitManager):
            # Do not apply spell effects on dead targets unless it's a resurrection effect.
            if not target.is_alive and effect.effect_type != SpellEffects.SPELL_EFFECT_RESURRECT:
                return

        SPELL_EFFECTS[effect.effect_type](casting_spell, effect, caster, target)

    @staticmethod
    def handle_activate_object(casting_spell, effect, caster, target):
        if not target.is_gameobject(by_mask=True):
            return
        # Only two spells, Summon Voidwalker and Summon Succubus (Need summoning circle).
        # Both with same action, 'AnimateCustom0'.
        target.send_custom_animation(0)

    @staticmethod
    def handle_school_damage(casting_spell, effect, caster, target):
        if not target.is_unit(by_mask=True):
            return

        damage = effect.get_effect_points()
        caster.apply_spell_damage(target, damage, effect)

    @staticmethod
    def handle_heal(casting_spell, effect, caster, target):
        if not target.is_unit(by_mask=True):
            return

        healing = effect.get_effect_points()
        caster.apply_spell_healing(target, healing, casting_spell)

    @staticmethod
    def handle_heal_max_health(casting_spell, effect, caster, target):
        if not target.is_unit(by_mask=True):
            return

        healing = caster.max_health
        caster.apply_spell_healing(target, healing, casting_spell)

    @staticmethod
    def handle_weapon_damage(casting_spell, effect, caster, target):
        if not caster.is_unit(by_mask=True):
            return

        if casting_spell.spell_attack_type == -1:
            # Fall back to base_attack if the attack type couldn't be resolved on init.
            # This is required for some spells that don't define the type of weapon needed for the attack.
            # TODO This should be resolved during CastingSpell init, but more research is needed for a generic check.
            casting_spell.spell_attack_type = AttackTypes.BASE_ATTACK

        # Provide used bullets/arrows for base attack calculation.
        used_ammo = casting_spell.used_ranged_attack_item if \
            casting_spell.used_ranged_attack_item and \
            casting_spell.used_ranged_attack_item.item_template.class_ == ItemClasses.ITEM_CLASS_PROJECTILE else None

        weapon_damage = caster.calculate_base_attack_damage(casting_spell.spell_attack_type,
                                                            casting_spell.get_damage_school(),
                                                            target, used_ammo=used_ammo,
                                                            apply_bonuses=False)  # Bonuses are applied on spell damage.
        damage_bonus = effect.get_effect_points()

        # Overpower also uses combo points, but shouldn't scale.
        if caster.is_player() and not casting_spell.is_overpower() and casting_spell.requires_combo_points():
            damage_bonus *= casting_spell.spent_combo_points

        caster.apply_spell_damage(target, weapon_damage + damage_bonus, effect)

    @staticmethod
    def handle_add_combo_points(casting_spell, effect, caster, target):
        if not caster.is_unit(by_mask=True):
            return

        caster.add_combo_points_on_target(target, effect.get_effect_points())

    @staticmethod
    def handle_sanctuary(casting_spell, effect, caster, target):
        if caster.is_unit(by_mask=True):
            # Set sanctuary state.
            caster.set_sanctuary(True, time_secs=1)

    @staticmethod
    def handle_dispel(casting_spell, effect, caster, target):
        if not target.is_unit(by_mask=True):
            return

        friendly = not caster.can_attack_target(target)
        dispel_mask = 1 << effect.misc_value if effect.misc_value != DispelType.ALL else DispelType.MCDP_MASK
        # Retrieve either harmful or beneficial depending on target allegiance.
        auras = target.aura_manager.get_harmful_auras() if friendly else target.aura_manager.get_beneficial_auras()
        # Match by dispel mask if available (0 = No mask, use auras directly and randomly pick).
        auras_dispel_match = [aura for aura in auras if aura.get_dispel_mask() & dispel_mask] if dispel_mask else auras
        # Select N to remove given effect points.
        auras_to_remove = sample(auras_dispel_match, min(effect.get_effect_points(), len(auras_dispel_match)))
        # Remove auras.
        [target.aura_manager.remove_aura(aura) for aura in auras_to_remove]

    @staticmethod
    def handle_aura_application(casting_spell, effect, caster, target):
        if not target.is_unit(by_mask=True):
            return

        if casting_spell.is_target_immune_to_aura(target):
            return

        target.aura_manager.apply_spell_effect_aura(caster, casting_spell, effect)

    @staticmethod
    def handle_request_duel(casting_spell, effect, caster, target):
        # Handle caster already on a duel, forfeit.
        duel_arbiter = caster.get_duel_arbiter()
        if duel_arbiter:
            duel_arbiter.force_end_duel(caster)

        # New duel arbiter.
        duel_arbiter = GameObjectBuilder.create(effect.misc_value, effect.targets.resolved_targets_b[0],
                                                caster.map_id, caster.instance_id,
                                                GameObjectStates.GO_STATE_READY,
                                                summoner=caster,
                                                spell_id=casting_spell.spell_entry.ID,
                                                faction=caster.faction, ttl=3600)

        caster.get_map().spawn_object(world_object_instance=duel_arbiter)
        duel_arbiter.request_duel(caster, target)

    @staticmethod
    def handle_open_lock(casting_spell, effect, caster, target):
        if not caster or not caster.is_player():
            return

        if target.is_gameobject():
            target.use(caster, target)
        elif target.is_item():
            target.set_unlocked()

    @staticmethod
    def handle_energize(casting_spell, effect, caster, target):
        if not target.is_unit(by_mask=True):
            return

        power_type = effect.misc_value
        if power_type != target.power_type:
            return

        amount = effect.get_effect_points()
        target.receive_power(amount, power_type)

    @staticmethod
    def handle_power_burn(casting_spell, effect, caster, target):
        if not target.is_unit(by_mask=True):
            return

        power_type = effect.misc_value
        amount = effect.get_effect_points()

        # Determine the effective amount to be burned in order to apply damage later.
        current_power_amount = target.get_power_value(power_type)
        effective_amount = current_power_amount - max(0, (current_power_amount - amount))

        # Remove power from the target.
        target.receive_power(-amount, power_type)

        # Apply damage as per description (1 HP point per power drained).
        caster.apply_spell_damage(target, effective_amount, effect)

    @staticmethod
    def handle_power_drain(casting_spell, effect, caster, target):
        if not target.is_unit(by_mask=True):
            return

        power_type = effect.misc_value
        amount = effect.get_effect_points()

        # Determine the effective amount to be drained in order to restore power to the caster later.
        current_power_amount = target.get_power_value(power_type)
        effective_amount = current_power_amount - max(0, (current_power_amount - amount))

        # Remove power from the target.
        target.receive_power(-amount, power_type)

        # Restore power to the caster.
        caster.receive_power(effective_amount, power_type)

    @staticmethod
    def handle_health_leech(casting_spell, effect, caster, target):
        if not target.is_unit(by_mask=True):
            return

        amount = effect.get_effect_points()
        caster.apply_spell_damage(target, amount, effect)
        caster.receive_healing(amount, caster)

    @staticmethod
    def handle_summon_mount(casting_spell, effect, caster, target):
        if not target.is_unit(by_mask=True):
            return

        already_mounted = target.unit_flags & UnitFlags.UNIT_MASK_MOUNTED
        if already_mounted:
            # Remove any existing mount auras.
            target.aura_manager.remove_auras_by_type(AuraTypes.SPELL_AURA_MOUNTED)
            target.aura_manager.remove_auras_by_type(AuraTypes.SPELL_AURA_MOD_INCREASE_MOUNTED_SPEED)
            # Force dismount if target is still mounted (like a previous SPELL_EFFECT_SUMMON_MOUNT that doesn't
            # leave any applied aura).
            if target.mount_display_id > 0:
                target.unmount()
        else:
            creature_entry = effect.misc_value
            if not target.summon_mount(creature_entry):
                Logger.error(f'SPELL_EFFECT_SUMMON_MOUNT: Creature template ({creature_entry}) not found in database.')

    @staticmethod
    def handle_insta_kill(casting_spell, effect, caster, target):
        if not target.is_unit(by_mask=True):
            return

        # No SMSG_SPELLINSTAKILLLOG in 0.5.3
        target.die(killer=caster)

    @staticmethod
    def handle_create_item(casting_spell, effect, caster, target):
        if not target.is_player():
            return

        item_template = WorldDatabaseManager.ItemTemplateHolder.item_template_get_by_entry(effect.item_type)

        if not item_template:
            target.inventory.send_equip_error(InventoryError.BAG_UNKNOWN_ITEM)
            return

        amount = effect.get_effect_points()

        # Validate amount, at least 1 item should be created.
        if amount < 1:
            amount = 1
        if amount > item_template.stackable:
            amount = item_template.stackable

        can_store_item = target.inventory.can_store_item(item_template, amount)
        if can_store_item != InventoryError.BAG_OK:
            target.inventory.send_equip_error(can_store_item)
            return

        # Add the item to player inventory.
        target.inventory.add_item(effect.item_type, count=amount, created_by=caster.guid)

    @staticmethod
    def handle_teleport_units(casting_spell, effect, caster, target):
        # Teleport targets should follow the format (map, Vector).
        teleport_targets = effect.targets.get_resolved_effect_targets_by_type(tuple)
        if len(teleport_targets) == 0:
            return
        teleport_info = teleport_targets[0]
        if len(teleport_info) != 2 or not isinstance(teleport_info[1], Vector):
            return

        if target.is_player():
            target.teleport(teleport_info[0], teleport_info[1])  # map, coordinates resolved.
        else:
            target.near_teleport(teleport_info[1])
        # TODO Die sides are assigned for at least Word of Recall (ID 1)

    @staticmethod
    def handle_persistent_area_aura(casting_spell, effect, caster, target):  # Ground-targeted aoe.
        if target is not None:
            return

        # For now, dynamic object only enable us to properly display area effects to clients.
        # Targeting and effect application is still done by 'handle_apply_area_aura'.
        if not casting_spell.dynamic_object:
            DynamicObjectManager.spawn_from_spell_effect(effect, DynamicObjectTypes.DYNAMIC_OBJECT_AREA_SPELL)

        SpellEffectHandler.handle_apply_area_aura(casting_spell, effect, caster, target)

    @staticmethod
    def handle_apply_area_aura(casting_spell, effect, caster, target):  # Paladin auras, healing stream totem etc.
        casting_spell.cast_state = SpellState.SPELL_STATE_ACTIVE
        if not effect.area_aura_holder:
            effect.area_aura_holder = AreaAuraHolder(effect)
            previous_targets = []
        else:
            # B is always specifying for area auras if set (only 6672, 6755).
            previous_targets = effect.targets.previous_targets_b if effect.targets.previous_targets_b else \
                effect.targets.previous_targets_a if effect.targets.previous_targets_a else []

        current_targets = effect.targets.resolved_targets_b if effect.targets.resolved_targets_b else \
            effect.targets.resolved_targets_a

        new_targets = [unit for unit in current_targets if
                       unit not in previous_targets]  # Targets that can't have the aura yet.
        missing_targets = [unit for unit in previous_targets if
                           unit not in current_targets]  # Targets that moved out of the area.

        for target in new_targets:
            effect.area_aura_holder.add_target(target)

        for target in missing_targets:
            effect.area_aura_holder.remove_target(target.guid)

    @staticmethod
    def handle_learn_spell(casting_spell, effect, caster, target):
        target_spell_id = effect.trigger_spell_id
        if target.is_player(by_mask=True):
            target.spell_manager.learn_spell(target_spell_id)
            return

        # Pet teaching.
        summoner = target.get_charmer_or_summoner()
        if not summoner or not summoner.is_player():
            return

        active_pet = summoner.pet_manager.get_active_permanent_pet()
        if active_pet:
            active_pet.teach_spell(target_spell_id)

    @staticmethod
    def handle_learn_pet_spell(casting_spell, effect, caster, target):
        if not target.is_player():
            return

        target_spell_id = effect.trigger_spell_id
        active_pet = target.pet_manager.get_active_permanent_pet()
        if active_pet:
            active_pet.teach_spell(target_spell_id)

    @staticmethod
    def handle_summon_totem(casting_spell, effect, caster, target):
        totem_entry = effect.misc_value
        duration = casting_spell.get_duration()
        # If no duration, default to 5 minutes.
        duration = 300 if duration == 0 else (duration / 1000)

        creature_manager = CreatureBuilder.create(totem_entry, target, caster.map_id, caster.instance_id,
                                                  summoner=caster,
                                                  faction=caster.faction, ttl=duration,
                                                  subtype=CustomCodes.CreatureSubtype.SUBTYPE_TOTEM,
                                                  summon_type=TempSummonType.TEMP_SUMMON_TIMED_DEATH_AND_DEAD_DESPAWN)
        if not creature_manager:
            Logger.error(f'Creature with entry {totem_entry} not found for spell {casting_spell.spell_entry.ID}.')
            return

        totem_slot = casting_spell.get_totem_slot_type()
        # Remove existing totem in this slot.
        caster.pet_manager.detach_totem(totem_slot)
        caster.pet_manager.add_totem_from_spell(creature_manager, casting_spell)
        caster.get_map().spawn_object(world_object_instance=creature_manager)

    @staticmethod
    def handle_summon_object_wild(casting_spell, effect, caster, target):
        SpellEffectHandler._summon_object(casting_spell, effect, caster, target)

    @staticmethod
    def handle_summon_object(casting_spell, effect, caster, target):
        SpellEffectHandler._summon_object(casting_spell, effect, caster, target, faction_override=caster.faction)

    @staticmethod
    def _summon_object(casting_spell, effect, caster, target, faction_override=None):
        object_entry = effect.misc_value

        # Validate go template existence.
        go_template = WorldDatabaseManager.gameobject_template_get_by_entry(object_entry)
        if not go_template:
            Logger.error(f'Gameobject with entry {object_entry} not found for spell {casting_spell.spell_entry.ID}.')
            return

        if isinstance(target, ObjectManager):
            target = target.location

        if not target:
            Logger.error(f'Unable to resolve target, go entry {object_entry}, spell {casting_spell.spell_entry.ID}.')
            return

        map_ = caster.get_map()
        # TODO: Not sure if this check should be done here, an example of this: A creature spawning a camp fire
        #  behind a wall or inside another object with collision. @Fluglow
        if isinstance(target, Vector) and not map_.los_check(caster.get_ray_position(), target):
            Logger.error(f'Unable to resolve line of sight to vector target, go entry {object_entry},'
                         f' spell {casting_spell.spell_entry.ID},'
                         f' caster {caster.get_name()}')
            return

        duration = casting_spell.get_duration()
        # If no duration, default to 2 minutes.
        duration = 120 if duration == 0 else (duration / 1000)
        faction = faction_override if faction_override is not None else go_template.faction
        gameobject = GameObjectBuilder.create(object_entry, target, caster.map_id, caster.instance_id,
                                              GameObjectStates.GO_STATE_READY,
                                              summoner=caster,
                                              spell_id=casting_spell.spell_entry.ID,
                                              faction=faction, ttl=duration)
        map_.spawn_object(world_object_instance=gameobject)

    @staticmethod
    def handle_summon_possessed(casting_spell, effect, caster, target):
        creature_entry = effect.misc_value
        if not creature_entry:
            return

        duration = casting_spell.get_duration() / 1000
        creature_manager = CreatureBuilder.create(creature_entry, target, caster.map_id, caster.instance_id,
                                                  summoner=caster,
                                                  spell_id=casting_spell.spell_entry.ID,
                                                  faction=caster.faction,
                                                  ttl=duration,
                                                  level=caster.level,
                                                  possessed=True,
                                                  subtype=CustomCodes.CreatureSubtype.SUBTYPE_TEMP_SUMMON,
                                                  summon_type=TempSummonType.TEMP_SUMMON_TIMED_DEATH_AND_DEAD_DESPAWN)

        caster.get_map().spawn_object(world_object_instance=creature_manager)
        FarSightManager.add_camera(creature_manager, caster)

    @staticmethod
    def handle_summon_player(casting_spell, effect, caster, target):
        # Restrictions implemented later:
        # 0.9: A failed [Ritual of Summoning] should no longer cost a soul shard.
        # 1.1: Target of summoning ritual must already be in the same instance if caster is in an instance.
        # 1.1: Summoning gives a confirmation dialog to person being summoned.
        # 1.3: You can no longer accept a warlock summoning while you are in combat.

        if not caster.is_player():
            return

        # Since this handler is ONLY used by the ritual of summoning effect, directly check for that spell here (ID 698).
        if not caster.spell_manager.remove_cast_by_id(698):
            return  # Don't summon if the player interrupted the ritual channeling (couldn't remove the cast).

        player = WorldSessionStateHandler.find_player_by_guid(caster.current_selection)
        player.teleport(caster.map_id, caster.location)

    @staticmethod
    def handle_script_effect(casting_spell, effect, caster, target):
        arcane_missiles = [5143, 5144, 5145, 6125]  # Only arcane missiles and group astral recall.
        group_astral_recall = 966
        if casting_spell.spell_entry.ID in arcane_missiles:
            # Periodic trigger spell aura uses the original target mask.
            # Arcane missiles initial cast is self-targeted, so we need to switch the mask here.
            casting_spell.spell_target_mask = SpellTargetMask.UNIT

        elif casting_spell.spell_entry.ID == group_astral_recall:
            for target in effect.targets.get_resolved_effect_targets_by_type(ObjectManager):
                if not target.is_player():
                    continue
                deathbind_map, deathbind_location = target.get_deathbind_coordinates()
                target.teleport(deathbind_map, deathbind_location)

    @staticmethod
    def handle_weapon_skill(casting_spell, effect, caster, target):
        if not target.is_player():
            return

        skill = target.skill_manager.get_skill_for_spell_id(casting_spell.spell_entry.ID)
        if not skill:
            return
        target.skill_manager.add_skill(skill.ID)

    @staticmethod
    def handle_add_proficiency(casting_spell, effect, caster, target):
        if not target.is_player():
            return

        item_class = casting_spell.spell_entry.EquippedItemClass
        item_subclass_mask = casting_spell.spell_entry.EquippedItemSubclass

        skill = target.skill_manager.get_skill_for_spell_id(casting_spell.spell_entry.ID)
        if not skill:
            return
        target.skill_manager.add_proficiency(item_class, item_subclass_mask, skill.ID)

    @staticmethod
    def handle_add_language(casting_spell, effect, caster, target):
        if not target.is_player():
            return

        skill = target.skill_manager.get_skill_for_spell_id(casting_spell.spell_entry.ID)
        if not skill:
            return

        target.skill_manager.add_skill(skill.ID)

    @staticmethod
    def handle_bind(casting_spell, effect, caster, target):
        # Only target allowed is a player.
        if not target.is_player():
            return

        # Only save the GUID of the binder if the spell is casted by a creature.
        if caster.is_unit():
            target.deathbind.creature_binder_guid = caster.get_low_guid()
        else:
            target.deathbind.creature_binder_guid = 0

        target.deathbind.deathbind_map = target.map_id
        target.deathbind.deathbind_zone = target.zone
        target.deathbind.deathbind_position_x = target.location.x
        target.deathbind.deathbind_position_y = target.location.y
        target.deathbind.deathbind_position_z = target.location.z
        RealmDatabaseManager.character_update_deathbind(target.deathbind)
        target.enqueue_packet(target.get_deathbind_packet())

        data = pack('<Q', caster.guid)
        target.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_PLAYERBOUND, data))

    @staticmethod
    def handle_leap(casting_spell, effect, caster, target):
        leaper = effect.targets.resolved_targets_a
        if not len(leaper):
            return

        leaper = leaper[0]

        if casting_spell.initial_target_is_terrain():
            leap_target = casting_spell.initial_target
            leap_target.set_orientation(leaper.location.o)
            leaper.teleport(caster.map_id, leap_target)
            return

        # Unit-targeted leap (Charge/heroic leap).
        # Generate a point within combat reach and facing the target.
        # It wasn't until Patch 0.6 that Charge sped you along a path towards the target, it just teleported you
        # next to the target (there's also video evidence of this behavior).
        distance = caster.location.distance(target.location) - UnitFormulas.combat_distance(leaper, target)
        charge_location = caster.location.get_point_in_between(caster, distance, target.location, map_id=caster.map_id)
        charge_location.face_point(target.location)

        # Always increase Z when not using namigator to protect players from falling off world.
        if config.Server.Settings.use_map_tiles and not config.Server.Settings.use_nav_tiles:
            charge_location.z += 1.5

        # Stop movement if target is currently moving with waypoints.
        target.movement_manager.stop()

        # Instant teleport.
        caster.teleport(caster.map_id, charge_location)

    @staticmethod
    def handle_tame_creature(casting_spell, effect, caster, target):
        if not caster.is_player():
            return
        if target.is_player():
            return

        # Taming will always result in the target becoming the caster's pet.
        # Pass summon pet ID as the spell creating this unit since it's saved in the database.
        pet = caster.pet_manager.set_creature_as_pet(target, PetData.SUMMON_PET_SPELL_ID,
                                                     PetSlot.PET_SLOT_PERMANENT, is_permanent=True)
        if pet:
            # Since we have no data for what abilities pets had in the wild (or if it even varied in 0.5.3),
            # learn all abilities the pet could have at its current level.
            pet.initialize_spells()

    @staticmethod
    def handle_summon_pet(casting_spell, effect, caster, target):
        if not caster.is_unit(by_mask=True):
            return

        caster.pet_manager.summon_permanent_pet(casting_spell.spell_entry.ID, creature_id=effect.misc_value)

    # TODO:
    #  Level of pet summoned using engineering item based at engineering skill level.
    @staticmethod
    def handle_summon_guardian(casting_spell, effect, caster, target):
        creature_entry = effect.misc_value
        if not creature_entry:
            return
        duration = casting_spell.get_duration() / 1000
        radius = effect.get_radius()
        amount = effect.get_effect_simple_points()

        if not radius:
            radius = PET_FOLLOW_DISTANCE

        # Detach guardians with same entry if any.
        caster.pet_manager.detach_pets_by_entry(creature_entry)

        for count in range(amount):
            random_point = caster.location.get_random_point_in_radius(radius, caster.map_id)
            po = caster.location.o
            if casting_spell.spell_target_mask & SpellTargetMask.DEST_LOCATION:
                px = target.x if not count else random_point.x
                py = target.y if not count else random_point.y
                pz = target.z if not count else random_point.z
            else:
                px = random_point.x
                py = random_point.y
                pz = random_point.z

            creature_manager = CreatureBuilder.create(creature_entry, Vector(px, py, pz, po), caster.map_id,
                                                      caster.instance_id,
                                                      summoner=caster,
                                                      spell_id=casting_spell.spell_entry.ID,
                                                      faction=caster.faction, ttl=duration,
                                                      possessed=False,
                                                      subtype=CustomCodes.CreatureSubtype.SUBTYPE_TEMP_SUMMON,
                                                      is_guardian=True)

            caster.get_map().spawn_object(world_object_instance=creature_manager)
            caster.pet_manager.add_guardian_from_spell(creature_manager, casting_spell)
            if caster.object_ai:
                caster.object_ai.just_summoned(creature_manager)

    @staticmethod
    def handle_summon_wild(casting_spell, effect, caster, target):
        creature_entry = effect.misc_value
        if not creature_entry:
            return

        radius = effect.get_radius()
        duration = casting_spell.get_duration()
        # If no duration, default to 2 minutes.
        duration = 120 if duration == 0 else (duration / 1000)
        amount = effect.get_effect_simple_points()

        for count in range(amount):
            if casting_spell.spell_target_mask & SpellTargetMask.DEST_LOCATION:
                if count == 0:
                    location = target
                else:
                    location = caster.location.get_random_point_in_radius(radius, caster.map_id)
            else:
                if radius > 0.0:
                    location = caster.location.get_random_point_in_radius(radius, caster.map_id)
                else:
                    location = target if isinstance(target, Vector) else target.location

            summon_type = TempSummonType.TEMP_SUMMON_DEAD_DESPAWN if not duration \
                else TempSummonType.TEMP_SUMMON_TIMED_DEATH_AND_DEAD_DESPAWN

            # Spawn the summoned unit.
            creature_manager = CreatureBuilder.create(creature_entry, location, caster.map_id,
                                                      caster.instance_id,
                                                      summoner=caster, faction=caster.faction, ttl=duration,
                                                      spell_id=casting_spell.spell_entry.ID,
                                                      subtype=CustomCodes.CreatureSubtype.SUBTYPE_TEMP_SUMMON,
                                                      summon_type=summon_type)

            if not creature_manager:
                Logger.error(f'Summon failed, creature with entry {creature_entry} '
                                 f'not found for spell {casting_spell.spell_entry.ID}, '
                                 f'caster entry {caster.get_entry()}')
                return

            caster.get_map().spawn_object(world_object_instance=creature_manager)

    @staticmethod
    def handle_resurrect(casting_spell, effect, caster, target):
        if not target.is_player():
            return

        # Skip if target is not dead.
        if target.is_alive:
            return

        # Store resurrection data for target.
        from game.world.managers.maps.helpers.ResurrectionRequestDataHolder import ResurrectionRequestDataHolder
        target.resurrect_data = ResurrectionRequestDataHolder(
            caster.guid, effect.get_effect_points() / 100, caster.location.copy(), caster.map_id
        )

        # Send resurrection request.
        data = pack('<Q', caster.guid)
        target.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_RESURRECT_REQUEST, data))

    @staticmethod
    def handle_extra_attacks(casting_spell, effect, caster, target):
        if not target.is_unit(by_mask=True):
            return

        if not target.is_alive:
            return

        target.extra_attacks += effect.get_effect_simple_points()

    @staticmethod
    def handle_dummy(casting_spell, effect, caster, target):
        if casting_spell.spell_entry.ID not in SpellEffectDummyHandler.DUMMY_SPELL_EFFECTS:
            Logger.warning(f'Unimplemented dummy spell effect for spell {casting_spell.spell_entry.ID}.')
            return

        SpellEffectDummyHandler.DUMMY_SPELL_EFFECTS[casting_spell.spell_entry.ID](casting_spell, effect, caster, target)

    @staticmethod
    def handle_threat(casting_spell, effect, caster, target):
        if not target.is_unit():
            return

        if not target.is_alive:
            return

        threat = effect.get_effect_simple_points()
        target.threat_manager.add_threat(caster, threat)

    @staticmethod
    def handle_distract(casting_spell, effect, caster, target):
        if not target.is_unit(by_mask=True):
            return

        if target.combat_target or target.unit_state & UnitStates.DISTRACTED:
            return

        location = target.location if not isinstance(casting_spell.initial_target, Vector) else casting_spell.initial_target
        duration = casting_spell.get_duration() / 1000
        angle = target.location.get_angle_towards_vector(location)
        target.movement_manager.move_distracted(duration, angle=angle)

    @staticmethod
    def handle_interrupt_cast(casting_spell, effect, caster, target):
        if not target.is_unit(by_mask=True):
            return

        if not target.is_alive:
            return

        target.spell_manager.interrupt_casting_spell(cooldown_penalty=casting_spell.get_duration())

    @staticmethod
    def handle_stuck(casting_spell, effect, caster, target):
        if not target.is_player():
            return

        deathbind_map, deathbind_location = target.get_deathbind_coordinates()
        target.teleport(deathbind_map, deathbind_location)

    @staticmethod
    def handle_pick_pocket(casting_spell, effect, caster, target):
        if not caster.is_player():
            return

        if not target.pickpocket_loot_manager.has_loot() and not target.pickpocket_loot_manager.already_pickpocketed:
            target.pickpocket_loot_manager.generate_loot(caster)

        caster.send_loot(target.pickpocket_loot_manager)

    @staticmethod
    def handle_add_farsight(casting_spell, effect, caster, target):
        if not caster.is_player():
            return

        duration = casting_spell.get_duration() / 1000
        dyn_object = DynamicObjectManager.spawn_from_spell_effect(effect,
                                                                  DynamicObjectTypes.DYNAMIC_OBJECT_FARSIGHT_FOCUS,
                                                                  orientation=caster.location.o,
                                                                  ttl=duration)
        FarSightManager.add_camera(dyn_object, caster)

    @staticmethod
    def handle_skill_step(casting_spell, effect, caster, target):
        if not target.is_player():
            return

        step = effect.get_effect_points()
        if step < 0:
            return
        
        skill_max = (step * 5)
        skill_id = effect.misc_value
        
        if not target.skill_manager.has_skill(skill_id):
            if not target.skill_manager.add_skill(skill_id):
                return

        current_skill = target.skill_manager.get_total_skill_value(skill_id, no_bonus=True)
        target.skill_manager.set_skill(skill_id, max(1, current_skill),
                                       skill_max if skill_max < 1000 else -1)
        target.skill_manager.build_update()

    @staticmethod
    def handle_temporary_enchant(casting_spell, effect, caster, target):
        SpellEffectHandler.handle_permanent_enchant(casting_spell, effect, caster, target, True)

    @staticmethod
    def handle_permanent_enchant(casting_spell, effect, caster, target, is_temporary=False):
        if not caster.is_player():
            return

        # Calculate slot, duration and charges.
        enchantment_slot = EnchantmentSlots.PERMANENT_SLOT if not is_temporary else EnchantmentSlots.TEMPORARY_SLOT

        duration = 0
        charges = 0

        if is_temporary:
            charges = ExtendedSpellData.EnchantmentChargesInfo.get_charges(casting_spell.spell_entry.ID)
            # If not ruled by charges, use duration.
            if not charges:
                # Temporary enchantments from professions (enchanting) have a duration of 1h while others have 30min.
                duration = 30 * 60 if not casting_spell.spell_entry.CastUI else 60 * 60

        owner_player = WorldSessionStateHandler.find_player_by_guid(target.get_owner_guid())
        if not owner_player:
            return

        # If this enchantment is being applied on a trade, update trade status with proposed enchant.
        # Enchant will be applied after trade is accepted.
        if owner_player != caster:
            if caster.trade_data and caster.trade_data.other_player and caster.trade_data.other_player.trade_data:
                # Get the trade slot for the item being enchanted.
                trade_slot = caster.trade_data.other_player.trade_data.get_slot_by_item(target)

                # Update proposed enchantment on caster.
                caster.trade_data.set_proposed_enchant(trade_slot,
                                                       casting_spell.spell_entry.ID,
                                                       enchantment_slot,
                                                       effect.misc_value,
                                                       duration, charges)

                # Update proposed enchantment on receiver.
                caster.trade_data.other_player.trade_data.set_proposed_enchant(trade_slot,
                                                                               casting_spell.spell_entry.ID,
                                                                               enchantment_slot,
                                                                               effect.misc_value,
                                                                               duration, charges)

                # Update trade status, this will propagate to both players.
                caster.trade_data.update_trade_status()
                return

        # Apply permanent enchantment.
        owner_player.enchantment_manager.set_item_enchantment(target, enchantment_slot, effect.misc_value,
                                                              -1 if not is_temporary else duration, charges)
        owner_player.equipment_proc_manager.handle_equipment_change(target)

        # Save item.
        target.save()

        # Enchantment log.
        owner_player.enchantment_manager.send_enchantment_log(caster, target, effect.misc_value)

    # Block/parry/dodge/defense passives have their own effects and no aura.
    # Flag the unit here as being able to block/parry/dodge.
    @staticmethod
    def handle_block_passive(casting_spell, effect, caster, target):
        if not target.is_unit(by_mask=True):
            return

        target.has_block_passive = True

        if target.is_player():
            target.stat_manager.send_defense_bonuses()  # Send new block chance.
            skill, skill_line = SkillManager.get_skill_and_skill_line_for_spell_id(casting_spell.spell_entry.ID,
                                                                                   caster.race, caster.class_)
            if skill:
                target.skill_manager.add_skill(skill.ID)

    @staticmethod
    def handle_parry_passive(casting_spell, effect, caster, target):
        if not target.is_unit(by_mask=True):
            return

        target.has_parry_passive = True

        if target.is_player():
            target.stat_manager.send_defense_bonuses()  # Send new parry chance.
            skill, skill_line = SkillManager.get_skill_and_skill_line_for_spell_id(casting_spell.spell_entry.ID,
                                                                                   caster.race, caster.class_)
            if skill:
                target.skill_manager.add_skill(skill.ID)

    @staticmethod
    def handle_dodge_passive(casting_spell, effect, caster, target):
        if not target.is_unit(by_mask=True):
            return

        target.has_dodge_passive = True

        if target.is_player():
            target.stat_manager.send_defense_bonuses()  # Send new dodge chance.
            skill, skill_line = SkillManager.get_skill_and_skill_line_for_spell_id(casting_spell.spell_entry.ID,
                                                                                   caster.race, caster.class_)
            if skill:
                target.skill_manager.add_skill(skill.ID)

    @staticmethod
    def handle_defense_passive(casting_spell, effect, caster, target):
        if not target.is_player():
            return

        skill, skill_line = SkillManager.get_skill_and_skill_line_for_spell_id(casting_spell.spell_entry.ID,
                                                                               caster.race, caster.class_)
        if skill:
            target.skill_manager.add_skill(skill.ID)

    @staticmethod
    def handle_spell_defense_passive(casting_spell, effect, caster, target):
        pass  # Only "SPELLDEFENSE (DND)", obsolete

    @staticmethod
    def handle_dual_wield_passive(casting_spell, effect, caster, target):
        if not target.is_player():
            return

        skill, skill_line = SkillManager.get_skill_and_skill_line_for_spell_id(casting_spell.spell_entry.ID,
                                                                               caster.race, caster.class_)
        if skill:
            target.skill_manager.add_skill(skill.ID)

    AREA_SPELL_EFFECTS = {
        SpellEffects.SPELL_EFFECT_PERSISTENT_AREA_AURA,
        SpellEffects.SPELL_EFFECT_APPLY_AREA_AURA
    }

    @staticmethod
    def handle_quest_complete(casting_spell, effect, caster, target):
        target = target if target.is_player() else caster if caster.is_player() else None

        if not target:
            return

        quest = WorldDatabaseManager.QuestTemplateHolder.quest_get_by_entry(effect.misc_value)
        if not quest:
            return

        if quest.entry not in target.quest_manager.active_quests:
            return

        target.quest_manager.complete_quest_by_id(quest_id=quest.entry)

    @staticmethod
    def handle_send_event(casting_spell, effect, caster, target):
        event_scripts = WorldDatabaseManager.EventScriptHolder.event_scripts_get_by_id(effect.misc_value)
        if not event_scripts:
            return

        caster.get_map().enqueue_script(caster, target=target, script_type=ScriptTypes.SCRIPT_TYPE_EVENT_SCRIPT,
                                        script_id=effect.misc_value)


SPELL_EFFECTS = {
    SpellEffects.SPELL_EFFECT_ACTIVATE_OBJECT: SpellEffectHandler.handle_activate_object,
    SpellEffects.SPELL_EFFECT_SCHOOL_DAMAGE: SpellEffectHandler.handle_school_damage,
    SpellEffects.SPELL_EFFECT_HEAL: SpellEffectHandler.handle_heal,
    SpellEffects.SPELL_EFFECT_HEAL_MAX_HEALTH: SpellEffectHandler.handle_heal_max_health,
    SpellEffects.SPELL_EFFECT_QUEST_COMPLETE: SpellEffectHandler.handle_quest_complete,
    SpellEffects.SPELL_EFFECT_WEAPON_DAMAGE: SpellEffectHandler.handle_weapon_damage,
    SpellEffects.SPELL_EFFECT_WEAPON_DAMAGE_PLUS: SpellEffectHandler.handle_weapon_damage,
    SpellEffects.SPELL_EFFECT_ADD_COMBO_POINTS: SpellEffectHandler.handle_add_combo_points,
    SpellEffects.SPELL_EFFECT_SANCTUARY: SpellEffectHandler.handle_sanctuary,
    SpellEffects.SPELL_EFFECT_DUEL: SpellEffectHandler.handle_request_duel,
    SpellEffects.SPELL_EFFECT_APPLY_AURA: SpellEffectHandler.handle_aura_application,
    SpellEffects.SPELL_EFFECT_DISPEL: SpellEffectHandler.handle_dispel,
    SpellEffects.SPELL_EFFECT_ENERGIZE: SpellEffectHandler.handle_energize,
    SpellEffects.SPELL_EFFECT_POWER_BURN: SpellEffectHandler.handle_power_burn,
    SpellEffects.SPELL_EFFECT_POWER_DRAIN: SpellEffectHandler.handle_power_drain,
    SpellEffects.SPELL_EFFECT_HEALTH_LEECH: SpellEffectHandler.handle_health_leech,
    SpellEffects.SPELL_EFFECT_SUMMON_MOUNT: SpellEffectHandler.handle_summon_mount,
    SpellEffects.SPELL_EFFECT_INSTAKILL: SpellEffectHandler.handle_insta_kill,
    SpellEffects.SPELL_EFFECT_CREATE_ITEM: SpellEffectHandler.handle_create_item,
    SpellEffects.SPELL_EFFECT_TELEPORT_UNITS: SpellEffectHandler.handle_teleport_units,
    SpellEffects.SPELL_EFFECT_PERSISTENT_AREA_AURA: SpellEffectHandler.handle_persistent_area_aura,
    SpellEffects.SPELL_EFFECT_OPEN_LOCK: SpellEffectHandler.handle_open_lock,
    SpellEffects.SPELL_EFFECT_OPEN_LOCK_ITEM: SpellEffectHandler.handle_open_lock,
    SpellEffects.SPELL_EFFECT_LEARN_SPELL: SpellEffectHandler.handle_learn_spell,
    SpellEffects.SPELL_EFFECT_LEARN_PET_SPELL: SpellEffectHandler.handle_learn_pet_spell,
    SpellEffects.SPELL_EFFECT_APPLY_AREA_AURA: SpellEffectHandler.handle_apply_area_aura,
    SpellEffects.SPELL_EFFECT_SUMMON_TOTEM: SpellEffectHandler.handle_summon_totem,
    SpellEffects.SPELL_EFFECT_SCRIPT_EFFECT: SpellEffectHandler.handle_script_effect,
    SpellEffects.SPELL_EFFECT_SUMMON_OBJECT: SpellEffectHandler.handle_summon_object,
    SpellEffects.SPELL_EFFECT_SUMMON_OBJECT_WILD: SpellEffectHandler.handle_summon_object_wild,
    SpellEffects.SPELL_EFFECT_SUMMON_PLAYER: SpellEffectHandler.handle_summon_player,
    SpellEffects.SPELL_EFFECT_CREATE_HOUSE: SpellEffectHandler.handle_summon_object,
    SpellEffects.SPELL_EFFECT_SUMMON_POSSESSED: SpellEffectHandler.handle_summon_possessed,
    SpellEffects.SPELL_EFFECT_BIND: SpellEffectHandler.handle_bind,
    SpellEffects.SPELL_EFFECT_LEAP: SpellEffectHandler.handle_leap,
    SpellEffects.SPELL_EFFECT_TAME_CREATURE: SpellEffectHandler.handle_tame_creature,
    SpellEffects.SPELL_EFFECT_SUMMON_PET: SpellEffectHandler.handle_summon_pet,
    SpellEffects.SPELL_EFFECT_SUMMON: SpellEffectHandler.handle_summon_pet,
    SpellEffects.SPELL_EFFECT_ENCHANT_ITEM_PERMANENT: SpellEffectHandler.handle_permanent_enchant,
    SpellEffects.SPELL_EFFECT_SKILL_STEP: SpellEffectHandler.handle_skill_step,
    SpellEffects.SPELL_EFFECT_ENCHANT_ITEM_TEMPORARY: SpellEffectHandler.handle_temporary_enchant,
    SpellEffects.SPELL_EFFECT_PICKPOCKET: SpellEffectHandler.handle_pick_pocket,
    SpellEffects.SPELL_EFFECT_ADD_FARSIGHT: SpellEffectHandler.handle_add_farsight,
    SpellEffects.SPELL_EFFECT_SUMMON_WILD: SpellEffectHandler.handle_summon_wild,
    SpellEffects.SPELL_EFFECT_SUMMON_GUARDIAN: SpellEffectHandler.handle_summon_guardian,
    SpellEffects.SPELL_EFFECT_RESURRECT: SpellEffectHandler.handle_resurrect,
    SpellEffects.SPELL_EFFECT_EXTRA_ATTACKS: SpellEffectHandler.handle_extra_attacks,
    SpellEffects.SPELL_EFFECT_DUMMY: SpellEffectHandler.handle_dummy,
    SpellEffects.SPELL_EFFECT_THREAT: SpellEffectHandler.handle_threat,
    SpellEffects.SPELL_EFFECT_STUCK: SpellEffectHandler.handle_stuck,
    SpellEffects.SPELL_EFFECT_INTERRUPT_CAST: SpellEffectHandler.handle_interrupt_cast,
    SpellEffects.SPELL_EFFECT_DISTRACT: SpellEffectHandler.handle_distract,

    # Event scripts.
    SpellEffects.SPELL_EFFECT_SEND_EVENT: SpellEffectHandler.handle_send_event,

    # Passive effects - enable skills, add skills and proficiencies on login.
    SpellEffects.SPELL_EFFECT_BLOCK: SpellEffectHandler.handle_block_passive,
    SpellEffects.SPELL_EFFECT_PARRY: SpellEffectHandler.handle_parry_passive,
    SpellEffects.SPELL_EFFECT_DODGE: SpellEffectHandler.handle_dodge_passive,
    SpellEffects.SPELL_EFFECT_DEFENSE: SpellEffectHandler.handle_defense_passive,
    SpellEffects.SPELL_EFFECT_SPELL_DEFENSE: SpellEffectHandler.handle_spell_defense_passive,
    SpellEffects.SPELL_EFFECT_DUAL_WIELD: SpellEffectHandler.handle_dual_wield_passive,
    SpellEffects.SPELL_EFFECT_WEAPON: SpellEffectHandler.handle_weapon_skill,
    SpellEffects.SPELL_EFFECT_PROFICIENCY: SpellEffectHandler.handle_add_proficiency,
    SpellEffects.SPELL_EFFECT_LANGUAGE: SpellEffectHandler.handle_add_language
}
