from tools.extractors.definitions.objects.Vector3 import Vector3
from tools.extractors.definitions.reader.StreamReader import StreamReader


class MLIQ:
    def __init__(self):
        self.x_tiles = 0
        self.y_tiles = 0
        self.x_vertex_count = 0
        self.y_vertex_count = 0
        self.corner = None
        self.heights = None
        self.flags = None

    @staticmethod
    def from_reader(reader: StreamReader):
        mliq = MLIQ()

        mliq.x_vertex_count = reader.read_int32()
        mliq.y_vertex_count = reader.read_int32()
        mliq.x_tiles = reader.read_int32()
        mliq.y_tiles = reader.read_uint32()

        mliq.corner = Vector3.from_reader(reader)

        tile_size = (533.0 + (1.0 / 3.0)) / 128.0

        mliq.corner.X -= tile_size * mliq.y_tiles

        tmp = mliq.x_tiles
        mliq.x_tiles = mliq.y_tiles
        mliq.y_tiles = tmp

        tmp = mliq.x_vertex_count
        mliq.x_vertex_count = mliq.y_vertex_count
        mliq.y_vertex_count = tmp

        reader.read_uint16()  # Material ID.

        mliq.heights = [[None for _ in range(mliq.x_vertex_count)] for _ in range(mliq.y_vertex_count)]
        for y in range(mliq.y_vertex_count):
            for x in range(mliq.x_vertex_count):
                reader.move_forward(4)  # Skip mins.
                mliq.heights[y][x] = reader.read_float()

        mliq.flags = [[None for _ in range(mliq.x_tiles)] for _ in range(mliq.y_tiles)]
        for y in range(mliq.y_tiles):
            for x in range(mliq.x_tiles):
                mliq.flags[y][x] = reader.read_int8()

        return mliq