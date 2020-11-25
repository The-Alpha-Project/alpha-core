from struct import pack, unpack
from bitarray import bitarray

from network.packet.update.UpdateMask import UpdateMask
from utils.constants.OpCodes import OpCode
from utils.constants.UpdateFields import *
from utils.constants.ObjectCodes import *
from network.packet.PacketWriter import PacketWriter


class UpdatePacketFactory(object):
    def __init__(self):
        self.fields_size = 0
        self.update_values = []
        self.update_mask = UpdateMask()

    def init_values(self, fields_size):
        self.fields_size = fields_size
        self.update_values = [None] * self.fields_size
        self.update_mask.set_count(self.fields_size)

    def reset(self):
        self.update_values = [None] * self.fields_size
        self.update_mask.clear()

    def update(self, index, value, value_type):
        if value_type.lower() == 'q':
            self.update(index, int(value & 0xFFFFFFFF), 'I')
            self.update(index + 1, int(value >> 32), 'I')
        else:
            self.update_values[index] = pack('<%s' % value_type, value)
            self.update_mask.set_bit(index)

    @staticmethod
    def compress_if_needed(update_packet):
        if len(update_packet) > 100:
            compressed_packet_data = PacketWriter.deflate(update_packet[6:])
            compressed_data = pack('<I', len(update_packet) - 6)
            compressed_data += compressed_packet_data
            update_packet = PacketWriter.get_packet(OpCode.SMSG_COMPRESSED_UPDATE_OBJECT, compressed_data)
        return update_packet
