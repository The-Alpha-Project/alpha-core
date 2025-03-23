from struct import unpack


class MpqHeader:
    SIZE = 32
    MPQ_ID = 441536589  # 0x1A51504D

    def __init__(self):
        self.id = 0  # Should be 0x1a51504d
        self.data_offset = 0
        self.size = 0
        self.version = 0
        self.block_size = 0
        self.hash_table_pos = 0
        self.block_table_pos = 0
        self.hash_table_size = 0
        self.block_table_size = 0

    @staticmethod
    def from_stream(stream):
        header = MpqHeader()
        header.id = unpack('<I', stream.read(4))[0]
        header.data_offset = unpack('<I', stream.read(4))[0]
        header.size = unpack('<I', stream.read(4))[0]
        header.version = unpack('<H', stream.read(2))[0]
        header.block_size = unpack('<H', stream.read(2))[0]
        header.hash_table_pos = unpack('<I', stream.read(4))[0]
        header.block_table_pos = unpack('<I', stream.read(4))[0]
        header.hash_table_size = unpack('<I', stream.read(4))[0]
        header.block_table_size = unpack('<I', stream.read(4))[0]
        return header
