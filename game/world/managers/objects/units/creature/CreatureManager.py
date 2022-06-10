import math
from dataclasses import dataclass
from random import randint, choice
from struct import pack

from database.world.WorldModels import TrainerTemplate, SpellChain, SpawnsCreatures
from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.abstractions.Vector import Vector
from game.world.managers.maps.MapManager import MapManager
from game.world.managers.objects.spell.ExtendedSpellData import ShapeshiftInfo
from game.world.managers.objects.units.UnitManager import UnitManager
from game.world.managers.objects.ai.AIFactory import AIFactory
from game.world.managers.objects.units.creature.CreatureLootManager import CreatureLootManager
from game.world.managers.objects.item.ItemManager import ItemManager
from game.world.managers.objects.units.creature.CreaturePickPocketLootManager import CreaturePickPocketLootManager
from game.world.managers.objects.units.creature.ThreatManager import ThreatManager
from network.packet.PacketWriter import PacketWriter
from utils import Formulas
from utils.ByteUtils import ByteUtils
from utils.Logger import Logger
from utils.Formulas import UnitFormulas
from utils.TextUtils import GameTextFormatter
from utils.constants.SpellCodes import SpellTargetMask
from utils.constants.ItemCodes import InventoryTypes, ItemSubClasses
from utils.constants.MiscCodes import NpcFlags, ObjectTypeIds, UnitDynamicTypes, TrainerServices, \
    TrainerTypes
from utils.constants.OpCodes import OpCode
from utils.constants.UnitCodes import UnitFlags, WeaponMode, CreatureTypes, MovementTypes, SplineFlags, \
    CreatureStaticFlags, PowerTypes, CreatureFlagsExtra
from utils.constants.UpdateFields import ObjectFields, UnitFields


