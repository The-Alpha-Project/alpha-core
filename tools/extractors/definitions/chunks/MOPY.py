from tools.extractors.definitions.reader.StreamReader import StreamReader


class MOPY:
    def __init__(self):
        self.flags = []
        self.material_id = []
        self.triangle_count = 4

    @staticmethod
    def from_reader(reader: StreamReader, position):
        mopy = MOPY()
        reader.set_position(position + 8)

        for i in range(0, mopy.triangle_count):
            mopy.flags.append(reader.read_int8())
            reader.set_position(reader.get_position() + 1)
            mopy.material_id.append(reader.read_int8())
            reader.set_position(reader.get_position() + 1)

        return mopy
