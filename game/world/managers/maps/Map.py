from enum import IntEnum
from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from game.world.managers.maps.GridManager import GridManager
from utils.Logger import Logger


class MapType(IntEnum):
    INSTANCE = 0,
    COMMON = 1


class Map(object):
    def __init__(self, map_id):
        self.map_ = DbcDatabaseManager.map_get_by_id(map_id)
        self.grid_manager = GridManager(map_id)
        self.tiles_used = [[False for r in range(0, 64)] for c in range(0, 64)]
        self.tiles = [[None for r in range(0, 64)] for c in range(0, 64)]
        Logger.success(f'Initialized map {self.map_.MapName_enUS}')

    def is_dungeon(self):
        return self.map_.IsInMap == MapType.INSTANCE
