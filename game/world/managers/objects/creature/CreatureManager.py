import time
from random import randint, choice
from struct import unpack, pack

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.GridManager import GridManager
from game.world.managers.abstractions.Vector import Vector
from game.world.managers.objects.UnitManager import UnitManager
from game.world.managers.objects.item.ItemManager import ItemManager
from game.world.managers.objects.creature.CreatureLootManager import CreatureLootManager
from network.packet.PacketWriter import PacketWriter
from utils import Formulas
from utils.constants.ItemCodes import InventoryTypes, ItemSubClasses
from utils.constants.ObjectCodes import ObjectTypes, ObjectTypeIds, HighGuid, UnitDynamicTypes
from utils.constants.OpCodes import OpCode
from utils.constants.UnitCodes import UnitFlags, WeaponMode, CreatureTypes, MovementTypes, SplineFlags
from utils.constants.UpdateFields import ObjectFields, UnitFields


class CreatureManager(UnitManager):

    def __init__(self,
                 creature_template,
                 creature_instance=None,
                 **kwargs):
        super().__init__(**kwargs)

        self.creature_template = creature_template
        self.creature_instance = creature_instance
        self.killed_by = None

        self.guid = (creature_instance.spawn_id if creature_instance else 0) | HighGuid.HIGHGUID_UNIT

        if self.creature_template:
            self.entry = self.creature_template.entry
            self.display_id = self.generate_display_id()
            self.max_health = self.creature_template.health_max
            self.power_1 = self.creature_template.mana_min
            self.max_power_1 = self.creature_template.mana_max
            self.level = randint(self.creature_template.level_min, self.creature_template.level_max)
            self.resistance_0 = self.creature_template.armor
            self.resistance_1 = self.creature_template.holy_res
            self.resistance_2 = self.creature_template.fire_res
            self.resistance_3 = self.creature_template.nature_res
            self.resistance_4 = self.creature_template.frost_res
            self.resistance_5 = self.creature_template.shadow_res
            self.npc_flags = self.creature_template.npc_flags
            self.mod_cast_speed = 1.0
            self.base_attack_time = self.creature_template.base_attack_time
            self.unit_flags = self.creature_template.unit_flags
            self.faction = self.creature_template.faction
            self.creature_type = self.creature_template.type
            self.sheath_state = WeaponMode.SHEATHEDMODE  # Default one

            if 0 < self.creature_template.rank < 4:
                self.unit_flags = self.unit_flags | UnitFlags.UNIT_FLAG_PLUS_MOB

            self.fully_loaded = False
            self.is_evading = False
            self.has_offhand_weapon = False
            self.respawn_timer = 0
            self.is_spawned = True
            self.last_random_movement = 0
            self.random_movement_wait_time = randint(1, 12)

            self.loot_manager = CreatureLootManager(self)

        if self.creature_instance:
            self.health = int((self.creature_instance.health_percent / 100) * self.max_health)
            self.map_ = self.creature_instance.map
            self.spawn_position = Vector(self.creature_instance.position_x,
                                         self.creature_instance.position_y,
                                         self.creature_instance.position_z,
                                         self.creature_instance.orientation)
            self.location = self.spawn_position
            self.respawn_time = randint(self.creature_instance.spawntimesecsmin, self.creature_instance.spawntimesecsmax)

    def load(self):
        GridManager.add_or_get(self, True)

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
            for vendor_data_entry in vendor_data:
                data += pack(
                    '<7I',
                    1,  # mui
                    vendor_data_entry.item,
                    vendor_data_entry.item_template.display_id,
                    0xFFFFFFFF if vendor_data_entry.maxcount <= 0 else vendor_data_entry.maxcount,
                    vendor_data_entry.item_template.buy_price,
                    0,  # durability
                    0,  # stack count
                )
                world_session.send_message(ItemManager(item_template=vendor_data_entry.item_template).query_details())

        session.close()
        world_session.send_message(PacketWriter.get_packet(OpCode.SMSG_LIST_INVENTORY, data))

    def finish_loading(self):
        if self.creature_template and self.creature_instance:
            if not self.fully_loaded:
                creature_model_info = WorldDatabaseManager.creature_get_model_info(self.display_id)
                if creature_model_info:
                    self.bounding_radius = creature_model_info.bounding_radius
                    self.combat_reach = creature_model_info.combat_reach

                if self.creature_template.scale == 0:
                    display_scale = DbcDatabaseManager.creature_display_info_get_by_id(self.display_id)
                    if display_scale and display_scale.CreatureModelScale > 0:
                        self.scale = display_scale.CreatureModelScale
                    else:
                        self.scale = 1
                else:
                    self.scale = self.creature_template.scale

                if self.creature_template.equipment_id > 0:
                    creature_equip_template = WorldDatabaseManager.creature_get_equipment_by_id(
                        self.creature_template.equipment_id
                    )
                    if creature_equip_template:
                        self.set_virtual_item(0, creature_equip_template.equipentry1)
                        self.set_virtual_item(1, creature_equip_template.equipentry2)
                        self.set_virtual_item(2, creature_equip_template.equipentry3)

                self.fully_loaded = True

    def set_virtual_item(self, slot, item_entry):
        if item_entry == 0:
            self.set_uint32(UnitFields.UNIT_VIRTUAL_ITEM_SLOT_DISPLAY + slot, 0)
            self.set_uint32(UnitFields.UNIT_VIRTUAL_ITEM_INFO + (slot * 2) + 0, 0)
            self.set_uint32(UnitFields.UNIT_VIRTUAL_ITEM_INFO + (slot * 2) + 1, 0)
            return

        item_template = WorldDatabaseManager.ItemTemplateHolder.item_template_get_by_entry(item_entry)
        if item_template:
            self.set_uint32(UnitFields.UNIT_VIRTUAL_ITEM_SLOT_DISPLAY + slot, item_template.display_id)
            virtual_item_info = unpack('<I', pack('<4B',
                                                  item_template.class_,
                                                  item_template.subclass,
                                                  item_template.material,
                                                  item_template.inventory_type)
                                       )[0]
            self.set_uint32(UnitFields.UNIT_VIRTUAL_ITEM_INFO + (slot * 2) + 0, virtual_item_info)
            self.set_uint32(UnitFields.UNIT_VIRTUAL_ITEM_INFO + (slot * 2) + 1, item_template.sheath)

            # Main hand
            if slot == 0:
                # This is a TOTAL guess, I have no idea about real weapon reach values.
                # The weapon reach unit field was removed in patch 0.10.
                if item_template.inventory_type == InventoryTypes.TWOHANDEDWEAPON:
                    self.weapon_reach = 1.5
                elif item_template.subclass == ItemSubClasses.ITEM_SUBCLASS_DAGGER:
                    self.weapon_reach = 0.5
                elif item_template.subclass != ItemSubClasses.ITEM_SUBCLASS_FIST_WEAPON:
                    self.weapon_reach = 1.0

            # Offhand
            if slot == 1:
                self.has_offhand_weapon = (item_template.inventory_type == InventoryTypes.WEAPON or
                                           item_template.inventory_type == InventoryTypes.WEAPONOFFHAND)
        elif slot == 0:
            self.weapon_reach = 0.0

    # override
    def get_full_update_packet(self, is_self=True):
        self.finish_loading()

        # stand_state, npc_flags, shapeshift_form, visibility_flag
        self.bytes_1 = unpack('<I', pack('<4B', self.stand_state, self.npc_flags, self.shapeshift_form, 0))[0]
        # sheath_state, misc_flags, pet_flags, unknown
        self.bytes_2 = unpack('<I', pack('<4B', self.sheath_state, 0, 0, 0))[0]
        self.damage = unpack('<I', pack('<2H', int(self.creature_template.dmg_min),
                                        int(self.creature_template.dmg_max)))[0]

        # Object fields
        self.set_uint64(ObjectFields.OBJECT_FIELD_GUID, self.guid)
        self.set_uint32(ObjectFields.OBJECT_FIELD_TYPE, self.get_object_type_value())
        self.set_uint32(ObjectFields.OBJECT_FIELD_ENTRY, self.entry)
        self.set_float(ObjectFields.OBJECT_FIELD_SCALE_X, self.scale)

        # Unit fields
        self.set_uint32(UnitFields.UNIT_CHANNEL_SPELL, self.channel_spell)
        self.set_uint64(UnitFields.UNIT_FIELD_CHANNEL_OBJECT, self.channel_object)
        self.set_uint32(UnitFields.UNIT_FIELD_HEALTH, self.health)
        self.set_uint32(UnitFields.UNIT_FIELD_MAXHEALTH, self.max_health)
        self.set_uint32(UnitFields.UNIT_FIELD_POWER1, self.power_1)
        self.set_uint32(UnitFields.UNIT_FIELD_MAXHEALTH, self.max_health)
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
        self.set_uint32(UnitFields.UNIT_FIELD_DISPLAYID, self.display_id)
        self.set_uint32(UnitFields.UNIT_FIELD_BYTES_1, self.bytes_1)
        self.set_uint32(UnitFields.UNIT_FIELD_BYTES_2, self.bytes_2)
        self.set_float(UnitFields.UNIT_MOD_CAST_SPEED, self.mod_cast_speed)
        self.set_uint32(UnitFields.UNIT_DYNAMIC_FLAGS, self.dynamic_flags)
        self.set_uint32(UnitFields.UNIT_FIELD_DAMAGE, self.damage)

        return self.get_object_create_packet(is_self)

    def query_details(self):
        name_bytes = PacketWriter.string_to_bytes(self.creature_template.name)
        subname_bytes = PacketWriter.string_to_bytes(self.creature_template.subname)
        data = pack(
            f'<I{len(name_bytes)}ssss{len(subname_bytes)}s3I',
            self.entry,
            name_bytes, b'\x00', b'\x00', b'\x00',
            subname_bytes,
            self.creature_template.type_flags,
            self.creature_type,
            self.creature_template.beast_family
        )
        return PacketWriter.get_packet(OpCode.SMSG_CREATURE_QUERY_RESPONSE, data)

    # override
    def demorph(self):
        self.set_display_id(self.generate_display_id())

    # override
    def update(self):
        now = time.time()
        if now > self.last_tick > 0:
            elapsed = now - self.last_tick

            if self.is_alive:
                # Movement Updates
                self.movement_manager.update_pending_waypoints(elapsed)
                # Random Movement
                if not self.in_combat and self.creature_instance.movement_type == MovementTypes.WANDER:
                    if len(self.movement_manager.pending_waypoints) == 0:
                        if now > self.last_random_movement + self.random_movement_wait_time:
                            self.movement_manager.move_random(self.spawn_position,
                                                              self.creature_instance.wander_distance)
                            self.random_movement_wait_time = randint(1, 12)
                            self.last_random_movement = now
            # Dead
            else:
                self.respawn_timer += elapsed
                if self.respawn_timer >= self.respawn_time:
                    self.respawn()
                # Destroy body when creature is about to respawn
                elif self.is_spawned and self.respawn_timer >= self.respawn_time * 0.8:
                    self.is_spawned = False
                    GridManager.send_surrounding(self.get_destroy_packet(), self, include_self=False)
        self.last_tick = now

        if self.dirty:
            GridManager.send_surrounding(self.generate_proper_update_packet(create=False), self, include_self=False)
            GridManager.update_object(self)
            self.reset_fields()

            self.set_dirty(is_dirty=False)

    # override
    def respawn(self, force_update=True):
        super().respawn()

        self.set_health(self.max_health)
        self.set_mana(self.max_power_1)

        self.loot_manager.clear()
        self.set_lootable(False)

        if self.killed_by and self.killed_by.group_manager:
            self.killed_by.group_manager.clear_looters_for_victim(self)
        self.killed_by = None

        self.is_spawned = True
        self.respawn_timer = 0
        self.respawn_time = randint(self.creature_instance.spawntimesecsmin, self.creature_instance.spawntimesecsmax)

        if force_update:
            GridManager.send_surrounding(self.generate_proper_update_packet(create=True), self, include_self=False)

    # override
    def die(self, killer=None):
        super().die(killer)
        self.loot_manager.generate_loot()

        if killer and killer.get_type() == ObjectTypes.TYPE_PLAYER:
            self.reward_kill_xp(killer)
            self.killed_by = killer
            if self.killed_by.group_manager and self.loot_manager.has_loot():
                self.killed_by.group_manager.set_allowed_looters(self)

        if self.loot_manager.has_loot():
            self.set_lootable(True, set_dirty=False)

        self.set_dirty()

    def reward_kill_xp(self, player):
        # Critters don't award XP
        if self.creature_type == CreatureTypes.AMBIENT:
            return

        is_elite = 0 < self.creature_template.rank < 4

        if player.group_manager:
            player.group_manager.reward_group_xp(player, self, is_elite)
        else:
            player.give_xp([Formulas.CreatureFormulas.xp_reward(self.level, player.level, is_elite)], self)

    def calculate_min_max_damage(self, attack_type=0):
        min_damage, max_damage = unpack('<2H', pack('<I', self.damage))
        return int(min_damage), int(max_damage)

    def set_lootable(self, flag=True, set_dirty=True):
        if flag:
            self.dynamic_flags |= UnitDynamicTypes.UNIT_DYNAMIC_LOOTABLE
        else:
            self.dynamic_flags &= ~UnitDynamicTypes.UNIT_DYNAMIC_LOOTABLE
        self.set_uint32(UnitFields.UNIT_DYNAMIC_FLAGS, self.dynamic_flags)

        if set_dirty:
            self.set_dirty()

    # override
    def has_offhand_weapon(self):
        return self.has_offhand_weapon

    # override
    def set_weapon_mode(self, weapon_mode):
        super().set_weapon_mode(weapon_mode)
        self.bytes_2 = unpack('<I', pack('<4B', self.sheath_state, 0, 0, 0))[0]

        self.set_uint32(UnitFields.UNIT_FIELD_BYTES_2, self.bytes_2)
        self.set_dirty()

    # override
    def set_stand_state(self, stand_state):
        super().set_stand_state(stand_state)
        self.bytes_1 = unpack('<I', pack('<4B', self.stand_state, self.npc_flags, self.shapeshift_form, 0))[0]
        self.set_uint32(UnitFields.UNIT_FIELD_BYTES_1, self.bytes_1)

    # override
    def get_type(self):
        return ObjectTypes.TYPE_UNIT

    # override
    def get_type_id(self):
        return ObjectTypeIds.ID_UNIT
