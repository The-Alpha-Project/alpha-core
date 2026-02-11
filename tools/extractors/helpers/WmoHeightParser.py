import math
import struct

from game.world.managers.maps.helpers.Constants import RESOLUTION_ZMAP, ADT_SIZE, BLOCK_SIZE
from game.world.managers.maps.helpers.MapUtils import MapUtils
from tools.extractors.definitions.objects.Vector3 import Vector3
from tools.extractors.definitions.objects.Wmo import Wmo, WMO_FILE_PATHS_HASH_MAP, WMO_GEO_FILES_HASH_MAP
from tools.extractors.definitions.objects.WmoGroupFile import WmoGroupFile
from tools.extractors.definitions.reader.StreamReader import StreamReader
from tools.extractors.pympqlib.MpqArchive import MpqArchive
from tools.extractors.helpers.Constants import Constants
from utils.Logger import Logger


class WmoHeightParser:
    _MIN_NORMAL_Z = 0.05
    _HEIGHT_EPSILON = 0.1
    _WMO_TOKENS = {b'REVM', b'OMOM', b'PGOM', b'MVER', b'MOMO', b'MOGP'}

    def __init__(self, adt):
        self.adt = adt

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        self.adt = None

    def parse(self, wmo_heights):
        if not wmo_heights or not self.adt.wmo_placements or not self.adt.wmo_filenames:
            return
        for wmo_placement in self.adt.wmo_placements:
            self._process_wmo_placement(wmo_placement, wmo_heights)

    def _process_wmo_placement(self, wmo_placement, wmo_heights):
        try:
            wmo_hash = Wmo.get_hash_filename(self.adt.wmo_filenames[wmo_placement.name_id])
            wmo_path = WMO_FILE_PATHS_HASH_MAP.get(wmo_hash)
            if not wmo_path:
                return

            t_matrix = wmo_placement.get_transform_matrix()
            for v0, v1, v2, flags, material_id in self._iter_wmo_triangles(wmo_hash, wmo_path):
                if not self._is_collidable(flags, material_id):
                    continue
                tv0 = Vector3.transform(v0, t_matrix)
                tv1 = Vector3.transform(v1, t_matrix)
                tv2 = Vector3.transform(v2, t_matrix)
                self._rasterize_triangle(tv0, tv1, tv2, wmo_heights)
        except Exception as e:
            Logger.error(f'Error processing WMO height data {wmo_placement.name_id}: {e}')
            exit()

    @classmethod
    def _iter_wmo_triangles(cls, wmo_hash, wmo_path):
        geo_path = WMO_GEO_FILES_HASH_MAP.get(wmo_hash)
        if geo_path:
            yield from cls._iter_geometry_file(geo_path)
            return

        with MpqArchive(wmo_path) as archive:
            data = archive.read_file_bytes()
            if cls._looks_like_wmo(data):
                yield from cls._iter_triangles_from_data(data)

    @classmethod
    def _iter_triangles_from_data(cls, data):
        try:
            with StreamReader(data) as reader:
                yield from cls._scan_chunks(reader, reader.eof)
        except UnicodeDecodeError:
            return

    @classmethod
    def _iter_geometry_file(cls, file_path):
        try:
            with open(file_path, 'rb') as f:
                magic = f.read(4)
                if magic != Constants.WGEO_MAGIC:
                    raise ValueError('Legacy WGEO file missing version header.')
                header = f.read(4)
                if len(header) < 4:
                    raise ValueError('Legacy WGEO file missing version header.')
                version, _, _ = struct.unpack('<BBH', header)
                if version != Constants.WGEO_EXPECTED_VERSION:
                    raise ValueError(f'Unsupported WGEO version {version}')
                group_count = struct.unpack('<I', f.read(4))[0]

                for _ in range(group_count):
                    index_size, _, _, vertex_count, triangle_count = struct.unpack('<BBHII', f.read(12))
                    if index_size not in (2, 4):
                        return

                    vertices = []
                    for _ in range(vertex_count):
                        x, y, z = struct.unpack('<fff', f.read(12))
                        vertices.append(Vector3(x, y, z))

                    for _ in range(triangle_count):
                        if index_size == 2:
                            i0, i1, i2 = struct.unpack('<HHH', f.read(6))
                        else:
                            i0, i1, i2 = struct.unpack('<III', f.read(12))
                        flags = struct.unpack('<B', f.read(1))[0]
                        if i0 >= vertex_count or i1 >= vertex_count or i2 >= vertex_count:
                            continue
                        yield (vertices[i0], vertices[i1], vertices[i2], flags, 0xFF)
        except (OSError, struct.error):
            return

    @classmethod
    def _scan_chunks(cls, reader, end_position):
        while reader.get_position() + 8 <= end_position:
            error, token, size = reader.read_chunk_information()
            if error:
                break
            chunk_end = reader.get_position() + size
            if chunk_end > end_position:
                break

            if token == 'MVER':
                reader.read_int32()
                continue

            if token == 'MOMO':
                yield from cls._scan_chunks(reader, chunk_end)
                reader.set_position(chunk_end)
                continue

            if token == 'MOGP':
                group = WmoGroupFile.from_reader(reader, size=size, parse_geometry=True)
                if group.vertices and group.indices:
                    flags = group.triangle_flags or []
                    materials = group.triangle_materials or []
                    max_index = len(group.vertices)
                    tri_count = int(len(group.indices) / 3)
                    for tri_index in range(tri_count):
                        idx = tri_index * 3
                        i0 = group.indices[idx]
                        i1 = group.indices[idx + 1]
                        i2 = group.indices[idx + 2]
                        if i0 >= max_index or i1 >= max_index or i2 >= max_index:
                            continue
                        tri_flags = flags[tri_index] if tri_index < len(flags) else 0
                        material_id = materials[tri_index] if tri_index < len(materials) else 0xFF
                        yield (group.vertices[i0], group.vertices[i1], group.vertices[i2], tri_flags, material_id)
                reader.set_position(chunk_end)
                continue

            reader.move_forward(size)

    @staticmethod
    def _is_collidable(flags, material_id):
        # Match client logic: flags bit 0x04 means no collision unless material id is 0xFF.
        return not (flags & 0x04 and material_id != 0xFF)

    @classmethod
    def _looks_like_wmo(cls, data):
        if not data or len(data) < 4:
            return False
        header = bytes(data[:4])
        return header in cls._WMO_TOKENS

    def _rasterize_triangle(self, v0, v1, v2, wmo_heights):
        normal = self._cross(self._sub(v1, v0), self._sub(v2, v0))
        if abs(normal.Z) < self._MIN_NORMAL_Z:
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

        resolution = RESOLUTION_ZMAP - 1
        cell_step = ADT_SIZE / resolution
        half_step = cell_step * 0.5
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
                        self._add_height(wmo_heights, adt_x, adt_y, cell_x, cell_y, z)

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

    def _plane_z(self, x, y, v0, normal):
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

    def _add_height(self, wmo_heights, adt_x, adt_y, cell_x, cell_y, z):
        if not wmo_heights[adt_x][adt_y]:
            wmo_heights[adt_x][adt_y] = {}

        key = (cell_x << 8) | cell_y
        heights = wmo_heights[adt_x][adt_y].get(key)
        if heights is None:
            wmo_heights[adt_x][adt_y][key] = [z]
            return

        for existing in heights:
            if math.fabs(existing - z) < self._HEIGHT_EPSILON:
                return
        heights.append(z)

    @staticmethod
    def _world_to_cell(value, adt_coord, resolution):
        return int(round(resolution * (32.0 - (value / ADT_SIZE) - adt_coord)))

    @staticmethod
    def _cell_to_world(adt_coord, cell_coord, resolution):
        return (32.0 - adt_coord - (cell_coord / resolution)) * ADT_SIZE

    def _world_range_to_cells(self, min_value, max_value, adt_coord, resolution):
        min_pos = resolution * (32.0 - (min_value / ADT_SIZE) - adt_coord)
        max_pos = resolution * (32.0 - (max_value / ADT_SIZE) - adt_coord)
        cell_min = max(0, int(math.floor(min(min_pos, max_pos))))
        cell_max = min(resolution, int(math.ceil(max(min_pos, max_pos))))
        return cell_min, cell_max