# noinspection PyCallByClass
class CreatureManager(UnitManager):
    CURRENT_HIGHEST_GUID = 0

    def __init__(self,
                 creature_template,
                 creature_instance=None,
                 summoner=None,
                 **kwargs):
        super().__init__(**kwargs)

        self.creature_template = creature_template
        self.creature_instance = creature_instance
        self.fully_loaded = False
        self.killed_by = None
        self.summoner = summoner

        self.entry = self.creature_template.entry
        self.class_ = self.creature_template.unit_class
        self.native_display_id = self.generate_display_id()
        self.current_display_id = self.native_display_id
        self.level = randint(self.creature_template.level_min, self.creature_template.level_max)

        # Calculate relative level in order to get health and mana values.
        rel_level = 0 if self.creature_template.level_max == self.creature_template.level_min else \
            ((self.level - self.creature_template.level_min) /
             (self.creature_template.level_max - self.creature_template.level_min))
        self.max_health = self.creature_template.health_min + int(rel_level * (self.creature_template.health_max -
                                                                               self.creature_template.health_min))
        self.max_power_1 = self.creature_template.mana_min + int(rel_level * (self.creature_template.mana_max -
                                                                              self.creature_template.mana_min))

        self.health = self.max_health
        self.power_1 = self.max_power_1
        self.resistance_0 = self.creature_template.armor
        self.resistance_1 = self.creature_template.holy_res
        self.resistance_2 = self.creature_template.fire_res
        self.resistance_3 = self.creature_template.nature_res
        self.resistance_4 = self.creature_template.frost_res
        self.resistance_5 = self.creature_template.shadow_res
        self.npc_flags = self.creature_template.npc_flags
        self.static_flags = self.creature_template.static_flags
        self.mod_cast_speed = 1.0
        self.base_attack_time = self.creature_template.base_attack_time
        self.unit_flags = self.creature_template.unit_flags
        self.emote_state = 0
        self.faction = self.creature_template.faction
        self.creature_type = self.creature_template.type
        self.spell_list_id = self.creature_template.spell_list_id
        self.sheath_state = WeaponMode.NORMALMODE
        self.regen_flags = self.creature_template.regeneration
        self.virtual_item_info = {}  # Slot: VirtualItemInfoHolder

        self.set_melee_damage(int(self.creature_template.dmg_min), int(self.creature_template.dmg_max))

        if 0 < self.creature_template.rank < 4:
            self.unit_flags = self.unit_flags | UnitFlags.UNIT_FLAG_PLUS_MOB

        self.wearing_offhand_weapon = False
        self.wearing_ranged_weapon = False
        self.time_to_live_timer = -1
        self.respawn_timer = 0
        self.last_random_movement = 0
        self.random_movement_wait_time = randint(1, 12)

        if self.creature_instance:
            if CreatureManager.CURRENT_HIGHEST_GUID < creature_instance.spawn_id:
                CreatureManager.CURRENT_HIGHEST_GUID = creature_instance.spawn_id

            self.guid = self.generate_object_guid(creature_instance.spawn_id)
            self.health = int((self.creature_instance.health_percent / 100) * self.max_health)
            # If spawned by another unit, use that unit map and zone.
            self.map_ = self.creature_instance.map if not self.summoner else self.summoner.map_
            self.zone = self.summoner.zone if self.summoner else 0
            self.spawn_position = Vector(self.creature_instance.position_x,
                                         self.creature_instance.position_y,
                                         self.creature_instance.position_z,
                                         self.creature_instance.orientation)
            self.location = self.spawn_position.copy()
            self.respawn_time = randint(self.creature_instance.spawntimesecsmin, self.creature_instance.spawntimesecsmax)

        # All creatures can block, parry and dodge by default.
        # TODO, Checks for CREATURE_FLAG_EXTRA_NO_BLOCK and CREATURE_FLAG_EXTRA_NO_PARRY, for hit results.
        self.has_block_passive = True
        self.has_dodge_passive = True
        self.has_parry_passive = True

        # Managers, will be load upon lazy loading trigger.
        self.loot_manager = None
        self.pickpocket_loot_manager = None
        self.threat_manager = None

    @dataclass
    class VirtualItemInfoHolder:
        display_id: int = 0
        info_packed: int = 0  # ClassID, SubClassID, Material, InventoryType.
        info_packed_2: int = 0  # Sheath, Padding, Padding, Padding.

    def load(self):
        MapManager.update_object(self)

    @staticmethod
    def spawn(entry, location, map_id, summoner=None, override_faction=0, despawn_time=1, spell_id=0, ttl=-1):
        creature_template = WorldDatabaseManager.creature_get_by_entry(entry)

        if not creature_template:
            return None

        instance = SpawnsCreatures()
        instance.spawn_id = CreatureManager.CURRENT_HIGHEST_GUID + 1
        instance.spawn_entry1 = entry
        instance.map = map_id
        instance.position_x = location.x
        instance.position_y = location.y
        instance.position_z = location.z
        instance.orientation = location.o
        instance.health_percent = 100
        instance.mana_percent = 100
        if despawn_time < 1:
            despawn_time = 1

        instance.spawntimesecsmin = despawn_time
        instance.spawntimesecsmax = despawn_time

        creature = CreatureManager(
            creature_template=creature_template,
            creature_instance=instance,
            summoner=summoner
        )

        if ttl > 0:
            creature.time_to_live_timer = ttl

        if spell_id:
            creature.set_uint32(UnitFields.UNIT_CREATED_BY_SPELL, spell_id)

        if override_faction > 0:
            creature.faction = override_faction

        creature.load()
        return creature

    def generate_display_id(self):
        display_id_list = list(filter((0).__ne__, [self.creature_template.display_id1,
                                                   self.creature_template.display_id2,
                                                   self.creature_template.display_id3,
                                                   self.creature_template.display_id4]))
        return choice(display_id_list) if len(display_id_list) > 0 else 4  # 4 = cube

    def send_inventory_list(self, world_session):
        vendor_data, session = WorldDatabaseManager.creature_get_vendor_data(self.entry)
        item_count = len(vendor_data) if vendor_data else 0

        data = pack(
            '<QB',
            self.guid,
            item_count
        )

        if item_count == 0:
            data += pack('<B', 0)
        else:
            item_query = pack('<I', len(vendor_data))
            for count, vendor_data_entry in enumerate(vendor_data):
                data += pack(
                    '<7I',
                    count + 1,  # m_muid, acts as slot counter.
                    vendor_data_entry.item,
                    vendor_data_entry.item_template.display_id,
                    0xFFFFFFFF if vendor_data_entry.maxcount <= 0 else vendor_data_entry.maxcount,
                    vendor_data_entry.item_template.buy_price,
                    vendor_data_entry.item_template.max_durability,  # Max durability (not implemented in 0.5.3).
                    vendor_data_entry.item_template.buy_count  # Stack count.
                )
                item_query += ItemManager.generate_query_details_data(vendor_data_entry.item_template)

            # Send all vendor item query details.
            world_session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_ITEM_QUERY_MULTIPLE_RESPONSE, item_query))

        session.close()
        world_session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_LIST_INVENTORY, data))

    # TODO Add skills (Two-Handed Swords etc.) to trainers for skill points https://i.imgur.com/tzyDDqL.jpg
    def send_trainer_list(self, world_session):
        if not self.can_train(world_session.player_mgr):
            Logger.anticheat(f'send_trainer_list called from NPC {self.entry} by player with GUID {world_session.player_mgr.guid} but this unit does not train that player\'s class. Possible cheating')
            return

        train_spell_bytes: bytes = b''
        train_spell_count: int = 0

        trainer_ability_list: list[TrainerTemplate] = WorldDatabaseManager.TrainerSpellHolder.trainer_spells_get_by_trainer(self.entry)

        if not trainer_ability_list or trainer_ability_list.count == 0:
            Logger.warning(f'send_trainer_list called from NPC {self.entry} but no trainer spells found!')
            return

        for trainer_spell in trainer_ability_list:  # trainer_spell: The spell the trainer uses to teach the player.
            player_spell_id = trainer_spell.playerspell
            
            ability_spell_chain: SpellChain = WorldDatabaseManager.SpellChainHolder.spell_chain_get_by_spell(player_spell_id)

            spell_level: int = trainer_spell.reqlevel  # Use this and not spell data, as there are differences between data source (2003 Game Guide) and what is in spell table.
            spell_rank: int = ability_spell_chain.rank
            prev_spell: int = ability_spell_chain.prev_spell

            spell_is_too_high_level: bool = spell_level > world_session.player_mgr.level

            if player_spell_id in world_session.player_mgr.spell_manager.spells:
                status = TrainerServices.TRAINER_SERVICE_USED
            else:
                if prev_spell in world_session.player_mgr.spell_manager.spells and spell_rank > 1 and not spell_is_too_high_level:
                    status = TrainerServices.TRAINER_SERVICE_AVAILABLE
                elif spell_rank == 1 and not spell_is_too_high_level:
                    status = TrainerServices.TRAINER_SERVICE_AVAILABLE
                else:
                    status = TrainerServices.TRAINER_SERVICE_UNAVAILABLE

            data: bytes = pack(
                '<IBI3B6I',
                player_spell_id,  # Spell id
                status,  # Status
                trainer_spell.spellcost,  # Cost
                trainer_spell.talentpointcost,  # Talent Point Cost
                trainer_spell.skillpointcost,  # Skill Point Cost
                spell_level,  # Required Level
                trainer_spell.reqskill,  # Required Skill Line
                trainer_spell.reqskillvalue,  # Required Skill Rank
                0,  # Required Skill Step
                prev_spell,  # Required Ability (1)
                0,  # Required Ability (2)
                0  # Required Ability (3)
            )
            train_spell_bytes += data
            train_spell_count += 1

        # TODO: Placeholder text, although it seems to appear in most of the trainer screenshots.
        #  https://imgur.com/a/70OcLjv
        placeholder_greeting: str = f'Hello, $c!  Ready for some training?'
        greeting_bytes = PacketWriter.string_to_bytes(GameTextFormatter.format(world_session.player_mgr,
                                                                               placeholder_greeting))
        greeting_bytes = pack(
                    f'<{len(greeting_bytes)}s', 
                    greeting_bytes
        )

        data = pack('<Q2I', self.guid, TrainerTypes.TRAINER_TYPE_GENERAL, train_spell_count) + train_spell_bytes + greeting_bytes
        world_session.player_mgr.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_TRAINER_LIST, data))

    def finish_loading(self):
        if self.creature_instance and not self.fully_loaded:
            # Load loot manager.
            self.loot_manager = CreatureLootManager(self)
            # Load pickpocket loot manager if required.
            if self.creature_template.pickpocket_loot_id:
                self.pickpocket_loot_manager = CreaturePickPocketLootManager(self)
            self.threat_manager = ThreatManager(self)

            creature_model_info = WorldDatabaseManager.CreatureModelInfoHolder.creature_get_model_info(self.current_display_id)
            if creature_model_info:
                self.bounding_radius = creature_model_info.bounding_radius
                self.combat_reach = creature_model_info.combat_reach
                self.gender = creature_model_info.gender

            if self.creature_template.scale == 0:
                display_scale = DbcDatabaseManager.CreatureDisplayInfoHolder.creature_display_info_get_by_id(self.current_display_id)
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
                    self.set_virtual_item(0, creature_equip_template.equipentry1)
                    self.set_virtual_item(1, creature_equip_template.equipentry2)
                    self.set_virtual_item(2, creature_equip_template.equipentry3)

            addon_template = self.creature_instance.addon_template
            if addon_template:
                self.set_stand_state(addon_template.stand_state)
                self.set_weapon_mode(addon_template.sheath_state)

                # Set emote state if available.
                if addon_template.emote_state:
                    self.set_emote_state(addon_template.emote_state)

                # Check auras; 'auras' points to an entry id on Spell dbc.
                if addon_template.auras:
                    spells = str(addon_template.auras).rsplit(' ')
                    for spell in spells:
                        self.spell_manager.handle_cast_attempt(int(spell), self, SpellTargetMask.SELF,
                                                               validate=False)

                # Update display id if available.
                if addon_template.display_id:
                    self.set_display_id(addon_template.display_id)

                # Mount this creature if defined.
                if addon_template.mount_display_id > 0:
                    self.mount(addon_template.mount_display_id)

            # Creature AI.
            self.object_ai = AIFactory.build_ai(self)

            # Stats.
            self.stat_manager.init_stats()
            self.stat_manager.apply_bonuses(replenish=True)

            self.fully_loaded = True

    def is_guard(self):
        return self.creature_template.flags_extra & CreatureFlagsExtra.CREATURE_FLAG_EXTRA_GUARD

    def can_summon_guards(self):
        return self.creature_template.flags_extra & CreatureFlagsExtra.CREATURE_FLAG_EXTRA_SUMMON_GUARD

    def is_critter(self):
        return self.creature_template.type == CreatureTypes.AMBIENT

    # TODO, should be able to check 'ownership' or set a custom flag upon creature creation.
    def is_pet(self):
        return False

    # TODO, should be able to check 'ownership' or set a custom flag upon creature creation.
    def is_totem(self):
        return False

    def set_virtual_item(self, slot, item_entry):
        item_template = None
        if item_entry > 0:
            item_template = WorldDatabaseManager.ItemTemplateHolder.item_template_get_by_entry(item_entry)

        if item_template:
            virtual_item_info = ByteUtils.bytes_to_int(
                item_template.inventory_type,
                item_template.material,
                item_template.subclass,
                item_template.class_,
            )

            virtual_item_info_2 = ByteUtils.bytes_to_int(
                0, 0, 0,  # Padding.
                item_template.sheath
            )

            self.virtual_item_info[slot] = CreatureManager.VirtualItemInfoHolder(
                item_template.display_id, virtual_item_info, virtual_item_info_2
            )

            # Main hand.
            if slot == 0:
                # This is a TOTAL guess, I have no idea about real weapon reach values.
                # The weapon reach unit field was removed in patch 0.10.
                if item_template.inventory_type == InventoryTypes.TWOHANDEDWEAPON:
                    self.weapon_reach = 1.5
                elif item_template.subclass == ItemSubClasses.ITEM_SUBCLASS_DAGGER:
                    self.weapon_reach = 0.5
                elif item_template.subclass != ItemSubClasses.ITEM_SUBCLASS_FIST_WEAPON:
                    self.weapon_reach = 1.0

            # Offhand.
            if slot == 1:
                self.wearing_offhand_weapon = (item_template.inventory_type == InventoryTypes.WEAPON or
                                               item_template.inventory_type == InventoryTypes.WEAPONOFFHAND)
            # Ranged.
            if slot == 2:
                self.wearing_ranged_weapon = (item_template.inventory_type == InventoryTypes.RANGED or
                                              item_template.inventory_type == InventoryTypes.RANGEDRIGHT)
        else:
            self.virtual_item_info[slot] = CreatureManager.VirtualItemInfoHolder()

            if slot == 0:
                self.weapon_reach = 0.0

        self.set_float(UnitFields.UNIT_FIELD_WEAPONREACH, self.weapon_reach)

    def is_quest_giver(self) -> bool:
        return self.npc_flags & NpcFlags.NPC_FLAG_QUESTGIVER

    def is_trainer(self) -> bool:
        return self.npc_flags & NpcFlags.NPC_FLAG_TRAINER

    # override
    def is_tameable(self) -> bool:
        return self.static_flags & CreatureStaticFlags.TAMEABLE

    # TODO: Validate trainer_spell field and Pet trainers.
    def can_train(self, player_mgr) -> bool:
        if not self.is_trainer():
            return False

        if not self.is_within_interactable_distance(player_mgr) and not player_mgr.is_gm:
            return False

        # If expecting a specific class, check if they match.
        if self.creature_template.trainer_class > 0:
            return self.creature_template.trainer_class == player_mgr.player.class_

        # Mount, TradeSkill or Pet trainer.
        return True

    def trainer_has_spell(self, spell_id: int) -> bool:
        if not self.is_trainer():
            return False
        
        trainer_spells: list[TrainerTemplate] = WorldDatabaseManager.TrainerSpellHolder.trainer_spells_get_by_trainer(self.entry)

        for trainer_spell in trainer_spells:
            if trainer_spell.spell == spell_id:
                return True

        return False

    # override
    def initialize_field_values(self):
        # Lazy loading first.
        if not self.fully_loaded:
            self.finish_loading()

        # Initialize values.
        # After this, fields must be modified by setters or directly writing values to them.
        if not self.initialized and self.creature_instance:
            self.bytes_1 = self.get_bytes_1()
            self.bytes_2 = self.get_bytes_2()
            self.damage = self.get_damages()

            # Object fields.
            self.set_uint64(ObjectFields.OBJECT_FIELD_GUID, self.guid)
            self.set_uint32(ObjectFields.OBJECT_FIELD_TYPE, self.object_type_mask)
            self.set_uint32(ObjectFields.OBJECT_FIELD_ENTRY, self.entry)
            self.set_float(ObjectFields.OBJECT_FIELD_SCALE_X, self.current_scale)

            # Unit fields.
            self.set_uint32(UnitFields.UNIT_CHANNEL_SPELL, self.channel_spell)
            self.set_uint64(UnitFields.UNIT_FIELD_CHANNEL_OBJECT, self.channel_object)
            self.set_uint32(UnitFields.UNIT_FIELD_HEALTH, self.health)
            self.set_uint32(UnitFields.UNIT_FIELD_MAXHEALTH, self.max_health)
            self.set_uint32(UnitFields.UNIT_FIELD_POWER1, self.power_1)
            self.set_uint32(UnitFields.UNIT_FIELD_MAXPOWER1, self.max_power_1)
            self.set_uint32(UnitFields.UNIT_FIELD_LEVEL, self.level)
            self.set_uint32(UnitFields.UNIT_FIELD_FACTIONTEMPLATE, self.faction)
            self.set_uint32(UnitFields.UNIT_FIELD_FLAGS, self.unit_flags)
            self.set_uint32(UnitFields.UNIT_FIELD_COINAGE, self.coinage)
            self.set_float(UnitFields.UNIT_FIELD_BASEATTACKTIME, self.base_attack_time)
            self.set_float(UnitFields.UNIT_FIELD_BASEATTACKTIME + 1, 0)
            self.set_int64(UnitFields.UNIT_FIELD_RESISTANCES, self.resistance_0)
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
            self.set_float(UnitFields.UNIT_MOD_CAST_SPEED, self.mod_cast_speed)
            self.set_uint32(UnitFields.UNIT_DYNAMIC_FLAGS, self.dynamic_flags)
            self.set_uint32(UnitFields.UNIT_FIELD_DAMAGE, self.damage)

            for slot, virtual_item in self.virtual_item_info.items():
                self.set_uint32(UnitFields.UNIT_VIRTUAL_ITEM_SLOT_DISPLAY + slot, virtual_item.display_id)
                self.set_uint32(UnitFields.UNIT_VIRTUAL_ITEM_INFO + (slot * 2) + 0, virtual_item.info_packed)
                self.set_uint32(UnitFields.UNIT_VIRTUAL_ITEM_INFO + (slot * 2) + 1, virtual_item.info_packed_2)

            self.initialized = True

    def query_details(self):
        name_bytes = PacketWriter.string_to_bytes(self.creature_template.name)
        subname_bytes = PacketWriter.string_to_bytes(self.creature_template.subname)
        data = pack(
            f'<I{len(name_bytes)}ssss{len(subname_bytes)}s3I',
            self.entry,
            name_bytes, b'\x00', b'\x00', b'\x00',
            subname_bytes,
            self.creature_template.static_flags,
            self.creature_type,
            self.creature_template.beast_family
        )
        return PacketWriter.get_packet(OpCode.SMSG_CREATURE_QUERY_RESPONSE, data)

    def can_swim(self):
        return (self.static_flags & CreatureStaticFlags.AMPHIBIOUS) or (self.static_flags & CreatureStaticFlags.AQUATIC)

    def can_exit_water(self):
        return self.static_flags & CreatureStaticFlags.AQUATIC == 0

    # TODO: Finish implementing evade mechanic.
    def evade(self):
        # Already evading.
        if self.is_evading:
            return

        # Get the path we are using to get back to spawn location.
        waypoints_to_spawn, z_locked = self._get_return_to_spawn_points()
        self.leave_combat(force=True)
        if not self.static_flags & CreatureStaticFlags.NO_AUTO_REGEN:
            self.set_health(self.max_health)
            self.recharge_power()
        self.is_evading = True

        # TODO: Find a proper move type that accepts multiple waypoints, RUNMODE and others halt the unit movement.
        spline_flag = SplineFlags.SPLINEFLAG_RUNMODE if not z_locked else SplineFlags.SPLINEFLAG_FLYING
        self.movement_manager.send_move_normal(waypoints_to_spawn, self.running_speed, spline_flag)

    # TODO: Below return to spawn point logic should be removed once a navmesh is available.
    def _get_return_to_spawn_points(self) -> tuple:  # [waypoints], z_locked bool
        # No points, return just spawn point.
        if len(self.evading_waypoints) == 0:
            return [self.spawn_position], False

        # Reverse the combat waypoints, so they point back to spawn location.
        waypoints = [wp for wp in reversed(self.evading_waypoints)]
        # Set self location to the latest known point.
        self.location = waypoints[0].copy()
        last_waypoint = self.location
        # Distance we want between each waypoint.
        d_factor = 4
        # Try to use waypoints only for units that have invalid z calculations.
        z_locked = False
        distance_sum = 0
        # Filter the waypoints by distance, remove those that are too close to each other.
        for waypoint in list(waypoints):
            # Check for protected z.
            if not z_locked:
                z, z_locked = MapManager.calculate_z(self.map_, waypoint.x, waypoint.y, waypoint.z)
            distance_sum += last_waypoint.distance(waypoint)
            if distance_sum < d_factor:
                waypoints.remove(waypoint)
            else:
                distance_sum = 0
            last_waypoint = waypoint

        if z_locked:
            # Make sure the last waypoints its self spawn position.
            waypoints.append(self.spawn_position.copy())
        else:
            # This unit is probably outside a cave, do not use waypoints.
            waypoints.clear()
            waypoints.append(self.spawn_position)
        return waypoints, z_locked

    def is_moving(self):
        return self.movement_manager.unit_is_moving()

    def stop_movement(self):
        self.movement_manager.send_move_stop()

    def is_casting(self):
        return self.spell_manager.is_casting()

    def _perform_random_movement(self, now):
        # Do not wander in combat, while evading or without wander flag.
        if not self.in_combat and not self.is_evading and self.creature_instance.movement_type == MovementTypes.WANDER:
            if len(self.movement_manager.pending_waypoints) == 0:
                if now > self.last_random_movement + self.random_movement_wait_time:
                    self.movement_manager.move_random(self.spawn_position,
                                                      self.creature_instance.wander_distance)
                    self.random_movement_wait_time = randint(1, 12)
                    self.last_random_movement = now

    def _perform_combat_movement(self):
        if self.combat_target and not self.is_casting() and not self.is_evading:
            if not self.combat_target.is_alive and len(self.attackers) == 0:
                self.evade()
                return

            # In 0.5.3, evade mechanic was only based on distance, the correct instance remains unknown. Assuming
            # 50 yd for now.
            # From 0.5.4 patch notes:
            #     "Creature pursuit is now timer based rather than distance based."
            if self.location.distance(self.spawn_position) > 50:
                self.evade()
                return

            # TODO: There are some creatures like crabs or murlocs that apparently couldn't swim in earlier versions
            #  but are spawned inside the water at this moment since most spawns come from Vanilla data. These mobs
            #  will currently bug out when you try to engage in combat with them. Also seems like a lot of humanoids
            #  couldn't swim before patch 1.3.0:
            #  World of Warcraft Client Patch 1.3.0 (2005-03-22)
            #   - Most humanoids NPCs have gained the ability to swim.
            if self.is_on_water():
                if not self.can_swim():
                    self.evade()
                    return
            else:
                if not self.can_exit_water():
                    self.evade()
                    return

            current_distance = self.location.distance(self.combat_target.location)
            combat_position_distance = UnitFormulas.combat_distance(self, self.combat_target)

            # If target is within combat distance, don't move but do check creature orientation.
            if current_distance <= combat_position_distance:
                # If this creature is not facing the attacker, update its orientation (server-side).
                if not self.location.has_in_arc(self.combat_target.location, math.pi):
                    self.location.face_point(self.combat_target.location)
                return

            combat_location = self.combat_target.location.get_point_in_between(combat_position_distance, vector=self.location)

            if not combat_location:
                return

            # If already going to the correct spot, don't do anything.
            if len(self.movement_manager.pending_waypoints) > 0 and self.movement_manager.pending_waypoints[0].location == combat_location:
                return

            # Make sure the server knows where the creature is facing.
            self.location.face_point(self.combat_target.location)

            if self.is_on_water():
                # Force destination Z to target Z.
                combat_location.z = self.combat_target.location.z
                # TODO: Find how to actually trigger swim animation and which spline flag to use.
                #  VMaNGOS uses UNIT_FLAG_USE_SWIM_ANIMATION, we don't have that.
                self.movement_manager.send_move_normal([combat_location], self.swim_speed, SplineFlags.SPLINEFLAG_FLYING)
            else:
                self.movement_manager.send_move_normal([combat_location], self.running_speed, SplineFlags.SPLINEFLAG_RUNMODE)

    # override
    def update(self, now):
        if now > self.last_tick > 0:
            elapsed = now - self.last_tick

            if self.is_alive and self.is_spawned:
                # Time to live.
                if self.time_to_live_timer > 0:
                    self.time_to_live_timer -= elapsed
                # Regeneration.
                self.regenerate(elapsed)
                # Spell/Aura Update.
                self.spell_manager.update(now)
                self.aura_manager.update(now)
                # Movement Updates.
                self.movement_manager.update_pending_waypoints(elapsed)
                # Random Movement.
                self._perform_random_movement(now)
                # Combat Movement.
                self._perform_combat_movement()
                # AI.
                if self.object_ai:
                    self.object_ai.update_ai(elapsed)
                # Attack Update.
                if self.combat_target and self.is_within_interactable_distance(self.combat_target):
                    self.attack_update(elapsed)
            # Dead
            elif not self.is_alive:
                self.respawn_timer += elapsed
                if self.respawn_timer >= self.respawn_time:
                    self.respawn()
                # Destroy body when creature is about to respawn.
                elif self.is_spawned and self.respawn_timer >= self.respawn_time * 0.8:
                    if self.summoner:
                        self.despawn(destroy=True)
                    else:
                        self.despawn()

            # Time to live expired, destroy.
            if self.time_to_live_timer < -1:
                self.despawn(destroy=True)
            # Check if this creature object should be updated yet or not.
            elif self.has_pending_updates():
                MapManager.update_object(self, has_changes=True)
                self.reset_fields_older_than(now)

        self.last_tick = now

    # override
    def attack_update(self, elapsed):
        target = self.threat_manager.get_hostile_target()
        if target:
            self.attack(target)
        else:
            # If we did not find a target, leave combat.
            self.threat_manager.reset()
            self.leave_combat()

        super().attack_update(elapsed)

    # override
    def receive_damage(self, amount, source=None, is_periodic=False):
        super().receive_damage(amount, source, is_periodic)

        if self.is_alive:
            # If creature's being attacked by another unit, automatically set combat target.
            not_attacked_by_gameobject = source and source.get_type_id() != ObjectTypeIds.ID_GAMEOBJECT
            if not self.combat_target and not_attacked_by_gameobject:
                # Make sure to first stop any movement right away.
                if len(self.movement_manager.pending_waypoints) > 0:
                    self.movement_manager.send_move_stop()
                # Attack.
                self.attack(source)
            self.threat_manager.add_threat(source, amount)

    # override
    def respawn(self):
        super().respawn()
        # Set all property values before making this creature visible.
        self.location = self.spawn_position.copy()
        self.set_health(self.max_health)
        self.set_mana(self.max_power_1)

        self.loot_manager.clear()
        self.set_lootable(False)

        if self.killed_by and self.killed_by.group_manager:
            self.killed_by.group_manager.clear_looters_for_victim(self)
        self.killed_by = None

        self.respawn_timer = 0
        self.respawn_time = randint(self.creature_instance.spawntimesecsmin, self.creature_instance.spawntimesecsmax)

        # Update its cell position if needed (Died far away from spawn location cell)
        MapManager.update_object(self)
        # Make this creature visible to its surroundings.
        MapManager.respawn_object(self)

    # override
    def die(self, killer=None):
        if not self.is_alive:
            return False

        if killer.get_type_id() != ObjectTypeIds.ID_PLAYER:
            # Attribute non-player kills to the creature's summoner.
            # TODO Does this also apply for player mind control?
            killer = killer.summoner if killer.summoner else killer

        if killer and killer.get_type_id() == ObjectTypeIds.ID_PLAYER:
            self.loot_manager.generate_loot(killer)

            self.reward_kill_xp(killer)
            self.killed_by = killer
            # If the player/group requires the kill, reward it to them.
            if self.killed_by.group_manager:
                self.killed_by.group_manager.reward_group_creature_or_go(self.killed_by, self)
            else:
                # Reward quest creature to player with killing blow.
                self.killed_by.quest_manager.reward_creature_or_go(self)

            # If the player is in a group, set the group as allowed looters if needed.
            if self.killed_by.group_manager and self.loot_manager.has_loot():
                self.killed_by.group_manager.set_allowed_looters(self)

        if self.loot_manager.has_loot():
            self.set_lootable(True)

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
            0,  # visibility flags
            self.shapeshift_form,  # shapeshift form
            self.npc_flags,  # npc flags
            self.stand_state  # stand state
        )

    # override
    def get_bytes_2(self):
        return ByteUtils.bytes_to_int(
            0,  # unknown
            0,  # pet flags
            0,  # misc flags
            self.sheath_state  # sheath state
        )

    # override
    def get_damages(self):
        return ByteUtils.shorts_to_int(
            int(self.creature_template.dmg_max),
            int(self.creature_template.dmg_min)
        )

    # override
    def has_offhand_weapon(self):
        return self.wearing_offhand_weapon

    # override
    def has_ranged_weapon(self):
        return self.wearing_ranged_weapon

    # override
    def set_weapon_mode(self, weapon_mode):
        super().set_weapon_mode(weapon_mode)
        self.bytes_2 = self.get_bytes_2()
        self.set_uint32(UnitFields.UNIT_FIELD_BYTES_2, self.bytes_2)

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
    def get_type_id(self):
        return ObjectTypeIds.ID_UNIT
