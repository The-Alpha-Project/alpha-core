import os
from os import path
from typing import Optional

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from game.world.managers.maps.helpers.Constants import RESOLUTION_ZMAP, RESOLUTION_LIQUIDS, RESOLUTION_AREA_INFO
from game.world.managers.maps.helpers.AreaInformation import AreaInformation
from game.world.managers.maps.helpers.LiquidInformation import LiquidInformation
from game.world.managers.maps.MapTileLoader import MapTileLoadError, load_map_tile_data
from utils.ConfigManager import config
from utils.Float16 import Float16
from utils.Logger import Logger
from utils.PathManager import PathManager


class MapTile:
    EXPECTED_VERSION = 'ACMAP_1.75'

    def __init__(self, map_, adt_x, adt_y):
        self.map_ = map_
        self.map_id = map_.map_id
        self.initialized = False
        self.ready = False
        self.has_maps = False
        self.has_navigation = False
        self.adt_x = adt_x
        self.adt_y = adt_y
        self.area_information: list[list[Optional[AreaInformation]]] = []
        self.liquid_information: list[list[Optional[LiquidInformation]]] = []
        self.z_height_map: list[list[float]] = []

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
        if not self.z_height_map:
            return 0.0
        if config.Server.Settings.use_float_16:
            return Float16.decompress(int(self.z_height_map[cell_x][cell_y]))
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
        self.has_maps = self.load_maps_data_sync()
        self.has_navigation = self.load_namigator_data(namigator)
        self.ready = True

    def unload(self):
        self.initialized = False
        self.has_maps = False
        self.has_navigation = False
        self.ready = False
        self.area_information = []
        self.liquid_information = []
        self.z_height_map = []

    def load_namigator_data(self, namigator):
        if not config.Server.Settings.use_nav_tiles or not namigator:
            return False
        return self._load_namigator_adt_navs(namigator)

    def apply_map_data(self, map_data, use_float_16):
        # Apply parsed map data from a worker process to avoid blocking the main ticker.
        if not map_data or map_data.error != MapTileLoadError.NONE:
            self.has_maps = False
            self.area_information = []
            self.liquid_information = []
            self.z_height_map = []
            return False

        self.z_height_map = map_data.z_height_map
        self.area_information = [[None for _ in range(RESOLUTION_AREA_INFO)] for _ in range(RESOLUTION_AREA_INFO)]
        for x in range(RESOLUTION_AREA_INFO):
            for y in range(RESOLUTION_AREA_INFO):
                area_entry = map_data.area_data[x][y]
                if not area_entry:
                    continue
                zone_id, area, flag, lvl, explore = area_entry
                area_info = self._get_area_information(self.map_id, zone_id, area, flag, lvl, explore)
                # noinspection PyTypeChecker
                self.area_information[x][y] = area_info

        self.liquid_information = [[None for _ in range(RESOLUTION_LIQUIDS)] for _ in range(RESOLUTION_LIQUIDS)]
        map_liquids = map_data.map_liquids
        if map_liquids:
            for x in range(RESOLUTION_LIQUIDS):
                for y in range(RESOLUTION_LIQUIDS):
                    liquid_entry = map_liquids[x][y]
                    if not liquid_entry:
                        continue
                    liq_type, l_min, l_max = liquid_entry
                    # noinspection PyTypeChecker
                    self.liquid_information[x][y] = self.map_.get_liquid_or_create(
                        liq_type,
                        l_min,
                        l_max,
                        use_float_16,
                        is_wmo=False,
                    )

        wmo_liquids = map_data.wmo_liquids
        if wmo_liquids:
            for x in range(RESOLUTION_LIQUIDS):
                for y in range(RESOLUTION_LIQUIDS):
                    liquids = wmo_liquids[x][y]
                    if not liquids:
                        continue
                    liq_type, l_min, l_max = liquids[0]
                    liq_info = self.map_.get_liquid_or_create(liq_type, l_min, l_max, use_float_16, is_wmo=True)
                    # noinspection PyTypeChecker
                    self.liquid_information[x][y] = liq_info
                    for nested in liquids[1:]:
                        n_type, n_min, n_max = nested
                        n_liq_info = self.map_.get_liquid_or_create(n_type, n_min, n_max, use_float_16, is_wmo=True)
                        liq_info.set_nested_liquid(n_liq_info)

        self.has_maps = True
        return True

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

    def load_maps_data_sync(self):
        if not config.Server.Settings.use_map_tiles:  # No .map files for dungeons.
            return False

        filename = f'{self.map_id:03}{self.adt_x:02}{self.adt_y:02}.map'
        Logger.info(f'[Maps] Loading map tile, Map:{self.map_id} Tile:{self.adt_x},{self.adt_y}, File: {filename}')

        map_data = load_map_tile_data(
            PathManager.get_maps_path(),
            self.map_id,
            self.adt_x,
            self.adt_y,
            config.Server.Settings.use_float_16,
            MapTile.EXPECTED_VERSION,
        )

        if map_data.error == MapTileLoadError.MISSING:
            Logger.warning(f'[Maps] Unable to locate map file: {filename}, '
                           f'Map:{self.map_id} Tile:{self.adt_x},{self.adt_y}')
            return False

        if map_data.error == MapTileLoadError.VERSION:
            Logger.error(f'[Maps] Unexpected map version. Expected "{MapTile.EXPECTED_VERSION}", found "{map_data.version}".')
            return False

        return self.apply_map_data(map_data, config.Server.Settings.use_float_16)

    def _map_liquid_to_height(self, x_liquid, y_liquid):
        x_height = int(round(x_liquid * (RESOLUTION_ZMAP - 1) / (RESOLUTION_LIQUIDS - 1)))
        y_height = int(round(y_liquid * (RESOLUTION_ZMAP - 1) / (RESOLUTION_LIQUIDS - 1)))
        return x_height, y_height

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
            version = map_tiles.read(10).split(b'\x00', 1)[0].decode('ascii', errors='ignore')
            if version != MapTile.EXPECTED_VERSION:
                return False

        return True
