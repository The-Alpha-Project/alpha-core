import math
from random import randint

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.maps.MapManager import MapManager
from game.world.managers.objects.ai.AIFactory import AIFactory
from game.world.managers.objects.farsight.FarSightManager import FarSightManager
from game.world.managers.objects.spell.ExtendedSpellData import ShapeshiftInfo
from game.world.managers.objects.units.UnitManager import UnitManager
from game.world.managers.objects.units.creature.CreatureLootManager import CreatureLootManager
from game.world.managers.objects.units.creature.CreaturePickPocketLootManager import CreaturePickPocketLootManager
from game.world.managers.objects.units.creature.ThreatManager import ThreatManager
from game.world.managers.objects.units.creature.items.VirtualItemUtils import VirtualItemsUtils
from game.world.managers.objects.units.creature.utils.CreatureUtils import CreatureUtils
from utils import Formulas
from utils.ByteUtils import ByteUtils
from utils.Formulas import UnitFormulas, Distances
from utils.Logger import Logger
from utils.constants import CustomCodes
from utils.constants.MiscCodes import NpcFlags, ObjectTypeIds, UnitDynamicTypes, ObjectTypeFlags, MoveFlags
from utils.constants.SpellCodes import SpellTargetMask
from utils.constants.UnitCodes import UnitFlags, WeaponMode, CreatureTypes, MovementTypes, SplineFlags, \
    CreatureStaticFlags, PowerTypes, CreatureFlagsExtra, CreatureReactStates, AIReactionStates, UnitStates
from utils.constants.UpdateFields import ObjectFields, UnitFields


