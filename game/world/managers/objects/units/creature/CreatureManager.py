from random import randint
from struct import pack

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.objects.ai.AIFactory import AIFactory
from game.world.managers.objects.farsight.FarSightManager import FarSightManager
from game.world.managers.objects.spell.ExtendedSpellData import ShapeshiftInfo
from game.world.managers.objects.units.UnitManager import UnitManager
from game.world.managers.objects.units.creature.CreatureLootManager import CreatureLootManager
from game.world.managers.objects.units.creature.CreaturePickPocketLootManager import CreaturePickPocketLootManager
from game.world.managers.objects.units.creature.ThreatManager import ThreatManager
from game.world.managers.objects.units.creature.items.VirtualItemUtils import VirtualItemsUtils
from game.world.managers.objects.units.creature.utils.CreatureUtils import CreatureUtils
from game.world.managers.objects.units.creature.groups.CreatureGroupManager import CreatureGroupManager
from network.packet.PacketWriter import PacketWriter
from utils import Formulas
from utils.ByteUtils import ByteUtils
from utils.Formulas import CreatureFormulas, Distances
from utils.GuidUtils import GuidUtils
from utils.Logger import Logger
from utils.constants import CustomCodes
from utils.constants.MiscCodes import NpcFlags, ObjectTypeIds, UnitDynamicTypes, ObjectTypeFlags, MoveFlags, HighGuid, \
    MoveType, Emotes
from utils.constants.OpCodes import OpCode
from utils.constants.SpellCodes import SpellTargetMask
from utils.constants.UnitCodes import UnitFlags, WeaponMode, CreatureTypes, MovementTypes, CreatureStaticFlags, \
    PowerTypes, CreatureFlagsExtra, CreatureReactStates, StandState
from utils.constants.UpdateFields import ObjectFields, UnitFields


