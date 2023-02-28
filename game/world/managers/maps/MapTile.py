import traceback
from enum import IntEnum
from os import path
from struct import unpack

from game.world.managers.maps.helpers.AreaInformation import AreaInformation
from game.world.managers.maps.helpers.Constants import RESOLUTION_ZMAP, RESOLUTION_LIQUIDS, RESOLUTION_AREA_INFO
from game.world.managers.maps.helpers.LiquidInformation import LiquidInformation
from network.packet.PacketReader import PacketReader
from utils.ConfigManager import config
from utils.Logger import Logger
from utils.PathManager import PathManager


class MapTileStates(IntEnum):
    READY = 0
    LOADING = 1
    UNUSABLE = 2


class MapTile(object):
    EXPECTED_VERSION = 'ACMAP_1.40'

    def __init__(self, map_id, adt_x, adt_y):
        self.initialized = False
        self.ready = False
        self.has_maps = False
        self.has_navigation = False
        self.adt_x = adt_x
        self.adt_y = adt_y
        self.cell_map = map_id
        self.area_information = None
        self.liquid_information = None
        self.z_height_map = None

    def can_use(self):
        return self.initialized and self.ready and (self.has_maps or self.has_navigation)

    def get_liquids_at(self, cell_x, cell_y):
        if not self.has_maps or not self.liquid_information:
            return None
        return self.liquid_information[cell_x][cell_y]

    def get_area_at(self, cell_x, cell_y):
        if not self.has_maps or not self.area_information:
            return None
        return self.area_information[cell_x][cell_y]

    def get_z_at(self, cell_x, cell_y):
        return self.z_height_map[cell_x][cell_y]

    def is_initialized(self):
        return self.initialized

    def is_ready(self):
        return self.ready

    def is_loading(self):
        return self.initialized and not self.ready

    def initialize(self, namigator):
        if self.initialized:
            return
        # Set as initialized to avoid another load() call from another thread.
        self.initialized = True
        self.has_maps = self.load_maps_data()
        self.has_navigation = self.load_namigator_data(namigator)
        self.ready = True

    def load_namigator_data(self, namigator):
        if not config.Server.Settings.use_nav_tiles or not namigator:
            return False
        try:
            Logger.debug(f'[Namigator] Loading nav ADT, Map:{self.cell_map} Tile:{self.adt_x},{self.adt_y}')
            # Notice, namigator has inverted coordinates.
            namigator.load_adt(self.adt_y, self.adt_x)
            self.has_navigation = True
            return True
        except:
            Logger.error(traceback.format_exc())
            return False

    def load_maps_data(self):
        if not config.Server.Settings.use_map_tiles:
            return False
        filename = f'{self.cell_map:03}{self.adt_x:02}{self.adt_y:02}.map'
        maps_path = PathManager.get_map_file_path(filename)
        Logger.debug(f'[Maps] Loading map file: {filename}, Map:{self.cell_map} Tile:{self.adt_x},{self.adt_y}')

        if not path.exists(maps_path):
            Logger.warning(f'[Maps] Unable to locate map file: {filename}, '
                           f'Map:{self.cell_map} Tile:{self.adt_x},{self.adt_y}')
            return False
        else:
            self.area_information = [[None for r in range(RESOLUTION_AREA_INFO)] for c in range(RESOLUTION_AREA_INFO)]
            self.liquid_information = [[None for r in range(RESOLUTION_LIQUIDS)] for c in range(RESOLUTION_LIQUIDS)]
            self.z_height_map = [[0 for r in range(RESOLUTION_ZMAP)] for c in range(RESOLUTION_ZMAP)]

            with open(maps_path, "rb") as map_tiles:
                version = PacketReader.read_string(map_tiles.read(10), 0)
                if version != MapTile.EXPECTED_VERSION:
                    Logger.error(f'[Maps] Unexpected map version. Expected "{MapTile.EXPECTED_VERSION}", found "{version}".')
                    return False

                # Height Map
                for x in range(RESOLUTION_ZMAP):
                    for y in range(RESOLUTION_ZMAP):
                        self.z_height_map[x][y] = unpack('<f', map_tiles.read(4))[0]

                # ZoneID, AreaNumber, AreaFlags, AreaLevel, AreaExploreFlag(Bit), AreaFactionMask
                for x in range(RESOLUTION_AREA_INFO):
                    for y in range(RESOLUTION_AREA_INFO):
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
                for x in range(RESOLUTION_LIQUIDS):
                    for y in range(RESOLUTION_LIQUIDS):
                        liquid_type = unpack('<b', map_tiles.read(1))[0]
                        if liquid_type == -1:  # No liquid information / not rendered.
                            continue
                        height = unpack('<f', map_tiles.read(4))[0]
                        # noinspection PyTypeChecker
                        self.liquid_information[x][y] = LiquidInformation(liquid_type, height)
        return True

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
