from utils.constants.OpCodes import *


class PacketWriter(object):
    @staticmethod
    def string_to_bytes(value):
        return value.encode('ascii') + b'\x00'

    @staticmethod
    def get_packet_header_format(opcode):
        return '!H' + 'B' * (4 if opcode == SMSG_AUTH_CHALLENGE else 2)

    @staticmethod
    def get_packet_header(opcode):
        # Packet header for SMSG_AUTH_CHALLENGE : Size: 2 bytes + Cmd: 2 bytes
        # Packet header : Size: 2 bytes + Cmd: 4 bytes
        if opcode == SMSG_AUTH_CHALLENGE:
            return 0, int(opcode % 0x100), int(opcode / 0x100), 0, 0
        else:
            return 0, int(opcode % 0x100), int(opcode / 0x100)
