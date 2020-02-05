import math

from utils.constants.ObjectCodes import ObjectTypes

TOLERANCE = 0.00001
GRID_SIZE = 300

GRIDS = dict()


class GridManager(object):
    @staticmethod
    def add_or_get(worldobject, store=False):
        grid_coords = GridManager.GridCoords(worldobject.location, worldobject.map_)
        if grid_coords.key in GRIDS:
            grid = GRIDS[grid_coords.key]
        else:
            grid = Grid(grid_coords.min_x, grid_coords.min_y, grid_coords.max_x, grid_coords.max_y, grid_coords.map_)
            GRIDS[grid.key] = grid

        if store:
            grid.add(worldobject)

        return grid

    class GridCoords(object):
        def __init__(self, vector, map_):
            self.mod_x = vector.x / GRID_SIZE
            self.mod_y = vector.y / GRID_SIZE

            self.max_x = math.ceil(self.mod_x) * GRID_SIZE - TOLERANCE
            self.max_y = math.ceil(self.mod_y) * GRID_SIZE - TOLERANCE
            self.min_x = self.max_x - GRID_SIZE + TOLERANCE
            self.min_y = self.max_y - GRID_SIZE + TOLERANCE
            self.map_ = map_
            self.key = '%u:%u:%u:%u%u' % (round(self.min_x, 5), round(self.min_y, 5), round(self.max_x, 5),
                                          round(self.max_y, 5), self.map_)


class Grid(object):
    def __init__(self, min_x=0.0, min_y=0.0, max_x=0.0, max_y=0.0, map_=0.0, zones=None, gameobjects=None,
                 creatures=None, players=None, key=''):
        self.min_x = min_x
        self.min_y = min_y
        self.max_x = max_x
        self.max_y = max_y
        self.map_ = map_
        self.zones = zones
        self.key = key
        self.gameobjects = gameobjects
        self.creatures = creatures
        self.players = players

        if not key:
            self.key = '%u:%u:%u:%u%u' % (round(self.min_x, 5), round(self.min_y, 5), round(self.max_x, 5),
                                          round(self.max_y, 5), self.map_)

        if not gameobjects:
            self.gameobjects = dict()
        if not creatures:
            self.creatures = dict()
        if not players:
            self.players = dict()

        if not zones:
            self.zones = set()

    def contains(self, worldobject=None, vector=None, map_=None):
        if worldobject:
            vector = worldobject.location
            map_ = worldobject.map_

        if vector and map_:
            return self.min_x <= round(vector.x, 5) <= self.max_x and self.min_y <= round(vector.y, 5) <= self.max_y \
                   and map_ == self.map_
        return False

    def add(self, worldobject):
        if worldobject.get_type() == ObjectTypes.TYPE_PLAYER:
            self.players[worldobject.guid] = worldobject
            self.zones.add(worldobject.zone)
        elif worldobject.get_type() == ObjectTypes.TYPE_UNIT:
            self.creatures[worldobject.guid] = worldobject
        elif worldobject.get_type() == ObjectTypes.TYPE_GAMEOBJECT:
            self.gameobjects[worldobject.guid] = worldobject

        worldobject.current_grid = self.key

    def remove(self, worldobject):
        if worldobject.get_type() == ObjectTypes.TYPE_PLAYER:
            self.players.pop(worldobject.guid, None)
        elif worldobject.get_type() == ObjectTypes.TYPE_UNIT:
            self.creatures.pop(worldobject.guid, None)
        elif worldobject.get_type() == ObjectTypes.TYPE_GAMEOBJECT:
            self.gameobjects.pop(worldobject.guid, None)

    def send_all(self, packet, source):
        for player in self.players:
            if player.is_online and player.guid != source.guid:
                player.request.sendall(packet)

    def send_all_in_range(self, packet, source, range_):
        if range_ <= 0:
            self.send_all(packet, source)
        else:
            for player in self.players:
                if player.is_online and player.location.distance(source.location) <= range_ \
                        and player.guid != source.guid:
                    player.request.sendall(packet)
