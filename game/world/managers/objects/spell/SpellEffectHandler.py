from struct import pack

from database.realm.RealmDatabaseManager import RealmDatabaseManager
from game.world.WorldSessionStateHandler import WorldSessionStateHandler
from game.world.managers.abstractions.Vector import Vector
from game.world.managers.objects.ObjectManager import ObjectManager
from game.world.managers.objects.gameobjects.GameObjectManager import GameObjectManager
from game.world.managers.objects.units.player.DuelManager import DuelManager
from game.world.managers.objects.units.player.SkillManager import SkillTypes
from game.world.managers.objects.spell.AuraManager import AppliedAura
from network.packet.PacketWriter import PacketWriter, OpCode
from utils.Formulas import UnitFormulas
from utils.Logger import Logger
from utils.constants.MiscCodes import ObjectTypeFlags, GameObjectTypes, HighGuid, ObjectTypeIds
from utils.constants.SpellCodes import SpellCheckCastResult, AuraTypes, SpellEffects, SpellState, SpellTargetMask
from utils.constants.UnitCodes import UnitFlags, PowerTypes
from utils.constants.UpdateFields import UnitFields


class SpellEffectHandler(object):
    @staticmethod
    def apply_effect(casting_spell, effect, caster, target):
        if effect.effect_type not in SPELL_EFFECTS:
            Logger.debug(f'Unimplemented spell effect called ({SpellEffects(effect.effect_type).name}: '
                         f'{effect.effect_type}) from spell {casting_spell.spell_entry.ID}.')
            return
        SPELL_EFFECTS[effect.effect_type](casting_spell, effect, caster, target)

    @staticmethod
    def handle_school_damage(casting_spell, effect, caster, target):
        if not target.object_type_mask & ObjectTypeFlags.TYPE_UNIT :
            return

        damage = effect.get_effect_points(casting_spell.caster_effective_level)
        caster.apply_spell_damage(target, damage, casting_spell)

    @staticmethod
    def handle_heal(casting_spell, effect, caster, target):
        if not target.object_type_mask & ObjectTypeFlags.TYPE_UNIT :
            return

        healing = effect.get_effect_points(casting_spell.caster_effective_level)
        caster.apply_spell_healing(target, healing, casting_spell)

    @staticmethod
    def handle_weapon_damage(casting_spell, effect, caster, target):
        if not caster.object_type_mask & ObjectTypeFlags.TYPE_UNIT:
            return

        weapon_damage = caster.calculate_base_attack_damage(casting_spell.spell_attack_type, casting_spell.spell_entry.School,
                                                            target, apply_bonuses=False)  # Bonuses are applied on spell damage

        damage = weapon_damage + effect.get_effect_points(casting_spell.caster_effective_level)
        caster.apply_spell_damage(target, damage, casting_spell)

    @staticmethod
    def handle_weapon_damage_plus(casting_spell, effect, caster, target):
        if not caster.object_type_mask & ObjectTypeFlags.TYPE_UNIT:
            return

        weapon_damage = caster.calculate_base_attack_damage(casting_spell.spell_attack_type, casting_spell.spell_entry.School,
                                                            target, apply_bonuses=False)  # Bonuses are applied on spell damage

        damage_bonus = effect.get_effect_points(casting_spell.caster_effective_level)

        if caster.get_type_id() == ObjectTypeIds.ID_PLAYER and \
                casting_spell.requires_combo_points():
            damage_bonus *= caster.combo_points

        caster.apply_spell_damage(target, weapon_damage + damage_bonus, casting_spell)

    @staticmethod
    def handle_add_combo_points(casting_spell, effect, caster, target):
        if not caster.object_type_mask & ObjectTypeFlags.TYPE_UNIT:
            return

        caster.add_combo_points_on_target(target, effect.get_effect_points(casting_spell.caster_effective_level))

    @staticmethod
    def handle_aura_application(casting_spell, effect, caster, target):
        if not target.object_type_mask & ObjectTypeFlags.TYPE_UNIT :
            return

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
    def handle_open_lock(casting_spell, effect, caster, target):
        # TODO Skill checks etc.
        if caster and target and target.get_type_id() == ObjectTypeIds.ID_GAMEOBJECT:  # TODO other object types, ie. lockboxes
            target.use(caster, target)
            caster.unit_flags |= UnitFlags.UNIT_FLAG_LOOTING
            caster.set_uint32(UnitFields.UNIT_FIELD_FLAGS, caster.unit_flags)

    @staticmethod
    def handle_energize(casting_spell, effect, caster, target):
        if not target.object_type_mask & ObjectTypeFlags.TYPE_UNIT :
            return

        power_type = effect.misc_value
        if power_type != target.power_type:
            return

        amount = effect.get_effect_points(casting_spell.caster_effective_level)
        target.receive_power(amount, power_type)

    @staticmethod
    def handle_summon_mount(casting_spell, effect, caster, target):
        if not target.object_type_mask & ObjectTypeFlags.TYPE_UNIT :
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
        if not target.object_type_mask & ObjectTypeFlags.TYPE_UNIT :
            return

        # No SMSG_SPELLINSTAKILLLOG in 0.5.3
        target.die(killer=caster)

    @staticmethod
    def handle_create_item(casting_spell, effect, caster, target):
        if target.get_type_id() != ObjectTypeIds.ID_PLAYER:
            return

        target.inventory.add_item(effect.item_type,
                                  count=effect.get_effect_points(casting_spell.caster_effective_level), update_inventory=True)

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

        new_targets = [unit for unit in current_targets if unit not in previous_targets]  # Targets that can't have the aura yet
        missing_targets = [unit for unit in previous_targets if unit not in current_targets]  # Targets that moved out of the area

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
        # TODO Refactor to avoid circular import?
        from game.world.managers.objects.units.creature.CreatureManager import CreatureManager
        creature_manager = CreatureManager.spawn(totem_entry, target, caster.map_,
                                                 override_faction=caster.faction)

        if not creature_manager:
            return

        creature_manager.respawn()

        # TODO This should be handled in creature AI instead
        # TODO Totems are not connected to player (pet etc. handling)
        for spell_id in [creature_manager.creature_template.spell_id1,
                         creature_manager.creature_template.spell_id2,
                         creature_manager.creature_template.spell_id3,
                         creature_manager.creature_template.spell_id4]:
            if spell_id == 0:
                break
            creature_manager.spell_manager.handle_cast_attempt(spell_id, creature_manager, 0)

    @staticmethod
    def handle_summon_object(casting_spell, effect, caster, target):
        object_entry = effect.misc_value
        go_manager = GameObjectManager.spawn(object_entry, target, caster.map_, override_faction=caster.faction)
        if not go_manager:
            Logger.error(f'Gameobject with entry {object_entry} not found for spell {casting_spell.spell_entry.ID}.')
            return

        if go_manager.gobject_template.type == GameObjectTypes.TYPE_RITUAL:
            go_manager.ritual_caster = caster

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
        distance = caster.location.distance(target.location) - UnitFormulas.combat_distance(leaper, leap_target)
        charge_location = caster.location.get_point_in_between(distance, target.location, map_id=caster.map_)
        charge_location.face_point(target.location)

        # Stop movement if target is currently moving with waypoints.
        if len(target.movement_manager.pending_waypoints) > 0:
            target.movement_manager.send_move_stop()

        # Instant teleport.
        caster.teleport(caster.map_, charge_location, is_instant=True)

    # Block/parry/dodge/defense passives have their own effects and no aura.
    # Flag the unit here as being able to block/parry/dodge.
    @staticmethod
    def handle_block_passive(casting_spell, effect, caster, target):
        if not target.object_type_mask & ObjectTypeFlags.TYPE_UNIT :
            return

        target.has_block_passive = True
        if target.get_type_id() == ObjectTypeIds.ID_PLAYER:
            target.skill_manager.add_skill(SkillTypes.BLOCK.value)

    @staticmethod
    def handle_parry_passive(casting_spell, effect, caster, target):
        if not target.object_type_mask & ObjectTypeFlags.TYPE_UNIT :
            return

        target.has_parry_passive = True

    @staticmethod
    def handle_dodge_passive(casting_spell, effect, caster, target):
        if not target.object_type_mask & ObjectTypeFlags.TYPE_UNIT :
            return

        target.has_dodge_passive = True

    @staticmethod
    def handle_defense_passive(casting_spell, effect, caster, target):
        if not target.object_type_mask & ObjectTypeFlags.TYPE_UNIT :
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
    SpellEffects.SPELL_EFFECT_LEARN_SPELL: SpellEffectHandler.handle_learn_spell,
    SpellEffects.SPELL_EFFECT_APPLY_AREA_AURA: SpellEffectHandler.handle_apply_area_aura,
    SpellEffects.SPELL_EFFECT_SUMMON_TOTEM: SpellEffectHandler.handle_summon_totem,
    SpellEffects.SPELL_EFFECT_SCRIPT_EFFECT: SpellEffectHandler.handle_script_effect,
    SpellEffects.SPELL_EFFECT_SUMMON_OBJECT: SpellEffectHandler.handle_summon_object,
    SpellEffects.SPELL_EFFECT_SUMMON_PLAYER: SpellEffectHandler.handle_summon_player,
    SpellEffects.SPELL_EFFECT_CREATE_HOUSE: SpellEffectHandler.handle_summon_object,
    SpellEffects.SPELL_EFFECT_BIND: SpellEffectHandler.handle_bind,
    SpellEffects.SPELL_EFFECT_LEAP: SpellEffectHandler.handle_leap,

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


