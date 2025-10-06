import os
from os import path
from struct import unpack

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from game.world.managers.maps.helpers.Constants import RESOLUTION_ZMAP, RESOLUTION_LIQUIDS, RESOLUTION_AREA_INFO
from network.packet.PacketReader import PacketReader
from utils.ConfigManager import config
from utils.Float16 import Float16
from utils.Logger import Logger
from utils.PathManager import PathManager


class MapTile(object):
    EXPECTED_VERSION = 'ACMAP_1.72'

    def __init__(self, map_, adt_x, adt_y):
        self.map_ = map_
        self.map_id = map_.map_id
        self.initialized = False
        self.ready = False
        self.has_maps = False
        self.has_navigation = False
        self.adt_x = adt_x
        self.adt_y = adt_y
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
        if config.Server.Settings.use_float_16:
            return Float16.decompress(self.z_height_map[cell_x][cell_y])
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

    def unload(self):
        self.initialized = False
        self.has_maps = False
        self.has_navigation = False
        self.ready = False
        if self.area_information:
            del self.area_information
        if self.liquid_information:
            del self.liquid_information
        if self.z_height_map:
            del self.z_height_map
        self.area_information = None
        self.liquid_information = None
        self.z_height_map = None

    def load_namigator_data(self, namigator):
        if not config.Server.Settings.use_nav_tiles or not namigator:
            return False
        return self._load_namigator_adt_navs(namigator)

    def _load_namigator_adt_navs(self, namigator):
        try:
            Logger.info(f'[Namigator] Loading navs, Map:{self.map_id} Tile:{self.adt_x},{self.adt_y}')
            if namigator.has_adts():
                # Notice, namigator has inverted coordinates.
                if not namigator.adt_loaded(self.adt_y, self.adt_x):
                    namigator.load_adt(self.adt_y, self.adt_x)
                self.has_navigation = namigator.adt_loaded(self.adt_y, self.adt_x)
            else:  # WMO only.
                self.has_navigation = True
            return self.has_navigation
        except RuntimeError:
            Logger.warning(f'[Namigator] Unable to load Adt nav for {self.adt_x},{self.adt_y}.')
        return False

    def load_maps_data(self):
        if not config.Server.Settings.use_map_tiles:  # No .map files for dungeons.
            return False
        filename = f'{self.map_id:03}{self.adt_x:02}{self.adt_y:02}.map'
        maps_path = PathManager.get_map_file_path(filename)
        Logger.info(f'[Maps] Loading map tile, Map:{self.map_id} Tile:{self.adt_x},{self.adt_y}, File: {filename}')

        if not path.exists(maps_path):
            Logger.warning(f'[Maps] Unable to locate map file: {filename}, '
                           f'Map:{self.map_id} Tile:{self.adt_x},{self.adt_y}')
            return False
        else:
            self.area_information = [[None for _ in range(RESOLUTION_AREA_INFO)] for _ in range(RESOLUTION_AREA_INFO)]
            self.liquid_information = [[None for _ in range(RESOLUTION_LIQUIDS)] for _ in range(RESOLUTION_LIQUIDS)]
            self.z_height_map = [[0 for _ in range(RESOLUTION_ZMAP)] for _ in range(RESOLUTION_ZMAP)]
            use_f16 = config.Server.Settings.use_float_16

            with open(maps_path, "rb") as map_tiles:
                version = PacketReader.read_string_from_stream(map_tiles)
                if version != MapTile.EXPECTED_VERSION:
                    Logger.error(f'[Maps] Unexpected map version. Expected "{MapTile.EXPECTED_VERSION}", found "{version}".')
                    return False

                # Height Map
                for x in range(RESOLUTION_ZMAP):
                    for y in range(RESOLUTION_ZMAP):
                        if use_f16:
                            self.z_height_map[x][y] = unpack('>h', map_tiles.read(2))[0]
                            continue
                        self.z_height_map[x][y] = unpack('<f', map_tiles.read(4))[0]

                # ZoneID, AreaNumber, AreaFlags, AreaLevel, AreaExploreFlag(Bit).
                for x in range(RESOLUTION_AREA_INFO):
                    for y in range(RESOLUTION_AREA_INFO):
                        zone_id = unpack('<i', map_tiles.read(4))[0]
                        if zone_id == -1:  # No area information.
                            continue
                        # Area, flags, level, explore_bit.
                        area, flag, lvl, explore = unpack('<i2BH', map_tiles.read(8))
                        # Create or use cached information.
                        area_info = self._get_area_information(self.map_id, zone_id, area, flag, lvl, explore)
                        # noinspection PyTypeChecker
                        self.area_information[x][y] = area_info

                # Liquids
                for x in range(RESOLUTION_LIQUIDS):
                    for y in range(RESOLUTION_LIQUIDS):
                        liquid_type = unpack('<b', map_tiles.read(1))[0]
                        if liquid_type == -1:  # No liquid information / not rendered.
                            continue
                        if use_f16:
                            height = unpack('>h', map_tiles.read(2))[0]
                        else:
                            height = unpack('<f', map_tiles.read(4))[0]
                        # noinspection PyTypeChecker
                        self.liquid_information[x][y] = self.map_.get_liquid_or_create(liquid_type, height, use_f16)

                has_wmo_liquids = unpack('<b', map_tiles.read(1))[0]
                if not has_wmo_liquids:
                    return True

                # Wmo Liquids
                for x in range(RESOLUTION_LIQUIDS):
                    for y in range(RESOLUTION_LIQUIDS):
                        liquid_type = unpack('<b', map_tiles.read(1))[0]
                        if liquid_type == -1:  # No liquid information / not rendered.
                            continue
                        if use_f16:
                            height = unpack('>h', map_tiles.read(2))[0]
                        else:
                            height = unpack('<f', map_tiles.read(4))[0]
                        # noinspection PyTypeChecker
                        self.liquid_information[x][y] = self.map_.get_liquid_or_create(liquid_type, height, use_f16)

        return True

    # noinspection PyMethodMayBeStatic
    def _get_area_information(self, map_id, zone, area, flag, level, explore):
        return DbcDatabaseManager.AreaInformationHolder.get_or_create(map_id, zone, area, flag, level, explore)

    @staticmethod
    def validate_version():
        # Try to use the first available tile map.
        map_file = None
        try:
            for file in os.listdir(PathManager.get_maps_path()):
                if file.endswith('.map'):
                    map_file = file
                    break
        except (FileNotFoundError, PermissionError, WindowsError):
            return False

        if not map_file:
            return False

        maps_path = PathManager.get_map_file_path(map_file)
        if not path.exists(maps_path):
            return False

        with open(maps_path, "rb") as map_tiles:
            version = PacketReader.read_string(map_tiles.read(10), 0)
            if version != MapTile.EXPECTED_VERSION:
                return False

        return True
