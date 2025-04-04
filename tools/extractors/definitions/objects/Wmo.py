from tools.extractors.definitions.objects.WmoGroupFile import WmoGroupFile
from tools.extractors.definitions.reader.BinaryReader import BinaryReader


class Wmo:
    def __init__(self, mpq_entry):
        self.mpq_entry = mpq_entry
        self.vertices = []
        self.indices = []
        self.has_geometry = False
        self._read()

    def _read(self):
        data = self.mpq_entry.read_file_bytes()

        self.reader = BinaryReader(data)
        with self.reader as reader:
            mver_loc = reader.get_chunk_location('MVER')
            if mver_loc == -1:
                raise ValueError('MVER_NOT_FOUND.')

            reader.seek(mver_loc + 8)
            version = reader.read_int()
            if version != 14:
                raise ValueError('UNSUPPORTED_ALPHA_WMO_VERSION.')

            momo_loc = reader.get_chunk_location('MOMO')
            if momo_loc == -1:
                raise ValueError('MOMO_NOT_FOUND.')

            mohd_loc = reader.get_chunk_location('MOHD')
            if mohd_loc == -1:
                raise ValueError('MOHD_NOT_FOUND.')

            reader.seek(mohd_loc + 8)

            mohd = MOHD.from_reader(reader)
            group_files = []

            for group_file in range (0, mohd.wmo_group_files_count):
                group_files.append(WmoGroupFile.from_reader(reader, reader.tell()))

            mods_loc = reader.get_chunk_location('MODS', mohd_loc)
            if mods_loc == -1:
                raise ValueError('MODS_NOT_FOUND.')

            modn_loc = reader.get_chunk_location('MODN', mods_loc)
            if modn_loc == -1:
                raise ValueError('MODN_NOT_FOUND.')

            modd_loc = reader.get_chunk_location('MODD', modn_loc)
            if modd_loc == -1:
                raise ValueError('MODD_NOT_FOUND.')