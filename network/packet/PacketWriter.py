from struct import calcsize

from utils.constants.OpCodes import *


class PacketWriter(object):
    @staticmethod
    def string_to_bytes(value):
        return value.encode('ascii') + b'\x00'

    @staticmethod
    def get_packet_header_format(opcode):
        return '!' + 'B' * (4 if opcode == OpCode.SMSG_AUTH_CHALLENGE else 6)

    @staticmethod
    def get_packet_header(opcode, fmt):
        # Packet header for SMSG_AUTH_CHALLENGE : Size: 2 bytes + Cmd: 2 bytes
        # Packet header : Size: 2 bytes + Cmd: 4 bytes
        size = calcsize(fmt) - 2
        if opcode == OpCode.SMSG_AUTH_CHALLENGE:
            return int(size / 0x100), int(size % 0x100), int(opcode.value % 0x100), int(opcode.value / 0x100)
        else:
            return int(size / 0x100), int(size % 0x100), int(opcode.value % 0x100), int(opcode.value / 0x100), 0, 0
