import math
import threading

from game.world.managers.abstractions.Vector import Vector
from utils.constants.ObjectCodes import ObjectTypes

TOLERANCE = 0.00001
GRID_SIZE = 200

GRIDS = dict()


class GridManager(object):

    ACTIVE_GRID_KEYS = []

    @staticmethod
    def add_or_get(world_obj, store=False):
        min_x, min_y, max_x, max_y = GridManager.generate_coord_data(world_obj.location)
        grid_coords = GridManager.get_grid_key(world_obj.location, world_obj.map_)
        if grid_coords in GRIDS:
            grid = GRIDS[grid_coords]
        else:
            grid = Grid(min_x, min_y, max_x, max_y, world_obj.map_)
            GRIDS[grid.key] = grid

        if store:
            grid.add(world_obj)

        return grid

    @staticmethod
    def update_object(world_obj):
        grid_coords = GridManager.get_grid_key(world_obj.location, world_obj.map_)

        if grid_coords != world_obj.current_grid:
            if world_obj.current_grid in GRIDS:
                grid = GRIDS[world_obj.current_grid]
                grid.remove(world_obj)

            if grid_coords in GRIDS:
                GRIDS[grid_coords].add(world_obj)
            else:
                GridManager.add_or_get(world_obj, store=True)

            if world_obj.get_type() == ObjectTypes.TYPE_PLAYER:
                world_obj.update_surrounding_on_me()

    @staticmethod
    def remove_object(world_obj):
        if world_obj.current_grid in GRIDS:
            grid = GRIDS[world_obj.current_grid]
            grid.remove(world_obj)
            grid.send_all_in_range(world_obj.get_destroy_packet(), source=world_obj, range_=GRID_SIZE)

    @staticmethod
    def get_surrounding(world_obj, x_s=-1, x_m=1, y_s=-1, y_m=1):
        vector = world_obj.location
        near_grids = set()

        for x in range(x_s, x_m + 1):
            for y in range(y_s, y_m + 1):
                grid_coords = GridManager.get_grid_key(
                    Vector(vector.x + (x * GRID_SIZE), vector.y + (y * GRID_SIZE), 0),
                    world_obj.map_)
                if grid_coords in GRIDS:
                    near_grids.add(GRIDS[grid_coords])

        return near_grids

    @staticmethod
    def send_surrounding(packet, world_obj, include_self=True):
        for grid in GridManager.get_surrounding(world_obj):
            grid.send_all(packet, source=None if include_self else world_obj)

    @staticmethod
    def send_surrounding_in_range(packet, world_obj, range_, include_self=True):
        for grid in GridManager.get_surrounding(world_obj):
            grid.send_all_in_range(packet, range_, world_obj, include_self)

    @staticmethod
    def get_surrounding_objects(world_obj, object_types):
        surrounding_objects = [{}, {}, {}]
        for grid in GridManager.get_surrounding(world_obj):
            if ObjectTypes.TYPE_PLAYER in object_types:
                surrounding_objects[0] = {**surrounding_objects[0], **grid.players}
            if ObjectTypes.TYPE_UNIT in object_types:
                surrounding_objects[1] = {**surrounding_objects[1], **grid.creatures}
            if ObjectTypes.TYPE_GAMEOBJECT in object_types:
                surrounding_objects[2] = {**surrounding_objects[2], **grid.gameobjects}

        return surrounding_objects

    @staticmethod
    def get_surrounding_players(world_obj, include_self=False):
        world_objs = GridManager.get_surrounding_objects(world_obj, [ObjectTypes.TYPE_PLAYER])[0]
        if include_self:
            world_objs[world_obj.guid] = world_obj
        return world_objs

    @staticmethod
    def get_surrounding_units(world_obj, include_players=False):
        object_types = [ObjectTypes.TYPE_PLAYER, ObjectTypes.TYPE_UNIT] if include_players else [ObjectTypes.TYPE_UNIT]
        res = GridManager.get_surrounding_objects(world_obj, object_types)
        if include_players:
            return res[0], res[1]
        else:
            return res[1]

    @staticmethod
    def get_surrounding_gameobjects(world_obj):
        return GridManager.get_surrounding_objects(world_obj, [ObjectTypes.TYPE_GAMEOBJECT])[2]

    @staticmethod
    def get_surrounding_player_by_guid(world_obj, guid):
        for p_guid, player in list(GridManager.get_surrounding_players(world_obj).items()):
            if p_guid == guid:
                return player
        return None

    @staticmethod
    def get_surrounding_unit_by_guid(world_obj, guid, include_players=False):
        surrounding_units = GridManager.get_surrounding_units(world_obj, include_players)
        if include_players:
            for p_guid, player in surrounding_units[0].items():
                if p_guid == guid:
                    return player

        creature_dict = surrounding_units[1] if include_players else surrounding_units
        for u_guid, unit in creature_dict.items():
            if u_guid == guid:
                return unit

        return None

    @staticmethod
    def get_surrounding_gameobject_by_guid(world_obj, guid):
        for g_guid, gameobject in list(GridManager.get_surrounding_gameobjects(world_obj).items()):
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
        key = '%u:%u:%u:%u:%u' % (round(min_x, 5), round(min_y, 5), round(max_x, 5),
                                  round(max_y, 5), map_)

        return key

    @staticmethod
    def get_grids():
        return GRIDS

    @staticmethod
    def update_creatures():
        for key in GridManager.ACTIVE_GRID_KEYS:
            grid = GRIDS[key]
            for guid, creature in list(grid.creatures.items()):
                creature.update()

    @staticmethod
    def update_gameobjects():
        for key in GridManager.ACTIVE_GRID_KEYS:
            grid = GRIDS[key]
            for guid, gameobject in list(grid.gameobjects.items()):
                gameobject.update()


