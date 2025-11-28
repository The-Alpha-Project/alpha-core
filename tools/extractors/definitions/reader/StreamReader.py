from io import BytesIO
from struct import unpack


class StreamReader:
    def __init__(self, data_source):
        if not isinstance(data_source, BytesIO):
            data_source = BytesIO(data_source)
        self.eof = data_source.getbuffer().nbytes
        self.stream = data_source

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        self.close()

    def close(self):
        if self.stream:
            self.stream.close()
        self.stream = None

    def is_eof(self):
        return self.get_position() >= self.eof

    def read_chunk_information(self, expected_token=None, skip=0, seek=0, backwards=True, expected_tokens=None):
        if seek:
            self.set_position(seek)
        if skip:
            self.move_forward(skip)
        token = self.read_bytes(4)
        token_name = token.decode('utf8')[::-1] if backwards else token.decode('utf8')

        if (expected_token and token_name != expected_token) or (expected_tokens and token_name not in expected_tokens):
            self.move_backwards(4)
            return f'Found token "{token_name}", expected "{expected_token}"', token_name, 0

        size = self.read_int32()
        return '', token_name, size

    def assert_token(self, expected_token):
        token = self.read_bytes(4)
        token_name = token.decode('utf8').strip()
        if token_name != expected_token:
            raise ValueError(f'Invalid token, expected {expected_token}, got {token_name}')

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

        return unpack('<b', self.stream.read(1))[0]

    def read_uint8(self, seek=0, skip=0):
        if seek:
            self.set_position(seek)
        if skip:
            self.move_forward(skip)

        return unpack('<B', self.stream.read(1))[0]

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

    def read_string(self, terminator=b'\x00'):
        buffer = BytesIO()
        while True:
            chunk = self.stream.read(64)
            if not chunk:
                # EOF reached without terminator.
                break
            try:
                # Find the terminator within the chunk.
                null_pos = chunk.index(terminator)
                buffer.write(chunk[:null_pos])
                # Move the underlying stream position to just after the terminator.
                self.stream.seek(self.get_position() - len(chunk) + null_pos + len(terminator))
                break
            except ValueError:
                # Terminator not found in this chunk, write the whole chunk and continue.
                buffer.write(chunk)

        return buffer.getvalue().decode('utf8')
