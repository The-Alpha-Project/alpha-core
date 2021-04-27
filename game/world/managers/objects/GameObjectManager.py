import math
from math import pi, cos, sin
from struct import pack

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from game.world.managers.GridManager import GridManager
from game.world.managers.abstractions.Vector import Vector
from game.world.managers.objects.ObjectManager import ObjectManager
from network.packet.PacketWriter import PacketWriter
from network.packet.update.UpdatePacketFactory import UpdatePacketFactory
from utils.constants.ObjectCodes import ObjectTypes, ObjectTypeIds, HighGuid, GameObjectTypes, \
    GameObjectStates
from utils.constants.OpCodes import OpCode
from utils.constants.UnitCodes import StandState
from utils.constants.UpdateFields import ObjectFields, GameObjectFields


class GameObjectManager(ObjectManager):
    def __init__(self,
                 gobject_template,
                 gobject_instance=None,
                 **kwargs):
        super().__init__(**kwargs)

        self.gobject_template = gobject_template
        self.gobject_instance = gobject_instance

        self.guid = (gobject_instance.spawn_id if gobject_instance else 0) | HighGuid.HIGHGUID_GAMEOBJECT

        if self.gobject_template:
            self.entry = self.gobject_template.entry
            self.native_display_id = self.gobject_template.display_id
            self.current_display_id = self.native_display_id
            self.native_scale = self.gobject_template.scale
            self.current_scale = self.native_scale
            self.faction = self.gobject_template.faction

        if gobject_instance:
            self.state = self.gobject_instance.spawn_state
            self.location.x = self.gobject_instance.spawn_positionX
            self.location.y = self.gobject_instance.spawn_positionY
            self.location.z = self.gobject_instance.spawn_positionZ
            self.location.o = self.gobject_instance.spawn_orientation
            self.map_ = self.gobject_instance.spawn_map

        self.object_type.append(ObjectTypes.TYPE_GAMEOBJECT)
        self.update_packet_factory.init_values(GameObjectFields.GAMEOBJECT_END)

    def load(self):
        GridManager.add_or_get(self, True)

    def use(self, player):
        if self.gobject_template.type == GameObjectTypes.TYPE_DOOR or \
                self.gobject_template.type == GameObjectTypes.TYPE_BUTTON:
            # TODO: Check locks for doors
            if self.state == GameObjectStates.GO_STATE_READY:
                self.state = GameObjectStates.GO_STATE_ACTIVE
                # TODO: Trigger sripts / events on cooldown restart
                self.send_update_surrounding()
        elif self.gobject_template.type == GameObjectTypes.TYPE_CAMERA:
            cinematic_id = self.gobject_template.data1
            if DbcDatabaseManager.cinematic_sequences_get_by_id(cinematic_id):
                data = pack('<I', cinematic_id)
                player.session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_TRIGGER_CINEMATIC, data))
        elif self.gobject_template.type == GameObjectTypes.TYPE_CHAIR:
            slots = self.gobject_template.data0
            height = self.gobject_template.data1

            lowest_distance = 90.0
            x_lowest = self.location.x
            y_lowest = self.location.y

            if slots > 0:
                orthogonal_orientation = self.location.o + pi * 0.5
                for x in range(0, slots):
                    relative_distance = (self.current_scale * x) - (self.current_scale * (slots - 1) / 2.0)
                    x_i = self.location.x + relative_distance * cos(orthogonal_orientation)
                    y_i = self.location.y + relative_distance * sin(orthogonal_orientation)

                    player_slot_distance = player.location.distance(Vector(x_i, y_i, player.location.z))
                    if player_slot_distance <= lowest_distance:
                        lowest_distance = player_slot_distance
                        x_lowest = x_i
                        y_lowest = y_i
                player.teleport(player.map_, Vector(x_lowest, y_lowest, self.location.z, self.location.o))
                player.set_stand_state(StandState.UNIT_SITTINGCHAIRLOW.value + height)

    # override
    def set_display_id(self, display_id):
        super().set_display_id(display_id)
        if display_id <= 0 or not \
                DbcDatabaseManager.gameobject_display_info_get_by_id(display_id):
            return

        self.set_uint32(GameObjectFields.GAMEOBJECT_DISPLAYID, self.current_display_id)

    # override
    def get_full_update_packet(self, is_self=True):
        if self.gobject_template and self.gobject_instance:
            # Object fields
            self.set_uint64(ObjectFields.OBJECT_FIELD_GUID, self.guid)
            self.set_uint32(ObjectFields.OBJECT_FIELD_TYPE, self.get_object_type_value())
            self.set_uint32(ObjectFields.OBJECT_FIELD_ENTRY, self.entry)
            self.set_float(ObjectFields.OBJECT_FIELD_SCALE_X, self.current_scale)
            self.set_uint32(ObjectFields.OBJECT_FIELD_PADDING, 0)

            # Gameobject fields
            self.set_uint32(GameObjectFields.GAMEOBJECT_DISPLAYID, self.current_display_id)
            self.set_uint32(GameObjectFields.GAMEOBJECT_FLAGS, self.gobject_template.flags)
            self.set_uint32(GameObjectFields.GAMEOBJECT_FACTION, self.faction)
            self.set_uint32(GameObjectFields.GAMEOBJECT_STATE, self.state)
            self.set_float(GameObjectFields.GAMEOBJECT_ROTATION, self.gobject_instance.spawn_rotation0)
            self.set_float(GameObjectFields.GAMEOBJECT_ROTATION + 1, self.gobject_instance.spawn_rotation1)

            if self.gobject_instance.spawn_rotation2 == 0 and self.gobject_instance.spawn_rotation3 == 0:
                f_rot1 = math.sin(self.location.o / 2.0)
                f_rot2 = math.cos(self.location.o / 2.0)
            else:
                f_rot1 = self.gobject_instance.spawn_rotation2
                f_rot2 = self.gobject_instance.spawn_rotation3

            self.set_float(GameObjectFields.GAMEOBJECT_ROTATION + 2, f_rot1)
            self.set_float(GameObjectFields.GAMEOBJECT_ROTATION + 3, f_rot2)
            self.set_float(GameObjectFields.GAMEOBJECT_POS_X, self.location.x)
            self.set_float(GameObjectFields.GAMEOBJECT_POS_Y, self.location.y)
            self.set_float(GameObjectFields.GAMEOBJECT_POS_Z, self.location.z)
            self.set_float(GameObjectFields.GAMEOBJECT_FACING, self.location.o)

            return self.get_object_create_packet(is_self)

    def query_details(self):
        name_bytes = PacketWriter.string_to_bytes(self.gobject_template.name)
        data = pack(
            f'<3I{len(name_bytes)}ssss10I',
            self.gobject_template.entry,
            self.gobject_template.type,
            self.current_display_id,
            name_bytes, b'\x00', b'\x00', b'\x00',
            self.gobject_template.data0,
            self.gobject_template.data1,
            self.gobject_template.data2,
            self.gobject_template.data3,
            self.gobject_template.data4,
            self.gobject_template.data5,
            self.gobject_template.data6,
            self.gobject_template.data7,
            self.gobject_template.data8,
            self.gobject_template.data9
        )
        return PacketWriter.get_packet(OpCode.SMSG_GAMEOBJECT_QUERY_RESPONSE, data)

    def send_update_surrounding(self):
        update_packet = UpdatePacketFactory.compress_if_needed(
            PacketWriter.get_packet(OpCode.SMSG_UPDATE_OBJECT,
                                    self.get_full_update_packet(is_self=False)))
        GridManager.send_surrounding(update_packet, self, include_self=False)

    # override
    def on_cell_change(self):
        pass

    # override
    def get_type(self):
        return ObjectTypes.TYPE_GAMEOBJECT

    # override
    def get_type_id(self):
        return ObjectTypeIds.ID_GAMEOBJECT
