from tools.extractors.definitions.reader.BinaryReader import BinaryReader


class MOHD:
    def __init__(self):
        self.textures_count = 0
        self.wmo_group_files_count = 0
        self.portals_count = 0
        self.light_count = 0
        self.doodad_name_count = 0
        self.doodad_ref_count = 0
        self.doodad_set_count = 0
        self.col_r = 0
        self.col_g = 0
        self.col_b = 0
        self.col_x = 0
        self.wmo_id = 0

    @staticmethod
    def from_reader(reader: BinaryReader):
        mohd = MOHD()

        mohd.textures_count = reader.read_uint()
        mohd.wmo_group_files_count = reader.read_int()
        mohd.portals_count = reader.read_uint()
        mohd.light_count = reader.read_uint()
        mohd.doodad_name_count = reader.read_uint()
        mohd.doodad_ref_count = reader.read_uint()
        mohd.doodad_set_count = reader.read_uint()
        mohd.col_r = reader.read_byte()
        mohd.col_g = reader.read_byte()
        mohd.col_b = reader.read_byte()
        mohd.col_x = reader.read_byte()
        mohd.wmo_id = reader.read_uint()

        return mohd