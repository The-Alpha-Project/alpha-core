from struct import pack, calcsize

from utils.constants.OpCodes import *


class PacketWriter(object):
    @staticmethod
    def string_to_bytes(value):
        return value.encode('ascii') + b'\x00'

    @staticmethod
    def get_packet(opcode, data=b''):
        # Packet header for SMSG_AUTH_CHALLENGE : Size: 2 bytes + Cmd: 2 bytes
        # Packet header : Size: 2 bytes + Cmd: 4 bytes
        size = (4 if opcode == OpCode.SMSG_AUTH_CHALLENGE else 6) + len(data) - 2
        base_header = pack('4B',
                           int(size / 0x100),
                           int(size % 0x100),
                           int(opcode.value % 0x100),
                           int(opcode.value / 0x100))
        if opcode == OpCode.SMSG_AUTH_CHALLENGE:
            return base_header + data
        else:
            return base_header + pack('!BB', 0, 0) + data
