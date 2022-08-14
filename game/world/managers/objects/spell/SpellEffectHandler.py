from struct import pack

from database.realm.RealmDatabaseManager import RealmDatabaseManager
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.WorldSessionStateHandler import WorldSessionStateHandler
from game.world.managers.abstractions.Vector import Vector
from game.world.managers.objects.ObjectManager import ObjectManager
from game.world.managers.objects.gameobjects.GameObjectManager import GameObjectManager
from game.world.managers.objects.item.ItemManager import ItemManager
from game.world.managers.objects.locks.LockManager import LockManager
from game.world.managers.objects.spell.AuraManager import AppliedAura
from game.world.managers.objects.units.player.DuelManager import DuelManager
from game.world.managers.objects.units.player.SkillManager import SkillTypes
from network.packet.PacketWriter import PacketWriter, OpCode
from utils.Formulas import UnitFormulas
from utils.Logger import Logger
from utils.constants import CustomCodes
from utils.constants.ItemCodes import EnchantmentSlots, ItemDynFlags, InventoryError
from utils.constants.MiscCodes import ObjectTypeFlags, HighGuid, ObjectTypeIds, AttackTypes
from utils.constants.SpellCodes import SpellCheckCastResult, AuraTypes, SpellEffects, SpellState, SpellTargetMask, \
    SpellImmunity
from utils.constants.UnitCodes import UnitFlags, Classes


