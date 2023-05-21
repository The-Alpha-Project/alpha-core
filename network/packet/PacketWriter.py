import zlib
from struct import pack


class PacketWriter(object):
    MAX_PACKET_SIZE = 0x8000
    HEADER_SIZE = 6

    @staticmethod
    def string_to_bytes(value):
        if value is None:
            value = ''
        return value.encode('latin1') + b'\x00'

    @staticmethod
    def get_packet(opcode, data=b''):
        if data is None:
            data = b''

        data = pack('<I', opcode) + data
        return pack('>H', len(data)) + data

    @staticmethod
    def deflate(data):
        return zlib.compress(data)
