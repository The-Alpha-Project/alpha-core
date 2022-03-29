from enum import IntEnum

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from game.world.managers.maps.GridManager import GridManager


class MapType(IntEnum):
    INSTANCE = 0
    COMMON = 1


class Map(object):
    def __init__(self, map_id, active_cell_callback):
        self.map_ = DbcDatabaseManager.map_get_by_id(map_id)
        self.grid_manager = GridManager(map_id, active_cell_callback)
        self.tiles = [[None for r in range(0, 64)] for c in range(0, 64)]

    def is_dungeon(self):
        return self.map_.IsInMap == MapType.INSTANCE
