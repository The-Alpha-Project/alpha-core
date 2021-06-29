from os import path
from struct import unpack

from game.world.managers.maps.Constants import RESOLUTION_ZMAP, RESOLUTION_WATER, RESOLUTION_AREA_INFO
from network.packet.PacketReader import PacketReader
from utils.Logger import Logger
from utils.PathManager import PathManager


class MapTile(object):
    EXPECTED_VERSION = 'ACMAP_1.10'

    def __init__(self, map_id, tile_x, tile_y):
        self.cell_x = tile_x
        self.cell_y = tile_y
        self.cell_map = map_id
        self.area_number = [[0 for r in range(0, RESOLUTION_AREA_INFO + 1)] for c in range(0, RESOLUTION_AREA_INFO + 1)]
        self.area_flags = [[0 for r in range(0, RESOLUTION_AREA_INFO + 1)] for c in range(0, RESOLUTION_AREA_INFO + 1)]
        self.area_level = [[0 for r in range(0, RESOLUTION_AREA_INFO + 1)] for c in range(0, RESOLUTION_AREA_INFO + 1)]
        self.area_explore_flag = [[0 for r in range(0, RESOLUTION_AREA_INFO + 1)] for c in range(0, RESOLUTION_AREA_INFO + 1)]
        self.area_faction_mask = [[0 for r in range(0, RESOLUTION_AREA_INFO + 1)] for c in range(0, RESOLUTION_AREA_INFO + 1)]
        self.water_level = [[0 for r in range(0, RESOLUTION_WATER + 1)] for c in range(0, RESOLUTION_WATER + 1)]
        self.z_coords = [[0 for r in range(0, RESOLUTION_ZMAP + 1)] for c in range(0, RESOLUTION_ZMAP + 1)]

        self.load()

    def load(self):
        filename = f'{self.cell_map:03}{self.cell_x:02}{self.cell_y:02}.map'
        maps_path = PathManager.get_map_file_path(filename)
        Logger.debug(f'[Maps] Loading map file: {filename}')

        if not path.exists(maps_path):
            Logger.warning(f'Unable to locate map file: {filename}')
        else:
            with open(maps_path, "rb") as map_tiles:
                version = PacketReader.read_string(map_tiles.read(10), 0)
                if version != MapTile.EXPECTED_VERSION:
                    Logger.error(f'Unexpected map version. Expected "{MapTile.EXPECTED_VERSION}", found "{version}".')
                    return

                # Height Map
                for x in range(0, RESOLUTION_ZMAP + 1):
                    for y in range(0, RESOLUTION_ZMAP + 1):
                        self.z_coords[x][y] = unpack('<f', map_tiles.read(4))[0]

                # AreaNumber, AreaFlags, AreaLevel, AreaExploreFlag(Bit), AreaFactionMask
                for x in range(0, RESOLUTION_AREA_INFO + 1):
                    for y in range(0, RESOLUTION_AREA_INFO + 1):
                        self.area_number[x][y] = unpack('<I', map_tiles.read(4))[0]
                        self.area_flags[x][y] = unpack('<B', map_tiles.read(1))[0]
                        self.area_level[x][y] = unpack('<B', map_tiles.read(1))[0]
                        self.area_explore_flag[x][y] = unpack('<H', map_tiles.read(2))[0]
                        self.area_faction_mask[x][y] = unpack('<B', map_tiles.read(1))[0]

                # TODO: Liquids
                # for x in range(0, RESOLUTION_WATER + 1):
                #     for y in range(0, RESOLUTION_WATER + 1):
                #         self.water_level[x][y] = unpack('<f', map_tiles.read(4))[0]
