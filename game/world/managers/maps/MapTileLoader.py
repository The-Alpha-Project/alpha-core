import math
import os
import sys
from array import array
from dataclasses import dataclass
from enum import IntEnum
from struct import unpack
from typing import Optional

from game.world.managers.maps.helpers.Constants import RESOLUTION_ZMAP, RESOLUTION_LIQUIDS, RESOLUTION_AREA_INFO, \
    ADT_SIZE, V8_GRID_SIZE, V9_GRID_SIZE, UNIT_SIZE
from utils.Float16 import Float16


class MapTileLoadError(IntEnum):
    NONE = 0
    MISSING = 1
    VERSION = 2


@dataclass
class MapTileLoadResult:
    error: MapTileLoadError
    filename: str
    map_id: int
    adt_x: int
    adt_y: int
    version: Optional[str] = None
    uniform_height: Optional[float] = None
    v8_heights: Optional[array] = None
    v9_heights: Optional[array] = None
    area_data: Optional[list[list[Optional[tuple]]]] = None
    liquid_cells: Optional[dict[int, list[tuple]]] = None
    wmo_height_cells: Optional[dict[int, list[float]]] = None


HEIGHTMAP_MODE_UNIFORM = 0
HEIGHTMAP_MODE_V8V9 = 1
LIQUID_FLAG_IS_WMO = 0x1


def _read_cstring(stream):
    chars = bytearray()
    while True:
        data = stream.read(1)
        if not data:
            return None
        if data == b'\x00':
            break
        chars.extend(data)
    return chars.decode('ascii')


def _map_liquid_to_height(x_liquid, y_liquid):
    x_height = int(round(x_liquid * (RESOLUTION_ZMAP - 1) / (RESOLUTION_LIQUIDS - 1)))
    y_height = int(round(y_liquid * (RESOLUTION_ZMAP - 1) / (RESOLUTION_LIQUIDS - 1)))
    return x_height, y_height


def _read_height_grid(stream, grid_size, use_float_16):
    count = grid_size * grid_size
    if use_float_16:
        raw = array('h')
        raw.frombytes(stream.read(count * 2))
        if sys.byteorder != 'big':
            raw.byteswap()
        return array('f', [Float16.decompress(value) for value in raw])
    raw = array('f')
    raw.frombytes(stream.read(count * 4))
    if sys.byteorder != 'little':
        raw.byteswap()
    return raw


def _get_v8(v8_heights, x, y):
    return v8_heights[(x * V8_GRID_SIZE) + y]


def _get_v9(v9_heights, x, y):
    return v9_heights[(x * V9_GRID_SIZE) + y]


def _calculate_height_from_v8v9(v8_heights, v9_heights, local_x, local_z):
    if local_x < 0.0:
        local_x = 0.0
    elif local_x > ADT_SIZE:
        local_x = ADT_SIZE

    if local_z < 0.0:
        local_z = 0.0
    elif local_z > ADT_SIZE:
        local_z = ADT_SIZE

    xc = int(local_x / UNIT_SIZE)
    zc = int(local_z / UNIT_SIZE)
    if xc >= V8_GRID_SIZE:
        xc = V8_GRID_SIZE - 1
    if zc >= V8_GRID_SIZE:
        zc = V8_GRID_SIZE - 1

    lx = local_x - xc * UNIT_SIZE
    lz = local_z - zc * UNIT_SIZE
    half_unit = UNIT_SIZE / 2.0

    v0x = half_unit
    v0y = _get_v8(v8_heights, xc, zc)
    v0z = half_unit

    if lx > lz:
        v1x = UNIT_SIZE
        v1y = _get_v9(v9_heights, xc + 1, zc)
        v1z = 0.0
    else:
        v1x = 0.0
        v1y = _get_v9(v9_heights, xc, zc + 1)
        v1z = UNIT_SIZE

    if lz > UNIT_SIZE - lx:
        v2x = UNIT_SIZE
        v2y = _get_v9(v9_heights, xc + 1, zc + 1)
        v2z = UNIT_SIZE
    else:
        v2x = 0.0
        v2y = _get_v9(v9_heights, xc, zc)
        v2z = 0.0

    a = v0y * (v1z - v2z) + v1y * (v2z - v0z) + v2y * (v0z - v1z)
    b = v0z * (v1x - v2x) + v1z * (v2x - v0x) + v2z * (v0x - v1x)
    c = v0x * (v1y - v2y) + v1x * (v2y - v0y) + v2x * (v0y - v1y)
    d = v0x * (v1y * v2z - v2y * v1z) \
        + v1x * (v2y * v0z - v0y * v2z) \
        + v2x * (v0y * v1z - v1y * v0z)

    if b == 0:
        return v0y

    return -round(float((a * lx + c * lz - d) / b), 5)


