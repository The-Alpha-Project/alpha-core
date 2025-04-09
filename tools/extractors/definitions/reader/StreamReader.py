from io import BytesIO
from struct import unpack


class StreamReader:
    def __init__(self, data_source):
        if not isinstance(data_source, BytesIO):
            data_source = BytesIO(data_source)
        self.stream = data_source

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        self.close()

    def close(self):
        if self.stream:
            self.stream.close()
        self.stream = None

    def read_chunk_information(self, expected_token, skip=0, seek=0):
        if seek:
            self.set_position(seek)
        if skip:
            self.move_forward(skip)
        token = self.read_bytes(4)
        token_name = token.decode('utf8')[::-1]

        if token_name != expected_token:
            self.move_backwards(4)
            return f'Found token {token_name} expected {expected_token}', token_name, 0

        size = self.read_int32()
        return '', token_name, size

    def set_position(self, position):
        self.stream.seek(position)

    def get_position(self, skip=0):
        if skip:
            self.move_forward(skip)
        return self.stream.tell()

    def move_forward(self, length):
        self.stream.seek(self.get_position() + length)

    def move_backwards(self, length):
        self.stream.seek(self.get_position() - length)

    def read_bytes(self, length, seek=0, skip=0):
        if seek:
            self.set_position(seek)
        if skip:
            self.move_forward(skip)

        return self.stream.read(length)

    def read_int8(self, seek=0, skip=0):
        if seek:
            self.set_position(seek)
        if skip:
            self.move_forward(skip)

        return unpack('<B', self.stream.read(1))[0]

    def read_uint8(self, seek=0, skip=0):
        if seek:
            self.set_position(seek)
        if skip:
            self.move_forward(skip)

        return unpack('<b', self.stream.read(1))[0]

    def read_uint16(self, seek=0, skip=0):
        if seek:
            self.set_position(seek)
        if skip:
            self.move_forward(skip)

        return unpack('<H', self.stream.read(2))[0]

    def read_int32(self, seek=0, skip=0):
        if seek:
            self.set_position(seek)
        if skip:
            self.move_forward(skip)

        return unpack('<I', self.stream.read(4))[0]

    def read_uint32(self, seek=0, skip=0):
        if seek:
            self.set_position(seek)
        if skip:
            self.move_forward(skip)

        return unpack('<i', self.stream.read(4))[0]

    def read_float(self, seek=0, skip=0):
        if seek:
            self.set_position(seek)
        if skip:
            self.move_forward(skip)

        return unpack('<f', self.stream.read(4))[0]

    def read_string(self, terminator='\x00'):
        tmp_string = ''
        tmp_char = chr(unpack('<B', self.stream.read(1))[0])
        while tmp_char != terminator:
            tmp_string += tmp_char
            tmp_char = chr(unpack('<B', self.stream.read(1))[0])

        return tmp_string
