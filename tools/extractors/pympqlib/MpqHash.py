from io import BytesIO
from struct import unpack


class MpqHash:
    SIZE = 16

    def __init__(self):
        self.name_1 = 0
        self.name_2 = 0
        self.locale = 0
        self.block_index = 0

    @staticmethod
    def from_data(stream: BytesIO):
        mpq_hash = MpqHash()
        mpq_hash.name_1 = unpack('<I', stream.read(4))[0]
        mpq_hash.name_2 = unpack('<I', stream.read(4))[0]
        mpq_hash.locale = unpack('<I', stream.read(4))[0]
        mpq_hash.block_index = unpack('<I', stream.read(4))[0]
        return mpq_hash