class SpellEffectHandler:
    @staticmethod
    def apply_effect(casting_spell, effect, caster, target):
        if effect.effect_type not in SPELL_EFFECTS:
            Logger.debug(f'Unimplemented spell effect called ({SpellEffects(effect.effect_type).name}: '
                         f'{effect.effect_type}) from spell {casting_spell.spell_entry.ID}.')
            return

        # Immunities.
        if target and isinstance(target, ObjectManager) and \
                target.object_type_mask & ObjectTypeFlags.TYPE_UNIT:
            # Spell school/effect aura.
            if casting_spell.is_target_immune() or \
                    (effect.effect_type == SpellEffects.SPELL_EFFECT_APPLY_AURA and
                     casting_spell.is_target_immune_to_aura()):
                caster.spell_manager.send_cast_immune_result(target, casting_spell.spell_entry.ID)
                return

            # Effect type.
            if target.handle_immunity(caster, SpellImmunity.IMMUNITY_EFFECT,
                                      effect.effect_type, spell_id=casting_spell.spell_entry.ID):
                return

        SPELL_EFFECTS[effect.effect_type](casting_spell, effect, caster, target)

    @staticmethod
    def handle_school_damage(casting_spell, effect, caster, target):
        if not target.object_type_mask & ObjectTypeFlags.TYPE_UNIT:
            return

        damage = effect.get_effect_points()
        caster.apply_spell_damage(target, damage, casting_spell)

    @staticmethod
    def handle_heal(casting_spell, effect, caster, target):
        if not target.object_type_mask & ObjectTypeFlags.TYPE_UNIT:
            return

        healing = effect.get_effect_points()
        caster.apply_spell_healing(target, healing, casting_spell)

    @staticmethod
    def handle_heal_max_health(casting_spell, effect, caster, target):
        if not target.object_type_mask & ObjectTypeFlags.TYPE_UNIT:
            return

        healing = caster.max_health
        caster.apply_spell_healing(target, healing, casting_spell)

    @staticmethod
    def handle_weapon_damage(casting_spell, effect, caster, target):
        if not caster.object_type_mask & ObjectTypeFlags.TYPE_UNIT:
            return

        if casting_spell.spell_attack_type == -1:
            # Fall back to base_attack if the attack type couldn't be resolved on init.
            # This is required for some spells that don't define the type of weapon needed for the attack.
            # TODO This should be resolved during CastingSpell init, but more research is needed for a generic check.
            casting_spell.spell_attack_type = AttackTypes.BASE_ATTACK

        weapon_damage = caster.calculate_base_attack_damage(casting_spell.spell_attack_type,
                                                            casting_spell.spell_entry.School,
                                                            target,
                                                            apply_bonuses=False)  # Bonuses are applied on spell damage.

        damage = weapon_damage + effect.get_effect_points()
        caster.apply_spell_damage(target, damage, casting_spell)

    @staticmethod
    def handle_weapon_damage_plus(casting_spell, effect, caster, target):
        if not caster.object_type_mask & ObjectTypeFlags.TYPE_UNIT:
            return

        if casting_spell.spell_attack_type == -1:
            casting_spell.spell_attack_type = AttackTypes.BASE_ATTACK

        weapon_damage = caster.calculate_base_attack_damage(casting_spell.spell_attack_type,
                                                            casting_spell.spell_entry.School,
                                                            target,
                                                            apply_bonuses=False)  # Bonuses are applied on spell damage.

        damage_bonus = effect.get_effect_points()

        # Overpower also uses combo points, but shouldn't scale.
        if caster.get_type_id() == ObjectTypeIds.ID_PLAYER and not casting_spell.is_overpower() and \
                casting_spell.requires_combo_points():
            damage_bonus *= casting_spell.spent_combo_points

        caster.apply_spell_damage(target, weapon_damage + damage_bonus, casting_spell)

    @staticmethod
    def handle_add_combo_points(casting_spell, effect, caster, target):
        if not caster.object_type_mask & ObjectTypeFlags.TYPE_UNIT:
            return

        caster.add_combo_points_on_target(target, effect.get_effect_points())

    @staticmethod
    def handle_aura_application(casting_spell, effect, caster, target):
        if not target.object_type_mask & ObjectTypeFlags.TYPE_UNIT:
            return

        target.aura_manager.apply_spell_effect_aura(caster, casting_spell, effect)

    @staticmethod
    def handle_request_duel(casting_spell, effect, caster, target):
        arbiter = GameObjectManager.spawn(effect.misc_value, effect.targets.resolved_targets_b[0], caster.map_,
                                          summoner=caster, ttl=3600, spell_id=casting_spell.spell_entry.ID,
                                          override_faction=caster.faction)

        DuelManager.request_duel(caster, target, arbiter)

    @staticmethod
    def handle_open_lock(casting_spell, effect, caster, target):
        if not caster or caster.get_type_id() != ObjectTypeIds.ID_PLAYER:
            return

        if target.get_type_id() == ObjectTypeIds.ID_GAMEOBJECT:
            target.use(caster, target)
        elif target.get_type_id() == ObjectTypeIds.ID_ITEM:
            target.set_unlocked()
        else:
            Logger.debug(f'Unimplemented open lock spell effect.')
            return

        lock_type = effect.misc_value
        lock_id = target.lock
        bonus_points = effect.get_effect_simple_points()

        # Lock opening is already validated at this point, but use can_open_lock to fetch lock info.
        lock_result = LockManager.can_open_lock(caster, lock_type, lock_id,
                                                cast_item=casting_spell.source_item,
                                                bonus_points=bonus_points)

        caster.skill_manager.handle_gather_skill_gain(lock_result.skill_type,
                                                      lock_result.required_skill_value)

    @staticmethod
    def handle_energize(casting_spell, effect, caster, target):
        if not target.object_type_mask & ObjectTypeFlags.TYPE_UNIT:
            return

        power_type = effect.misc_value
        if power_type != target.power_type:
            return

        amount = effect.get_effect_points()
        target.receive_power(amount, power_type)

    @staticmethod
    def handle_summon_mount(casting_spell, effect, caster, target):
        if not target.object_type_mask & ObjectTypeFlags.TYPE_UNIT:
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
        if not target.object_type_mask & ObjectTypeFlags.TYPE_UNIT:
            return

        # No SMSG_SPELLINSTAKILLLOG in 0.5.3
        target.die(killer=caster)

    @staticmethod
    def handle_create_item(casting_spell, effect, caster, target):
        if target.get_type_id() != ObjectTypeIds.ID_PLAYER:
            return

        item_template = WorldDatabaseManager.ItemTemplateHolder.item_template_get_by_entry(effect.item_type)

        if not item_template:
            target.inventory.send_equip_error(InventoryError.BAG_UNKNOWN_ITEM)
            return

        amount = effect.get_effect_points()
        can_store_item = target.inventory.can_store_item(item_template, amount)
        if can_store_item != InventoryError.BAG_OK:
            target.inventory.send_equip_error(can_store_item)
            return

        # Add the item to player inventory.
        target.inventory.add_item(effect.item_type, count=amount, created_by=caster.guid)

        # Craft Skill gain if needed.
        target.skill_manager.handle_profession_skill_gain(casting_spell.spell_entry.ID)

    @staticmethod
    def handle_teleport_units(casting_spell, effect, caster, target):
        if not target.object_type_mask & ObjectTypeFlags.TYPE_PLAYER:
            return

        # Teleport targets should follow the format (map, Vector).
        teleport_targets = effect.targets.get_resolved_effect_targets_by_type(tuple)
        if len(teleport_targets) == 0:
            return
        teleport_info = teleport_targets[0]
        if len(teleport_info) != 2 or not isinstance(teleport_info[1], Vector):
            return

        target.teleport(teleport_info[0], teleport_info[1])  # map, coordinates resolved.
        # TODO Die sides are assigned for at least Word of Recall (ID 1)

    @staticmethod
    def handle_persistent_area_aura(casting_spell, effect, caster, target):  # Ground-targeted aoe.
        if target is not None:
            return

        SpellEffectHandler.handle_apply_area_aura(casting_spell, effect, caster, target)
        return

    @staticmethod
    def handle_apply_area_aura(casting_spell, effect, caster, target):  # Paladin auras, healing stream totem etc.
        casting_spell.cast_state = SpellState.SPELL_STATE_ACTIVE

        previous_targets = effect.targets.previous_targets_a if effect.targets.previous_targets_a else []
        current_targets = effect.targets.resolved_targets_a

        new_targets = [unit for unit in current_targets if
                       unit not in previous_targets]  # Targets that can't have the aura yet.
        missing_targets = [unit for unit in previous_targets if
                           unit not in current_targets]  # Targets that moved out of the area.

        for target in new_targets:
            new_aura = AppliedAura(caster, casting_spell, effect, target)
            target.aura_manager.add_aura(new_aura)

        for target in missing_targets:
            target.aura_manager.cancel_auras_by_spell_id(casting_spell.spell_entry.ID)

    @staticmethod
    def handle_learn_spell(casting_spell, effect, caster, target):
        target_spell_id = effect.trigger_spell_id
        target.spell_manager.learn_spell(target_spell_id)

    @staticmethod
    def handle_summon_totem(casting_spell, effect, caster, target):
        totem_entry = effect.misc_value
        duration = effect.get_duration()
        # If no duration, default to 5 minutes.
        duration = 300 if duration == 0 else (duration / 1000)
        # TODO Refactor to avoid circular import?
        from game.world.managers.objects.units.creature.CreatureManager import CreatureManager
        creature_manager = CreatureManager.spawn(totem_entry, target, caster.map_, summoner=caster,
                                                 override_faction=caster.faction, ttl=duration)

        if not creature_manager:
            return

        creature_manager.subtype = CustomCodes.CreatureSubtype.SUBTYPE_TOTEM
        creature_manager.respawn()

        # TODO This should be handled in creature AI instead
        # TODO Totems are not connected to player (pet etc. handling)
        for spell_id in [creature_manager.creature_template.spell_id1,
                         creature_manager.creature_template.spell_id2,
                         creature_manager.creature_template.spell_id3,
                         creature_manager.creature_template.spell_id4]:
            if spell_id == 0:
                break
            creature_manager.spell_manager.handle_cast_attempt(spell_id, creature_manager, SpellTargetMask.SELF)

    @staticmethod
    def handle_summon_object(casting_spell, effect, caster, target):
        object_entry = effect.misc_value

        # Validate go template existence.
        go_template = WorldDatabaseManager.gameobject_template_get_by_entry(object_entry)
        if not go_template:
            Logger.error(f'Gameobject with entry {object_entry} not found for spell {casting_spell.spell_entry.ID}.')
            return

        target = None
        if isinstance(effect.targets.resolved_targets_a[0], ObjectManager):
            target = effect.targets.resolved_targets_a[0].location
        elif isinstance(effect.targets.resolved_targets_a[0], Vector):
            target = effect.targets.resolved_targets_a[0]

        if not target:
            Logger.error(f'Unable to resolve target, go entry {object_entry}, spell {casting_spell.spell_entry.ID}.')
            return

        duration = effect.get_duration()
        # If no duration, default to 2 minutes.
        duration = 120 if duration == 0 else (duration / 1000)
        GameObjectManager.spawn(object_entry, target, caster.map_, summoner=caster,
                                spell_id=casting_spell.spell_entry.ID, override_faction=caster.faction,
                                ttl=duration)

    @staticmethod
    def handle_summon_player(casting_spell, effect, caster, target):
        # Restrictions implemented later:
        # 0.9: A failed [Ritual of Summoning] should no longer cost a soul shard.
        # 1.1: Target of summoning ritual must already be in the same instance if caster is in an instance.
        # 1.1: Summoning gives a confirmation dialog to person being summoned.
        # 1.3: You can no longer accept a warlock summoning while you are in combat.

        if caster.get_type_id() != ObjectTypeIds.ID_PLAYER:
            return

        # Since this handler is ONLY used by the ritual of summoning effect, directly check for that spell here (ID 698).
        if not caster.spell_manager.remove_cast_by_id(698):
            return  # Don't summon if the player interrupted the ritual channeling (couldn't remove the cast).

        player = WorldSessionStateHandler.find_player_by_guid(caster.current_selection)
        player.teleport(caster.map_, caster.location)

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
                if target.get_type_id() != ObjectTypeIds.ID_PLAYER:
                    continue
                recall_coordinates = target.get_deathbind_coordinates()
                target.teleport(recall_coordinates[0], recall_coordinates[1])

    @staticmethod
    def handle_weapon_skill(casting_spell, effect, caster, target):
        if target.get_type_id() != ObjectTypeIds.ID_PLAYER:
            return

        skill = target.skill_manager.get_skill_for_spell_id(casting_spell.spell_entry.ID)
        if not skill:
            return
        target.skill_manager.add_skill(skill.ID)

    @staticmethod
    def handle_add_proficiency(casting_spell, effect, caster, target):
        if target.get_type_id() != ObjectTypeIds.ID_PLAYER:
            return

        item_class = casting_spell.spell_entry.EquippedItemClass
        item_subclass_mask = casting_spell.spell_entry.EquippedItemSubclass

        skill = target.skill_manager.get_skill_for_spell_id(casting_spell.spell_entry.ID)
        if not skill:
            return
        target.skill_manager.add_proficiency(item_class, item_subclass_mask, skill.ID)

    @staticmethod
    def handle_add_language(casting_spell, effect, caster, target):
        if target.get_type_id() != ObjectTypeIds.ID_PLAYER:
            return

        skill = target.skill_manager.get_skill_for_spell_id(casting_spell.spell_entry.ID)
        if not skill:
            return

        target.skill_manager.add_skill(skill.ID)

    @staticmethod
    def handle_bind(casting_spell, effect, caster, target):
        # Only target allowed is a player.
        if target.get_type_id() != ObjectTypeIds.ID_PLAYER:
            return

        # Only save the GUID of the binder if the spell is casted by a creature.
        if caster.get_type_id() == ObjectTypeIds.ID_UNIT:
            target.deathbind.creature_binder_guid = caster.guid & ~HighGuid.HIGHGUID_UNIT
        else:
            target.deathbind.creature_binder_guid = 0

        target.deathbind.deathbind_map = target.map_
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
        # Leap targeting specifies both the leaping unit and their leap target.
        # Since there are no leap spells with multiple targets,
        # this method selects the first targets.

        leaper = effect.targets.resolved_targets_a
        leap_target = effect.targets.resolved_targets_b

        if len(leaper) != 1 or len(leap_target) != 1:
            return

        leaper = leaper[0]
        leap_target = leap_target[0]

        # Terrain targeted leaps (ie. blink).
        if casting_spell.initial_target_is_terrain():
            leap_target.o = leaper.location.o
            leaper.teleport(caster.map_, leap_target)
            return

        # Unit-targeted leap (Charge/heroic leap).
        # Generate a point within combat reach and facing the target.
        # It wasn't until Patch 0.6 that Charge speeded you along a path towards the target, it just teleported you
        # next to the target (there's also video evidence of this behavior).
        distance = caster.location.distance(target.location) - UnitFormulas.combat_distance(leaper, leap_target)
        charge_location = caster.location.get_point_in_between(distance, target.location, map_id=caster.map_)
        charge_location.face_point(target.location)

        # Stop movement if target is currently moving with waypoints.
        target.stop_movement()

        # Instant teleport.
        caster.teleport(caster.map_, charge_location, is_instant=True)

    @staticmethod
    def handle_tame_creature(casting_spell, effect, caster, target):
        if caster.get_type_id() != ObjectTypeIds.ID_PLAYER:
            return
        if target.get_type_id() == ObjectTypeIds.ID_PLAYER:
            return

        # Taming will always result in the target becoming the caster's pet.
        # Pass ID 883 (Summon Pet) as the spell creating this unit since it's saved in the database.
        caster.pet_manager.add_pet_from_world(target, 883)

    @staticmethod
    def handle_summon_pet(casting_spell, effect, caster, target):
        if caster.get_type_id() != ObjectTypeIds.ID_PLAYER:
            return

        caster.pet_manager.summon_permanent_pet(casting_spell.spell_entry.ID, effect.misc_value)

    @staticmethod
    def handle_summon_wild(casting_spell, effect, caster, target):
        creature_entry = effect.misc_value
        if not creature_entry:
            return

        radius = effect.get_radius()
        duration = effect.get_duration()
        # If no duration, default to 2 minutes.
        duration = 120 if duration == 0 else (duration / 1000)
        amount = effect.get_effect_simple_points()

        for count in range(amount):
            if casting_spell.spell_target_mask & SpellTargetMask.DEST_LOCATION:
                if count == 0:
                    px = target.x
                    py = target.y
                    pz = target.z
                else:
                    location = caster.location.get_random_point_in_radius(radius, caster.map_)
                    px = location.x
                    py = location.Y
                    pz = location.z
            else:
                if radius > 0.0:
                    location = caster.location.get_random_point_in_radius(radius, caster.map_)
                    px = location.x
                    py = location.Y
                    pz = location.z
                else:
                    px = target.location.x
                    py = target.location.y
                    pz = target.location.z

            # Spawn the summoned unit.
            from game.world.managers.objects.units.creature.CreatureManager import CreatureManager
            unit = CreatureManager.spawn(creature_entry, Vector(px, py, pz), caster.map_, summoner=caster,
                                         spell_id=casting_spell.spell_entry.ID, override_faction=caster.faction,
                                         ttl=duration)
            if not unit:
                Logger.error(f'Creature with entry {creature_entry} not found for spell {casting_spell.spell_entry.ID}.')
                return

            unit.respawn()

    @staticmethod
    def handle_resurrect(casting_spell, effect, caster, target):
        # TODO: Add support for pets too?
        if target.get_type_id() != ObjectTypeIds.ID_PLAYER:
            return

        # Skip if target is not dead.
        if target.is_alive:
            return

        # Send resurrection request.
        data = pack('<Q', caster.guid)
        target.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_RESURRECT_REQUEST, data))

    # TODO: Currently you always succeed.
    @staticmethod
    def handle_pick_pocket(casting_spell, effect, caster, target):
        if caster.get_type_id() != ObjectTypeIds.ID_PLAYER:
            return

        if not target.pickpocket_loot_manager.has_loot() and not target.pickpocket_loot_manager.already_pickpocketed:
            target.pickpocket_loot_manager.generate_loot(caster)

        caster.send_loot(target.pickpocket_loot_manager)

    @staticmethod
    def handle_temporary_enchant(casting_spell, effect, caster, target):
        SpellEffectHandler.handle_permanent_enchant(casting_spell, effect, caster, target, True)

    # TODO: Handle ITEM_ENCHANTMENT_TYPE, e.g. Damage, Stats modifiers, etc
    @staticmethod
    def handle_permanent_enchant(casting_spell, effect, caster, target, is_temporary=False):
        if caster.get_type_id() != ObjectTypeIds.ID_PLAYER:
            return

        # Calculate slot, duration and charges.
        enchantment_slot = EnchantmentSlots.PERMANENT_SLOT if not is_temporary else EnchantmentSlots.TEMPORARY_SLOT

        duration = 0
        charges = 0

        if is_temporary:
            # Temporary enchantments from professions (enchanting) have a duration of 1h while others have 30min.
            duration = 30 * 60 if not casting_spell.spell_entry.CastUI else 60 * 60
            charges = int(WorldDatabaseManager.spell_enchant_charges_get_by_spell(casting_spell.spell_entry.ID))

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
                                                              duration, charges)

        caster.skill_manager.handle_profession_skill_gain(casting_spell.spell_entry.ID)

        # Save item.
        target.save()

    # Block/parry/dodge/defense passives have their own effects and no aura.
    # Flag the unit here as being able to block/parry/dodge.
    @staticmethod
    def handle_block_passive(casting_spell, effect, caster, target):
        if not target.object_type_mask & ObjectTypeFlags.TYPE_UNIT:
            return

        target.has_block_passive = True
        if target.get_type_id() == ObjectTypeIds.ID_PLAYER:
            target.skill_manager.add_skill(SkillTypes.BLOCK.value)

    @staticmethod
    def handle_parry_passive(casting_spell, effect, caster, target):
        if not target.object_type_mask & ObjectTypeFlags.TYPE_UNIT:
            return

        target.has_parry_passive = True

    @staticmethod
    def handle_dodge_passive(casting_spell, effect, caster, target):
        if not target.object_type_mask & ObjectTypeFlags.TYPE_UNIT:
            return

        target.has_dodge_passive = True

    @staticmethod
    def handle_defense_passive(casting_spell, effect, caster, target):
        if not target.object_type_mask & ObjectTypeFlags.TYPE_UNIT:
            return

        if target.get_type_id() == ObjectTypeIds.ID_PLAYER:
            target.skill_manager.add_skill(SkillTypes.DEFENSE.value)

    @staticmethod
    def handle_spell_defense_passive(casting_spell, effect, caster, target):
        pass  # Only "SPELLDEFENSE (DND)", obsolete

    AREA_SPELL_EFFECTS = [
        SpellEffects.SPELL_EFFECT_PERSISTENT_AREA_AURA,
        SpellEffects.SPELL_EFFECT_APPLY_AREA_AURA
    ]


