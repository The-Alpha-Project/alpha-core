import math
import struct

from game.world.managers.maps.helpers.Constants import RESOLUTION_LIQUIDS, ADT_SIZE, BLOCK_SIZE
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
        with open(file_path, 'rb') as f:
            magic = f.read(4)
            if magic == b'WLIQ':
                version, _, liquids_chunks_count = struct.unpack('<HHI', f.read(8))
                if version != 2:
                    raise ValueError(f'Unsupported WLIQ version {version}')
                entries = []
                for _ in range(liquids_chunks_count):
                    liquid_type = struct.unpack('<B', f.read(1))[0]
                    min_bound_vector = Vector3.from_bytes(f.read(12))
                    corner = Vector3.from_bytes(f.read(12))
                    x_tiles, y_tiles = struct.unpack('<HH', f.read(4))
                    entries.append((liquid_type, min_bound_vector, corner, x_tiles, y_tiles))
                return 2, entries

            # Fallback to legacy vertex-sampled format.
            f.seek(0)
            liquids_chunks_count = struct.unpack('i', f.read(4))[0]
            entries = []
            for _ in range(liquids_chunks_count):
                liquid_type = struct.unpack('B', f.read(1))[0]
                min_bound_vector = Vector3.from_bytes(f.read(12))
                vertices_count = struct.unpack('i', f.read(4))[0]
                vertices = []
                for _ in range(vertices_count):
                    vertices.append(Vector3.from_bytes(f.read(12)))
                entries.append((liquid_type, min_bound_vector, vertices))
            return 1, entries

    def parse(self, wmo_liquids):
        if not self.adt.wmo_placements or not self.adt.wmo_filenames:
            return
        [self._process_wmo_placement(wmo_placement, wmo_liquids) for wmo_placement in self.adt.wmo_placements]

    def _process_wmo_placement(self, wmo_placement, wmo_liquids):
        try:
            wmo_hash = Wmo.get_hash_filename(self.adt.wmo_filenames[wmo_placement.name_id])
            if wmo_hash not in WMO_LIQ_FILES_HASH_MAP:
                return

            version, entries = self.load_liquid_data_from(WMO_LIQ_FILES_HASH_MAP[wmo_hash])
            t_matrix = wmo_placement.get_transform_matrix()

            if version == 2:
                for liq_type, min_bound, corner, x_tiles, y_tiles in entries:
                    self._rasterize_liquid_tiles(
                        wmo_liquids,
                        t_matrix,
                        liq_type,
                        min_bound,
                        corner,
                        x_tiles,
                        y_tiles,
                    )
            else:
                for liq_type, min_bound, vertices in entries:
                    WmoLiquidParser._transform_and_cache_vertices(wmo_liquids, vertices, t_matrix, min_bound, liq_type)

            return
        except Exception as e:
            Logger.error(f'Error processing WMO placement {wmo_placement.name_id}: {e}')
            exit()

    @staticmethod
    def _transform_and_cache_vertices(wmo_liquids, vertices, t_matrix, liq_min_bound, liq_type):
        # Transform liquid min_bound.
        min_bound = Vector3.transform(liq_min_bound, t_matrix)

        for vert in vertices:
            v = Vector3.transform(vert, t_matrix)
            adt_x, adt_y, cell_x, cell_y = MapUtils.calculate_tile(v.X, v.Y, RESOLUTION_LIQUIDS - 1)
            # Initialize wmo liquids for adt if needed.
            WmoLiquidParser._ensure_adt_wmo_liquid_initialization(wmo_liquids, adt_x, adt_y)

            # Write wmo liquid height.
            # We can have different liquids at the same cell at different heights, handle that here.
            # This is seen mostly in IF (Kings room lava vs upper floor lava) and UC (Entrance slime vs canals slime).
            liq_list_for_cells = wmo_liquids[adt_x][adt_y][cell_x][cell_y]
            if liq_list_for_cells:
                # Allow two liquids per cell position.
                if len(liq_list_for_cells) > 1:
                    continue

                z0 = liq_list_for_cells[0][0]  # Known Z.
                # Within the already known liquid for this cell.
                if abs(round(z0, 3) - round(v.Z, 3)) < 2.0:
                    continue

            # Append either first liquid or second liquid for this cell.
            wmo_liquids[adt_x][adt_y][cell_x][cell_y].append((v.Z, min_bound.Z, liq_type))

        vertices.clear()

    def _rasterize_liquid_tiles(self, wmo_liquids, t_matrix, liq_type, liq_min_bound, corner, x_tiles, y_tiles):
        min_bound = Vector3.transform(liq_min_bound, t_matrix)
        tile_size = Constants.UNIT_SIZE
        corner_z = corner.Z
        for y in range(y_tiles):
            base_x = corner.X - tile_size * y
            for x in range(x_tiles):
                base_y = corner.Y + tile_size * x
                v00 = Vector3(base_x, base_y, corner_z)
                v10 = Vector3(base_x, base_y + tile_size, corner_z)
                v01 = Vector3(base_x - tile_size, base_y, corner_z)
                v11 = Vector3(base_x - tile_size, base_y + tile_size, corner_z)

                tv00 = Vector3.transform(v00, t_matrix)
                tv10 = Vector3.transform(v10, t_matrix)
                tv01 = Vector3.transform(v01, t_matrix)
                tv11 = Vector3.transform(v11, t_matrix)

                self._rasterize_liquid_triangle(tv00, tv10, tv01, wmo_liquids, liq_type, min_bound.Z)
                self._rasterize_liquid_triangle(tv10, tv11, tv01, wmo_liquids, liq_type, min_bound.Z)

    def _rasterize_liquid_triangle(self, v0, v1, v2, wmo_liquids, liq_type, min_bound_z):
        normal = self._cross(self._sub(v1, v0), self._sub(v2, v0))
        if abs(normal.Z) < 0.05:
            return

        area = self._triangle_area(v0, v1, v2)
        if area == 0.0:
            return

        min_x = min(v0.X, v1.X, v2.X)
        max_x = max(v0.X, v1.X, v2.X)
        min_y = min(v0.Y, v1.Y, v2.Y)
        max_y = max(v0.Y, v1.Y, v2.Y)

        adt_x_values = []
        adt_y_values = []
        for v in (v0, v1, v2):
            adt_x, adt_y = MapUtils.get_tile(v.X, v.Y)
            adt_x_values.append(adt_x)
            adt_y_values.append(adt_y)

        min_adt_x = max(0, min(adt_x_values))
        max_adt_x = min(BLOCK_SIZE - 1, max(adt_x_values))
        min_adt_y = max(0, min(adt_y_values))
        max_adt_y = min(BLOCK_SIZE - 1, max(adt_y_values))

        resolution = RESOLUTION_LIQUIDS - 1
        cell_step = ADT_SIZE / resolution
        half_step = cell_step * 0.5
        # Conservative rasterization against the cell square, avoids expensive sampling.
        e0 = self._edge_coeffs(v0, v1)
        e1 = self._edge_coeffs(v1, v2)
        e2 = self._edge_coeffs(v2, v0)
        if area < 0.0:
            e0 = (-e0[0], -e0[1], -e0[2])
            e1 = (-e1[0], -e1[1], -e1[2])
            e2 = (-e2[0], -e2[1], -e2[2])
        m0 = half_step * (abs(e0[0]) + abs(e0[1]))
        m1 = half_step * (abs(e1[0]) + abs(e1[1]))
        m2 = half_step * (abs(e2[0]) + abs(e2[1]))
        for adt_x in range(min_adt_x, max_adt_x + 1):
            for adt_y in range(min_adt_y, max_adt_y + 1):
                cell_x_min, cell_x_max = self._world_range_to_cells(min_x, max_x, adt_x, resolution)
                cell_y_min, cell_y_max = self._world_range_to_cells(min_y, max_y, adt_y, resolution)
                for cell_x in range(cell_x_min, cell_x_max + 1):
                    wx = self._cell_to_world(adt_x, cell_x, resolution)
                    for cell_y in range(cell_y_min, cell_y_max + 1):
                        wy = self._cell_to_world(adt_y, cell_y, resolution)
                        if (self._edge_eval(e0, wx, wy) < -m0
                                or self._edge_eval(e1, wx, wy) < -m1
                                or self._edge_eval(e2, wx, wy) < -m2):
                            continue
                        z = self._plane_z(wx, wy, v0, normal)
                        if z is None:
                            continue
                        self._add_liquid_height(
                            wmo_liquids,
                            adt_x,
                            adt_y,
                            cell_x,
                            cell_y,
                            z,
                            min_bound_z,
                            liq_type,
                        )

    @staticmethod
    def _ensure_adt_wmo_liquid_initialization(wmo_liquids, adt_x, adt_y):
        if wmo_liquids[adt_x][adt_y]:
            return
        grid_size = Constants.GRID_SIZE + 1
        wmo_liquids[adt_x][adt_y] = [[[] for _ in range(grid_size)] for _ in range(grid_size)]

    @staticmethod
    def _add_liquid_height(wmo_liquids, adt_x, adt_y, cell_x, cell_y, z, min_bound_z, liq_type):
        WmoLiquidParser._ensure_adt_wmo_liquid_initialization(wmo_liquids, adt_x, adt_y)

        liq_list_for_cells = wmo_liquids[adt_x][adt_y][cell_x][cell_y]
        if liq_list_for_cells:
            if len(liq_list_for_cells) > 1:
                return
            z0 = liq_list_for_cells[0][0]
            if abs(round(z0, 3) - round(z, 3)) < 2.0:
                return

        wmo_liquids[adt_x][adt_y][cell_x][cell_y].append((z, min_bound_z, liq_type))

    @staticmethod
    def _sub(a, b):
        return Vector3(a.X - b.X, a.Y - b.Y, a.Z - b.Z)

    @staticmethod
    def _cross(a, b):
        return Vector3(
            a.Y * b.Z - a.Z * b.Y,
            a.Z * b.X - a.X * b.Z,
            a.X * b.Y - a.Y * b.X,
        )

    @staticmethod
    def _plane_z(x, y, v0, normal):
        if normal.Z == 0.0:
            return None
        d = -(normal.X * v0.X + normal.Y * v0.Y + normal.Z * v0.Z)
        return -((normal.X * x + normal.Y * y + d) / normal.Z)

    @staticmethod
    def _edge_coeffs(v0, v1):
        a = v0.Y - v1.Y
        b = v1.X - v0.X
        c = v0.X * v1.Y - v1.X * v0.Y
        return a, b, c

    @staticmethod
    def _edge_eval(edge, x, y):
        return edge[0] * x + edge[1] * y + edge[2]

    @staticmethod
    def _triangle_area(v0, v1, v2):
        return (v1.X - v0.X) * (v2.Y - v0.Y) - (v1.Y - v0.Y) * (v2.X - v0.X)

    @staticmethod
    def _cell_to_world(adt_coord, cell_coord, resolution):
        return (32.0 - adt_coord - (cell_coord / resolution)) * ADT_SIZE

    @staticmethod
    def _world_range_to_cells(min_value, max_value, adt_coord, resolution):
        min_pos = resolution * (32.0 - (min_value / ADT_SIZE) - adt_coord)
        max_pos = resolution * (32.0 - (max_value / ADT_SIZE) - adt_coord)
        cell_min = max(0, int(math.floor(min(min_pos, max_pos))))
        cell_max = min(resolution, int(math.ceil(max(min_pos, max_pos))))
        return cell_min, cell_max
