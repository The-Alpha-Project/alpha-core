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
                    WmoLiquidParser._transform_and_save_vertices(wmo_liquids, vertices, t_matrix)

    @staticmethod
    def _transform_and_save_vertices(wmo_liquids, vertices, t_matrix):
        for v in [Vector3.transform(vert, t_matrix) for vert in vertices]:
                adt_x, adt_y, cell_x, cell_y = MapUtils.calculate_tile(v.X, v.Y, RESOLUTION_LIQUIDS - 1)
                # Initialize wmo liquids for adt if needed.
                WmoLiquidParser._ensure_adt_wmo_liquid_initialization(wmo_liquids, adt_x, adt_y)
                # Write wmo liquid height.
                wmo_liquids[adt_x][adt_y][cell_x][cell_y] = v.Z

        vertices.clear()

    @staticmethod
    def _ensure_adt_wmo_liquid_initialization(wmo_liquids, adt_x, adt_y):
        if wmo_liquids[adt_x][adt_y]:
            return
        grid_size = Constants.GRID_SIZE + 1
        wmo_liquids[adt_x][adt_y] = [[0.0 for _ in range(grid_size)] for _ in range(grid_size)]

    @staticmethod
    def _get_mliq_vertices(mliq, vertices, tile_size):
        c = mliq.corner  # Corner.
        for y in range(mliq.y_tiles):
            for x in range(mliq.x_tiles):
                if mliq.flags[y][x] == 15:  # Do not show.
                    continue
                vertices.append(Vector3(c.X + tile_size * (x + 0), c.Y + tile_size * (y + 0), c.Z))
                vertices.append(Vector3(c.X + tile_size * (x + 1), c.Y + tile_size * (y + 0), c.Z))
                vertices.append(Vector3(c.X + tile_size * (x + 0), c.Y + tile_size * (y + 1), c.Z))
                vertices.append(Vector3(c.X + tile_size * (x + 1), c.Y + tile_size * (y + 1), c.Z))