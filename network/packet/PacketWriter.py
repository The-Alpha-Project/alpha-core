import zlib
from struct import pack

from utils.Logger import Logger


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
    def get_packet(opcode, data=b''):
        if data is None:
            data = b''

        data = pack('<I', opcode) + data
        return pack('>H', len(data)) + data

    @staticmethod
    def deflate(data):
        return zlib.compress(data)
