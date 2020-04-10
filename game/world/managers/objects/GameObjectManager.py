from struct import pack

from game.world.managers.GridManager import GridManager
from game.world.managers.objects.ObjectManager import ObjectManager
from network.packet.PacketWriter import PacketWriter
from network.packet.UpdatePacketFactory import UpdatePacketFactory
from utils.constants.ObjectCodes import ObjectTypes, ObjectTypeIds, HighGuid, UpdateTypes
from utils.constants.OpCodes import OpCode
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

        if gobject_instance:
            self.state = self.gobject_instance.spawn_state
            self.location.x = self.gobject_instance.spawn_positionX
            self.location.y = self.gobject_instance.spawn_positionY
            self.location.z = self.gobject_instance.spawn_positionZ
            self.location.o = self.gobject_instance.spawn_orientation

        self.object_type.append(ObjectTypes.TYPE_GAMEOBJECT)

    def load(self):
        GridManager.add_or_get(self, True)

    # override
    def get_update_packet(self, update_type=UpdateTypes.UPDATE_FULL, is_self=True):
        if self.gobject_template and self.gobject_instance:
            # Object fields
            self.update_packet_factory.update(self.update_packet_factory.object_values, self.update_packet_factory.updated_object_fields, ObjectFields.OBJECT_FIELD_GUID, self.guid, 'Q')
            self.update_packet_factory.update(self.update_packet_factory.object_values, self.update_packet_factory.updated_object_fields, ObjectFields.OBJECT_FIELD_TYPE, self.get_object_type_value(), 'I')
            self.update_packet_factory.update(self.update_packet_factory.object_values, self.update_packet_factory.updated_object_fields, ObjectFields.OBJECT_FIELD_ENTRY, self.gobject_template.entry, 'I')
            self.update_packet_factory.update(self.update_packet_factory.object_values, self.update_packet_factory.updated_object_fields, ObjectFields.OBJECT_FIELD_SCALE_X, self.gobject_template.scale, 'f')
            self.update_packet_factory.update(self.update_packet_factory.object_values, self.update_packet_factory.updated_object_fields, ObjectFields.OBJECT_FIELD_PADDING, 0, 'I')

            # Gameobject fields
            self.update_packet_factory.update(self.update_packet_factory.gameobject_values, self.update_packet_factory.updated_gameobject_fields, GameObjectFields.GAMEOBJECT_DISPLAYID, self.gobject_template.display_id, 'I')
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
            self.gobject_template.display_id,
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

    # override
    def get_type(self):
        return ObjectTypes.TYPE_GAMEOBJECT

    # override
    def get_type_id(self):
        return ObjectTypeIds.TYPEID_GAMEOBJECT
