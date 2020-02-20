from struct import pack, unpack
from bitarray import bitarray

from utils.constants.OpCodes import OpCode
from utils.constants.UpdateFields import *
from utils.constants.ObjectCodes import *
from network.packet.PacketWriter import PacketWriter


class UpdatePacketFactory(object):
    def __init__(self, types_list=()):
        self.types_list = types_list

        self.object_values = []
        self.updated_object_fields = bitarray(ObjectFields.OBJECT_END.value)

        self.item_values = []
        self.updated_item_fields = bitarray(ItemFields.ITEM_END.value)

        self.container_values = []
        self.updated_container_fields = bitarray(ContainerFields.CONTAINER_END.value)

        self.unit_values = []
        self.updated_unit_fields = bitarray(UnitFields.UNIT_END.value)

        self.player_values = []
        self.updated_player_fields = bitarray(PlayerFields.PLAYER_END.value)

        self.gameobject_values = []
        self.updated_gameobject_fields = bitarray(GameObjectFields.GAMEOBJECT_END.value)

        self.dynamic_object_values = []
        self.updated_dynamic_object_fields = bitarray(DynamicObjectFields.DYNAMICOBJECT_END.value)

        self.init_lists()

        self.update_packet = b''

    def update(self, values_list, updated_fields_list, pos, value, value_type):
        if value_type.lower() == 'q':
            self.update(values_list, updated_fields_list, pos, int(value & 0xFFFFFFFF), 'I')
            self.update(values_list, updated_fields_list, pos + 1, int(value >> 32), 'I')
        else:
            values_list[pos] = pack('<%s' % value_type, value)
            updated_fields_list[pos] = 1

    def init_lists(self):
        self.object_values = [pack('<I', 0)] * ObjectFields.OBJECT_END.value
        self.updated_object_fields.setall(0)

        self.item_values = [pack('<I', 0)] * ItemFields.ITEM_END.value
        self.updated_item_fields.setall(0)

        self.container_values = [pack('<I', 0)] * ContainerFields.CONTAINER_END.value
        self.updated_container_fields.setall(0)

        self.unit_values = [pack('<I', 0)] * UnitFields.UNIT_END.value
        self.updated_unit_fields.setall(0)

        self.player_values = [pack('<I', 0)] * PlayerFields.PLAYER_END.value
        self.updated_player_fields.setall(0)

        self.gameobject_values = [pack('<I', 0)] * GameObjectFields.GAMEOBJECT_END.value
        self.updated_gameobject_fields.setall(0)

        self.dynamic_object_values = [pack('<I', 0)] * DynamicObjectFields.DYNAMICOBJECT_END.value
        self.updated_player_fields.setall(0)

    def get_updated_fields_mask(self):
        updated_fields_mask = b''

        if ObjectTypes.TYPE_OBJECT.value in self.types_list:
            updated_fields_mask += self.updated_object_fields.tobytes()
        if ObjectTypes.TYPE_UNIT.value in self.types_list:
            updated_fields_mask += self.updated_unit_fields.tobytes()
        if ObjectTypes.TYPE_PLAYER.value in self.types_list:
            updated_fields_mask += self.updated_player_fields.tobytes()
        if ObjectTypes.TYPE_ITEM.value in self.types_list:
            updated_fields_mask += self.updated_item_fields.tobytes()
        if ObjectTypes.TYPE_CONTAINER.value in self.types_list:
            updated_fields_mask += self.updated_container_fields.tobytes()
        if ObjectTypes.TYPE_GAMEOBJECT.value in self.types_list:
            updated_fields_mask += self.updated_gameobject_fields.tobytes()
        if ObjectTypes.TYPE_DYNAMICOBJECT.value in self.types_list:
            updated_fields_mask += self.updated_dynamic_object_fields.tobytes()

        return updated_fields_mask

    def build_packet(self):
        self.update_packet = b''

        if ObjectTypes.TYPE_OBJECT.value in self.types_list:
            self.update_packet += b''.join(self.object_values)
        if ObjectTypes.TYPE_UNIT.value in self.types_list:
            self.update_packet += b''.join(self.unit_values)
        if ObjectTypes.TYPE_PLAYER.value in self.types_list:
            self.update_packet += b''.join(self.player_values)
        if ObjectTypes.TYPE_ITEM.value in self.types_list:
            self.update_packet += b''.join(self.item_values)
        if ObjectTypes.TYPE_CONTAINER.value in self.types_list:
            self.update_packet += b''.join(self.container_values)
        if ObjectTypes.TYPE_GAMEOBJECT.value in self.types_list:
            self.update_packet += b''.join(self.gameobject_values)
        if ObjectTypes.TYPE_DYNAMICOBJECT.value in self.types_list:
            self.update_packet += b''.join(self.dynamic_object_values)

        self.init_lists()
        return self.update_packet

    @staticmethod
    def compress_if_needed(update_packet):
        if len(update_packet) > 100:
            compressed_packet_data = PacketWriter.deflate(update_packet[6:])
            compressed_data = pack('<I', len(update_packet) - 6)
            compressed_data += compressed_packet_data
            update_packet = PacketWriter.get_packet(OpCode.SMSG_COMPRESSED_UPDATE_OBJECT, compressed_data)
        return update_packet
