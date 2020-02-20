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
        min_x, min_y, max_x, max_y = GridManager.generate_coord_data(worldobject.location)
        grid_coords = GridManager.get_grid_key(worldobject.location, worldobject.map_)
        if grid_coords in GRIDS:
            grid = GRIDS[grid_coords]
        else:
            grid = Grid(min_x, min_y, max_x, max_y, worldobject.map_)
            GRIDS[grid.key] = grid

        if store:
            grid.add(worldobject)

        return grid

    @staticmethod
    def update_object(worldobject):
        grid_coords = GridManager.get_grid_key(worldobject.location, worldobject.map_)

        if grid_coords != worldobject.current_grid:
            if worldobject.current_grid in GRIDS:
                grid = GRIDS[worldobject.current_grid]
                grid.remove(worldobject)

            if grid_coords in GRIDS:
                GRIDS[grid_coords].add(worldobject)
            else:
                GridManager.add_or_get(worldobject, store=True)

            worldobject.update_surrounding()

    @staticmethod
    def remove_object(worldobject):
        if worldobject.current_grid in GRIDS:
            grid = GRIDS[worldobject.current_grid]
            grid.remove(worldobject)
            grid.send_all_in_range(worldobject.get_destroy_packet(), source=worldobject, range_=GRID_SIZE)

    @staticmethod
    def get_surrounding(worldobject, x_s=-1, x_m=1, y_s=-1, y_m=1):
        vector = worldobject.location
        near_grids = set()

        for x in range(x_s, x_m + 1):
            for y in range(y_s, y_m + 1):
                grid_coords = GridManager.get_grid_key(
                    Vector(vector.x + (x * GRID_SIZE), vector.y + (y * GRID_SIZE), 0),
                    worldobject.map_)
                if grid_coords in GRIDS:
                    near_grids.add(GRIDS[grid_coords])

        return near_grids

    @staticmethod
    def send_surrounding(packet, worldobject, include_self=True):
        for grid in GridManager.get_surrounding(worldobject):
            grid.send_all(packet, source=None if include_self else worldobject)

    @staticmethod
    def send_surrounding_in_range(packet, worldobject, range_, include_self=True):
        for grid in GridManager.get_surrounding(worldobject):
            grid.send_all_in_range(packet, range_, worldobject, include_self)

    @staticmethod
    def get_surrounding_objects(worldobject, object_types):
        surrounding_objects = []
        for grid in GridManager.get_surrounding(worldobject):
            if ObjectTypes.TYPE_PLAYER in object_types:
                surrounding_objects.append(grid.players)
            if ObjectTypes.TYPE_UNIT in object_types:
                surrounding_objects.append(grid.creatures)
            if ObjectTypes.TYPE_GAMEOBJECT in object_types:
                surrounding_objects.append(grid.gameobjects)

        return surrounding_objects

    @staticmethod
    def get_surrounding_players(worldobject):
        return GridManager.get_surrounding_objects(worldobject, [ObjectTypes.TYPE_PLAYER])

    @staticmethod
    def get_surrounding_units(worldobject, include_players=False):
        object_types = [ObjectTypes.TYPE_PLAYER, ObjectTypes.TYPE_UNIT] if include_players else [ObjectTypes.TYPE_UNIT]
        return GridManager.get_surrounding_objects(worldobject, object_types)

    @staticmethod
    def get_surrounding_gameobjects(worldobject):
        return GridManager.get_surrounding_objects(worldobject, [ObjectTypes.TYPE_GAMEOBJECT])

    @staticmethod
    def get_surrounding_player_by_guid(worldobject, guid):
        for p_guid, player in list(GridManager.get_surrounding_players(worldobject)[0].items()):
            if p_guid == guid:
                return player
        return None

    @staticmethod
    def get_surrounding_unit_by_guid(worldobject, guid, include_players=False):
        for u_guid, unit in list(GridManager.get_surrounding_units(worldobject, include_players)[0].items()):
            if u_guid == guid:
                return unit
        return None

    @staticmethod
    def get_surrounding_gameobject_by_guid(worldobject, guid):
        for g_guid, gameobject in list(GridManager.get_surrounding_gameobjects(worldobject)[0].items()):
            if g_guid == guid:
                return gameobject
        return None

    @staticmethod
    def generate_coord_data(vector):
        mod_x = vector.x / GRID_SIZE
        mod_y = vector.y / GRID_SIZE

        max_x = math.ceil(mod_x) * GRID_SIZE - TOLERANCE
        max_y = math.ceil(mod_y) * GRID_SIZE - TOLERANCE
        min_x = max_x - GRID_SIZE + TOLERANCE
        min_y = max_y - GRID_SIZE + TOLERANCE

        return min_x, min_y, max_x, max_y

    @staticmethod
    def get_grid_key(vector, map_):
        min_x, min_y, max_x, max_y = GridManager.generate_coord_data(vector)
        key = '%u:%u:%u:%u%u' % (round(min_x, 5), round(min_y, 5), round(max_x, 5),
                                 round(max_y, 5), map_)

        return key

    @staticmethod
    def get_grids():
        return GRIDS

    @staticmethod
    def find_player_by_guid(guid_to_search):
        for key, grid in GRIDS.items():
            for guid, player in list(grid.players.items()):
                if guid == guid_to_search:
                    return player
        return None

    @staticmethod
    def find_player_by_name(name_to_search):
        for key, grid in GRIDS.items():
            for guid, player in list(grid.players.items()):
                if player.player.name.lower() == name_to_search.lower():
                    return player
        return None

    @staticmethod
    def update_players():
        for key, grid in GRIDS.items():
            for guid, player in list(grid.players.items()):
                threading.Thread(target=player.update).start()


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
        for guid, player_mgr in list(self.players.items()):
            if player_mgr.is_online:
                if source and player_mgr.guid == source.guid:
                    continue
                threading.Thread(target=player_mgr.session.request.sendall, args=(packet,)).start()

    def send_all_in_range(self, packet, range_, source, include_self=True):
        if range_ <= 0:
            self.send_all(packet, source)
        else:
            for guid, player_mgr in list(self.players.items()):
                if player_mgr.is_online and player_mgr.location.distance(source.location) <= range_:
                    if not include_self and player_mgr.guid == source.guid:
                        continue
                    threading.Thread(target=player_mgr.session.request.sendall, args=(packet,)).start()
