import math
import os
from dataclasses import dataclass
from enum import IntEnum
from struct import unpack
from typing import Optional

from game.world.managers.maps.helpers.Constants import RESOLUTION_ZMAP, RESOLUTION_LIQUIDS, RESOLUTION_AREA_INFO


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
    z_height_map: Optional[list[list[float]]] = None
    area_data: Optional[list[list[Optional[tuple]]]] = None
    map_liquids: Optional[list[list[Optional[tuple]]]] = None
    wmo_liquids: Optional[list[list[Optional[list[tuple]]]]] = None


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

        z_height_map = [[0.0 for _ in range(RESOLUTION_ZMAP)] for _ in range(RESOLUTION_ZMAP)]
        for x in range(RESOLUTION_ZMAP):
            for y in range(RESOLUTION_ZMAP):
                if use_float_16:
                    z_height_map[x][y] = unpack('>h', map_tiles.read(2))[0]
                else:
                    z_height_map[x][y] = unpack('<f', map_tiles.read(4))[0]

        area_data = [[None for _ in range(RESOLUTION_AREA_INFO)] for _ in range(RESOLUTION_AREA_INFO)]
        for x in range(RESOLUTION_AREA_INFO):
            for y in range(RESOLUTION_AREA_INFO):
                zone_id = unpack('<h', map_tiles.read(2))[0]
                if zone_id == -1:
                    continue
                area, flag, lvl, explore = unpack('<i2BH', map_tiles.read(8))
                area_data[x][y] = (zone_id, area, flag, lvl, explore)

        map_liquids = [[None for _ in range(RESOLUTION_LIQUIDS)] for _ in range(RESOLUTION_LIQUIDS)]
        for x in range(RESOLUTION_LIQUIDS):
            for y in range(RESOLUTION_LIQUIDS):
                liq_type = unpack('<b', map_tiles.read(1))[0]
                if liq_type == -1:
                    continue
                if use_float_16:
                    l_max = unpack('>h', map_tiles.read(2))[0]
                else:
                    l_max = unpack('<f', map_tiles.read(4))[0]

                xh, yh = _map_liquid_to_height(x, y)
                l_min = math.floor(z_height_map[xh][yh] - 3.0)
                if l_max > l_min:
                    map_liquids[x][y] = (liq_type, l_min, l_max)

        has_wmo_liquids = unpack('<b', map_tiles.read(1))[0]
        wmo_liquids = None
        if has_wmo_liquids:
            wmo_liquids = [[None for _ in range(RESOLUTION_LIQUIDS)] for _ in range(RESOLUTION_LIQUIDS)]
            for x in range(RESOLUTION_LIQUIDS):
                for y in range(RESOLUTION_LIQUIDS):
                    liq_count = unpack('<b', map_tiles.read(1))[0]
                    if liq_count <= 0:
                        continue
                    liquids = []
                    for _ in range(liq_count):
                        liq_type = unpack('<b', map_tiles.read(1))[0]
                        if liq_type == -1:
                            continue
                        if use_float_16:
                            l_max = unpack('>h', map_tiles.read(2))[0]
                            l_min = unpack('>h', map_tiles.read(2))[0]
                        else:
                            l_max = unpack('<f', map_tiles.read(4))[0]
                            l_min = math.floor(unpack('<f', map_tiles.read(4))[0])

                        if l_max < l_min:
                            continue
                        liquids.append((liq_type, l_min, l_max))
                    if liquids:
                        wmo_liquids[x][y] = liquids

    return MapTileLoadResult(
        error=MapTileLoadError.NONE,
        filename=filename,
        map_id=map_id,
        adt_x=adt_x,
        adt_y=adt_y,
        z_height_map=z_height_map,
        area_data=area_data,
        map_liquids=map_liquids,
        wmo_liquids=wmo_liquids,
    )
