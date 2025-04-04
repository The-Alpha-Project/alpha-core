from tools.extractors.definitions.reader.BinaryReader import BinaryReader


class MOVI:
    def __init__(self):
        self.indices = []

    @staticmethod
    def from_reader(reader: BinaryReader, position):
        reader.seek(position)
        movi = MOVI()
        type = reader.read_uint()
        size = reader.read_uint()
        count = int(size / 2)

        for i in range(count):
            movi.indices.append(reader.read_ushort())

        return movi