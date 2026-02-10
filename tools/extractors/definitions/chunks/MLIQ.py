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

        mliq.material_id = reader.read_uint16()

        for _ in range(mliq.y_vertex_count):
            for _ in range(mliq.x_vertex_count):
                reader.move_forward(8)  # Skip mins and heights to avoid storing large grids.

        scan_limit = mliq.x_tiles
        scan_index = 0
        v4 = 15  # Default value indicating no specific liquid.
        for _ in range(mliq.y_tiles):
            for _ in range(mliq.x_tiles):
                flag = reader.read_uint8()
                if scan_index < scan_limit and v4 == 15 and (flag & 0xF) != 15:
                    v4 = flag & 0xF
                scan_index += 1

        # The below code is reversed directly from client:
        # void __thiscall CMapObj::RenderLiquid_0(CMapObj *this, CMapObjGroup *group)
        # Determine liquid type based on flags:
        # If no liquid found, raise error
        if v4 == 15:
            raise ValueError

        # Determine the liquid type based on v4.
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