def load_map_tile_data(maps_path, map_id, adt_x, adt_y, use_float_16, expected_version):
    filename = f'{map_id:03}{adt_x:02}{adt_y:02}.map'
    maps_path = os.path.join(maps_path, filename)

    if not os.path.exists(maps_path):
        return MapTileLoadResult(
            error=MapTileLoadError.MISSING,
            filename=filename,
            map_id=map_id,
            adt_x=adt_x,
            adt_y=adt_y,
        )

    with open(maps_path, 'rb') as map_tiles:
        version = _read_cstring(map_tiles)
        if version != expected_version:
            return MapTileLoadResult(
                error=MapTileLoadError.VERSION,
                filename=filename,
                version=version,
                map_id=map_id,
                adt_x=adt_x,
                adt_y=adt_y,
            )

        heightmap_mode = unpack('<b', map_tiles.read(1))[0]

        v8_heights = None
        v9_heights = None
        uniform_height = None
        if heightmap_mode == HEIGHTMAP_MODE_UNIFORM:
            if use_float_16:
                uniform_height = Float16.decompress(unpack('>h', map_tiles.read(2))[0])
            else:
                uniform_height = unpack('<f', map_tiles.read(4))[0]
        elif heightmap_mode == HEIGHTMAP_MODE_V8V9:
            v9_heights = _read_height_grid(map_tiles, V9_GRID_SIZE, use_float_16)
            v8_heights = _read_height_grid(map_tiles, V8_GRID_SIZE, use_float_16)
        else:
            return MapTileLoadResult(
                error=MapTileLoadError.VERSION,
                filename=filename,
                version=f'{version} (unknown heightmap mode {heightmap_mode})',
                map_id=map_id,
                adt_x=adt_x,
                adt_y=adt_y,
            )

        area_data = [[None for _ in range(RESOLUTION_AREA_INFO)] for _ in range(RESOLUTION_AREA_INFO)]
        for x in range(RESOLUTION_AREA_INFO):
            for y in range(RESOLUTION_AREA_INFO):
                zone_id = unpack('<h', map_tiles.read(2))[0]
                if zone_id == -1:
                    continue
                area, flag, lvl, explore = unpack('<i2BH', map_tiles.read(8))
                area_data[x][y] = (zone_id, area, flag, lvl, explore)

        liquid_cells = {}
        cell_count = unpack('<H', map_tiles.read(2))[0]
        for _ in range(cell_count):
            cell_x, cell_y, layer_count = unpack('<BBB', map_tiles.read(3))
            layers = []
            for _ in range(layer_count):
                liq_type, flags = unpack('<BB', map_tiles.read(2))
                is_wmo = flags & LIQUID_FLAG_IS_WMO
                if is_wmo:
                    if use_float_16:
                        l_max = unpack('>h', map_tiles.read(2))[0]
                        l_min = unpack('>h', map_tiles.read(2))[0]
                    else:
                        l_max = unpack('<f', map_tiles.read(4))[0]
                        l_min = unpack('<f', map_tiles.read(4))[0]
                else:
                    if use_float_16:
                        l_max = unpack('>h', map_tiles.read(2))[0]
                    else:
                        l_max = unpack('<f', map_tiles.read(4))[0]

                    if uniform_height is not None:
                        height = uniform_height
                    else:
                        xh, yh = _map_liquid_to_height(cell_x, cell_y)
                        local_x = (xh * ADT_SIZE) / (RESOLUTION_ZMAP - 1)
                        local_z = (yh * ADT_SIZE) / (RESOLUTION_ZMAP - 1)
                        height = _calculate_height_from_v8v9(v8_heights, v9_heights, local_x, local_z)

                    if use_float_16:
                        l_min = Float16.compress(height - 3.0)
                    else:
                        l_min = math.floor(height - 3.0)

                # Compare decoded float values for float16; raw int ordering is not meaningful.
                if use_float_16:
                    l_max_cmp = Float16.decompress(l_max)
                    l_min_cmp = Float16.decompress(l_min)
                else:
                    l_max_cmp = l_max
                    l_min_cmp = l_min

                if l_max_cmp < l_min_cmp:
                    continue

                layers.append((liq_type, bool(is_wmo), l_min, l_max))

            if layers:
                liquid_cells[(cell_x << 8) | cell_y] = layers

        wmo_height_cells = {}
        wmo_cell_count = unpack('<H', map_tiles.read(2))[0]
        for _ in range(wmo_cell_count):
            cell_x, cell_y, height_count = unpack('<BBB', map_tiles.read(3))
            heights = []
            for _ in range(height_count):
                if use_float_16:
                    heights.append(Float16.decompress(unpack('>h', map_tiles.read(2))[0]))
                else:
                    heights.append(unpack('<f', map_tiles.read(4))[0])
            if heights:
                wmo_height_cells[(cell_x << 8) | cell_y] = heights

    return MapTileLoadResult(
        error=MapTileLoadError.NONE,
        filename=filename,
        map_id=map_id,
        adt_x=adt_x,
        adt_y=adt_y,
        uniform_height=uniform_height,
        v8_heights=v8_heights,
        v9_heights=v9_heights,
        area_data=area_data,
        liquid_cells=liquid_cells,
        wmo_height_cells=wmo_height_cells,
    )
