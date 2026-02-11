import os
from os import path
from typing import Optional

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from game.world.managers.maps.helpers.Constants import RESOLUTION_ZMAP, RESOLUTION_LIQUIDS, RESOLUTION_AREA_INFO, \
    ADT_SIZE, UNIT_SIZE, V8_GRID_SIZE, V9_GRID_SIZE
from game.world.managers.maps.helpers.AreaInformation import AreaInformation
from game.world.managers.maps.helpers.MapUtils import MapUtils
from game.world.managers.maps.MapTileLoader import MapTileLoadError, load_map_tile_data
from utils.ConfigManager import config
from utils.Logger import Logger
from utils.PathManager import PathManager
from utils.constants.MiscCodes import ZSource


class MapTile:
    EXPECTED_VERSION = 'ACMAP_1.76'

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
        self.liquid_information = {}
        self.uniform_height = None
        self.v8_heights = None
        self.v9_heights = None
        self.wmo_height_cells = {}

    def can_use(self):
        return self.initialized and self.ready and (self.has_maps or self.has_navigation)

    def get_liquids_at(self, cell_x, cell_y):
        if not self.has_maps or not self.liquid_information:
            return None
        return self.liquid_information.get((cell_x << 8) | cell_y)

    def get_wmo_heights_at(self, cell_x, cell_y):
        if not self.has_maps or not self.wmo_height_cells:
            return None
        return self.wmo_height_cells.get((cell_x << 8) | cell_y)

    def get_area_at(self, cell_x, cell_y):
        if not self.has_maps or not self.area_information:
            return None
        return self.area_information[cell_x][cell_y]

    def get_z_at(self, cell_x, cell_y):
        return self.get_height_at_cell(cell_x, cell_y)

    def get_height_at_world(self, x, y):
        if self.uniform_height is not None:
            return self.uniform_height
        if not self.v8_heights or not self.v9_heights:
            return 0.0
        local_x = (32.0 - (x / ADT_SIZE) - self.adt_x) * ADT_SIZE
        local_z = (32.0 - (y / ADT_SIZE) - self.adt_y) * ADT_SIZE
        return self._calculate_height(local_x, local_z)

    def get_best_height_at_world(self, x, y, current_z, navs_z=0.0):
        terrain_z = self.get_height_at_world(x, y)
        wmo_adt_x, wmo_adt_y, wmo_cell_x, wmo_cell_y = MapUtils.calculate_tile(x, y, RESOLUTION_ZMAP - 1)
        if wmo_adt_x != self.adt_x or wmo_adt_y != self.adt_y:
            return terrain_z, ZSource.TERRAIN

        wmo_heights = self.get_wmo_heights_at(wmo_cell_x, wmo_cell_y)
        if not wmo_heights:
            return terrain_z, ZSource.TERRAIN

        candidates = [terrain_z] + wmo_heights

        # If we have navs z, append it to candidates.
        if navs_z:
            candidates.append(navs_z)

        best_z = min(candidates, key=lambda z: abs(current_z - z))
        if best_z == terrain_z:
            return best_z, ZSource.TERRAIN

        return best_z, ZSource.WMO

    def get_height_at_cell(self, cell_x, cell_y):
        if self.uniform_height is not None:
            return self.uniform_height
        if not self.v8_heights or not self.v9_heights:
            return 0.0
        local_x = (cell_x * ADT_SIZE) / (RESOLUTION_ZMAP - 1)
        local_z = (cell_y * ADT_SIZE) / (RESOLUTION_ZMAP - 1)
        return self._calculate_height(local_x, local_z)

    def _get_v8(self, x, y):
        return self.v8_heights[(x * V8_GRID_SIZE) + y]

    def _get_v9(self, x, y):
        return self.v9_heights[(x * V9_GRID_SIZE) + y]

    def _calculate_height(self, local_x, local_z):
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
        v0y = self._get_v8(xc, zc)
        v0z = half_unit

        if lx > lz:
            v1x = UNIT_SIZE
            v1y = self._get_v9(xc + 1, zc)
            v1z = 0.0
        else:
            v1x = 0.0
            v1y = self._get_v9(xc, zc + 1)
            v1z = UNIT_SIZE

        if lz > UNIT_SIZE - lx:
            v2x = UNIT_SIZE
            v2y = self._get_v9(xc + 1, zc + 1)
            v2z = UNIT_SIZE
        else:
            v2x = 0.0
            v2y = self._get_v9(xc, zc)
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
        self.liquid_information = {}
        self.uniform_height = None
        self.v8_heights = None
        self.v9_heights = None
        self.wmo_height_cells = {}

    def load_namigator_data(self, namigator):
        if not config.Server.Settings.use_nav_tiles or not namigator:
            return False
        return self._load_namigator_adt_navs(namigator)

    def apply_map_data(self, map_data, use_float_16):
        # Apply parsed map data from a worker process to avoid blocking the main ticker.
        if not map_data or map_data.error != MapTileLoadError.NONE:
            self.has_maps = False
            self.area_information = []
            self.liquid_information = {}
            self.uniform_height = None
            self.v8_heights = None
            self.v9_heights = None
            self.wmo_height_cells = {}
            return False

        self.uniform_height = map_data.uniform_height
        if self.uniform_height is not None:
            self.v8_heights = None
            self.v9_heights = None
        else:
            self.v8_heights = map_data.v8_heights
            self.v9_heights = map_data.v9_heights
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

        self.liquid_information = {}
        liquid_cells = map_data.liquid_cells
        if liquid_cells:
            for cell_key, layers in liquid_cells.items():
                liq_info = None
                for liq_type, is_wmo, l_min, l_max in layers:
                    current = self.map_.get_liquid_or_create(liq_type, l_min, l_max, use_float_16, is_wmo=is_wmo)
                    if liq_info is None:
                        liq_info = current
                    else:
                        liq_info.set_nested_liquid(current)
                if liq_info:
                    self.liquid_information[cell_key] = liq_info

        self.wmo_height_cells = map_data.wmo_height_cells or {}

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
