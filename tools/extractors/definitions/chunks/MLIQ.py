from tools.extractors.definitions.objects.Vector3 import Vector3
from tools.extractors.definitions.reader.StreamReader import StreamReader
from tools.extractors.helpers.Constants import Constants


class MLIQ:
    def __init__(self):
        self.x_tiles = 0
        self.y_tiles = 0
        self.x_vertex_count = 0
        self.y_vertex_count = 0
        self.corner = None
        self.heights = None
        self.flags = None
        self.material_id = 0
        self.min_bound = None

    @staticmethod
    def from_reader(reader: StreamReader, min_bound: Vector3):
        mliq = MLIQ()
        mliq.min_bound = min_bound

        mliq.x_vertex_count = reader.read_int32()
        mliq.y_vertex_count = reader.read_int32()
        mliq.x_tiles = reader.read_int32()
        mliq.y_tiles = reader.read_uint32()

        mliq.corner = Vector3.from_reader(reader)

        tile_size = Constants.UNIT_SIZE

        mliq.corner.X -= tile_size * mliq.y_tiles

        tmp = mliq.x_tiles
        mliq.x_tiles = mliq.y_tiles
        mliq.y_tiles = tmp

        tmp = mliq.x_vertex_count
        mliq.x_vertex_count = mliq.y_vertex_count
        mliq.y_vertex_count = tmp

        mliq.material_id = reader.read_uint16()

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

    def get_vertices(self):
        vertices = []
        tile_size = Constants.UNIT_SIZE
        c = self.corner  # Corner.
        fractions = [0.0, 0.25, 0.5, 0.75]

        # Loop over each tile
        for y in range(self.y_tiles):
            for x in range(self.x_tiles):
                # Corner vertices.
                vertices.append(Vector3(c.X + tile_size * (x + 0), c.Y + tile_size * (y + 0), c.Z))
                vertices.append(Vector3(c.X + tile_size * (x + 1), c.Y + tile_size * (y + 0), c.Z))
                vertices.append(Vector3(c.X + tile_size * (x + 0), c.Y + tile_size * (y + 1), c.Z))
                vertices.append(Vector3(c.X + tile_size * (x + 1), c.Y + tile_size * (y + 1), c.Z))

                # Generate 16 fractional points at all combinations of 0.0, 0.25, 0.5, 0.75.
                for frac_x in fractions:
                    for frac_y in fractions:
                        vertices.append(Vector3(c.X + tile_size * (x + frac_x), c.Y + tile_size * (y + frac_y), c.Z))

        return vertices