class Grid(object):
    def __init__(self, min_x=0.0, min_y=0.0, max_x=0.0, max_y=0.0, map_=0.0, gameobjects=None,
                 creatures=None, players=None, key=''):
        self.min_x = min_x
        self.min_y = min_y
        self.max_x = max_x
        self.max_y = max_y
        self.map_ = map_
        self.key = key
        self.gameobjects = gameobjects
        self.creatures = creatures
        self.players = players

        if not key:
            self.key = '%u:%u:%u:%u:%u' % (round(self.min_x, 5), round(self.min_y, 5), round(self.max_x, 5),
                                           round(self.max_y, 5), self.map_)

        if not gameobjects:
            self.gameobjects = dict()
        if not creatures:
            self.creatures = dict()
        if not players:
            self.players = dict()

    def has_players(self):
        return len(self.players) > 0

    def contains(self, world_obj=None, vector=None, map_=None):
        if world_obj:
            vector = world_obj.location
            map_ = world_obj.map_

        if vector and map_:
            return self.min_x <= round(vector.x, 5) <= self.max_x and self.min_y <= round(vector.y, 5) <= self.max_y \
                   and map_ == self.map_
        return False

    def add(self, world_obj):
        if world_obj.get_type() == ObjectTypes.TYPE_PLAYER:
            self.players[world_obj.guid] = world_obj
            # Add Grid key to the active grid list
            if self.key not in GridManager.ACTIVE_GRID_KEYS:
                GridManager.ACTIVE_GRID_KEYS.append(self.key)
        elif world_obj.get_type() == ObjectTypes.TYPE_UNIT:
            self.creatures[world_obj.guid] = world_obj
        elif world_obj.get_type() == ObjectTypes.TYPE_GAMEOBJECT:
            self.gameobjects[world_obj.guid] = world_obj

        world_obj.current_grid = self.key

    def remove(self, world_obj):
        if world_obj.get_type() == ObjectTypes.TYPE_PLAYER:
            self.players.pop(world_obj.guid, None)
            # If no players left on Grid, remove its key from the active grid list
            if len(self.players) == 0 and self.key in GridManager.ACTIVE_GRID_KEYS:
                GridManager.ACTIVE_GRID_KEYS.remove(self.key)
        elif world_obj.get_type() == ObjectTypes.TYPE_UNIT:
            self.creatures.pop(world_obj.guid, None)
        elif world_obj.get_type() == ObjectTypes.TYPE_GAMEOBJECT:
            self.gameobjects.pop(world_obj.guid, None)

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
