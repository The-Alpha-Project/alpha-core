import math
import threading

from game.world.managers.abstractions.Vector import Vector
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

    @staticmethod
    def update_object(worldobject):
        if worldobject.current_grid in GRIDS:
            grid = GRIDS[worldobject.current_grid]
            if grid.contains(worldobject):
                return  # Same grid, ignore

            grid.remove(worldobject)
            grid.send_all(worldobject.get_destroy_packet())

        grid_coords = GridManager.GridCoords(worldobject.location, worldobject.map_)
        if grid_coords.key in GRIDS:
            GRIDS[grid_coords.key].add(worldobject)
        else:
            GridManager.add_or_get(worldobject, store=True)

    @staticmethod
    def remove_object(worldobject):
        grid = GRIDS[worldobject.current_grid]
        grid.remove(worldobject)
        grid.send_all_in_range(worldobject.get_destroy_packet(), range_=GRID_SIZE)

    @staticmethod
    def get_surrounding(worldobject, x_s=-1, x_m=1, y_s=-1, y_m=1):
        vector = worldobject.location
        near_grids = set()

        for x in range(x_s, x_m+1):
            for y in range(y_s, y_m+1):
                grid_coords = GridManager.GridCoords(Vector(vector.x + (x * GRID_SIZE), vector.y + (y * GRID_SIZE), 0),
                                                     worldobject.map_)
                if grid_coords.key in GRIDS:
                    near_grids.add(GRIDS[grid_coords.key])

        return near_grids

    @staticmethod
    def send_surrounding(packet, worldobject, exclude_self=False):
        for grid in GridManager.get_surrounding(worldobject):
            grid.send_all(packet, source=None if exclude_self else worldobject)

    @staticmethod
    def send_surrounding_in_range(packet, worldobject, range_, exclude_self=False):
        for grid in GridManager.get_surrounding(worldobject):
            grid.send_all_in_range(packet, range_, source=None if exclude_self else worldobject)

    @staticmethod
    def get_surrounding_objects(worldobject, object_types):
        surrounding_objects = set()
        for grid in GridManager.get_surrounding(worldobject):
            if ObjectTypes.TYPE_PLAYER in object_types:
                surrounding_objects.update(grid.players)
            if ObjectTypes.TYPE_UNIT in object_types:
                surrounding_objects.update(grid.creatures)
            if ObjectTypes.TYPE_GAMEOBJECT in object_types:
                surrounding_objects.update(grid.gameobjects)

        return surrounding_objects

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

    def send_all(self, packet, source=None):
        for player in self.players:
            if player.is_online:
                if source and player.guid == source.guid:
                    continue
                threading.Thread(target=player.request.sendall, args=(packet,)).start()

    def send_all_in_range(self, packet, range_, source=None):
        if range_ <= 0:
            self.send_all(packet, source)
        else:
            for player in self.players:
                if player.is_online and player.location.distance(source.location) <= range_:
                    if source and player.guid == source.guid:
                        continue
                    threading.Thread(target=player.request.sendall, args=(packet,)).start()
