from tools.extractors.definitions.reader.BinaryReader import BinaryReader


class MOVT:
    def __init__(self):
        self.vertices = []

    @staticmethod
    def from_reader(reader: BinaryReader, position):
        reader.seek(position)
        movt = MOVT()
        type = reader.read_uint()
        size = reader.read_uint()
        count = int(size / 12)

        for i in range(count):
            movt.vertices.append(reader.read_float())

        return movt