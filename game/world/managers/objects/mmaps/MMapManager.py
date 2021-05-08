import math
import traceback

from game.world.managers.objects.mmaps.Constants import SIZE, RESOLUTION_ZMAP, RESOLUTION_WATER, RESOLUTION_TERRAIN, \
    RESOLUTION_FLAGS
from game.world.managers.objects.mmaps.Map import Map
from game.world.managers.objects.mmaps.MapTile import MapTile
from utils.Logger import Logger

MAPS = {}
MAP_LIST = [0, 1]  # Both continents


class MMapManager(object):
    @staticmethod
    def initialize_maps():
        for map in MAP_LIST:
            new_map = Map()
            new_map.load(map)
            MAPS[map] = new_map

    @staticmethod
    def load_mmap(map, x, y):
        x = MMapManager.get_tile_x(x)
        y = MMapManager.get_tile_y(y)

        if map not in MAP_LIST:
            return

        for i in range(-1, 1):
            for j in range(-1, 1):
                if -1 < x + i < 64 and -1 < y + j < 64:
                    if not MAPS[map].tiles_used[x + i][y + j]:
                        MAPS[map].tiles_used[x + i][y + j] = True
                        MAPS[map].tiles[x + i][y + j] = MapTile(x + i, y + j, map)

    @staticmethod
    def get_tile(x, y):
        tile_x = int(32.0 - MMapManager.validate_map_coord(x) / SIZE)
        tile_y = int(32.0 - MMapManager.validate_map_coord(y) / SIZE)
        return [tile_x, tile_y]

    @staticmethod
    def get_tile_x(x):
        tile_x = int(32.0 - MMapManager.validate_map_coord(x) / SIZE)
        return tile_x

    @staticmethod
    def get_tile_y(y):
        tile_y = int(32.0 - MMapManager.validate_map_coord(y) / SIZE)
        return tile_y

    @staticmethod
    def get_submap_tile_x(x):
        tile_x = int(RESOLUTION_ZMAP * (
                32.0 - MMapManager.validate_map_coord(x) / SIZE - int(
            32.0 - MMapManager.validate_map_coord(x) / SIZE)))

        return tile_x

    @staticmethod
    def get_submap_tile_y(y):
        tile_y = int(RESOLUTION_ZMAP * (
                32.0 - MMapManager.validate_map_coord(y) / SIZE - int(
            32.0 - MMapManager.validate_map_coord(y) / SIZE)))

        return tile_y

    @staticmethod
    def get_z_coord(map_id, x, y):
        try:
            x = MMapManager.validate_map_coord(x)
            y = MMapManager.validate_map_coord(y)
            map_tile_x = int(32.0 - (x / SIZE))
            map_tile_y = int(32.0 - (y / SIZE))
            map_tile_local_x = math.floor(RESOLUTION_ZMAP * (32.0 - (x / SIZE) - map_tile_x))
            map_tile_local_y = math.floor(RESOLUTION_ZMAP * (32.0 - (y / SIZE) - map_tile_y))
            x_normalized = RESOLUTION_ZMAP * (32.0 - (x / SIZE) - map_tile_x) - map_tile_local_x
            y_normalized = RESOLUTION_ZMAP * (32.0 - (y / SIZE) - map_tile_y) - map_tile_local_y

            if map_id not in MAPS or not MAPS[map_id].tiles[map_tile_x][map_tile_y]:
                Logger.warning(f'Tile [{map_tile_x},{map_tile_y}] information not found.')
                return 0.0
            else:
                try:
                    val_1 = MMapManager.get_height(map_id, map_tile_x, map_tile_y, map_tile_local_x, map_tile_local_y)
                    val_2 = MMapManager.get_height(map_id, map_tile_x, map_tile_y, map_tile_local_x + 1, map_tile_local_y)
                    top_height = MMapManager._lerp(val_1, val_2, x_normalized)
                    val_3 = MMapManager.get_height(map_id, map_tile_x, map_tile_y, map_tile_local_x, map_tile_local_y + 1)
                    val_4 = MMapManager.get_height(map_id, map_tile_x, map_tile_y, map_tile_local_x + 1, map_tile_local_y + 1)
                    bottom_height = MMapManager._lerp(val_3, val_4, x_normalized)
                    return MMapManager._lerp(top_height, bottom_height, y_normalized)
                except:
                    return MAPS[map_id].tiles[map_tile_x][map_tile_y].z_coords[map_tile_local_x][map_tile_local_x]
        except Exception:
            Logger.error(traceback.format_exc())
            return 0.0

    @staticmethod
    def get_water_level(map_id, x, y):
        x = MMapManager.validate_map_coord(x)
        y = MMapManager.validate_map_coord(y)
        map_tile_x = int(32.0 - (x / SIZE))
        map_tile_y = int(32.0 - (y / SIZE))
        tile_local_x = int(RESOLUTION_WATER * (32.0 - (x / SIZE) - map_tile_x))
        tile_local_y = int(RESOLUTION_WATER * (32.0 - (y / SIZE) - map_tile_y))

        if map_id not in MAPS or not MAPS[map_id].tiles[map_tile_x][map_tile_y]:
            return 0.0
        return MAPS[map_id].tiles[map_tile_x][map_tile_y].water_level[tile_local_x][tile_local_y]

    @staticmethod
    def get_terrain_type(map_id, x, y):
        x = MMapManager.validate_map_coord(x)
        y = MMapManager.validate_map_coord(y)
        map_tile_x = int(32.0 - (x / SIZE))
        map_tile_y = int(32.0 - (y / SIZE))
        tile_local_x = int(RESOLUTION_TERRAIN * (32.0 - (x / SIZE) - map_tile_x))
        tile_local_y = int(RESOLUTION_TERRAIN * (32.0 - (y / SIZE) - map_tile_y))

        if map_id not in MAPS or not MAPS[map_id].tiles[map_tile_x][map_tile_y]:
            return 0.0
        return MAPS[map_id].tiles[map_tile_x][map_tile_y].area_terrain[tile_local_x][tile_local_y]

    @staticmethod
    def get_area_flag(map_id, x, y):
        x = MMapManager.validate_map_coord(x)
        y = MMapManager.validate_map_coord(y)
        map_tile_x = int(32.0 - (x / SIZE))
        map_tile_y = int(32.0 - (y / SIZE))
        tile_local_x = int(RESOLUTION_FLAGS * (32.0 - (x / SIZE) - map_tile_x))
        tile_local_y = int(RESOLUTION_FLAGS * (32.0 - (y / SIZE) - map_tile_y))

        if map_id not in MAPS or not MAPS[map_id].tiles[map_tile_x][map_tile_y]:
            return 0.0
        return MAPS[map_id].tiles[map_tile_x][map_tile_y].area_terrain[tile_local_x][tile_local_y]

    @staticmethod
    def get_height(map_id, map_tile_x, map_tile_y, map_tile_local_x, map_tile_local_y):
        if map_tile_local_x > RESOLUTION_ZMAP:
            map_tile_x = int(map_tile_x + 1)
            map_tile_local_x = int(map_tile_local_x - (RESOLUTION_ZMAP + 1))
        elif map_tile_local_x < 0:
            map_tile_x = int(map_tile_x - 1)
            map_tile_local_x = int(-map_tile_local_x - 1)

        if map_tile_local_y > RESOLUTION_ZMAP:
            map_tile_y = int(map_tile_y + 1)
            map_tile_local_y = int(map_tile_local_y - (RESOLUTION_ZMAP + 1))
        elif map_tile_local_y < 0:
            map_tile_y = int(map_tile_y - 1)
            map_tile_local_y = int(-map_tile_local_y - 1)

        return MAPS[map_id].tiles[map_tile_x][map_tile_y].z_coords[map_tile_local_x][map_tile_local_y]

    @staticmethod
    def validate_map_coord(coord):
        if coord > 32.0 * SIZE:
            return 32.0 * SIZE
        elif coord < -32.0 * SIZE:
            return -32 * SIZE
        else:
            return coord

    @staticmethod
    def _lerp(value1, value2, amount):
        return value1 + (value2 - value1) * amount

