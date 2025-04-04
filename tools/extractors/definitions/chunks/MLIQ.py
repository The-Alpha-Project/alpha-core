from tools.extractors.definitions.reader.BinaryReader import BinaryReader


class MLIQ:
    def __init__(self):
        self.width = 0
        self.height = 0
        self.corner = [0.0, 0.0, 0.0]
        self.heights = None

    @staticmethod
    def from_reader(reader: BinaryReader, position):
        reader.seek(position + 16)
        mliq = MLIQ()

        mliq.width = reader.read_uint()
        mliq.height = reader.read_uint()

        for i in range(len(mliq.corner)):
            mliq.corner[i] = reader.read_float()

        tile_size = (533.0 + (1.0 / 3.0)) / 128.0

        mliq.corner[0] -= tile_size * mliq.height

        w = mliq.width
        mliq.width = mliq.height
        mliq.height = w

        reader.seek(reader.tell() + 2)

        mliq.heights = [[None for _ in range(mliq.height + 1)] for _ in range(mliq.width + 1)]
        for y in range(mliq.height + 1):
            for x in range(mliq.width + 1):
                reader.seek(reader.tell() + 4)
                mliq.heights[y][x] = reader.read_float()

        return mliq