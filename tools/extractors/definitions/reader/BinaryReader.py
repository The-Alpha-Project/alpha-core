import encodings
from io import BytesIO
from struct import unpack


class BinaryReader(BytesIO):
    def __init__(self, data):
        super().__init__(data)

    def get_chunk_location(self, token_name, offset=0):
        with self.getbuffer() as buffer:
            buf_len = buffer.nbytes
            for i in range(offset, buf_len):
                if i + 4 > buf_len:
                    return -1

                chunk = buffer[i:i + 4].tobytes()
                if (self.validate_chunk_char(chunk[0]) and self.validate_chunk_char(chunk[1])
                        and self.validate_chunk_char(chunk[2]) and self.validate_chunk_char(chunk[3])):
                    if encodings.utf_8.decode(chunk)[0][::-1] == token_name:
                        return i
        return -1

    def validate_chunk_char(self, byte):
        c = chr(byte)
        return ('A' <= c <= 'Z') or c == '2'

    def read_token(self):
        tmp_string = ''
        for i in range(4):
            tmp_string += self.read_char()
        return tmp_string

    def read_byte(self):
        return unpack('<B', self.read(1))[0]

    def read_char(self):
        return chr(unpack('<B', self.read(1))[0])

    def read_short(self):
        return unpack('<H', self.read(2))[0]

    def read_ushort(self):
        return unpack('<h', self.read(2))[0]

    def read_int(self):
        return unpack('<I', self.read(4))[0]

    def read_uint(self):
        return unpack('<i', self.read(4))[0]

    def read_float(self):
        return unpack('<f', self.read(4))[0]

    def read_string(self, terminator='\x00'):
        tmp_string = ''
        tmp_char = chr(unpack('<B', self.read(1))[0])
        while tmp_char != terminator:
            tmp_string += tmp_char
            tmp_char = chr(unpack('<B', self.read(1))[0])

        return tmp_string