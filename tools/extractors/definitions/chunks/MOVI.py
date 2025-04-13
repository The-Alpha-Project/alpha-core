from tools.extractors.definitions.reader.StreamReader import StreamReader


class MOVI:
    def __init__(self):
        self.indices = []

    @staticmethod
    def from_reader(reader: StreamReader, position):
        reader.set_position(position)
        movi = MOVI()
        type = reader.read_uint32()
        size = reader.read_int32()
        count = int(size / 2)

        for i in range(count):
            movi.indices.append(reader.read_uint16())

        return movi