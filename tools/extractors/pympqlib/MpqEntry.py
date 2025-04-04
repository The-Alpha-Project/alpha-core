import os
from io import BytesIO
from struct import unpack
from tools.extractors.pympqlib.MpqFlags import MpqFlags


class MpqEntry:
    SIZE = 16

    def __init__(self, mpq_archive):
        self.mpq_archive = mpq_archive
        self.compressed_size = 0
        self.file_size = 0
        self.flags = 0
        self.block_positions = []
        self.block_position_size = 0
        self.encryption_seed = 0
        self._file_offset = 0
        self.file_pos = 0
        self.filename = ''
        self.file_path = ''

    def set_filename(self, filename):
        self.filename = filename
        self.encryption_seed = self.calculate_encryption_seed()
        n_path = os.path.normpath(filename)
        n_path = n_path.replace('\\', '/')
        self.file_path = n_path
        self.filename = os.path.basename(n_path)

    def is_encrypted(self):
        return self.flags & MpqFlags.Encrypted

    def is_compressed(self):
        return self.flags & MpqFlags.Compressed

    def is_compressed_multi(self):
        return self.flags & MpqFlags.CompressedMulti

    def is_single_unit(self):
        return self.flags & MpqFlags.SingleUnit

    def calculate_encryption_seed(self):
        if not self.filename:
            return 0
        seed = self.mpq_archive.hash_string(self.filename, 0x300)
        if self.flags & MpqFlags.BlockOffsetAdjustedKey:
            seed = ((seed + self._file_offset) ^ self.file_size) & 0xffffffff
        return seed

    def fill_block_information(self):
        block_pos_count = int(((self.file_size + self.mpq_archive.block_size - 1) / self.mpq_archive.block_size) + 1)
        self.block_positions = [0 for x in range(block_pos_count)]
        self.mpq_archive.stream.seek(self.file_pos)
        for j in range(block_pos_count):
            self.block_positions[j] = unpack('<I', self.mpq_archive.stream.read(4))[0]
        self.block_position_size = int(block_pos_count) * 4

    @staticmethod
    def from_data(mpq_archive, stream: BytesIO):
        entry = MpqEntry(mpq_archive)
        entry._file_offset = unpack('<I', stream.read(4))[0]
        entry.file_pos = entry._file_offset
        entry.compressed_size = unpack('<I', stream.read(4))[0]
        entry.file_size = unpack('<I', stream.read(4))[0]
        entry.flags = unpack('<I', stream.read(4))[0]
        entry.encryption_seed = 0
        entry.fill_block_information()
        return entry
