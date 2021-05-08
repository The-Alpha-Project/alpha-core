from os import path
from struct import unpack

from game.world.managers.objects.mmaps.Enums import DBCValueType
from network.packet.PacketReader import PacketReader
from utils.Logger import Logger


class DBCReader(object):
    def __init__(self, filename):
        self.filename = filename
        self.file_type = ""
        self.rows = 0
        self.cols = 0
        self.rows_length = 0
        self.string_part_length = 0
        self.bytes = None
        self.load()

    def load(self):
        dbc_path = path.join(path.dirname(__file__), f'../../../../../etc/dbc/{self.filename}')
        if not path.exists(dbc_path):
            Logger.warning(f'Unable to locate mmap file {dbc_path}')
            return False
        else:
            with open(dbc_path, "rb") as dbc:
                self.bytes = dbc.read()

            self.file_type = PacketReader.read_string(self.bytes[0:4], 0).strip()
            self.rows = unpack('<I', self.bytes[4:8])[0]
            self.cols = unpack('<I', self.bytes[8:12])[0]
            self.rows_length = unpack('<I', self.bytes[12:16])[0]
            self.string_part_length = unpack('<I', self.bytes[16:20])[0]
            return True

    def read_value(self, row, col, data_type):
        tmp_offset = int(20 + row * self.rows_length + col * 4)
        length = tmp_offset + 4
        if data_type == DBCValueType.DBC_FLOAT:
            return unpack('<f', self.bytes[tmp_offset:length])[0]
        elif data_type == DBCValueType.DBC_INTEGER:
            return unpack('<I', self.bytes[tmp_offset:length])[0]
        else:
            offset = unpack('<I', self.bytes[tmp_offset:length])[0]
            return PacketReader.read_string(self.bytes[20 + self.rows * self.rows_length + offset:], 0).strip()
