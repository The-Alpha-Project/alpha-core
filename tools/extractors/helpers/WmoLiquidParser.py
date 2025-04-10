from game.world.managers.maps.helpers.Constants import ADT_SIZE, RESOLUTION_LIQUIDS
from game.world.managers.maps.helpers.MapUtils import MapUtils
from tools.extractors.definitions.objects.Vector3 import Vector3
from tools.extractors.definitions.objects.Wmo import Wmo
from tools.extractors.helpers.Constants import Constants


class WmoLiquidParser:
    def __init__(self, adt, wmo_liquids):
        self.adt = adt
        self.has_liquids = False
        self._fill_wmo_liquids(wmo_liquids)

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        self.adt = None

    def _fill_wmo_liquids(self, wmo_liquids):
        if not self.adt.wmo_placements or not self.adt.wmo_filenames:
            return

        for wmo_placement in self.adt.wmo_placements:
            with Wmo(self.adt.wmo_filenames[wmo_placement.name_id]) as wmo:
                if not wmo.has_liquids():
                    continue

                self.has_liquids = True
                t_matrix = wmo_placement.get_transform_matrix()
                verts = []
                tile_size = Constants.UNIT_SIZE

                for mliq in wmo.mliq:
                    c = mliq.corner  # Corner.

                    for y in range(mliq.y_tiles):
                        for x in range(mliq.x_tiles):
                            if mliq.flags[y][x] == 15:  # Do not show.
                                continue
                            verts.append(Vector3(c.X + tile_size * (x + 0), c.Y + tile_size * (y + 0), c.Z))
                            verts.append(Vector3(c.X + tile_size * (x + 1), c.Y + tile_size * (y + 0), c.Z))
                            verts.append(Vector3(c.X + tile_size * (x + 0), c.Y + tile_size * (y + 1), c.Z))
                            verts.append(Vector3(c.X + tile_size * (x + 1), c.Y + tile_size * (y + 1), c.Z))

                    for v in [Vector3.transform(vert, t_matrix) for vert in verts]:
                        # Check which vertices lands on this ADT.
                        adt_x, adt_y, cell_x, cell_y = MapUtils.calculate_tile(v.X, v.Y, RESOLUTION_LIQUIDS - 1)
                        # Initialize wmo liquids for adt if needed.
                        if not wmo_liquids[adt_x][adt_y]:
                            wmo_liquids[adt_x][adt_y] = [[0.0 for _ in range(Constants.GRID_SIZE + 1)] for _ in
                                                         range(Constants.GRID_SIZE + 1)]
                        # Write wmo liquid height.
                        wmo_liquids[adt_x][adt_y][cell_x][cell_y] = v.Z

                    verts.clear()
