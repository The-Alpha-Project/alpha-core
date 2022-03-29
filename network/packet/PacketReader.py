from struct import unpack


class PacketReader(object):
    def __init__(self, data):
        if len(data) > 5:
            self.size = unpack('>H', data[:2])[0] - 4  # Big Endian
            self.opcode = unpack('<I', data[2:6])[0]
            self.data = data[6:]
        else:
            self.size = 0
            self.opcode = 0
            self.data = bytearray()

    @staticmethod
    def read_string(packet, start, terminator='\x00'):
        char_list = []
        for ci in packet[start:]:
            cc = chr(ci)
            if cc == terminator:
                break
            char_list.append(cc)
        return ''.join(char_list)