# noinspection PyCallByClass
class CreatureManager(UnitManager):
    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        self.spawn_id = 0
        self.entry = 0
        self.guid = 0
        self.creature_template = None
        self.location = None
        self.spawn_position = None
        self.map_id = 0
        self.health_percent = 100
        self.mana_percent = 100
        self.summoner = None
        self.charmer = None
        self.addon = None
        self.spell_id = 0
        self.time_to_live_timer = 0
        self.faction = 0
        self.subtype = CustomCodes.CreatureSubtype.SUBTYPE_GENERIC
        self.react_state = CreatureReactStates.REACT_PASSIVE
        self.npc_flags = 0
        self.static_flags = 0
        self.emote_state = 0
        self.spell_list_id = 0
        self.wearing_mainhand_weapon = False
        self.wearing_offhand_weapon = False
        self.wearing_ranged_weapon = False
        self.ranged_attack_time = 0
        self.ranged_dmg_min = 0
        self.ranged_dmg_max = 0
        self.destroy_time = 0
        self.destroy_timer = 420  # Standalone instances, destroyed after 7 minutes.
        self.last_random_movement = 0
        self.random_movement_wait_time = randint(1, 12)
        self.virtual_item_info = {}
        self.wander_distance = 0
        self.movement_type = MovementTypes.IDLE
        self.fully_loaded = False
        self.killed_by = None
        self.known_players = {}

        # # Managers, will be load upon lazy loading trigger.
        self.loot_manager = None
        self.pickpocket_loot_manager = None

        # # All creatures can block, parry and dodge by default.
        self.has_block_passive = True
        self.has_dodge_passive = True
        self.has_parry_passive = True

    # This can also be used to 'morph' the creature.
    def initialize_from_creature_template(self, creature_template, subtype=CustomCodes.CreatureSubtype.SUBTYPE_GENERIC):
        if not creature_template:
            return

        self.entry = creature_template.entry
        self.creature_template = creature_template
        self.entry = self.creature_template.entry
        self.class_ = self.creature_template.unit_class
        self.resistance_0 = self.creature_template.armor
        self.resistance_1 = self.creature_template.holy_res
        self.resistance_2 = self.creature_template.fire_res
        self.resistance_3 = self.creature_template.nature_res
        self.resistance_4 = self.creature_template.frost_res
        self.resistance_5 = self.creature_template.shadow_res
        self.npc_flags = self.creature_template.npc_flags
        self.static_flags = self.creature_template.static_flags
        self.regen_flags = self.creature_template.regeneration
        self.virtual_item_info = {}  # Slot: VirtualItemInfoHolder
        self.base_attack_time = self.creature_template.base_attack_time
        self.ranged_attack_time = self.creature_template.ranged_attack_time
        self.ranged_dmg_min = self.creature_template.ranged_dmg_min
        self.ranged_dmg_max = self.creature_template.ranged_dmg_max
        self.unit_flags = self.creature_template.unit_flags
        self.emote_state = 0
        self.faction = self.creature_template.faction
        self.creature_type = self.creature_template.type
        self.spell_list_id = self.creature_template.spell_list_id
        self.sheath_state = WeaponMode.NORMALMODE
        self.subtype = subtype

        if 0 < self.creature_template.rank < 4:
            self.unit_flags |= UnitFlags.UNIT_FLAG_PLUS_MOB

        if self.is_totem() or self.is_critter() or not self.can_have_target():
            self.react_state = CreatureReactStates.REACT_PASSIVE
        elif self.creature_template.flags_extra & CreatureFlagsExtra.CREATURE_FLAG_EXTRA_NO_AGGRO:
            self.react_state = CreatureReactStates.REACT_DEFENSIVE
        else:
            self.react_state = CreatureReactStates.REACT_AGGRESSIVE

        self.set_melee_damage(int(self.creature_template.dmg_min), int(self.creature_template.dmg_max))

        self.wearing_mainhand_weapon = False
        self.wearing_offhand_weapon = False
        self.wearing_ranged_weapon = False

        self.fully_loaded = False

        self.initialized = False
        self.killed_by = None
        self.known_players = {}

        self.native_display_id = CreatureUtils.generate_creature_display_id(self.creature_template)
        self.current_display_id = self.native_display_id
        self.level = randint(self.creature_template.level_min, self.creature_template.level_max)

        self.max_health, self.max_power_1 = UnitFormulas.calculate_max_health_and_max_power(self, self.level)
        self.health = int((self.health_percent / 100) * self.max_health)
        self.power_1 = int((self.mana_percent / 100) * self.max_power_1)

        self.last_random_movement = 0
        self.threat_manager = ThreatManager(self, self.creature_template.call_for_help_range)

        # Reset pickpocket state.
        if self.pickpocket_loot_manager:
            self.pickpocket_loot_manager.already_pickpocketed = False

        # Creature AI.
        self.object_ai = AIFactory.build_ai(self)

    # override
    def initialize_field_values(self):
        # Lazy loading first.
        if not self.fully_loaded:
            self.finish_loading()

        # Initialize values.
        # After this, fields must be modified by setters or directly writing values to them.
        if not self.initialized:
            self.bytes_1 = self.get_bytes_1()
            self.bytes_2 = self.get_bytes_2()
            self.damage = self.get_damages()

            # Object fields.
            self.set_uint64(ObjectFields.OBJECT_FIELD_GUID, self.guid)
            self.set_uint32(ObjectFields.OBJECT_FIELD_TYPE, self.get_type_mask())
            self.set_uint32(ObjectFields.OBJECT_FIELD_ENTRY, self.entry)
            self.set_float(ObjectFields.OBJECT_FIELD_SCALE_X, self.current_scale)

            # Unit fields.
            self.set_uint32(UnitFields.UNIT_CHANNEL_SPELL, self.channel_spell)
            self.set_uint32(UnitFields.UNIT_CREATED_BY_SPELL, self.spell_id)
            self.set_uint64(UnitFields.UNIT_FIELD_CREATEDBY, self.summoner.guid if self.summoner else 0)
            self.set_uint64(UnitFields.UNIT_FIELD_SUMMONEDBY, self.summoner.guid if self.summoner else 0)
            self.set_uint64(UnitFields.UNIT_FIELD_CHANNEL_OBJECT, self.channel_object)
            self.set_uint32(UnitFields.UNIT_FIELD_HEALTH, self.health)
            self.set_uint32(UnitFields.UNIT_FIELD_MAXHEALTH, self.max_health)
            self.set_uint32(UnitFields.UNIT_FIELD_POWER1, self.power_1)
            self.set_uint32(UnitFields.UNIT_FIELD_MAXPOWER1, self.max_power_1)
            self.set_uint32(UnitFields.UNIT_FIELD_LEVEL, self.level)
            self.set_uint32(UnitFields.UNIT_FIELD_FACTIONTEMPLATE, self.faction)
            self.set_uint32(UnitFields.UNIT_FIELD_FLAGS, self.unit_flags)
            self.set_uint32(UnitFields.UNIT_FIELD_COINAGE, self.coinage)
            self.set_uint32(UnitFields.UNIT_FIELD_BASEATTACKTIME, self.base_attack_time)
            self.set_uint32(UnitFields.UNIT_FIELD_BASEATTACKTIME + 1, self.base_attack_time)
            self.set_int32(UnitFields.UNIT_FIELD_RESISTANCES, self.resistance_0)
            self.set_int32(UnitFields.UNIT_FIELD_RESISTANCES + 1, self.resistance_1)
            self.set_int32(UnitFields.UNIT_FIELD_RESISTANCES + 2, self.resistance_2)
            self.set_int32(UnitFields.UNIT_FIELD_RESISTANCES + 3, self.resistance_3)
            self.set_int32(UnitFields.UNIT_FIELD_RESISTANCES + 4, self.resistance_4)
            self.set_int32(UnitFields.UNIT_FIELD_RESISTANCES + 5, self.resistance_5)
            self.set_float(UnitFields.UNIT_FIELD_BOUNDINGRADIUS, self.bounding_radius)
            self.set_float(UnitFields.UNIT_FIELD_COMBATREACH, self.combat_reach)
            self.set_float(UnitFields.UNIT_FIELD_WEAPONREACH, self.weapon_reach)
            self.set_uint32(UnitFields.UNIT_FIELD_DISPLAYID, self.current_display_id)
            self.set_uint32(UnitFields.UNIT_FIELD_MOUNTDISPLAYID, self.mount_display_id)
            self.set_uint32(UnitFields.UNIT_EMOTE_STATE, self.emote_state)
            self.set_uint32(UnitFields.UNIT_FIELD_BYTES_0, self.bytes_0)
            self.set_uint32(UnitFields.UNIT_FIELD_BYTES_1, self.bytes_1)
            self.set_uint32(UnitFields.UNIT_FIELD_BYTES_2, self.bytes_2)
            self.set_uint32(UnitFields.UNIT_MOD_CAST_SPEED, 0)
            self.set_uint32(UnitFields.UNIT_DYNAMIC_FLAGS, self.dynamic_flags)
            self.set_uint32(UnitFields.UNIT_FIELD_DAMAGE, self.damage)

            for slot, virtual_item in self.virtual_item_info.items():
                self.set_uint32(UnitFields.UNIT_VIRTUAL_ITEM_SLOT_DISPLAY + slot, virtual_item.display_id)
                self.set_uint32(UnitFields.UNIT_VIRTUAL_ITEM_INFO + (slot * 2) + 0, virtual_item.info_packed)
                self.set_uint32(UnitFields.UNIT_VIRTUAL_ITEM_INFO + (slot * 2) + 1, virtual_item.info_packed_2)

            self.initialized = True

    def finish_loading(self):
        if not self.fully_loaded:
            # Load loot manager.
            self.loot_manager = CreatureLootManager(self)
            # Load pickpocket loot manager if required.
            if self.creature_template.pickpocket_loot_id:
                self.pickpocket_loot_manager = CreaturePickPocketLootManager(self)

            display_id = self.current_display_id
            creature_model_info = WorldDatabaseManager.CreatureModelInfoHolder.creature_get_model_info(display_id)
            if creature_model_info:
                self.bounding_radius = creature_model_info.bounding_radius
                self.combat_reach = creature_model_info.combat_reach
                self.gender = creature_model_info.gender

            if self.creature_template.scale == 0:
                display_scale = DbcDatabaseManager.CreatureDisplayInfoHolder.creature_display_info_get_by_id(display_id)
                if display_scale and display_scale.CreatureModelScale > 0:
                    self.native_scale = display_scale.CreatureModelScale
                else:
                    self.native_scale = 1
            else:
                self.native_scale = self.creature_template.scale
            self.current_scale = self.native_scale

            if self.creature_template.equipment_id > 0:
                creature_equip_template = WorldDatabaseManager.CreatureEquipmentHolder.creature_get_equipment_by_id(
                    self.creature_template.equipment_id
                )
                if creature_equip_template:
                    VirtualItemsUtils.set_virtual_item(self, 0, creature_equip_template.equipentry1)
                    VirtualItemsUtils.set_virtual_item(self, 1, creature_equip_template.equipentry2)
                    VirtualItemsUtils.set_virtual_item(self, 2, creature_equip_template.equipentry3)

            # Mount this creature, will be overriden if defined in creature_addon.
            if self.creature_template.mount_display_id > 0:
                self.mount(self.creature_template.mount_display_id)

            if self.addon:
                self.set_stand_state(self.addon.stand_state)
                self.set_weapon_mode(self.addon.sheath_state)

                # Set emote state if available.
                if self.addon.emote_state:
                    self.set_emote_state(self.addon.emote_state)

                # Update display id if available.
                if self.addon.display_id:
                    self.set_display_id(self.addon.display_id)

                # Mount this creature if defined (will override template mount).
                if self.addon.mount_display_id > 0:
                    self.mount(self.addon.mount_display_id)

            # Cast default auras for this unit.
            self.apply_default_auras()

            # Stats.
            self.stat_manager.init_stats()
            self.stat_manager.apply_bonuses(replenish=True)

            self.fully_loaded = True

    def is_guard(self):
        return self.creature_template.flags_extra & CreatureFlagsExtra.CREATURE_FLAG_EXTRA_GUARD

    def can_summon_guards(self):
        return self.creature_template.flags_extra & CreatureFlagsExtra.CREATURE_FLAG_EXTRA_SUMMON_GUARD

    def can_assist_help_calls(self):
        return not self.creature_template.flags_extra & CreatureFlagsExtra.CREATURE_FLAG_EXTRA_NO_ASSIST

    def is_critter(self):
        return self.creature_template.type == CreatureTypes.AMBIENT

    def has_melee(self):
        return not self.creature_template.static_flags & CreatureStaticFlags.NO_MELEE

    def is_pet(self):
        return (self.summoner or self.charmer) and self.subtype == CustomCodes.CreatureSubtype.SUBTYPE_PET

    def is_temp_summon(self):
        return self.summoner and self.subtype == CustomCodes.CreatureSubtype.SUBTYPE_TEMP_SUMMON

    # override
    def is_unit_pet(self, unit):
        return self.is_pet() and self.get_charmer_or_summoner() == unit

    def is_player_controlled_pet(self):
        charmer_or_summoner = self.get_charmer_or_summoner()
        return self.is_pet() and charmer_or_summoner and charmer_or_summoner.get_type_id() == ObjectTypeIds.ID_PLAYER

    def is_totem(self):
        return self.summoner and self.subtype == CustomCodes.CreatureSubtype.SUBTYPE_TOTEM

    def has_combat_ping(self):
        return self.creature_template.static_flags & CreatureStaticFlags.COMBAT_PING

    def can_have_target(self):
        return not self.creature_template.flags_extra & CreatureFlagsExtra.CREATURE_FLAG_EXTRA_NO_TARGET

    def is_quest_giver(self):
        return self.npc_flags & NpcFlags.NPC_FLAG_QUESTGIVER

    def is_trainer(self):
        return self.npc_flags & NpcFlags.NPC_FLAG_TRAINER

    # override
    def is_tameable(self):
        return self.static_flags & CreatureStaticFlags.TAMEABLE

    def is_at_home(self):
        return self.location == self.spawn_position and not self.is_moving()

    def on_at_home(self):
        self.apply_default_auras()
        # Restore original location including orientation.
        self.location = self.spawn_position.copy()
        # Restore original spawn face position.
        self.movement_manager.send_face_target(self)
        # Scan surrounding for enemies.
        self._on_relocation()

    # override
    def on_cell_change(self):
        super().on_cell_change()
        camera = FarSightManager.get_camera_by_object(self)
        if camera:
            camera.update_camera_on_players()

    def can_swim(self):
        return (self.static_flags & CreatureStaticFlags.AMPHIBIOUS) or (self.static_flags & CreatureStaticFlags.AQUATIC)

    def can_exit_water(self):
        return self.static_flags & CreatureStaticFlags.AQUATIC == 0

    # override
    def can_block(self, attacker_location=None):
        if self.creature_template.flags_extra & CreatureFlagsExtra.CREATURE_FLAG_EXTRA_NO_BLOCK:
            return False

        return super().can_block(attacker_location)

    # override
    def can_parry(self, attacker_location=None):
        if self.creature_template.flags_extra & CreatureFlagsExtra.CREATURE_FLAG_EXTRA_NO_PARRY:
            return False

        return super().can_parry(attacker_location)

    # override
    def leave_combat(self):
        super().leave_combat()

        if not self.is_player_controlled_pet():
            self.evade()

    # TODO: Finish implementing evade mechanic.
    def evade(self):
        # Already evading or dead, ignore.
        if self.is_evading or not self.is_alive:
            return

        # Flag creature as currently evading.
        self.is_evading = True

        # Remove all auras on evade.
        self.aura_manager.remove_all_auras()

        if not self.static_flags & CreatureStaticFlags.NO_AUTO_REGEN:
            self.replenish_powers()

        # Pets should return to owner on evading, not to spawn position. This case at this moment only affects
        # creature summoned pets since player summoned pets will never enter this method.
        if self.is_pet() or self.is_at_home():
            # Should turn off flag since we are not sending move packets.
            self.is_evading = False
            return

        # Get the path we are using to get back to spawn location.
        failed, in_place, path = MapManager.calculate_path(self.map_id, self.location, self.spawn_position)

        if in_place:
            return

        # Destroy instance if too far away from spawn or unable to acquire a valid path.
        if failed or self.location.distance(path[-1]) > Distances.CREATURE_EVADE_DISTANCE * 2:
            if failed:
                Logger.warning(f'Unit: {self.get_name()}, Namigator was unable to provide a valid return home path:')
                Logger.warning(f'Start: {self.location}')
                Logger.warning(f'End: {self.spawn_position}')
            self.destroy()
        else:
            # TODO: Find a proper move type that accepts multiple waypoints, RUNMODE and others halt the unit movement.
            use_fly_spline = len(path) > 1
            spline_flag = SplineFlags.SPLINEFLAG_RUNMODE if not use_fly_spline else SplineFlags.SPLINEFLAG_FLYING
            self.movement_manager.send_move_normal(path, self.running_speed, spline_flag)

    def get_default_auras(self):
        auras = set()
        # Template auras.
        if self.creature_template.auras:
            auras = {int(aura) for aura in str(self.creature_template.auras).split()}

        # Addon auras.
        if self.addon:
            # Check spawn auras.
            if self.addon.auras:
                auras.update({int(aura) for aura in str(self.addon.auras).split()})

        return auras

    def apply_default_auras(self):
        for aura in self.get_default_auras():
            self.spell_manager.handle_cast_attempt(aura, self, SpellTargetMask.SELF, validate=False)

    # override
    # TODO: Quest active escort npc, other cases?
    def is_active_object(self):
        return len(self.known_players) > 0 or FarSightManager.object_is_camera_view_point(self)

    def has_wander_type(self):
        return self.movement_type == MovementTypes.WANDER

    def _perform_random_movement(self, now):
        # Do not wander if dead, in combat, while evading or without wander flag.
        if self.is_alive and not self.in_combat and not self.is_evading and self.has_wander_type() and \
                not self.unit_state & UnitStates.STUNNED:
            if len(self.movement_manager.pending_waypoints) == 0:
                if now > self.last_random_movement + self.random_movement_wait_time:
                    self.movement_manager.move_random(self.spawn_position, self.wander_distance)
                    self.random_movement_wait_time = randint(1, 12)
                    self.last_random_movement = now

    # TODO: There are some creatures like crabs or murlocs that apparently couldn't swim in earlier versions
    #  but are spawned inside the water at this moment since most spawns come from Vanilla data. These mobs
    #  will currently bug out when you try to engage in combat with them. Also seems like a lot of humanoids
    #  couldn't swim before patch 1.3.0:
    #  World of Warcraft Client Patch 1.3.0 (2005-03-22)
    #   - Most humanoids NPCs have gained the ability to swim.
    #  This might only refer to creatures not having swimming animations.
    def _perform_combat_movement(self):
        # Avoid moving while casting, no combat target, evading, target already dead or self stunned.
        if self.is_casting() or self.is_totem() or not self.combat_target or self.is_evading or not self.combat_target.is_alive or \
                self.unit_state & UnitStates.STUNNED:
            return

        # Check if target is player and is online.
        target_is_player = self.combat_target.get_type_id() == ObjectTypeIds.ID_PLAYER
        if target_is_player and not self.combat_target.online:
            self.threat_manager.remove_unit_threat(self.combat_target)
            return

        spawn_distance = self.location.distance(self.spawn_position)
        target_distance = self.location.distance(self.combat_target.location)
        combat_position_distance = UnitFormulas.combat_distance(self, self.combat_target)
        target_under_water = self.combat_target.is_under_water()

        if not self.is_pet():
            # In 0.5.3, evade mechanic was only based on distance, the correct distance remains unknown.
            # From 0.5.4 patch notes:
            #     "Creature pursuit is now timer based rather than distance based."
            if spawn_distance > Distances.CREATURE_EVADE_DISTANCE \
                    or target_distance > Distances.CREATURE_EVADE_DISTANCE:
                self.threat_manager.remove_unit_threat(self.combat_target)
                return

            # TODO: There are some creatures like crabs or murlocs that apparently couldn't swim in earlier versions
            #  but are spawned inside the water at this moment since most spawns come from Vanilla data. These mobs
            #  will currently bug out when you try to engage in combat with them. Also seems like a lot of humanoids
            #  couldn't swim before patch 1.3.0:
            #  World of Warcraft Client Patch 1.3.0 (2005-03-22)
            #   - Most humanoids NPCs have gained the ability to swim.
            if self.is_under_water():
                if not self.can_swim():
                    self.threat_manager.remove_unit_threat(self.combat_target)
                    return
                if not self.can_exit_water() and not target_under_water:
                    self.threat_manager.remove_unit_threat(self.combat_target)
                    return

        # If this creature is not facing the attacker, update its orientation.
        if not self.location.has_in_arc(self.combat_target.location, math.pi):
            self.movement_manager.send_face_target(self.combat_target)

        combat_location = self.combat_target.location.get_point_in_between_movement(self, combat_position_distance)
        if not combat_location:
            return

        # Target is within combat distance or already in combat location, don't move.
        if round(target_distance) <= round(combat_position_distance) or self.location == combat_location:
            return

        if len(self.movement_manager.pending_waypoints) > 0:
            # Not underwater , avoid moving due floating point precision.
            if self.movement_manager.pending_waypoints[0].location.distance(combat_location) < 0.1:
                return

        # Use direct combat location if target is over water.
        if not target_under_water:
            failed, in_place, path = MapManager.calculate_path(self.map_id, self.location.copy(), combat_location)
            if not failed and not in_place:
                combat_location = path[0]
            elif in_place:
                return
            # Unable to find a path while Namigator is enabled, log warning and use combat location directly.
            elif MapManager.NAMIGATOR_LOADED:
                Logger.warning(f'Unable to find navigation path, map {self.map_id} loc {self.location} end {combat_location}')

        self.movement_manager.send_move_normal([combat_location], self.running_speed, SplineFlags.SPLINEFLAG_RUNMODE)

    # override
    def update(self, now):
        if now > self.last_tick > 0:
            elapsed = now - self.last_tick

            if self.is_alive and self.is_spawned and self.initialized:
                # Time to live checks for standalone instances.
                if not self._check_time_to_live(elapsed):
                    return  # Creature destroyed.

                # Regeneration.
                self.regenerate(elapsed)
                # Spell/Aura Update.
                self.spell_manager.update(now)
                self.aura_manager.update(now)
                # Sanctuary check.
                self.update_sanctuary(elapsed)
                # Movement Updates.
                self.movement_manager.update_pending_waypoints(elapsed)
                if self.has_moved or self.has_turned:
                    # Relocate only if x, y changed.
                    if self.has_moved:
                        self._on_relocation()
                        self.set_has_moved(False, False, flush=True)
                    # Check spell and aura move interrupts.
                    self.spell_manager.check_spell_interrupts(moved=self.has_moved, turned=self.has_turned)
                    self.aura_manager.check_aura_interrupts(moved=self.has_moved, turned=self.has_turned)
                # Random Movement, if visible to players.
                if self.is_active_object():
                    self._perform_random_movement(now)
                # Combat Movement.
                self._perform_combat_movement()
                # AI.
                if self.object_ai:
                    self.object_ai.update_ai(elapsed)
                # Attack Update.
                if self.combat_target:
                    self.attack_update(elapsed)
                # Not in combat, check if threat manager can resolve a target or if unit should switch target.
                elif self.threat_manager:
                    target = self.threat_manager.resolve_target()
                    if target and target != self.combat_target:
                        self.attack(target)
            # Dead creature with no spawn point, handle destroy.
            elif not self._check_destroy(elapsed):
                return  # Creature destroyed.

            has_changes = self.has_pending_updates()
            # Check if this creature object should be updated yet or not.
            if has_changes:
                MapManager.update_object(self, has_changes=has_changes)

        self.last_tick = now

    def _check_destroy(self, elapsed):
        if self.summoner and not self.is_alive and self.is_spawned and self.initialized:
            self.destroy_timer += elapsed
            if self.destroy_timer >= self.destroy_time:
                self.destroy()
                return False
        return True

    def _check_time_to_live(self, elapsed):
        if self.time_to_live_timer > 0:
            self.time_to_live_timer -= elapsed
            # Time to live expired, destroy.
            if self.time_to_live_timer <= 0:
                self.destroy()
                return False
        return True

    # override
    def attack(self, victim: UnitManager):
        if victim.get_type_id() == ObjectTypeIds.ID_PLAYER:
            self.object_ai.send_ai_reaction(victim, AIReactionStates.AI_REACT_HOSTILE)
        # Had no target before, notify attack start on ai.
        if not self.combat_target:
            self.object_ai.attack_start(victim)
        super().attack(victim)

    # override
    def attack_update(self, elapsed):
        target = self.threat_manager.get_hostile_target()
        # Has a target, check if we need to attack or switch target.
        if target and self.combat_target != target:
            self.attack(target)
        if super().attack_update(elapsed):
            # Make sure sheath state is set to normal for melee attacks.
            if self.sheath_state != WeaponMode.NORMALMODE:
                self.set_weapon_mode(WeaponMode.NORMALMODE)
            return True
        return False

    # override
    def receive_damage(self, damage_info, source=None, casting_spell=None, is_periodic=False):
        if not self.is_spawned:
            return False

        if not super().receive_damage(damage_info, source, casting_spell=casting_spell, is_periodic=is_periodic):
            return False

        # Handle COMBAT_PING creature static flag.
        if self.has_combat_ping() and not self.in_combat:
            summoner = self.get_charmer_or_summoner()
            if summoner and summoner.get_type_id() == ObjectTypeIds.ID_PLAYER:
                summoner.send_minimap_ping(self.guid, self.location)

        # If creature's being attacked by another unit, automatically set combat target.
        not_attacked_by_gameobject = source and source.get_type_id() != ObjectTypeIds.ID_GAMEOBJECT
        if not_attacked_by_gameobject:
            if not self.combat_target:
                # Make sure to first stop any movement right away.
                self.stop_movement()

        return True

    # override
    def receive_healing(self, amount, source=None):
        if not self.is_spawned:
            return False

        return super().receive_healing(amount, source)

    # override
    def receive_power(self, amount, power_type, source=None):
        if not self.is_spawned:
            return False

        return super().receive_power(amount, power_type, source)

    # override
    def die(self, killer=None):
        if not self.is_alive:
            return False

        # Handle one shot kills leading to player remaining in combat.
        if not self.threat_manager.has_aggro_from(killer):
            self.threat_manager.add_threat(killer)

        # Notify pet AI about this kill.
        pet_or_killer_pet = self if self.is_pet() else killer.get_pet()
        if pet_or_killer_pet:
            pet_or_killer_pet.object_ai.killed_unit(self)

        if killer.get_type_id() != ObjectTypeIds.ID_PLAYER:
            charmer_or_summoner = killer.get_charmer_or_summoner()
            # Attribute non-player kills to the creature's charmer/summoner.
            # TODO Does this also apply for player mind control?
            killer = charmer_or_summoner if charmer_or_summoner else killer

        if killer and killer.get_type_id() == ObjectTypeIds.ID_PLAYER:
            self.loot_manager.generate_loot(killer)

            self.reward_kill_xp(killer)
            self.killed_by = killer
            # Handle required creature or go for quests and reputation.
            if self.killed_by.group_manager:
                self.killed_by.group_manager.reward_group_reputation(self.killed_by, self)
                self.killed_by.group_manager.reward_group_creature_or_go(self.killed_by, self)
            else:
                # Reward required creature or go and reputation to the player with the killing blow.
                self.killed_by.reward_reputation_on_kill(self)
                self.killed_by.quest_manager.reward_creature_or_go(self)

            # If the player is in a group, set the group as allowed looters if needed.
            if self.killed_by.group_manager and self.loot_manager.has_loot():
                self.killed_by.group_manager.set_allowed_looters(self)

        if self.loot_manager.has_loot():
            self.set_lootable(True)

        self.unit_flags = UnitFlags.UNIT_FLAG_STANDARD
        return super().die(killer)

    def reward_kill_xp(self, player):
        if self.static_flags & CreatureStaticFlags.NO_XP:
            return

        is_elite = 0 < self.creature_template.rank < 4
        if player.group_manager:
            player.group_manager.reward_group_xp(player, self, is_elite)
        else:
            player.give_xp([Formulas.CreatureFormulas.xp_reward(self.level, player.level, is_elite)], self)

    # override
    def set_max_mana(self, mana):
        if self.max_power_1 > 0:
            self.max_power_1 = mana
            self.set_uint32(UnitFields.UNIT_FIELD_MAXPOWER1, mana)

    def set_emote_state(self, emote_state):
        self.emote_state = emote_state
        self.set_uint32(UnitFields.UNIT_EMOTE_STATE, self.emote_state)

    def set_lootable(self, flag=True):
        if flag:
            self.dynamic_flags |= UnitDynamicTypes.UNIT_DYNAMIC_LOOTABLE
        else:
            self.dynamic_flags &= ~UnitDynamicTypes.UNIT_DYNAMIC_LOOTABLE
        self.set_uint32(UnitFields.UNIT_DYNAMIC_FLAGS, self.dynamic_flags)

    # override
    def get_name(self):
        return self.creature_template.name

    # override
    def get_bytes_0(self):
        return ByteUtils.bytes_to_int(
            self.power_type,  # power type
            self.gender,  # gender
            self.creature_template.unit_class,  # class
            self.race  # race (0 for creatures)
        )

    # override
    def get_bytes_1(self):
        return ByteUtils.bytes_to_int(
            self.sheath_state,  # sheath state
            self.shapeshift_form,  # shapeshift form
            self.npc_flags,  # npc flags
            self.stand_state  # stand state
        )

    # override
    # This update field is unused and private in 0.5.3.
    def get_bytes_2(self):
        return ByteUtils.bytes_to_int(
            0,  # unknown
            0,  # pet flags
            0,  # misc flags
            0,  # unknown
        )

    # override
    def get_damages(self):
        return ByteUtils.shorts_to_int(
            int(self.creature_template.dmg_max),
            int(self.creature_template.dmg_min)
        )

    def _on_relocation(self):
        self._update_swimming_state()
        self.object_ai.movement_inform()

    # Automatically set/remove swimming move flag on units.
    def _update_swimming_state(self):
        if not self.combat_target:
            return
        is_under_water = self.is_under_water()
        if is_under_water and not self.movement_flags & MoveFlags.MOVEFLAG_SWIMMING:
            self.movement_flags |= MoveFlags.MOVEFLAG_SWIMMING
            MapManager.send_surrounding(self.get_heartbeat_packet(), self)
        elif not is_under_water and self.movement_flags & MoveFlags.MOVEFLAG_SWIMMING:
            self.movement_flags &= ~MoveFlags.MOVEFLAG_SWIMMING
            MapManager.send_surrounding(self.get_heartbeat_packet(), self)

    # override
    def notify_moved_in_line_of_sight(self, target):
        self.object_ai.move_in_line_of_sight(target)

    # override
    def has_mainhand_weapon(self):
        return self.wearing_mainhand_weapon

    # override
    def has_offhand_weapon(self):
        return self.wearing_offhand_weapon

    # override
    def has_ranged_weapon(self):
        return self.wearing_ranged_weapon

    def set_charmed_by(self, charmer, subtype=CustomCodes.CreatureSubtype.SUBTYPE_GENERIC, movement_type=None,
                       remove=False):
        # Charmer must be set here not in parent.
        self.charmer = charmer if not remove else None
        self.movement_type = movement_type
        self.faction = charmer.faction if not remove else self.creature_template.faction
        self.subtype = subtype
        self.object_ai = AIFactory.build_ai(self)
        # Set/remove player controlled flag.
        if charmer.get_type_id() == ObjectTypeIds.ID_PLAYER:
            self.set_player_controlled(not remove)
        super().set_charmed_by(charmer, subtype=subtype, remove=remove)

    # override
    def set_summoned_by(self, summoner, spell_id=0, subtype=CustomCodes.CreatureSubtype.SUBTYPE_GENERIC,
                        movement_type=None, remove=False):
        # Summoner must be set here not in parent.
        self.summoner = summoner if not remove else None
        self.movement_type = movement_type
        self.spell_id = spell_id
        self.faction = summoner.faction if not remove else self.creature_template.faction
        self.subtype = subtype
        self.object_ai = AIFactory.build_ai(self)
        self.set_uint32(UnitFields.UNIT_CREATED_BY_SPELL, spell_id)
        # Set/remove player controlled flag.
        if summoner.get_type_id() == ObjectTypeIds.ID_PLAYER:
            self.set_player_controlled(not remove)
        super().set_summoned_by(summoner, subtype=subtype, remove=remove)

    # override
    def set_stand_state(self, stand_state):
        super().set_stand_state(stand_state)
        self.bytes_1 = self.get_bytes_1()
        self.set_uint32(UnitFields.UNIT_FIELD_BYTES_1, self.bytes_1)

    # override
    def set_shapeshift_form(self, shapeshift_form):
        super().set_shapeshift_form(shapeshift_form)
        self.bytes_1 = self.get_bytes_1()
        self.set_uint32(UnitFields.UNIT_FIELD_BYTES_1, self.bytes_1)

    # override
    def update_power_type(self):
        if not self.shapeshift_form:
            self.power_type = PowerTypes.TYPE_MANA
        else:
            self.power_type = ShapeshiftInfo.get_power_for_form(self.shapeshift_form)

        self.bytes_0 = self.get_bytes_0()

    # override
    def get_debug_messages(self, requester=None):
        return [
            f'Spawn ID {self.spawn_id}, Guid: {self.get_low_guid()}, Entry: {self.entry}, Display ID: {self.current_display_id}',
            f'X: {self.location.x:.3f}, Y: {self.location.y:.3f}, Z: {self.location.z:.3f}, O: {self.location.o:.3f}',
            f'Distance: {self.location.distance(requester.location) if requester else 0} yd'
        ]

    # override
    def get_type_mask(self):
        return super().get_type_mask() | ObjectTypeFlags.TYPE_UNIT

    # override
    def get_type_id(self):
        return ObjectTypeIds.ID_UNIT
