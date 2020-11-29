from random import randrange, choice
from struct import unpack, pack

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.GridManager import GridManager
from game.world.managers.objects.UnitManager import UnitManager
from game.world.managers.objects.item.ItemManager import ItemManager
from network.packet.PacketWriter import PacketWriter
from utils.constants.ObjectCodes import ObjectTypes, ObjectTypeIds, HighGuid
from utils.constants.OpCodes import OpCode
from utils.constants.UnitCodes import UnitFlags
from utils.constants.UpdateFields import ObjectFields, UnitFields


class CreatureManager(UnitManager):
    def __init__(self,
                 creature_template,
                 creature_instance=None,
                 **kwargs):
        super().__init__(**kwargs)

        self.creature_template = creature_template
        self.creature_instance = creature_instance

        self.guid = (creature_instance.spawn_id if creature_instance else 0) | HighGuid.HIGHGUID_UNIT

        if self.creature_template:
            self.entry = self.creature_template.entry
            display_id_list = list(filter((0).__ne__, [self.creature_template.display_id1,
                                                       self.creature_template.display_id2,
                                                       self.creature_template.display_id3,
                                                       self.creature_template.display_id4]))
            self.display_id = choice(display_id_list) if len(display_id_list) > 0 else 4  # 4 = cube
            self.max_health = self.creature_template.health_max
            self.level = randrange(self.creature_template.level_min, self.creature_template.level_max + 1)
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

            if 0 < self.creature_template.rank < 4:
                self.unit_flags = self.unit_flags | UnitFlags.UNIT_FLAG_PLUS_MOB

            self.model_info_loaded = False

        if self.creature_instance:
            self.health = int((self.creature_instance.health_percent / 100) * self.max_health)
            self.map_ = self.creature_instance.map
            self.location.x = self.creature_instance.position_x
            self.location.y = self.creature_instance.position_y
            self.location.z = self.creature_instance.position_z
            self.location.o = self.creature_instance.orientation

    def load(self):
        GridManager.add_or_get(self, True)

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
                world_session.request.sendall(ItemManager(item_template=vendor_data_entry.item_template).query_details())

        session.close()
        world_session.request.sendall(PacketWriter.get_packet(OpCode.SMSG_LIST_INVENTORY, data))

    def preload_model_info(self):
        if self.creature_template and self.creature_instance:
            if not self.model_info_loaded:
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

                self.model_info_loaded = True

    # override
    def get_full_update_packet(self, is_self=True):
        self.preload_model_info()

        self.bytes_1 = unpack('<I', pack('<4B', self.stand_state, self.npc_flags, 0, self.sheath_state))[0]
        self.damage = int(self.creature_template.dmg_max)  # temp

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
        self.set_uint32(UnitFields.UNIT_FIELD_DISPLAYID, self.display_id)
        self.set_uint32(UnitFields.UNIT_FIELD_BYTES_1, self.bytes_1)
        self.set_float(UnitFields.UNIT_MOD_CAST_SPEED, self.mod_cast_speed)
        self.set_uint32(UnitFields.UNIT_DYNAMIC_FLAGS, self.dynamic_flags)
        self.set_uint32(UnitFields.UNIT_FIELD_DAMAGE, self.damage)

        return self.get_object_create_packet(is_self)

    def query_details(self):
        name_bytes = PacketWriter.string_to_bytes(self.creature_template.name)
        subname_bytes = PacketWriter.string_to_bytes(self.creature_template.subname)
        data = pack(
            '<I%ussss%us3I' % (len(name_bytes), len(subname_bytes)),
            self.entry,
            name_bytes, b'\x00', b'\x00', b'\x00',
            subname_bytes,
            self.creature_template.type_flags,
            self.creature_template.type,
            self.creature_template.beast_family
        )
        return PacketWriter.get_packet(OpCode.SMSG_CREATURE_QUERY_RESPONSE, data)

    # override
    def set_weapon_mode(self, weapon_mode):
        super().set_weapon_mode(weapon_mode)
        self.bytes_1 = unpack('<I', pack('<4B', self.stand_state, self.npc_flags, self.shapeshift_form,
                                         self.sheath_state))[0]

        self.set_uint32(UnitFields.UNIT_FIELD_BYTES_1, self.bytes_1)
        self.flagged_for_update = True

    # override
    def set_stand_state(self, stand_state):
        super().set_stand_state(stand_state)
        self.bytes_1 = unpack('<I', pack('<4B', self.stand_state, self.npc_flags, 0, 0))[0]
        self.set_uint32(UnitFields.UNIT_FIELD_BYTES_1, self.bytes_1)

    # override
    def get_type(self):
        return ObjectTypes.TYPE_UNIT

    # override
    def get_type_id(self):
        return ObjectTypeIds.ID_UNIT
