from struct import unpack

from utils.constants.OpCodes import *


class PacketReader(object):
    def __init__(self, data):
        if len(data) > 5:
            size, opcode = unpack(
                '<HL', data[0:6]
            )

            self.size = (size / 0x100) - 4
            self.opcode = opcode
            self.data = data[6:]
        else:
            self.size = 0
            self.opcode = 0
            self.data = []

    @staticmethod
    def read_string(packet, start, terminator='\x00'):
        char_list = []
        for ci in packet[start:]:
            cc = chr(ci)
            if cc == terminator:
                break
            char_list.append(cc)
        return ''.join(char_list)
