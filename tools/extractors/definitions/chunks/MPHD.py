class MPHD:
    def __init__(self):
        self.doodad_count = 0
        self.doodad_offset = 0
        self.wmo_count = 0
        self.wmo_offset = 0

    @staticmethod
    def from_reader(stream_reader):
        mphd = MPHD()

        mphd.doodad_count = stream_reader.read_uint32()
        mphd.doodad_offset = stream_reader.read_uint32()
        mphd.wmo_count = stream_reader.read_uint32()
        mphd.wmo_offset = stream_reader.read_uint32()

        stream_reader.move_forward(112)
        return mphd
