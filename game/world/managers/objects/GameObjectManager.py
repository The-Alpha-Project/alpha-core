from math import pi, cos, sin
from struct import pack

from game.world.managers.GridManager import GridManager
from game.world.managers.abstractions.Vector import Vector
from game.world.managers.objects.ObjectManager import ObjectManager
from network.packet.PacketWriter import PacketWriter
from network.packet.UpdatePacketFactory import UpdatePacketFactory
from utils.constants.ObjectCodes import ObjectTypes, ObjectTypeIds, HighGuid, UpdateTypes, GameObjectTypes, \
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

        self.update_packet_factory = UpdatePacketFactory([ObjectTypes.TYPE_OBJECT,
                                                          ObjectTypes.TYPE_GAMEOBJECT])

        self.gobject_template = gobject_template
        self.gobject_instance = gobject_instance

        self.guid = (gobject_instance.spawn_id if gobject_instance else 0) | HighGuid.HIGHGUID_GAMEOBJECT

        if self.gobject_template:
            self.display_id = self.gobject_template.display_id

        if gobject_instance:
            self.state = self.gobject_instance.spawn_state
            self.location.x = self.gobject_instance.spawn_positionX
            self.location.y = self.gobject_instance.spawn_positionY
            self.location.z = self.gobject_instance.spawn_positionZ
            self.location.o = self.gobject_instance.spawn_orientation
            self.map_ = self.gobject_instance.spawn_map
            self.scale = self.gobject_template.scale

        self.object_type.append(ObjectTypes.TYPE_GAMEOBJECT)

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
        elif self.gobject_template.type == GameObjectTypes.TYPE_CHAIR:
            slots = self.gobject_template.data1
            height = self.gobject_template.data2

            lowest_distance = 90.0
            x_lowest = self.location.x
            y_lowest = self.location.y

            if slots > 0:
                orthogonal_orientation = self.location.o + pi * 0.5
                for x in range(0, slots):
                    relative_distance = (self.scale * x) - (self.scale * (slots - 1) / 2.0)
                    x_i = self.location.x + relative_distance * cos(orthogonal_orientation)
                    y_i = self.location.y + relative_distance * sin(orthogonal_orientation)

                    player_slot_distance = player.location.distance(Vector(x_i, y_i, player.location.z))
                    if player_slot_distance <= lowest_distance:
                        lowest_distance = player_slot_distance
                        x_lowest = x_i
                        y_lowest = y_i
                player.teleport(player.map_, Vector(x_lowest, y_lowest, self.location.z, self.location.o))
                player.stand_state = StandState.UNIT_SITTINGCHAIRLOW.value + height

    # override
    def get_update_packet(self, update_type=UpdateTypes.UPDATE_FULL, is_self=True):
        if self.gobject_template and self.gobject_instance:
            # Object fields
            self.update_packet_factory.update(self.update_packet_factory.object_values, self.update_packet_factory.updated_object_fields, ObjectFields.OBJECT_FIELD_GUID, self.guid, 'Q')
            self.update_packet_factory.update(self.update_packet_factory.object_values, self.update_packet_factory.updated_object_fields, ObjectFields.OBJECT_FIELD_TYPE, self.get_object_type_value(), 'I')
            self.update_packet_factory.update(self.update_packet_factory.object_values, self.update_packet_factory.updated_object_fields, ObjectFields.OBJECT_FIELD_ENTRY, self.gobject_template.entry, 'I')
            self.update_packet_factory.update(self.update_packet_factory.object_values, self.update_packet_factory.updated_object_fields, ObjectFields.OBJECT_FIELD_SCALE_X, self.scale, 'f')
            self.update_packet_factory.update(self.update_packet_factory.object_values, self.update_packet_factory.updated_object_fields, ObjectFields.OBJECT_FIELD_PADDING, 0, 'I')

            # Gameobject fields
            self.update_packet_factory.update(self.update_packet_factory.gameobject_values, self.update_packet_factory.updated_gameobject_fields, GameObjectFields.GAMEOBJECT_DISPLAYID, self.display_id, 'I')
            self.update_packet_factory.update(self.update_packet_factory.gameobject_values, self.update_packet_factory.updated_gameobject_fields, GameObjectFields.GAMEOBJECT_FLAGS, self.gobject_template.flags, 'I')
            self.update_packet_factory.update(self.update_packet_factory.gameobject_values, self.update_packet_factory.updated_gameobject_fields, GameObjectFields.GAMEOBJECT_FACTION, self.gobject_template.faction, 'I')
            self.update_packet_factory.update(self.update_packet_factory.gameobject_values, self.update_packet_factory.updated_gameobject_fields, GameObjectFields.GAMEOBJECT_STATE, self.state, 'I')
            self.update_packet_factory.update(self.update_packet_factory.gameobject_values, self.update_packet_factory.updated_gameobject_fields, GameObjectFields.GAMEOBJECT_ROTATION, self.gobject_instance.spawn_rotation0, 'f')
            self.update_packet_factory.update(self.update_packet_factory.gameobject_values, self.update_packet_factory.updated_gameobject_fields, GameObjectFields.GAMEOBJECT_ROTATION + 1, self.gobject_instance.spawn_rotation1, 'f')
            self.update_packet_factory.update(self.update_packet_factory.gameobject_values, self.update_packet_factory.updated_gameobject_fields, GameObjectFields.GAMEOBJECT_ROTATION + 2, self.gobject_instance.spawn_rotation2, 'f')
            self.update_packet_factory.update(self.update_packet_factory.gameobject_values, self.update_packet_factory.updated_gameobject_fields, GameObjectFields.GAMEOBJECT_ROTATION + 3, self.gobject_instance.spawn_rotation3, 'f')
            self.update_packet_factory.update(self.update_packet_factory.gameobject_values, self.update_packet_factory.updated_gameobject_fields, GameObjectFields.GAMEOBJECT_POS_X, self.location.x, 'f')
            self.update_packet_factory.update(self.update_packet_factory.gameobject_values, self.update_packet_factory.updated_gameobject_fields, GameObjectFields.GAMEOBJECT_POS_Y, self.location.y, 'f')
            self.update_packet_factory.update(self.update_packet_factory.gameobject_values, self.update_packet_factory.updated_gameobject_fields, GameObjectFields.GAMEOBJECT_POS_Z, self.location.z, 'f')
            self.update_packet_factory.update(self.update_packet_factory.gameobject_values, self.update_packet_factory.updated_gameobject_fields, GameObjectFields.GAMEOBJECT_FACING, self.location.o, 'f')

            packet = b''
            if update_type == UpdateTypes.UPDATE_FULL:
                packet += self.create_update_packet(is_self)
            else:
                packet += self.create_partial_update_packet(self.update_packet_factory)

            update_packet = packet + self.update_packet_factory.build_packet()
            return update_packet

    def query_details(self):
        name_bytes = PacketWriter.string_to_bytes(self.gobject_template.name)
        data = pack(
            '<3I%ussss10I' % len(name_bytes),
            self.gobject_template.entry,
            self.gobject_template.type,
            self.display_id,
            name_bytes, b'\x00', b'\x00', b'\x00',
            self.gobject_template.data1,
            self.gobject_template.data2,
            self.gobject_template.data3,
            self.gobject_template.data4,
            self.gobject_template.data5,
            self.gobject_template.data6,
            self.gobject_template.data7,
            self.gobject_template.data8,
            self.gobject_template.data9,
            self.gobject_template.data10,
        )
        return PacketWriter.get_packet(OpCode.SMSG_GAMEOBJECT_QUERY_RESPONSE, data)

    def send_update_surrounding(self, update_type=UpdateTypes.UPDATE_FULL):
        update_packet = UpdatePacketFactory.compress_if_needed(
            PacketWriter.get_packet(OpCode.SMSG_UPDATE_OBJECT,
                                    self.get_update_packet(update_type=update_type, is_self=False)))
        GridManager.send_surrounding(update_packet, self, include_self=False)

    # override
    def get_type(self):
        return ObjectTypes.TYPE_GAMEOBJECT

    # override
    def get_type_id(self):
        return ObjectTypeIds.ID_GAMEOBJECT
