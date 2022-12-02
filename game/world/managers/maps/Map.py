import traceback
from enum import IntEnum
from os import path
from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from game.world.managers.maps.GridManager import GridManager
from utils.Logger import Logger
from utils.PathManager import PathManager


class MapType(IntEnum):
    INSTANCE = 0
    COMMON = 1


class Map:
    def __init__(self, map_id, active_cell_callback):
        self.map_ = DbcDatabaseManager.map_get_by_id(map_id)
        self.grid_manager = GridManager(map_id, active_cell_callback)
        self.tiles = [[None for r in range(64)] for c in range(64)]
        self.name = self.map_.MapName_enUS
        self.namigator = None
        self._loaded_adts = {}

    def has_navigation(self):
        return self.namigator is not None

    def load_adt(self, raw_x, raw_y, adt_x, adt_y):
        try:
            if self.namigator is None:
                return False

            adt_key = f'{adt_x},{adt_y}'
            if adt_key in self._loaded_adts:
                return True

            Logger.debug(f'Loading nav ADT {adt_x},{adt_y} for Map {self.name}')
            self.namigator.load_adt_at(raw_x, raw_y)
            self._loaded_adts[adt_key] = True
            return True
        except:
            return False

    def build_navigation(self, pathfind):
        try:
            nav_root_path = PathManager.get_navs_path()
            nav_map_path = PathManager.get_nav_map_path(self.name)
            if not path.exists(nav_root_path) or not path.exists(nav_map_path):
                Logger.warning(f'Unable to locate namigator data for map {self.name}')
                return
            self.namigator = pathfind.Map(nav_root_path, f'{self.name}')
        except:
            Logger.error(traceback.format_exc())

    def is_dungeon(self):
        return self.map_.IsInMap == MapType.INSTANCE

    def is_pvp(self):
        return self.map_.PVP == 1
