from tools.extractors.definitions.reader.StreamReader import StreamReader


class MOVT:
    def __init__(self):
        self.vertices = []

    @staticmethod
    def from_reader(reader: StreamReader, position):
        reader.set_position(position)
        movt = MOVT()
        type = reader.read_uint32()
        size = reader.read_uint32()
        count = int(size / 12)

        for i in range(count):
            movt.vertices.append(reader.read_float())

        return movt