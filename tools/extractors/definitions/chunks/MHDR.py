class MHDR:
    def __init__(self):
        self.mcin_offset = 0
        self.mtex_offset = 0
        self.mtex_size = 0
        self.doodad_offset = 0
        self.doodad_size = 0
        self.wmo_offset = 0
        self.wmo_size = 0

    @staticmethod
    def from_reader(stream_reader):
        mhdr = MHDR()

        mhdr.mcin_offset = stream_reader.read_uint32()
        mhdr.mtex_offset = stream_reader.read_uint32()
        mhdr.mtex_size = stream_reader.read_uint32()
        mhdr.doodad_offset = stream_reader.read_uint32()
        mhdr.doodad_size = stream_reader.read_uint32()
        mhdr.wmo_offset = stream_reader.read_uint32()
        mhdr.wmo_size = stream_reader.read_uint32()

        stream_reader.move_forward(36)
        return mhdr
