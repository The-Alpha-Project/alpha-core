from tools.extractors.definitions.reader.StreamReader import StreamReader


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
    def from_reader(reader: StreamReader):
        mohd = MOHD()

        mohd.textures_count = reader.read_uint32()
        mohd.wmo_group_files_count = reader.read_int32()
        mohd.portals_count = reader.read_uint32()
        mohd.light_count = reader.read_uint32()
        mohd.doodad_name_count = reader.read_uint32()
        mohd.doodad_ref_count = reader.read_uint32()
        mohd.doodad_set_count = reader.read_uint32()
        mohd.col_r = reader.read_int8()
        mohd.col_g = reader.read_int8()
        mohd.col_b = reader.read_int8()
        mohd.col_x = reader.read_int8()
        mohd.wmo_id = reader.read_uint32()
        reader.move_forward(28)  # Padding.

        return mohd