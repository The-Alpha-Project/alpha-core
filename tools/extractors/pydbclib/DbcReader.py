import os
from io import BytesIO
from struct import unpack
from typing import Optional
from utils.Logger import Logger
from tools.extractors.pydbclib.structs.DbcHeader import DbcHeader


class DbcReader:
    def __init__(self, filename=None, buffer=None):
        self.filename = filename
        self.buffer = buffer
        self.reader = None
        self.header: Optional[DbcHeader] = None

    def __enter__(self):
        self.initialize()
        return self

    def __exit__(self, exc_type, exc_value, traceback):
        if self.reader:
            self.reader.close()

    def initialize(self):
        if not self.buffer and not os.path.exists(self.filename):
            return False
        self.reader = open(self.filename, 'rb') if self.filename else BytesIO(self.buffer)
        self.header = DbcHeader.from_bytes(self.reader)

    def get_position(self):
        return self.reader.tell()

    def set_position(self, position):
        self.reader.seek(position)

    def move_forward(self, length):
        self.reader.seek(self.get_position() + length)

    def read_records_by_type(self, object_type):
        records = []
        file_name = f'{object_type.__name__}.dbc'
        total = self.header.record_count
        for r in range(total):
            begin = self.reader.tell()
            records.append(self.read(object_type))
            # Make sure we move pointer to next record in case not everything was parsed.
            self.reader.seek(begin + self.header.record_size)
            Logger.progress(f'{file_name} reading entries...', r + 1, total, divisions=1)
        return records

    def read(self, object_type):
        return object_type.from_bytes(self)

    def read_int(self):
        return unpack('<I', self.reader.read(4))[0]

    def read_float(self):
        return unpack('<f', self.reader.read(4))[0]

    def read_string(self, terminator='\x00'):
        string_offset = unpack('<I', self.reader.read(4))[0]
        current_pos = self.reader.tell()
        string_start = self.header.record_count * self.header.record_size + 20 + string_offset
        self.reader.seek(string_start)
        value = self._read_string(terminator=terminator)
        self.reader.seek(current_pos)
        return value

    def _read_string(self, terminator='\x00'):
        tmp_string = ''
        tmp_char = chr(unpack('<B', self.reader.read(1))[0])
        while tmp_char != terminator:
            tmp_string += tmp_char
            tmp_char = chr(unpack('<B', self.reader.read(1))[0])

        return tmp_string
