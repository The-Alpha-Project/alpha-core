import os

from game.world.managers.maps.helpers.Constants import ADT_SIZE, RESOLUTION_LIQUIDS
from game.world.managers.maps.helpers.MapUtils import MapUtils
from tools.extractors.definitions.objects.Vector3 import Vector3
from tools.extractors.definitions.objects.Wmo import Wmo
from tools.extractors.helpers.Constants import Constants


class WmoLiquidParser:
    def __init__(self, adt):
        self.adt = adt
        self.has_liquids = False

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        self.adt = None

    def parse(self, wmo_liquids):
        if not self.adt.wmo_placements or not self.adt.wmo_filenames:
            return

        for wmo_placement in self.adt.wmo_placements:
            with Wmo(self.adt.wmo_filenames[wmo_placement.name_id]) as wmo:
                if not wmo.has_liquids():
                    continue

                self.has_liquids = True
                t_matrix = wmo_placement.get_transform_matrix()
                vertices = []
                tile_size = Constants.UNIT_SIZE

                for mliq in wmo.mliq:
                    WmoLiquidParser._get_mliq_vertices(mliq, vertices, tile_size)
                    WmoLiquidParser._transform_and_save_vertices(wmo_liquids, vertices, t_matrix, mliq, self.adt)

    @staticmethod
    def _transform_and_save_vertices(wmo_liquids, vertices, t_matrix, mliq, adt):
        # Transform min_bound.
        min_bound = Vector3.transform(mliq.min_bound, t_matrix)

        # Transform all vertices once.
        transformed_vertices = [Vector3.transform(vert, t_matrix) for vert in vertices]

        # filename = f'/home/user/{adt.map_id}.obj'
        # exists = os.path.exists(filename)
        # with open(filename, 'w' if not exists else 'a') as f:
        #print(f"OBJ file '{filename}' created with {len(vertices)} vertices.")
        for v in transformed_vertices:
                adt_x, adt_y, cell_x, cell_y = MapUtils.calculate_tile(v.X, v.Y, RESOLUTION_LIQUIDS - 1)
                # Initialize wmo liquids for adt if needed.
                WmoLiquidParser._ensure_adt_wmo_liquid_initialization(wmo_liquids, adt_x, adt_y)
                # Write wmo liquid height.
                wmo_liquids[adt_x][adt_y][cell_x][cell_y] = (v.Z, min_bound.Z)
                # f.write(f"v {v.X} {v.Y} {v.Z}\n")

        vertices.clear()

    @staticmethod
    def _ensure_adt_wmo_liquid_initialization(wmo_liquids, adt_x, adt_y):
        if wmo_liquids[adt_x][adt_y]:
            return
        grid_size = Constants.GRID_SIZE + 1
        wmo_liquids[adt_x][adt_y] = [[None for _ in range(grid_size)] for _ in range(grid_size)]

    @staticmethod
    def _get_mliq_vertices(mliq, vertices, tile_size):
        c = mliq.corner  # Corner.
        step = 0.1

        # Loop over each tile
        for y in range(mliq.y_tiles):
            for x in range(mliq.x_tiles):
                # For each tile, iterate tile_size from start to end in order to cover most of the area.
                factor = 1
                while factor <= tile_size:
                    # Generate vertices for the current tile_size factor.
                    vertices.append(Vector3(c.X + factor * (x + 0), c.Y + factor * (y + 0), c.Z))
                    vertices.append(Vector3(c.X + factor * (x + 1), c.Y + factor * (y + 0), c.Z))
                    vertices.append(Vector3(c.X + factor * (x + 0), c.Y + factor * (y + 1), c.Z))
                    vertices.append(Vector3(c.X + factor * (x + 1), c.Y + factor * (y + 1), c.Z))
                    factor += step
