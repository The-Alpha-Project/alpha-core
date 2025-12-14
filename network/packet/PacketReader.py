from struct import unpack

from utils.constants.OpCodes import OpCode


class PacketReader:
    def __init__(self, data):
        if len(data) > 5:
            self.size = unpack('>H', data[:2])[0] - 4  # Big Endian
            self.opcode = unpack('<I', data[2:6])[0]
            self.data = data[6:]
        else:
            self.size = 0
            self.opcode = 0
            self.data = bytearray()

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
