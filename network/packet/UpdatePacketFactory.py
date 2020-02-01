from struct import pack, unpack
import zlib

from utils.constants.UpdateFields import *
from utils.constants.ObjectCodes import *


class UpdatePacketFactory(object):
    def __init__(self, types_list=()):
        self.types_list = types_list

        self.object_values = []
        self.item_values = []
        self.container_values = []
        self.unit_values = []
        self.player_values = []
        self.gameobject_values = []
        self.dynamic_object_values = []
        self.init_lists()

        self.update_packet = b''

    def update(self, values_list, pos, value, value_type):
        if value_type.lower() == 'q':
            self.update(values_list, pos, int(value & 0xFFFFFFFF), 'I')
            self.update(values_list, pos + 1, int(value >> 32), 'I')
        else:
            values_list[pos] = pack('<%s' % value_type, value)

    def init_lists(self):
        self.object_values = [pack('<I', 0)] * ObjectFields.OBJECT_END.value
        self.item_values = [pack('<I', 0)] * ItemFields.ITEM_END.value
        self.container_values = [pack('<I', 0)] * ContainerFields.CONTAINER_END.value
        self.unit_values = [pack('<I', 0)] * UnitFields.UNIT_END.value
        self.player_values = [pack('<I', 0)] * PlayerFields.PLAYER_END.value
        self.gameobject_values = [pack('<I', 0)] * GameObjectFields.GAMEOBJECT_END.value
        self.dynamic_object_values = [pack('<I', 0)] * DynamicObjectFields.DYNAMICOBJECT_END.value

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
