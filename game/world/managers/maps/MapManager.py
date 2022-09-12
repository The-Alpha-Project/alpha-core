import traceback
import math
import _queue
from random import choice
from typing import Optional

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from game.world.managers.maps.Constants import SIZE, RESOLUTION_ZMAP, RESOLUTION_AREA_INFO, RESOLUTION_LIQUIDS
from game.world.managers.maps.GridManager import GridManager
from game.world.managers.maps.Map import Map
from game.world.managers.maps.MapTile import MapTile
from utils.ConfigManager import config
from utils.Logger import Logger

MAPS: dict[int, Map] = {}
MAP_LIST: list[int] = DbcDatabaseManager.map_get_all_ids()
AREAS = {}
AREA_LIST = DbcDatabaseManager.area_get_all_ids()
PENDING_LOAD = {}
PENDING_LOAD_QUEUE = _queue.SimpleQueue()


# noinspection PyBroadException
class MapManager:
    @staticmethod
    def initialize_maps():
        for map_id in MAP_LIST:
            MAPS[map_id] = Map(map_id, MapManager.on_cell_turn_active)

    @staticmethod
    def initialize_area_tables():
        for area_id in AREA_LIST:
            AREAS[area_id] = DbcDatabaseManager.area_get_by_id(area_id)

    @staticmethod
    def get_area_number_by_zone_id(zone_id):
        if zone_id in AREAS:
            return AREAS[zone_id].AreaNumber
        return zone_id

    @staticmethod
    def get_parent_zone_id(zone_id, map_id):
        if zone_id in AREAS and AREAS[zone_id].ParentAreaNum > 0:
            parent = DbcDatabaseManager.area_get_by_area_number(AREAS[zone_id].ParentAreaNum, map_id)
            if parent:
                return parent.ID
        return zone_id

    @staticmethod
    def on_cell_turn_active(world_object):
        MapManager.enqueue_tile_load(world_object.map_, world_object.location.x, world_object.location.y)

    @staticmethod
    def validate_maps():
        if not config.Server.Settings.use_map_tiles:
            return True

        if not MapTile.validate_version():
            return False

        return True

    @staticmethod
    def enqueue_tile_load(map_id, x, y):
        if not config.Server.Settings.use_map_tiles:
            return

        x = MapManager.get_tile_x(x)
        y = MapManager.get_tile_y(y)

        key = f'{map_id},{x},{y}'
        if key in PENDING_LOAD:
            return

        PENDING_LOAD[key] = True
        PENDING_LOAD_QUEUE.put(key)

    @staticmethod
    def load_pending_tiles():
        while True:
            key = PENDING_LOAD_QUEUE.get(block=True, timeout=None)
            map_id, x, y = str(key).rsplit(',')
            MapManager.load_map_tiles(int(map_id), int(x), int(y))

    @staticmethod
    def load_map_tiles(map_id, x, y):
        if not config.Server.Settings.use_map_tiles:
            return False

        if map_id not in MAP_LIST:
            return False

        x = MapManager.get_tile_x(x)
        y = MapManager.get_tile_y(y)

        for i in range(-1, 1):
            for j in range(-1, 1):
                if -1 < x + i < 64 and -1 < y + j < 64:
                    # Avoid loading tiles information if we already did.
                    if not MAPS[map_id].tiles[x + i][y + j] or not MAPS[map_id].tiles[x + i][y + j].initialized:
                        MAPS[map_id].tiles[x + i][y + j] = MapTile(map_id, x + i, y + j)

        return True

    @staticmethod
    def get_tile(x, y):
        tile_x = int(32.0 - MapManager.validate_map_coord(x) / SIZE)
        tile_y = int(32.0 - MapManager.validate_map_coord(y) / SIZE)
        return [tile_x, tile_y]

    @staticmethod
    def get_tile_x(x):
        tile_x = int(32.0 - MapManager.validate_map_coord(x) / SIZE)
        return tile_x

    @staticmethod
    def get_tile_y(y):
        tile_y = int(32.0 - MapManager.validate_map_coord(y) / SIZE)
        return tile_y

    @staticmethod
    def get_submap_tile_x(x):
        tile_x = int((RESOLUTION_ZMAP - 1) * (
                32.0 - MapManager.validate_map_coord(x) / SIZE - int(32.0 - MapManager.validate_map_coord(x) / SIZE)))

        return tile_x

    @staticmethod
    def get_submap_tile_y(y):
        tile_y = int((RESOLUTION_ZMAP - 1) * (
                32.0 - MapManager.validate_map_coord(y) / SIZE - int(32.0 - MapManager.validate_map_coord(y) / SIZE)))

        return tile_y

    @staticmethod
    def validate_teleport_destination(map_id, x, y):
        # Can't validate if not using tile files, so return as True.
        if not config.Server.Settings.use_map_tiles:
            return True

        if map_id not in MAPS:
            return False

        # Some instances don't have tiles, only WMOs; always allow teleporting inside one.
        if map_id > 1:
            return True

        map_tile_x, map_tile_y, tile_local_x, tile_local_y = MapManager.calculate_tile(x, y, RESOLUTION_AREA_INFO - 1)
        if not MapManager._check_tile_load(map_id, x, y, map_tile_x, map_tile_y):
            return False

        return MAPS[map_id].tiles[map_tile_x][map_tile_y] is not None

    @staticmethod
    def calculate_z_for_object(world_object):
        return world_object.location.calculate_z(world_object.location.x, world_object.location.y, world_object.map_,
                                                 world_object.location.z)

    # noinspection PyBroadException
    @staticmethod
    def calculate_z(map_id, x, y, current_z=0.0) -> tuple:  # float, z_locked (Could not use map files Z)
        try:
            map_tile_x, map_tile_y, tile_local_x, tile_local_y = MapManager.calculate_tile(x, y, (RESOLUTION_ZMAP - 1))
            x_normalized = (RESOLUTION_ZMAP - 1) * (32.0 - (x / SIZE) - map_tile_x) - tile_local_x
            y_normalized = (RESOLUTION_ZMAP - 1) * (32.0 - (y / SIZE) - map_tile_y) - tile_local_y

            if not MapManager._check_tile_load(map_id, x, y, map_tile_x, map_tile_y):
                return current_z if current_z else 0.0, False

            try:
                val_1 = MapManager.get_height(map_id, map_tile_x, map_tile_y, tile_local_x, tile_local_y)
                val_2 = MapManager.get_height(map_id, map_tile_x, map_tile_y, tile_local_x + 1, tile_local_y)
                top_height = MapManager._lerp(val_1, val_2, x_normalized)
                val_3 = MapManager.get_height(map_id, map_tile_x, map_tile_y, tile_local_x, tile_local_y + 1)
                val_4 = MapManager.get_height(map_id, map_tile_x, map_tile_y, tile_local_x + 1, tile_local_y + 1)
                bottom_height = MapManager._lerp(val_3, val_4, x_normalized)
                calculated_z = MapManager._lerp(top_height, bottom_height, y_normalized)  # Z
                # TODO: Protect against wrong maps Z due WMO's.
                if math.fabs(current_z - calculated_z) > 1.5 and current_z:
                    return current_z, True
                return calculated_z, False
            except:
                return MAPS[map_id].tiles[map_tile_x][map_tile_y].z_height_map[tile_local_x][tile_local_x], False
        except:
            Logger.error(traceback.format_exc())
            return current_z if current_z else 0.0, False

    @staticmethod
    def get_area_information(map_id, x, y):
        try:
            resolution = RESOLUTION_AREA_INFO - 1
            map_tile_x, map_tile_y, tile_local_x, tile_local_y = MapManager.calculate_tile(x, y, resolution)

            if not MapManager._check_tile_load(map_id, x, y, map_tile_x, map_tile_y):
                return None

            return MAPS[map_id].tiles[map_tile_x][map_tile_y].area_information[tile_local_x][tile_local_y]
        except:
            Logger.error(traceback.format_exc())
            return None

    @staticmethod
    def get_liquid_information(map_id, x, y, z, ignore_z=False):
        try:
            map_tile_x, map_tile_y, tile_local_x, tile_local_y = MapManager.calculate_tile(x, y, RESOLUTION_LIQUIDS - 1)

            if not MapManager._check_tile_load(map_id, x, y, map_tile_x, map_tile_y):
                return None

            liquids = MAPS[map_id].tiles[map_tile_x][map_tile_y].liquid_information[tile_local_x][tile_local_y]
            return liquids if liquids and liquids.height > z else liquids if liquids and ignore_z else None
        except:
            Logger.error(traceback.format_exc())
            return None

    @staticmethod
    def find_liquid_location_in_range(world_object, min_range, max_range):
        if not MapManager._validate_liquid_tile(world_object.map_, world_object.location.x, world_object.location.y):
            return None

        # Circular ref.
        from game.world.managers.abstractions.Vector import Vector
        start_range = min_range
        start_location = world_object.location
        liquids_vectors = []
        while start_range <= max_range:
            fx = start_location.x + start_range * math.cos(start_location.o)
            fy = start_location.y + start_range * math.sin(start_location.o)
            fz = start_location.z
            liquid_info = MapManager.get_liquid_information(world_object.map_, fx, fy, fz, ignore_z=True)
            if liquid_info:
                liquids_vectors.append(Vector(fx, fy, liquid_info.height))
            start_range += 1

        if len(liquids_vectors) == 0:
            return None

        # Should contain at least 1 element by now.
        return choice(liquids_vectors)

    @staticmethod
    def _validate_liquid_tile(map_id, x, y):
        map_tile_x, map_tile_y, tile_local_x, tile_local_y = MapManager.calculate_tile(x, y, RESOLUTION_LIQUIDS - 1)
        if not MapManager._check_tile_load(map_id, x, y, map_tile_x, map_tile_y):
            return False
        return True

    @staticmethod
    def _check_tile_load(map_id, location_x, location_y, map_tile_x, map_tile_y):
        if not config.Server.Settings.use_map_tiles:
            return False

        # Check if the map is valid first.
        if map_id not in MAPS:
            Logger.warning(f'Wrong map, {map_id} not found.')
            return False

        try:
            tile = MAPS[map_id].tiles[map_tile_x][map_tile_y]
        except IndexError:
            Logger.error(f'Error retrieving tile information for the following position: '
                         f'Map ID: {map_id}, X: {location_x}, Y: {location_y}, '
                         f'Tile X: {map_tile_x}, Tile Y: {map_tile_y}.')
            return False

        # Tile exists and has been initialized, return if it's already valid (finished loading) or not.
        if tile is not None and tile.initialized:
            return tile.is_valid

        # Tile does not exist, try to load it.
        if tile is None:
            MapManager.load_map_tiles(map_id, location_x, location_y)

        # Grab the tile again.
        tile = MAPS[map_id].tiles[map_tile_x][map_tile_y]

        # Tile exist, it's initialized and has loaded its internal data.
        return tile is not None and tile.initialized and tile.is_valid

    @staticmethod
    def calculate_tile(x, y, resolution):
        x = MapManager.validate_map_coord(x)
        y = MapManager.validate_map_coord(y)
        map_tile_x = int(32.0 - (x / SIZE))
        map_tile_y = int(32.0 - (y / SIZE))
        tile_local_x = int(resolution * (32.0 - (x / SIZE) - map_tile_x))
        tile_local_y = int(resolution * (32.0 - (y / SIZE) - map_tile_y))
        return map_tile_x, map_tile_y, tile_local_x, tile_local_y

    @staticmethod
    def get_height(map_id, map_tile_x, map_tile_y, map_tile_local_x, map_tile_local_y):
        if map_tile_local_x > RESOLUTION_ZMAP:
            map_tile_x = int(map_tile_x + 1)
            map_tile_local_x = int(map_tile_local_x - RESOLUTION_ZMAP)
        elif map_tile_local_x < 0:
            map_tile_x = int(map_tile_x - 1)
            map_tile_local_x = int(-map_tile_local_x - 1)

        if map_tile_local_y > RESOLUTION_ZMAP:
            map_tile_y = int(map_tile_y + 1)
            map_tile_local_y = int(map_tile_local_y - RESOLUTION_ZMAP)
        elif map_tile_local_y < 0:
            map_tile_y = int(map_tile_y - 1)
            map_tile_local_y = int(-map_tile_local_y - 1)

        return MAPS[map_id].tiles[map_tile_x][map_tile_y].z_height_map[map_tile_local_x][map_tile_local_y]

    @staticmethod
    def validate_map_coord(coord):
        if coord > 32.0 * SIZE:
            return 32.0 * SIZE
        elif coord < -32.0 * SIZE:
            return -32 * SIZE
        else:
            return coord

    @staticmethod
    def get_map(map_id):
        return MAPS.get(map_id)

    @staticmethod
    def get_grid_manager_by_map_id(map_id) -> Optional[GridManager]:
        if map_id in MAPS:
            return MAPS[map_id].grid_manager
        return None

    @staticmethod
    def _lerp(value1, value2, amount):
        return value1 + (value2 - value1) * amount

    # Object methods (wrappers around GridManager methods)

    @staticmethod
    def should_relocate(world_object, destination, destination_map):
        grid_manager = MapManager.get_grid_manager_by_map_id(destination_map)
        destination_cells = grid_manager.get_surrounding_cells_by_location(destination.x, destination.y,
                                                                           destination_map)
        current_cell = grid_manager.get_cells()[world_object.current_cell]
        return current_cell in destination_cells

    @staticmethod
    def update_object(world_object, has_changes=False, has_inventory_changes=False):
        if world_object.current_cell:
            old_map = int(world_object.current_cell.split(':')[-1])
            old_grid_manager = MapManager.get_grid_manager_by_map_id(old_map)
        else:
            old_grid_manager = None

        grid_manager = MapManager.get_grid_manager_by_map_id(world_object.map_)
        if grid_manager:
            grid_manager.update_object(world_object, old_grid_manager, has_changes=has_changes,
                                       has_inventory_changes=has_inventory_changes)
        else:
            Logger.warning(f'Warning, did not find grid_manager for map: {world_object.map_}')

    @staticmethod
    def spawn_object(world_object_spawn=None, world_object_instance=None):
        map_ = world_object_spawn.map_ if world_object_spawn else world_object_instance.map_
        grid_manager = MapManager.get_grid_manager_by_map_id(map_)
        if grid_manager:
            grid_manager.spawn_object(world_object_spawn, world_object_instance)
        else:
            Logger.warning(f'Warning, did not find grid_manager for map: {map_}')

    @staticmethod
    def remove_object(world_object):
        MapManager.get_grid_manager_by_map_id(world_object.map_).remove_object(world_object)

    @staticmethod
    def send_surrounding(packet, world_object, include_self=True, exclude=None, use_ignore=False):
        MapManager.get_grid_manager_by_map_id(world_object.map_).send_surrounding(
            packet, world_object, include_self, exclude, use_ignore)

    @staticmethod
    def send_surrounding_in_range(packet, world_object, range_, include_self=True, exclude=None, use_ignore=False):
        MapManager.get_grid_manager_by_map_id(world_object.map_).send_surrounding_in_range(
            packet, world_object, range_, include_self, exclude, use_ignore)

    @staticmethod
    def get_surrounding_objects(world_object, object_types):
        return MapManager.get_grid_manager_by_map_id(world_object.map_).get_surrounding_objects(
            world_object, object_types)

    @staticmethod
    def get_surrounding_players(world_object):
        return MapManager.get_grid_manager_by_map_id(world_object.map_).get_surrounding_players(world_object)

    @staticmethod
    def get_surrounding_units(world_object, include_players=False):
        return MapManager.get_grid_manager_by_map_id(world_object.map_).get_surrounding_units(
            world_object, include_players)

    @staticmethod
    def get_surrounding_units_by_location(vector, target_map, range_, include_players=False):
        grid_mgr = MapManager.get_grid_manager_by_map_id(target_map)
        if not grid_mgr:
            return [{}, {}]
        return grid_mgr.get_surrounding_units_by_location(vector, target_map, range_, include_players)

    @staticmethod
    def get_surrounding_players_by_location(vector, target_map, range_):
        grid_mgr = MapManager.get_grid_manager_by_map_id(target_map)
        if not grid_mgr:
            return {}
        return grid_mgr.get_surrounding_players_by_location(vector, target_map, range_)

    @staticmethod
    def get_surrounding_gameobjects(world_object):
        return MapManager.get_grid_manager_by_map_id(world_object.map_).get_surrounding_gameobjects(world_object)

    @staticmethod
    def get_surrounding_player_by_guid(world_object, guid):
        return MapManager.get_grid_manager_by_map_id(world_object.map_).get_surrounding_player_by_guid(
            world_object, guid)

    @staticmethod
    def get_surrounding_unit_by_guid(world_object, guid, include_players=False):
        return MapManager.get_grid_manager_by_map_id(world_object.map_).get_surrounding_unit_by_guid(
            world_object, guid, include_players)

    @staticmethod
    def get_surrounding_unit_by_spawn_id(world_object, spawn_id):
        return MapManager.get_grid_manager_by_map_id(world_object.map_).get_surrounding_unit_by_spawn_id(
            world_object, spawn_id)

    @staticmethod
    def get_surrounding_gameobject_by_guid(world_object, guid):
        return MapManager.get_grid_manager_by_map_id(world_object.map_).get_surrounding_gameobject_by_guid(
            world_object, guid)

    @staticmethod
    def get_surrounding_gameobject_by_spawn_id(world_object, spawn_id):
        return MapManager.get_grid_manager_by_map_id(world_object.map_).get_surrounding_gameobject_by_spawn_id(
            world_object, spawn_id)

    @staticmethod
    def update_creatures():
        for map_id, map_ in MAPS.items():
            map_.grid_manager.update_creatures()

    @staticmethod
    def update_gameobjects():
        for map_id, map_ in MAPS.items():
            map_.grid_manager.update_gameobjects()

    @staticmethod
    def update_spawns():
        for map_id, map_ in MAPS.items():
            map_.grid_manager.update_spawns()

    @staticmethod
    def update_corpses():
        for map_id, map_ in MAPS.items():
            map_.grid_manager.update_corpses()

    @staticmethod
    def deactivate_cells():
        for map_id, map_ in MAPS.items():
            map_.grid_manager.deactivate_cells()
