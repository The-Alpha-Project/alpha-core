import os
from io import BytesIO
from struct import unpack
from utils.Logger import Logger
from tools.extractors.pympqlib.MpqHash import MpqHash
from tools.extractors.pympqlib.MpqEntry import MpqEntry
from tools.extractors.pympqlib.MpqHeader import MpqHeader
from tools.extractors.pympqlib.MpqReader import MpqReader


class MpqArchive:
    def __init__(self, filename):
        self.filename = filename
        self.name = os.path.basename(filename).capitalize()
        self.storm_buffer = list()
        self.header = None
        self.block_size = 0
        self.stream = None
        self.mpq_hashes = []
        self.mpq_entries = []

    def __enter__(self):
        self.initialize()
        return self

    def __exit__(self, exc_type, exc_value, traceback):
        self.data = None
        if self.stream:
            self.stream.close()
        if self.storm_buffer:
            self.storm_buffer.clear()
        self.mpq_entries.clear()
        self.mpq_hashes.clear()

    def initialize(self):
        if not os.path.exists(self.filename):
            return False
        self.build_storm_buffer()
        self.stream = open(self.filename, 'rb')
        self.header = MpqHeader.from_stream(self.stream)
        self.block_size = 0x200 << self.header.block_size
        self.stream.seek(self.header.hash_table_pos)
        hash_data = self.stream.read(self.header.hash_table_size * MpqHash.SIZE)
        decrypted_data = self.decrypt_block_from_bytes(hash_data, self.hash_string('(hash table)', 0x300))
        self.build_mpq_hashes(decrypted_data)
        self.stream.seek(self.header.block_table_pos)
        entries_data = self.stream.read(self.header.block_table_size * MpqEntry.SIZE)
        decrypted_data = self.decrypt_block_from_bytes(entries_data, self.hash_string('(block table)', 0x300))
        self.build_mpq_entries(decrypted_data)
        self.add_list_filenames()

    def add_list_filenames(self):
        hash_entry = self._add_filename('(listfile)')
        if not hash_entry:
            return False

        mpq_entry: MpqEntry = self.mpq_entries[hash_entry.block_index]
        if not mpq_entry:
            return

        if not mpq_entry.is_encrypted():
            return False

        if not mpq_entry.encryption_seed:
            return False

        decrypted_data = self.decrypt_block_from_list(mpq_entry.block_positions, mpq_entry.encryption_seed - 1)

        if decrypted_data[0] != mpq_entry.block_position_size:
            return False

        if decrypted_data[1] > mpq_entry.block_position_size + self.block_size:
            return False

        with MpqReader(self, mpq_entry) as mpq_reader:
            i = 0
            total = len(self.mpq_entries)
            while not mpq_reader.end_of_stream():
                i += 1
                #Logger.progress(f'{self.name} processing (listfile) ...', i, total, divisions=1)
                filename = mpq_reader.read_line()
                hash_entry = self._try_get_hash_entry(filename)
                if hash_entry:
                    self.mpq_entries[hash_entry.block_index].set_filename(filename)
            #Logger.progress(f'{self.name} processing (listfile) ...', total, total, divisions=1)

        return True

    def find_file(self, name):
        for entry in self.mpq_entries:
            if entry.filename.lower() != name.lower():
                continue
            return entry
        return None

    def read_file_bytes(self, mpq_entry=None):
        mpq_entry = mpq_entry if mpq_entry else max(self.mpq_entries, key=lambda x: x.file_size)
        if not mpq_entry:
            raise ValueError(f'Unable to locate valid mpq entry inside {self.filename}')

        with MpqReader(self, mpq_entry) as mpq_reader:
            return mpq_reader.data

    def _add_filename(self, filename):
        hash_entry = self._try_get_hash_entry(filename)
        if not hash_entry or not filename:
            return None

        self.mpq_entries[hash_entry.block_index].set_filename(filename)
        return hash_entry

    def _try_get_hash_entry(self, filename):
        index = self.hash_string(filename, 0)
        index &= self.header.hash_table_size - 1
        name1 = self.hash_string(filename, 0x100)
        name2 = self.hash_string(filename, 0x200)

        for i in range(len(self.mpq_hashes)):
            if self.mpq_hashes[i].name_1 == name1 and self.mpq_hashes[i].name_2 == name2:
                return self.mpq_hashes[i]

        for i in range(index):
            if self.mpq_hashes[i].name_1 == name1 and self.mpq_hashes[i].name_2 == name2:
                return self.mpq_hashes[i]

        return None

    def detect_file_seed(self, value0, value1, decrypted):
        temp = ((value0 ^ decrypted) - 0xeeeeeeee) & 0xffffffff
        for i in range(0x100):
            seed1 = (temp - self.storm_buffer[0x400 + i]) & 0xffffffff
            seed2 = (0xeeeeeeee + self.storm_buffer[0x400 + (seed1 & 0xff)]) & 0xffffffff
            result = (value0 ^ (seed1 + seed2)) & 0xffffffff

            if result != decrypted:
                continue

            tmp_seed1 = seed1
            seed1 = (((~seed1 << 21) + 0x11111111) | (seed1 >> 11)) & 0xffffffff
            seed2 = (result + seed2 + (seed2 << 5) + 3) & 0xffffffff
            seed2 += (self.storm_buffer[0x400 + (seed1 & 0xff)]) & 0xffffffff
            result = (value1 ^ (seed1 + seed2)) & 0xffffffff

            if (result & 0xfffc0000) == 0:
                return tmp_seed1

        return 0

    def build_mpq_hashes(self, data):
        with BytesIO(data) as stream:
            for i in range(0, self.header.hash_table_size):
                self.mpq_hashes.append(MpqHash.from_data(stream))

    def build_mpq_entries(self, data):
        with BytesIO(data) as stream:
            for i in range(0, self.header.block_table_size):
                mpq_entry = MpqEntry.from_data(self, stream)
                self.mpq_entries.append(mpq_entry)
                # Logger.progress(f'{self.name} reading mpq entries ...', i + 1, self.header.block_table_size, divisions=1)

    def build_storm_buffer(self):
        seed = 0x100001
        result = [0 for _ in range(0x500)]
        for index1 in range(0, 0x100):
            index2 = index1
            for i in range(0, 5):
                seed = divmod(seed * 125 + 3, 0x2aaaab)[1]
                temp = (seed & 0xffff) << 16
                seed = divmod(seed * 125 + 3, 0x2aaaab)[1]
                result[index2] = temp | (seed & 0xffff)
                index2 += 0x100
        self.storm_buffer = result

    def hash_string(self, text, offset):
        seed1 = 0x7fed7fed
        seed2 = 0xeeeeeeee

        for c in text:
            val = ord(c.upper())
            seed1 = self.storm_buffer[offset + val] ^ (seed1 + seed2) & 0xffffffff
            seed2 = (val + seed1 + seed2 + (seed2 << 5) + 3) & 0xffffffff
        return seed1

    def decrypt_block_from_list(self, data, seed_1):
        seed_2 = 0xeeeeeeee
        for i in range(0, len(data)):
            seed_2 += self.storm_buffer[(0x400 + (seed_1 & 0xff))] & 0xffffffff
            result = data[i]
            result ^= (seed_1 + seed_2) & 0xffffffff
            seed_1 = (((~seed_1 << 21) + 0x11111111) | (seed_1 >> 11)) & 0xffffffff
            seed_2 = (result + seed_2 + (seed_2 << 5) + 3) & 0xffffffff
            data[i] = result
        return data

    def decrypt_block_from_bytes(self, data, seed_1):
        seed_2 = 0xeeeeeeee
        data: bytearray = bytearray(data)
        for i in range(0, len(data) - 3, 4):
            seed_2 = self.storm_buffer[(0x400 + (seed_1 & 0xff))] + seed_2 & 0xffffffff
            result = unpack('<I', data[i:i + 4])[0]
            result ^= (seed_1 + seed_2) & 0xffffffff
            seed_1 = (((~seed_1 << 21) + 0x11111111) | (seed_1 >> 11)) & 0xffffffff
            seed_2 = (result + seed_2 + (seed_2 << 5) + 3) & 0xffffffff

            data[i + 0] = result & 0xff
            data[i + 1] = (result >> 8) & 0xff
            data[i + 2] = (result >> 16) & 0xff
            data[i + 3] = (result >> 24) & 0xff
        return bytes(data)
