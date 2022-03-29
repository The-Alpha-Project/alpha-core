from os import path
from struct import unpack

from game.world.managers.maps.AreaInformation import AreaInformation
from game.world.managers.maps.Constants import RESOLUTION_ZMAP, RESOLUTION_LIQUIDS, RESOLUTION_AREA_INFO
from game.world.managers.maps.LiquidInformation import LiquidInformation
from network.packet.PacketReader import PacketReader
from utils.Logger import Logger
from utils.PathManager import PathManager


class MapTile(object):
    EXPECTED_VERSION = 'ACMAP_1.40'

    def __init__(self, map_id, tile_x, tile_y):
        self.initialized = False
        self.is_valid = False
        self.cell_x = tile_x
        self.cell_y = tile_y
        self.cell_map = map_id
        self.area_information = [[None for r in range(0, RESOLUTION_AREA_INFO)] for c in range(0, RESOLUTION_AREA_INFO)]
        self.liquid_information = [[None for r in range(0, RESOLUTION_LIQUIDS)] for c in range(0, RESOLUTION_LIQUIDS)]
        self.z_height_map = [[0 for r in range(0, RESOLUTION_ZMAP)] for c in range(0, RESOLUTION_ZMAP)]
        self.load()

    def load(self):
        # Set as initialized to avoid another load() call from another thread.
        self.initialized = True

        filename = f'{self.cell_map:03}{self.cell_x:02}{self.cell_y:02}.map'
        maps_path = PathManager.get_map_file_path(filename)
        Logger.debug(f'[Maps] Loading map file: {filename}, Map:{self.cell_map} Tile:{self.cell_x},{self.cell_y}')

        if not path.exists(maps_path):
            Logger.warning(f'Unable to locate map file: {filename}, Map:{self.cell_map} Tile:{self.cell_x},{self.cell_y}')
            return
        else:
            with open(maps_path, "rb") as map_tiles:
                version = PacketReader.read_string(map_tiles.read(10), 0)
                if version != MapTile.EXPECTED_VERSION:
                    Logger.error(f'Unexpected map version. Expected "{MapTile.EXPECTED_VERSION}", found "{version}".')
                    return

                # Height Map
                for x in range(0, RESOLUTION_ZMAP):
                    for y in range(0, RESOLUTION_ZMAP):
                        self.z_height_map[x][y] = unpack('<f', map_tiles.read(4))[0]

                # ZoneID, AreaNumber, AreaFlags, AreaLevel, AreaExploreFlag(Bit), AreaFactionMask
                for x in range(0, RESOLUTION_AREA_INFO):
                    for y in range(0, RESOLUTION_AREA_INFO):
                        zone_id = unpack('<i', map_tiles.read(4))[0]
                        if zone_id == -1:  # No area information.
                            continue
                        area_number = unpack('<I', map_tiles.read(4))[0]
                        area_flags = unpack('<B', map_tiles.read(1))[0]
                        area_level = unpack('<B', map_tiles.read(1))[0]
                        area_explore_bit = unpack('<H', map_tiles.read(2))[0]
                        area_faction_mask = unpack('<B', map_tiles.read(1))[0]
                        # noinspection PyTypeChecker
                        self.area_information[x][y] = AreaInformation(zone_id, area_number, area_flags, area_level, area_explore_bit, area_faction_mask)

                # Liquids
                for x in range(0, RESOLUTION_LIQUIDS):
                    for y in range(0, RESOLUTION_LIQUIDS):
                        liquid_type = unpack('<b', map_tiles.read(1))[0]
                        if liquid_type == -1:  # No liquid information / not rendered.
                            continue
                        height = unpack('<f', map_tiles.read(4))[0]
                        # noinspection PyTypeChecker
                        self.liquid_information[x][y] = LiquidInformation(liquid_type, height)

        # This is a valid tile, set as loaded.
        self.is_valid = True

    @staticmethod
    def validate_version():
        # Use the first available tile map.
        filename = '0000000.map'
        maps_path = PathManager.get_map_file_path(filename)

        if not path.exists(maps_path):
            return False

        with open(maps_path, "rb") as map_tiles:
            version = PacketReader.read_string(map_tiles.read(10), 0)
            if version != MapTile.EXPECTED_VERSION:
                return False

        return True
