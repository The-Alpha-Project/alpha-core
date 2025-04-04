from tools.extractors.definitions.reader.BinaryReader import BinaryReader


class MOPY:
    def __init__(self):
        self.flags = []
        self.material_id = []
        self.triangle_count = 4

    @staticmethod
    def from_reader(reader: BinaryReader, position):
        mopy = MOPY()
        reader.seek(position + 8)

        for i in range(0, mopy.triangle_count):
            mopy.flags.append(reader.read_byte())
            reader.seek(reader.tell() + 1)
            mopy.material_id.append(reader.read_byte())
            reader.seek(reader.tell() + 1)

        return mopy
