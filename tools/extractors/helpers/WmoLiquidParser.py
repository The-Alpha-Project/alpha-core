import struct

from game.world.managers.maps.helpers.Constants import RESOLUTION_LIQUIDS
from game.world.managers.maps.helpers.MapUtils import MapUtils
from tools.extractors.definitions.objects.Vector3 import Vector3
from tools.extractors.definitions.objects.Wmo import Wmo, WMO_LIQ_FILES_HASH_MAP
from tools.extractors.helpers.Constants import Constants

from utils.Logger import Logger


class WmoLiquidParser:
    def __init__(self, adt):
        self.adt = adt
        self.has_liquids = False

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        self.adt = None

    def load_liquid_data_from(self, file_path):
        liq_vertices = []
        liq_min_bounds = []
        liq_types = []
        with open(file_path, 'rb') as f:
            # Read the number of liquid chunks.
            liquids_chunks_count = struct.unpack('i', f.read(4))[0]

            for index in range(liquids_chunks_count):
                liquid_type = struct.unpack('B', f.read(1))[0]
                liq_types.append(liquid_type)

                # Read min_bound vector (3 floats)
                min_bound_vector = Vector3.from_bytes(f.read(12))
                liq_min_bounds.append(min_bound_vector)

                # Read vertices count for this bound.
                vertices_count = struct.unpack('i', f.read(4))[0]
                liq_vertices.append([])
                for _ in range(vertices_count):
                    liq_vertices[index].append(Vector3.from_bytes(f.read(12)))

        return liq_types, liq_min_bounds, liq_vertices

    def parse(self, wmo_liquids):
        if not self.adt.wmo_placements or not self.adt.wmo_filenames:
            return
        [self._process_wmo_placement(wmo_placement, wmo_liquids) for wmo_placement in self.adt.wmo_placements]

    def _process_wmo_placement(self, wmo_placement, wmo_liquids):
        try:
            wmo_hash = Wmo.get_hash_filename(self.adt.wmo_filenames[wmo_placement.name_id])
            if wmo_hash not in WMO_LIQ_FILES_HASH_MAP:
                return

            liq_types, min_bounds, liq_vertices = self.load_liquid_data_from(WMO_LIQ_FILES_HASH_MAP[wmo_hash])
            t_matrix = wmo_placement.get_transform_matrix()

            for min_bound, vertices, liq_type in zip(min_bounds, liq_vertices, liq_types):
                WmoLiquidParser._transform_and_cache_vertices(wmo_liquids, vertices, t_matrix, min_bound, liq_type)

            return
        except Exception as e:
            Logger.error(f'Error processing WMO placement {wmo_placement.name_id}: {e}')
            exit()

    @staticmethod
    def _transform_and_cache_vertices(wmo_liquids, vertices, t_matrix, liq_min_bound, liq_type):
        # Transform liquid min_bound.
        min_bound = Vector3.transform(liq_min_bound, t_matrix)

        # Transform all vertices once.
        transformed_vertices = [Vector3.transform(vert, t_matrix) for vert in vertices]

        for v in transformed_vertices:
            adt_x, adt_y, cell_x, cell_y = MapUtils.calculate_tile(v.X, v.Y, RESOLUTION_LIQUIDS - 1)
            # Initialize wmo liquids for adt if needed.
            WmoLiquidParser._ensure_adt_wmo_liquid_initialization(wmo_liquids, adt_x, adt_y)

            # Write wmo liquid height.
            # TODO: We can have different liquids at the same cell at different heights, handle that here.
            #  This is seen mostly in IF (Kings room lava vs upper floor lava) and UC (Entrance slime vs canals slime).
            #if wmo_liquids[adt_x][adt_y][cell_x][cell_y]:
            #    z0 = wmo_liquids[adt_x][adt_y][cell_x][cell_y][0]
            #    if abs(round(z0, 3) - round(v.Z, 3)) > 2.0:  # This is a different liquid layer.
            #        print(f'Old {z0} New {v.Z}')
            #        print(f'.port {v.X} {v.Y} {v.Z} ')
            wmo_liquids[adt_x][adt_y][cell_x][cell_y] = (v.Z, min_bound.Z, liq_type)
            # f.write(f"v {v.X} {v.Y} {v.Z}\n")

        vertices.clear()
        transformed_vertices.clear()

    @staticmethod
    def _ensure_adt_wmo_liquid_initialization(wmo_liquids, adt_x, adt_y):
        if wmo_liquids[adt_x][adt_y]:
            return
        grid_size = Constants.GRID_SIZE + 1
        wmo_liquids[adt_x][adt_y] = [[None for _ in range(grid_size)] for _ in range(grid_size)]
