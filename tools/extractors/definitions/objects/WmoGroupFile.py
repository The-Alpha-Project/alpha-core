from tools.extractors.definitions.reader.BinaryReader import BinaryReader


class WmoGroupFile:
    def __init__(self):
        self.flags = 0
        self.mopy = None
        self.movi = None
        self.movt = None
        self.mliq = None

    @staticmethod
    def from_reader(reader: BinaryReader, position):
        reader.seek(position)
        wmo_group_file = WmoGroupFile()

        mogp_loc = reader.get_chunk_location('MOGP', reader.tell())
        if mogp_loc == -1:
            raise ValueError('MOGP_NOT_FOUND.')

        reader.seek(mogp_loc + 4)
        size = reader.read_uint()

        reader.seek(reader.tell() + 8)  # Flags.
        wmo_group_file.flags = reader.read_uint()

        mopy_loc = reader.get_chunk_location('MOPY', reader.tell())
        if mopy_loc == -1:
            raise ValueError('MOPY_NOT_FOUND.')

        wmo_group_file.mopy = MOPY.from_reader(reader, mopy_loc)

        moin_loc = reader.get_chunk_location('MOIN', reader.tell())
        if moin_loc == -1:
            raise ValueError('MOIN_NOT_FOUND.')

        wmo_group_file.movi = MOVI.from_reader(reader, moin_loc)

        movt_loc = reader.get_chunk_location('MOVT', mopy_loc)
        if movt_loc == -1:
            raise ValueError('MOVT_NOT_FOUND.')

        wmo_group_file.movt = MOVT.from_reader(reader, movt_loc)

        mliq_loc = reader.get_chunk_location('MLIQ', movt_loc)
        if mliq_loc != -1:
            wmo_group_file.mliq = MLIQ.from_reader(reader, mliq_loc)

        return wmo_group_file