# noinspection PyCallByClass
class CreatureManager(UnitManager):
    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        self.spawn_id = 0
        self.is_dynamic_spawn = False
        self.entry = 0
        self.guid = 0
        self.creature_template = None
        self.location = None
        self.spawn_position = None
        self.creature_group = None
        self.map_id = 0
        self.health_percent = 100
        self.mana_percent = 100
        self.summoner = None
        self.charmer = None
        self.addon = None
        self.creation_spell_id = 0
        self.time_to_live_timer = 0
        self.faction = 0
        self.subtype = CustomCodes.CreatureSubtype.SUBTYPE_GENERIC
        self.react_state = CreatureReactStates.REACT_PASSIVE
        self.npc_flags = 0
        self.static_flags = 0
        self.spell_list_id = 0
        self.wearing_mainhand_weapon = False
        self.wearing_offhand_weapon = False
        self.wearing_ranged_weapon = False
        self.ranged_attack_time = 0
        self.dmg_min = 0
        self.dmg_max = 0
        self.destroy_time = 420  # Standalone instances, destroyed after 7 minutes.
        self.destroy_timer = 0
        self.virtual_item_info = {}
        self.wander_distance = 0
        self.movement_type = MovementTypes.IDLE
        self.fully_loaded = False
        self.killed_by = None
        self.known_players = {}

        # Managers, will be load upon lazy loading trigger.
        self.loot_manager = None
        self.pickpocket_loot_manager = None

        # All creatures can block, parry and dodge by default.
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
        self.npc_flags = self.creature_template.npc_flags
        self.static_flags = self.creature_template.static_flags
        self.regen_flags = self.creature_template.regeneration
        self.virtual_item_info = {}  # Slot: VirtualItemInfoHolder
        self.base_attack_time = self.creature_template.base_attack_time
        self.ranged_attack_time = self.creature_template.ranged_attack_time
        self.unit_flags = self.creature_template.unit_flags
        self.faction = self.creature_template.faction
        self.creature_type = self.creature_template.type
        self.spell_list_id = self.creature_template.spell_list_id
        self.sheath_state = WeaponMode.NORMALMODE
        self.subtype = subtype
        self.level = randint(self.creature_template.level_min, self.creature_template.level_max)

        # Elite mob.
        if 0 < self.creature_template.rank < 4:
            self.unit_flags |= UnitFlags.UNIT_FLAG_PLUS_MOB
        # NPC can't be attacked by other NPCs and can't attack other NPCs.
        if self.creature_template.static_flags & CreatureStaticFlags.IMMUNE_NPC:
            self.unit_flags |= UnitFlags.UNIT_FLAG_PASSIVE
        # NPC is immune to player characters.
        if self.creature_template.static_flags & CreatureStaticFlags.IMMUNE_PLAYER:
            self.unit_flags |= UnitFlags.UNIT_FLAG_NOT_ATTACKABLE_OCC

        if self.is_totem() or self.is_critter() or not self.can_have_target():
            self.react_state = CreatureReactStates.REACT_PASSIVE
        elif self.creature_template.flags_extra & CreatureFlagsExtra.CREATURE_FLAG_EXTRA_NO_AGGRO:
            self.react_state = CreatureReactStates.REACT_DEFENSIVE
        else:
            self.react_state = CreatureReactStates.REACT_AGGRESSIVE

        self.wearing_mainhand_weapon = False
        self.wearing_offhand_weapon = False
        self.wearing_ranged_weapon = False

        self.fully_loaded = False

        self.initialized = False
        self.killed_by = None
        self.known_players.clear()

        self.native_display_id = CreatureUtils.generate_creature_display_id(self.creature_template)
        self.current_display_id = self.native_display_id

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
        if self.initialized:
            return
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
        self.set_uint32(UnitFields.UNIT_CREATED_BY_SPELL, self.creation_spell_id)
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
        self.set_int32(UnitFields.UNIT_FIELD_RESISTANCES, self.resistances[0])
        self.set_int32(UnitFields.UNIT_FIELD_RESISTANCES + 1, self.resistances[1])
        self.set_int32(UnitFields.UNIT_FIELD_RESISTANCES + 2, self.resistances[2])
        self.set_int32(UnitFields.UNIT_FIELD_RESISTANCES + 3, self.resistances[3])
        self.set_int32(UnitFields.UNIT_FIELD_RESISTANCES + 4, self.resistances[4])
        self.set_int32(UnitFields.UNIT_FIELD_RESISTANCES + 5, self.resistances[5])
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

        # Trigger respawned event.
        self.object_ai.just_respawned()

    def finish_loading(self):
        if self.fully_loaded:
            return
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

        # No scale or creature was summoned, look for scale according to display id.
        if self.creature_template.scale == 0 or self.summoner:
            display_scale = DbcDatabaseManager.CreatureDisplayInfoHolder.creature_display_info_get_by_id(display_id)
            if display_scale and display_scale.CreatureModelScale > 0:
                self.native_scale = display_scale.CreatureModelScale
            else:
                self.native_scale = 1
        else:
            self.native_scale = self.creature_template.scale
        self.current_scale = self.native_scale

        # Creature group.
        creature_group = WorldDatabaseManager.CreatureGroupsHolder.get_group_by_member_spawn_id(self.spawn_id)
        if creature_group:
            self.creature_group = CreatureGroupManager.get_create_group(creature_group)
            self.creature_group.add_member(self, dist=creature_group.dist,
                                           angle=creature_group.angle, flags=creature_group.flags)

        # Equipment.
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
            # 0.5.3 weapon modes for sheathed and unsheathed status are swapped compared to later versions.
            # In order to keep full compatibility with VMaNGOS creature_addon table, we do the swap here instead of
            # changing the value in the database.
            weapon_mode = self.addon.sheath_state ^ 1 if self.addon.sheath_state < 2 else self.addon.sheath_state
            self.set_weapon_mode(weapon_mode)

            # Set emote state if available.
            if self.addon.emote_state:
                self.set_emote_state(self.addon.emote_state)

            # Update display id if available.
            if self.addon.display_id:
                self.set_display_id(self.addon.display_id)

            # Mount this creature if defined (will override template mount).
            if self.addon.mount_display_id > 0:
                self.mount(self.addon.mount_display_id)

        # Stats.
        self.stat_manager.init_stats()
        self.stat_manager.apply_bonuses(replenish=True)

        # Cast default auras for this unit.
        self.apply_default_auras()

        # Movement.
        self.set_move_flag(MoveFlags.MOVEFLAG_WALK, active=not self.should_always_run_ooc())
        self.movement_manager.initialize_or_reset()

        self.fully_loaded = True

    def set_virtual_equipment(self, slot, item_id):
        VirtualItemsUtils.set_virtual_item(self, slot, item_id)

    def reset_virtual_equipment(self):
        creature_equip_template = WorldDatabaseManager.CreatureEquipmentHolder.creature_get_equipment_by_id(
            self.creature_template.equipment_id
        )
        if creature_equip_template:
            VirtualItemsUtils.set_virtual_item(self, 0, creature_equip_template.equipentry1)
            VirtualItemsUtils.set_virtual_item(self, 1, creature_equip_template.equipentry2)
            VirtualItemsUtils.set_virtual_item(self, 2, creature_equip_template.equipentry3)

    def set_faction(self, faction_id):
        self.faction = faction_id
        self.set_uint32(UnitFields.UNIT_FIELD_FACTIONTEMPLATE, self.faction)

    def reset_faction(self):
        self.faction = self.creature_template.faction
        self.set_uint32(UnitFields.UNIT_FIELD_FACTIONTEMPLATE, self.faction)

    def get_template_spells(self):
        return list(filter((0).__ne__, [self.creature_template.spell_id1,
                                        self.creature_template.spell_id2,
                                        self.creature_template.spell_id3,
                                        self.creature_template.spell_id4]))

    def is_guard(self):
        return self.creature_template.flags_extra & CreatureFlagsExtra.CREATURE_FLAG_EXTRA_GUARD

    def can_summon_guards(self):
        return self.creature_template.flags_extra & CreatureFlagsExtra.CREATURE_FLAG_EXTRA_SUMMON_GUARD

    def can_assist_help_calls(self):
        return not self.creature_template.flags_extra & CreatureFlagsExtra.CREATURE_FLAG_EXTRA_NO_ASSIST

    def should_always_run_ooc(self):
        return self.creature_template.flags_extra & CreatureFlagsExtra.CREATURE_FLAG_EXTRA_ALWAYS_RUN

    def is_critter(self):
        return self.creature_template.type == CreatureTypes.AMBIENT

    def has_melee(self):
        return super().has_melee() and not self.creature_template.static_flags & CreatureStaticFlags.NO_MELEE

    def is_pet(self):
        return (self.summoner or self.charmer) \
               and (self.subtype == CustomCodes.CreatureSubtype.SUBTYPE_PET
                    or GuidUtils.extract_high_guid(self.guid) == HighGuid.HIGHGUID_PET)

    def set_guardian(self, state):
        self._is_guardian = state

    def is_guardian(self):
        owner = self.get_charmer_or_summoner()
        if not owner:
            return False
        return self._is_guardian

    def is_controlled(self):
        owner = self.get_charmer_or_summoner()
        if not owner:
            return False

        owner_controlled_pet = owner.pet_manager.get_active_controlled_pet()
        return owner_controlled_pet and owner_controlled_pet.creature is self

    def is_temp_summon(self):
        return self.summoner and self.subtype in \
               {CustomCodes.CreatureSubtype.SUBTYPE_TEMP_SUMMON, CustomCodes.CreatureSubtype.SUBTYPE_TOTEM}

    # override
    def is_unit_pet(self, unit):
        return self.is_pet() and self.get_charmer_or_summoner() == unit

    # override
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
        self.object_ai.ai_event_handler.reset()
        self.movement_manager.face_angle(self.spawn_position.o)
        # Scan surrounding for enemies.
        self._on_relocation()
        if self.object_ai:
            self.object_ai.just_reached_home()

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
    def enter_combat(self, source=None):
        if not super().enter_combat(source):
            return False

        if self.is_player_controlled_pet() or self.is_guardian():
            self.set_unit_flag(UnitFlags.UNIT_FLAG_PET_IN_COMBAT, True)
        self.object_ai.enter_combat(source)

    # override
    def leave_combat(self):
        was_in_combat = super().leave_combat()

        if not self.is_player_controlled_pet() and not self.is_guardian():
            self.evade()
            if self.object_ai and was_in_combat and self.is_alive:
                self.object_ai.on_combat_stop()
                self.object_ai.on_leave_combat()
        else:
            self.set_unit_flag(UnitFlags.UNIT_FLAG_PET_IN_COMBAT, False)

        if self.creature_group and self.is_evading and self.is_alive:
            self.creature_group.on_leave_combat(self)

    def evade(self):
        # Already evading or dead, ignore.
        if self.is_evading or not self.is_alive:
            return

        # Flag creature as currently evading.
        self.is_evading = True

        # Remove hostile auras.
        self.aura_manager.remove_hostile_auras()

        if not self.static_flags & CreatureStaticFlags.NO_AUTO_REGEN:
            self.replenish_powers()

        # Pets should return to owner on evading, not to spawn position.
        if self.is_controlled() or self.is_at_home():
            # Should turn off flag since we are not sending move packets.
            self.is_evading = False
            self.on_at_home()
            return

        # Get the path we are using to get back to spawn location.
        failed, in_place, waypoints = self.get_map().calculate_path(self.location, self.spawn_position.copy())

        # We are at spawn position already.
        if in_place:
            return

        # Near teleport the unit instance if unable to acquire a valid path.
        if failed or self.location.distance(waypoints[-1]) > Distances.CREATURE_EVADE_DISTANCE * 2:
            if failed:
                Logger.warning(f'Unit: {self.get_name()}, Namigator was unable to provide a valid return home path:')
                Logger.warning(f'Start: {self.location}')
                Logger.warning(f'End: {self.spawn_position}')
            self.near_teleport(self.spawn_position)
            self.is_evading = False
        else:
            self.movement_manager.move_home(waypoints)

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
    def is_active_object(self):
        if not self.fully_loaded or not self.is_spawned or not self.initialized:
            return False
        
        return len(self.known_players) > 0 or self.has_waypoints_type() or self.creature_group \
            or FarSightManager.object_is_camera_view_point(self) \
            or self.subtype == CustomCodes.CreatureSubtype.SUBTYPE_TEMP_SUMMON

    def has_waypoints_type(self):
        return self.movement_type == MovementTypes.WAYPOINT \
            or self.movement_manager.get_move_behavior_by_type(MoveType.WAYPOINTS)

    def has_wander_type(self):
        return self.movement_type == MovementTypes.WANDER

    # override
    def update(self, now):
        if now > self.last_tick > 0:
            elapsed = now - self.last_tick

            is_active = self.is_active_object()
            if not is_active:
                return

            if self.is_alive:
                # Time to live checks for standalone instances.
                if not self._check_time_to_live(elapsed):
                    return  # Creature destroyed.
                # Update relocate/call for help timer.
                self.relocation_call_for_help_timer += elapsed
                # Regeneration.
                self.regenerate(elapsed)
                # Spell/Aura Update.
                self.spell_manager.update(now)
                self.aura_manager.update(now)
                # Sanctuary check.
                self.update_sanctuary(elapsed)
                # AI.
                if self.object_ai:
                    self.object_ai.update_ai(elapsed)
                # Movement Updates, order matters.
                self.movement_manager.update(now, elapsed)
                # Attack Update.
                self.attack_update(elapsed)
                # Movement checks.
                if self.has_moved or self.has_turned:
                    # Relocate only if x, y changed.
                    if self.has_moved and not self.pending_relocation:
                        self.pending_relocation = True
                    # Check spell and aura move interrupts.
                    self.spell_manager.check_spell_interrupts(moved=self.has_moved, turned=self.has_turned)
                    self.aura_manager.check_aura_interrupts(moved=self.has_moved, turned=self.has_turned)

                if self.relocation_call_for_help_timer >= 1:
                    if self.pending_relocation:
                        self._on_relocation()
                        self.pending_relocation = False
                    if self.combat_target:
                        self.threat_manager.call_for_help(self.combat_target)
                    self.relocation_call_for_help_timer = 0
            # Dead creature with no spawn point, handle destroy.
            elif not self._check_destroy(elapsed):
                return  # Creature destroyed.

            has_changes = self.has_pending_updates()
            # Check if this creature object should be updated yet or not.
            if has_changes or self.has_moved:
                self.set_has_moved(False, False, flush=True)
                self.get_map().update_object(self, has_changes=has_changes)

        self.last_tick = now

    def _check_destroy(self, elapsed):
        if self.summoner and not self.is_alive and self.is_spawned and self.initialized:
            self.destroy_timer += elapsed
            if self.destroy_timer >= self.destroy_time:
                self.despawn()
                return False
        return True

    # override
    def despawn(self, ttl=0):
        if ttl:
            # Delayed despawn.
            self.time_to_live_timer = ttl / 1000  # Seconds.
            return
        super().despawn()

    def _check_time_to_live(self, elapsed):
        if self.time_to_live_timer > 0:
            self.time_to_live_timer -= elapsed
            # Time to live expired, destroy.
            if self.time_to_live_timer <= 0:
                self.despawn()
                return False
        return True

    # override
    def attack(self, victim: UnitManager):
        had_target = self.combat_target and self.combat_target.is_alive
        super().attack(victim)
        if had_target:
            return
        # Stand if necessary.
        if self.stand_state != StandState.UNIT_STANDING:
            self.set_stand_state(StandState.UNIT_STANDING)
        # Remove emote.
        if self.emote_state:
            self.set_emote_state(Emotes.NONE)
        self.object_ai.attack_start(victim)

    # override
    def attack_update(self, elapsed):
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

        self.object_ai.damage_taken(source, damage_info)

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
                self.movement_manager.stop()

        return True

    # override
    def receive_healing(self, amount, source=None):
        if not self.is_spawned:
            return False

        if (source and source.get_type_id() == ObjectTypeIds.ID_PLAYER and self.is_pet()
                and self.get_charmer_or_summoner() == source):
            data = pack('<IQ', amount, source.guid)
            source.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_HEALSPELL_ON_PLAYERS_PET, data))

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

        was_oneshot = not self.threat_manager.has_aggro_from(killer)
        if self.creature_group:
            if was_oneshot and killer:
                # AI will not trigger since NPC was unable to start attacking, make the call for attack start event.
                self.creature_group.on_members_attack_start(self, killer)
            # Notify member death.
            self.creature_group.on_member_died(self)

        if killer and killer.get_type_id() == ObjectTypeIds.ID_UNIT and killer.object_ai:
            killer.object_ai.killed_unit(self)

        # Handle one shot kills leading to player remaining in combat.
        if was_oneshot and killer:
            self.threat_manager.add_threat(killer)

        if killer and killer.get_type_id() != ObjectTypeIds.ID_PLAYER:
            charmer_or_summoner = killer.get_charmer_or_summoner()
            # Attribute non-player kills to the creature's charmer/summoner.
            # TODO Does this also apply for player mind control?
            killer = charmer_or_summoner if charmer_or_summoner else killer

        is_player_pet = self.get_charmer_or_summoner().pet_manager.get_active_permanent_pet().creature is self \
            if self.is_player_controlled_pet() else False

        if not is_player_pet and not self.is_guardian() and killer and killer.get_type_id() == ObjectTypeIds.ID_PLAYER:
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
    def set_melee_damage(self, min_dmg, max_dmg):
        super().set_melee_damage(min_dmg, max_dmg)
        self.dmg_min = min_dmg
        self.dmg_max = max_dmg

    # override
    def set_max_mana(self, mana):
        if mana > 0:
            self.max_power_1 = mana
            self.set_uint32(UnitFields.UNIT_FIELD_MAXPOWER1, mana)

    def set_lootable(self, flag=True):
        if flag:
            self.dynamic_flags |= UnitDynamicTypes.UNIT_DYNAMIC_LOOTABLE
        else:
            self.dynamic_flags &= ~UnitDynamicTypes.UNIT_DYNAMIC_LOOTABLE
        self.set_uint32(UnitFields.UNIT_DYNAMIC_FLAGS, self.dynamic_flags)

    def near_teleport(self, location):
        map_ = self.get_map()
        if not map_.validate_teleport_destination(location.x, location.y):
            return False

        self.movement_manager.reset()
        self.location = location.copy()
        self.set_has_moved(has_moved=True, has_turned=True)
        self.get_map().send_surrounding(self.get_heartbeat_packet(), self, False)

        if location == self.spawn_position:
            self.on_at_home()
        return True

    def set_npc_flag(self, flag, enable=True):
        if enable:
            self.npc_flags |= flag
        else:
            self.npc_flags &= ~flag
        self.set_uint32(UnitFields.UNIT_FIELD_BYTES_1, self.get_bytes_1())

    # override
    def get_name(self):
        return self.creature_template.name

    # override
    def respawn(self):
        super().respawn()

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
            self.dmg_max,
            self.dmg_min
        )

    def _on_relocation(self):
        self._update_swimming_state()
        self.notify_move_in_line_of_sight()

    def get_detection_range(self):
        return self.creature_template.detection_range

    # Automatically set/remove swimming move flag on units.
    def _update_swimming_state(self):
        # Not combat target and not evading, skip.
        if not self.combat_target and not self.is_evading:
            return
        is_under_water = self.is_under_water()
        if is_under_water and not self.movement_flags & MoveFlags.MOVEFLAG_SWIMMING:
            self.set_move_flag(MoveFlags.MOVEFLAG_SWIMMING, active=True)
            self.get_map().send_surrounding(self.get_heartbeat_packet(), self)
        elif not is_under_water and self.movement_flags & MoveFlags.MOVEFLAG_SWIMMING:
            self.set_move_flag(MoveFlags.MOVEFLAG_SWIMMING, active=False)
            self.get_map().send_surrounding(self.get_heartbeat_packet(), self)

    # override
    def has_mainhand_weapon(self):
        return self.wearing_mainhand_weapon

    # override
    def has_offhand_weapon(self):
        return self.wearing_offhand_weapon

    # override
    def has_ranged_weapon(self):
        return self.wearing_ranged_weapon

    # override
    def get_charmer_or_summoner(self, include_self=False):
        return self.charmer if self.charmer \
            else self.summoner if self.summoner \
            else self if include_self else None

    # override
    def set_charmed_by(self, charmer, subtype=CustomCodes.CreatureSubtype.SUBTYPE_GENERIC,
                       movement_type=None, remove=False):
        self._set_controlled_by(charmer, subtype, movement_type, remove)
        super().set_charmed_by(charmer, subtype=subtype, remove=remove)

    def set_summoned_by(self, summoner, spell_id=0, subtype=CustomCodes.CreatureSubtype.SUBTYPE_GENERIC,
                        movement_type=None, remove=False):
        self.summoner = summoner if not remove else None
        self.creation_spell_id = spell_id if not remove else 0

        self.set_uint64(UnitFields.UNIT_FIELD_CREATEDBY, self.summoner.guid if not remove else 0)
        self.set_uint64(UnitFields.UNIT_FIELD_SUMMONEDBY, self.summoner.guid if not remove else 0)
        self.set_uint32(UnitFields.UNIT_CREATED_BY_SPELL, self.creation_spell_id)
        self._set_controlled_by(summoner, subtype, movement_type, remove)
        super().set_summoned_by(summoner, subtype=subtype, remove=remove)

    def _set_controlled_by(self, controller, subtype=CustomCodes.CreatureSubtype.SUBTYPE_GENERIC,
                           movement_type=None, remove=False):
        self.movement_type = movement_type

        self.faction = controller.faction if not remove else self.creature_template.faction
        self.subtype = subtype
        self.object_ai = AIFactory.build_ai(self)
        # Set/remove player controlled flag.
        if controller.get_type_id() == ObjectTypeIds.ID_PLAYER:
            self.set_player_controlled(not remove)

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
    # noinspection PyMethodMayBeStatic
    def get_creature_family(self):
        return self.creature_template.beast_family

    def is_in_world(self):
        return self.is_spawned and self.get_map()

    # override
    def get_query_details_packet(self):
        from game.world.managers.objects.units.creature.utils.UnitQueryUtils import UnitQueryUtils
        return UnitQueryUtils.query_details(creature_mgr=self)

    # override
    def get_type_mask(self):
        return super().get_type_mask() | ObjectTypeFlags.TYPE_UNIT

    # override
    def get_type_id(self):
        return ObjectTypeIds.ID_UNIT

    def get_creature_class_level_stats(self):
        constraint_level = min(self.level, 255)
        creature_class_level_stats = WorldDatabaseManager.CreatureClassLevelStatsHolder.creature_class_level_stats_get_by_class_and_level(
            self.class_,
            constraint_level,
        )
        return creature_class_level_stats
