import zlib
from struct import pack

from utils.Logger import Logger
from utils.constants.OpCodes import OpCode


class PacketWriter(object):
    MAX_PACKET_SIZE = 0x8000
    HEADER_SIZE = 6

    @staticmethod
    def string_to_bytes(value, encoding='latin1'):
        if value is None:
            value = ''

        try:
            return value.encode(encoding) + b'\x00'
        except UnicodeEncodeError:
            Logger.error(f'Error when trying to encode the following string: {value}')
            return b'\x00'

    @staticmethod
    def get_srp6_packet(data=b''):
        return pack('>H', len(data)) + data

    @staticmethod
    def get_packet(opcode, data=b''):
        if data is None:
            data = b''

        data = pack('<I', opcode) + data
        packet = pack('>H', len(data)) + data

        if opcode == OpCode.SMSG_UPDATE_OBJECT and len(packet) > 100:
            compressed_packet_data = zlib.compress(packet[6:])
            compressed_data = pack('<I', len(packet) - 6)
            compressed_data += compressed_packet_data
            packet = PacketWriter.get_packet(OpCode.SMSG_COMPRESSED_UPDATE_OBJECT, compressed_data)

        return packet
