from struct import unpack

from utils.constants.OpCodes import OpCode


class PacketReader:
    __slots__ = ('size', 'opcode', '_data', '_packet_len_cache', '_validated_opcode_length_rule')

    def __init__(self, data):
        if len(data) > 5:
            self.size = unpack('>H', data[:2])[0] - 4  # Big Endian
            self.opcode = unpack('<I', data[2:6])[0]
            payload = data[6:]
        else:
            self.size = 0
            self.opcode = 0
            payload = bytearray()

        self._packet_len_cache = None
        self._validated_opcode_length_rule = None
        self._data = b''
        self.data = payload

    @property
    def data(self):
        return self._data

    @data.setter
    def data(self, value):
        self._data = value
        # Length-related caches depend on payload bytes.
        self._packet_len_cache = None
        self._validated_opcode_length_rule = None

    def opcode_str(self):
        return OpCode(self.opcode).name

    @staticmethod
    def read_string_from_stream(stream, terminator='\x00'):
        tmp_string = ''
        tmp_char = chr(unpack('<B', stream.read(1))[0])
        while tmp_char != terminator:
            tmp_string += tmp_char
            tmp_char = chr(unpack('<B', stream.read(1))[0])

        return tmp_string

    @staticmethod
    def read_string(packet, start, terminator='\x00'):
        char_list = []
        chars = 0
        for ci in packet[start:]:
            cc = chr(ci)
            if cc == terminator:
                break
            char_list.append(cc)
            chars += 1
        return ''.join(char_list)
