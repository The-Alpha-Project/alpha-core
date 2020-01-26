from struct import unpack

from utils.constants.OpCodes import *


class PacketReader(object):
    def __init__(self, data):
        size, opcode = unpack(
            '<HL', data[0:6]
        )

        self.size = size / 0x100 - 4
        self.opcode = opcode
