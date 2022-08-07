import zlib
from struct import pack

from utils.constants.OpCodes import *


class PacketWriter(object):
    MAX_PACKET_SIZE = 0x8000

    @staticmethod
    def string_to_bytes(value):
        if value is None:
            value = ''
        return value.encode('latin1') + b'\x00'

    @staticmethod
    def get_packet(opcode, data=b''):
        if data is None:
            data = b''

        # Packet header for SMSG_AUTH_CHALLENGE : Size: 2 bytes + Cmd: 2 bytes
        # Packet header : Size: 2 bytes + Cmd: 4 bytes
        size = (4 if opcode == OpCode.SMSG_AUTH_CHALLENGE else 6) + len(data) - 2
        base_header = pack('<4B',
                           int(size / 0x100),
                           int(size % 0x100),
                           int(opcode % 0x100),
                           int(opcode / 0x100))
        if opcode == OpCode.SMSG_AUTH_CHALLENGE:
            return base_header + data
        else:
            return base_header + pack('<BB', 0, 0) + data

    @staticmethod
    def deflate(data):
        return zlib.compress(data)