SPELL_EFFECTS = {
    SpellEffects.SPELL_EFFECT_SCHOOL_DAMAGE: SpellEffectHandler.handle_school_damage,
    SpellEffects.SPELL_EFFECT_HEAL: SpellEffectHandler.handle_heal,
    SpellEffects.SPELL_EFFECT_HEAL_MAX_HEALTH: SpellEffectHandler.handle_heal_max_health,
    SpellEffects.SPELL_EFFECT_WEAPON_DAMAGE: SpellEffectHandler.handle_weapon_damage,
    SpellEffects.SPELL_EFFECT_ADD_COMBO_POINTS: SpellEffectHandler.handle_add_combo_points,
    SpellEffects.SPELL_EFFECT_DUEL: SpellEffectHandler.handle_request_duel,
    SpellEffects.SPELL_EFFECT_WEAPON_DAMAGE_PLUS: SpellEffectHandler.handle_weapon_damage_plus,
    SpellEffects.SPELL_EFFECT_APPLY_AURA: SpellEffectHandler.handle_aura_application,
    SpellEffects.SPELL_EFFECT_ENERGIZE: SpellEffectHandler.handle_energize,
    SpellEffects.SPELL_EFFECT_SUMMON_MOUNT: SpellEffectHandler.handle_summon_mount,
    SpellEffects.SPELL_EFFECT_INSTAKILL: SpellEffectHandler.handle_insta_kill,
    SpellEffects.SPELL_EFFECT_CREATE_ITEM: SpellEffectHandler.handle_create_item,
    SpellEffects.SPELL_EFFECT_TELEPORT_UNITS: SpellEffectHandler.handle_teleport_units,
    SpellEffects.SPELL_EFFECT_PERSISTENT_AREA_AURA: SpellEffectHandler.handle_persistent_area_aura,
    SpellEffects.SPELL_EFFECT_OPEN_LOCK: SpellEffectHandler.handle_open_lock,
    SpellEffects.SPELL_EFFECT_OPEN_LOCK_ITEM: SpellEffectHandler.handle_open_lock,
    SpellEffects.SPELL_EFFECT_LEARN_SPELL: SpellEffectHandler.handle_learn_spell,
    SpellEffects.SPELL_EFFECT_APPLY_AREA_AURA: SpellEffectHandler.handle_apply_area_aura,
    SpellEffects.SPELL_EFFECT_SUMMON_TOTEM: SpellEffectHandler.handle_summon_totem,
    SpellEffects.SPELL_EFFECT_SCRIPT_EFFECT: SpellEffectHandler.handle_script_effect,
    SpellEffects.SPELL_EFFECT_SUMMON_OBJECT: SpellEffectHandler.handle_summon_object,
    SpellEffects.SPELL_EFFECT_SUMMON_PLAYER: SpellEffectHandler.handle_summon_player,
    SpellEffects.SPELL_EFFECT_CREATE_HOUSE: SpellEffectHandler.handle_summon_object,
    SpellEffects.SPELL_EFFECT_BIND: SpellEffectHandler.handle_bind,
    SpellEffects.SPELL_EFFECT_LEAP: SpellEffectHandler.handle_leap,
    SpellEffects.SPELL_EFFECT_TAME_CREATURE: SpellEffectHandler.handle_tame_creature,
    SpellEffects.SPELL_EFFECT_SUMMON_PET: SpellEffectHandler.handle_summon_pet,
    SpellEffects.SPELL_EFFECT_ENCHANT_ITEM_PERMANENT: SpellEffectHandler.handle_permanent_enchant,
    SpellEffects.SPELL_EFFECT_ENCHANT_ITEM_TEMPORARY: SpellEffectHandler.handle_temporary_enchant,
    SpellEffects.SPELL_EFFECT_PICKPOCKET: SpellEffectHandler.handle_pick_pocket,
    SpellEffects.SPELL_EFFECT_SUMMON_WILD: SpellEffectHandler.handle_summon_wild,
    SpellEffects.SPELL_EFFECT_RESURRECT: SpellEffectHandler.handle_resurrect,

    # Passive effects - enable skills, add skills and proficiencies on login.
    SpellEffects.SPELL_EFFECT_BLOCK: SpellEffectHandler.handle_block_passive,
    SpellEffects.SPELL_EFFECT_PARRY: SpellEffectHandler.handle_parry_passive,
    SpellEffects.SPELL_EFFECT_DODGE: SpellEffectHandler.handle_dodge_passive,
    SpellEffects.SPELL_EFFECT_DEFENSE: SpellEffectHandler.handle_defense_passive,
    SpellEffects.SPELL_EFFECT_SPELL_DEFENSE: SpellEffectHandler.handle_spell_defense_passive,
    SpellEffects.SPELL_EFFECT_WEAPON: SpellEffectHandler.handle_weapon_skill,
    SpellEffects.SPELL_EFFECT_PROFICIENCY: SpellEffectHandler.handle_add_proficiency,
    SpellEffects.SPELL_EFFECT_LANGUAGE: SpellEffectHandler.handle_add_language
}
