from game.world.managers.objects.mmaps.DBCReader import DBCReader
from game.world.managers.objects.mmaps.Enums import DBCValueType, MapType


class Map(object):
    def __init__(self):
        self.map_id = 0
        self.map_type = MapType.COMMON
        self.name = ''
        self.tiles_used = [[False for row in range(0, 64)] for col in range(0, 64)]
        self.tiles = [[None for row in range(0, 64)] for col in range(0, 64)]

    def is_dungeon(self):
        return self.map_type == 1

    def load(self, map_id):
        tmp_dbc = DBCReader('Map.dbc')
        for i in range(0, tmp_dbc.rows - 1):
            tmp_map = tmp_dbc.read_value(i, 0, DBCValueType.DBC_INTEGER)
            if map_id == tmp_map:
                self.map_id = map_id
                self.map_type = MapType(tmp_dbc.read_value(i, 2, DBCValueType.DBC_INTEGER))
                self.name = tmp_dbc.read_value(i, 4, DBCValueType.DBC_STRING)
                break
