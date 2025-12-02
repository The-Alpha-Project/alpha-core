from typing import List, Optional, Any

from tools.extractors.definitions.enums.LiquidFlags import WmoGroupLiquidType
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
        self.heights: Optional[List[Optional[Any]]] = None
        self.flags: Optional[List[Optional[Any]]] = None
        self.material_id = 0
        self.min_bound = None
        self.liquid_type = WmoGroupLiquidType.INTERIOR_WATER

    @staticmethod
    def from_reader(reader: StreamReader, min_bound: Vector3, group_flags):
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

        l_flags = []
        mliq.flags = [[None for _ in range(mliq.x_tiles)] for _ in range(mliq.y_tiles)]
        for y in range(mliq.y_tiles):
            for x in range(mliq.x_tiles):
                mliq.flags[y][x] = reader.read_uint8()
                l_flags.append(mliq.flags[y][x])

        # The below code is reversed directly from client:
        # void __thiscall CMapObj::RenderLiquid_0(CMapObj *this, CMapObjGroup *group)
        # Determine liquid type based on flags:
        # Find the first value with a non-default liquid indicator
        x = mliq.y_vertex_count  # x,y were previously swapped, use original x vertex count.
        v3 = 0
        v4 = 15  # Default value indicating no specific liquid.

        if x > 0:
            # Loop through flat flags to find first with a liquid flag.
            while v3 < x and (l_flags[v3] & 0xF) == 15:
                v3 += 1

            if v3 < x:
                v4 = l_flags[v3] & 0xF  # Extract lower 4 bits indicating liquid type.

        # If no liquid found, raise error
        if v4 == 15:
            raise Exception

        # Determine and print the liquid type based on v4.
        if v4 in (0, 4, 8):
            # Water: check if it's interior or exterior based on group_flags.
            if (group_flags & 0x48) == 0:
                mliq.liquid_type = WmoGroupLiquidType.INTERIOR_WATER
            else:
                mliq.liquid_type = WmoGroupLiquidType.EXTERIOR_WATER
        # Special case: This is based on UnderCity.wmo parsing, the client tag it as magma.
        elif v4 == 3:
            mliq.liquid_type = WmoGroupLiquidType.SLIME
        # Magma.
        elif v4 in (2, 6, 7):
            mliq.liquid_type = WmoGroupLiquidType.MAGMA
        else:
            raise ValueError

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
