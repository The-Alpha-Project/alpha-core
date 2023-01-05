import traceback
import math
from multiprocessing import RLock
from os import path

import _queue
from random import choice
from typing import Optional

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from game.world.managers.maps.InstancesManager import InstancesManager
from game.world.managers.maps.helpers.Constants import ADT_SIZE, RESOLUTION_ZMAP, RESOLUTION_AREA_INFO, RESOLUTION_LIQUIDS
from game.world.managers.maps.GridManager import GridManager
from game.world.managers.maps.Map import Map, MapType
from game.world.managers.maps.MapTile import MapTile, MapTileStates
from game.world.managers.maps.helpers.Namigator import Namigator
from game.world.managers.objects.farsight.FarSightManager import FarSightManager
from utils.ConfigManager import config
from utils.Logger import Logger
from utils.PathManager import PathManager

MAPS: dict[int, Map] = {}
MAP_LIST: list[int] = DbcDatabaseManager.map_get_all_ids()
# Holds .map files tiles information per Map.
MAPS_TILES = dict()
# Holds namigator instances per Map.
MAPS_NAMIGATOR: dict[int, Namigator] = dict()
# Holds maps which have no navigation data in alpha.
MAPS_NO_NAVIGATION = {2, 13, 25, 29, 30, 34, 35, 37, 42, 43, 44, 47, 48, 70, 90, 109, 129}

INSTANCES_MANAGER = InstancesManager()
AREAS = {}
AREA_LIST = DbcDatabaseManager.area_get_all_ids()
PENDING_TILE_INITIALIZATION = {}
PENDING_TILE_INITIALIZATION_QUEUE = _queue.SimpleQueue()
QUEUE_LOCK = RLock()


# noinspection PyBroadException
class MapManager:
    NAMIGATOR_LOADED = False
    NAMIGATOR_FAILED = False

    @staticmethod
    def initialize_world_maps():
        for map_id in MAP_LIST:
            dbc_map = DbcDatabaseManager.map_get_by_id(map_id)
            # Initialize common and pvp maps.
            if dbc_map.IsInMap != MapType.COMMON and dbc_map.PVP != 1:
                continue
            MAPS[map_id] = Map(map_id, MapManager.on_cell_turn_active)
            MAPS[map_id].initialize()
        Logger.success(f'Loading {len(MAPS)} maps...')

    @staticmethod
    def initialize_namigator():
        if not config.Server.Settings.use_nav_tiles or MapManager.NAMIGATOR_FAILED:
            return
        length = len(MAP_LIST)
        count = 0
        for map_id in MAP_LIST:
            count += 1
            MapManager.build_map_namigator(MAPS[map_id])
            Logger.progress('Loading map namigator...', count, length)

    @staticmethod
    def build_map_namigator(map_):
        if MapManager.NAMIGATOR_FAILED or map_.id in MAPS_NAMIGATOR or not config.Server.Settings.use_nav_tiles:
            return

        if map_.id in MAPS_NO_NAVIGATION:
            return

        # Attempt to load Namigator module if enabled.
        if config.Server.Settings.use_nav_tiles and MapManager.NAMIGATOR_FAILED:
            return
        try:
            from namigator import pathfind
            nav_root_path = PathManager.get_navs_path()
            nav_map_path = PathManager.get_nav_map_path(map_.name)
            if not path.exists(nav_root_path) or not path.exists(nav_map_path):
                Logger.warning(f'[Namigator] Skip {map_.name} ID {map_.id}, no data.')
                return
            MAPS_NAMIGATOR[map_.id] = pathfind.Map(nav_root_path, f'{map_.name}')
            Logger.success(f'[Namigator] Successfully loaded for map {map_.name}')
            MapManager.NAMIGATOR_LOADED = True
        except ImportError:
            Logger.error('[Namigator] Unable to load module.')
            MapManager.NAMIGATOR_FAILED = True
            pathfind = None  # Required.
            Logger.error(traceback.format_exc())
            return

    @staticmethod
    def get_maps():
        return list(MAPS.values())

    @staticmethod
    def get_instance_map(instance_token):
        if instance_token.instance_id not in MAPS:
            MAPS[instance_token.instance_id] = Map(instance_token.map_id, MapManager.on_cell_turn_active)
        return MAPS[instance_token.instance_id]

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
        MapManager.enqueue_adt_tile_initialization(world_object.map_, world_object.location.x, world_object.location.y)

    @staticmethod
    def validate_maps():
        if not config.Server.Settings.use_map_tiles:
            return True

        if not MapTile.validate_version():
            return False

        return True

    @staticmethod
    def enqueue_adt_tile_initialization(map_id, raw_x, raw_y):
        if not config.Server.Settings.use_map_tiles:
            return

        with QUEUE_LOCK:
            adt_x, adt_y = MapManager.get_tile(raw_x, raw_y)

            adt_key = f'{map_id},{adt_x},{adt_y}'
            if adt_key in PENDING_TILE_INITIALIZATION:
                return

            PENDING_TILE_INITIALIZATION[adt_key] = True
            to_load_data = f'{map_id},{raw_x},{raw_y}'
            PENDING_TILE_INITIALIZATION_QUEUE.put(to_load_data)

    @staticmethod
    def load_map_adt_tiles():
        if not config.Server.Settings.use_map_tiles:
            return False

        length = len(MAPS) * (64 * 64)
        count = 0
        for map_id in MAPS.keys():
            MAPS_TILES[map_id] = [[None for r in range(64)] for c in range(64)]
            for adt_x in range(64):
                for adt_y in range(64):
                    count += 1
                    MAPS_TILES[map_id][adt_x][adt_y] = MapTile(map_id, adt_x, adt_y)
                    Logger.progress('Loading map tiles...', count, length)

        return True

    @staticmethod
    def initialize_pending_tiles():
        if not PENDING_TILE_INITIALIZATION_QUEUE.empty():
            key = PENDING_TILE_INITIALIZATION_QUEUE.get()
            map_id, x, y = str(key).rsplit(',')
            MapManager.initialize_tile(int(map_id), float(x), float(y))

    @staticmethod
    def initialize_tile(map_id, x, y):
        if map_id not in MAP_LIST:
            return False

        adt_x = MapManager.get_tile_x(x)
        adt_y = MapManager.get_tile_y(y)

        # Map namigator instance, if available.
        namigator = MAPS_NAMIGATOR[map_id] if map_id in MAPS_NAMIGATOR and MapManager.NAMIGATOR_LOADED else None

        for i in range(-1, 1):
            for j in range(-1, 1):
                if -1 < adt_x + i < 64 and -1 < adt_y + j < 64:
                    if MAPS_TILES[map_id][adt_x + i][adt_y + j].initialized:
                        continue
                    Logger.debug(f'Loading ADT tile for coordinates {adt_x + i},{adt_y + j}')
                    MAPS_TILES[map_id][adt_x + i][adt_y + j].initialize(namigator)

        return True

    @staticmethod
    def get_tile(x, y):
        tile_x = int(32.0 - MapManager.validate_map_coord(x) / ADT_SIZE)
        tile_y = int(32.0 - MapManager.validate_map_coord(y) / ADT_SIZE)
        return [tile_x, tile_y]

    @staticmethod
    def get_tile_x(x):
        tile_x = int(32.0 - MapManager.validate_map_coord(x) / ADT_SIZE)
        return tile_x

    @staticmethod
    def get_tile_y(y):
        tile_y = int(32.0 - MapManager.validate_map_coord(y) / ADT_SIZE)
        return tile_y

    @staticmethod
    def get_submap_tile_x(x):
        tile_x = int((RESOLUTION_ZMAP - 1) * (
                32.0 - MapManager.validate_map_coord(x) / ADT_SIZE - int(32.0 - MapManager.validate_map_coord(x) / ADT_SIZE)))

        return tile_x

    @staticmethod
    def get_submap_tile_y(y):
        tile_y = int((RESOLUTION_ZMAP - 1) * (
                32.0 - MapManager.validate_map_coord(y) / ADT_SIZE - int(32.0 - MapManager.validate_map_coord(y) / ADT_SIZE)))

        return tile_y

    @staticmethod
    def calculate_nav_z_for_object(world_object):
        return MapManager.calculate_nav_z(world_object.map_, world_object.location.x, world_object.location.y,
                                          world_object.location.z)

    @staticmethod
    def calculate_nav_z(map_id, x, y, current_z=0.0) -> tuple:  # float, z_locked (Could not use map/nav files Z)
        # If nav tiles disabled or unable to load Namigator, return current Z as locked.
        if not config.Server.Settings.use_nav_tiles or not MapManager.NAMIGATOR_LOADED:
            return current_z, True

        if map_id not in MAPS:
            return current_z, True

        if map_id not in MAPS_NAMIGATOR:
            return current_z, True

        adt_x, adt_y = MapManager.get_tile(x, y)
        # Check if we need to load adt.
        if MapManager._check_tile_load(map_id, x, y, adt_x, adt_y) != MapTileStates.READY:
            return current_z, True

        z_values = MAPS_NAMIGATOR[map_id].query_z(float(x), float(y))

        if len(z_values) == 0:
            Logger.warning(f'[NAMIGATOR] Unable to find Z for Map {map_id} ADT [{adt_x},{adt_y}] X {x} Y {y}')
            return current_z, True

        # We are only interested in the resulting Z near to the Z we know.
        z_values = sorted(z_values, key=lambda _z: abs(current_z - _z))

        return z_values[0], False

    @staticmethod
    def los_check(map_id, start_vector, end_vector):
        # No nav tiles or unable to load Namigator, can't check LoS.
        if not config.Server.Settings.use_nav_tiles or not MapManager.NAMIGATOR_LOADED:
            return True

        if map_id not in MAPS_NAMIGATOR:
            return True

        # Calculate source adt coordinates for x,y.
        source_adt_x, source_adt_y, _, _ = MapManager.calculate_tile(start_vector.x, start_vector.y,
                                                                     (RESOLUTION_ZMAP - 1))

        # Calculate destination adt coordinates for x,y.
        destination_adt_x, destination_adt_y, _, _ = MapManager.calculate_tile(end_vector.x, end_vector.y,
                                                                               (RESOLUTION_ZMAP - 1))

        # Check if loaded or unable to load, return True if this fails.
        if MapManager._check_tile_load(map_id, start_vector.x, start_vector.y, source_adt_x, source_adt_y) != MapTileStates.READY:
            return True

        # Check if loaded or unable to load, return True if this fails.
        if MapManager._check_tile_load(map_id, end_vector.x, end_vector.y, destination_adt_x, destination_adt_y) != MapTileStates.READY:
            return True

        # Calculate path.
        namigator = MAPS_NAMIGATOR[map_id]

        los = namigator.line_of_sight(start_vector.x, start_vector.y, start_vector.z,
                                      end_vector.x, end_vector.y, end_vector.z)

        return los

    @staticmethod
    def can_reach_object(source_object, target_object):
        if source_object.map_ != target_object.map_:
            return False

        # If nav tiles disabled or unable to load Namigator, return as True.
        if not config.Server.Settings.use_nav_tiles or not MapManager.NAMIGATOR_LOADED:
            return True

        # We don't have navs loaded for a given map, return True.
        if source_object.map_ not in MAPS_NAMIGATOR:
            return True

        failed, in_place, navigation_path = MapManager.calculate_path(source_object.map_, source_object.location,
                                                                      target_object.location)
        return not failed

    @staticmethod
    def calculate_path(map_id, start_vector, end_vector) -> tuple:  # bool failed, in_place, path list.
        # If nav tiles disabled or unable to load Namigator, return the end_vector as found.
        if not config.Server.Settings.use_nav_tiles or not MapManager.NAMIGATOR_LOADED:
            return False, False, [end_vector]

        # We don't have navs loaded for a given map, return end vector.
        if map_id not in MAPS_NAMIGATOR:
            return False, False, [end_vector]

        # Calculate source adt coordinates for x,y.
        source_adt_x, source_adt_y, _, _ = MapManager.calculate_tile(start_vector.x, start_vector.y,
                                                                     (RESOLUTION_ZMAP - 1))

        # Calculate destination adt coordinates for x,y.
        destination_adt_x, destination_adt_y, _, _ = MapManager.calculate_tile(end_vector.x, end_vector.y,
                                                                               (RESOLUTION_ZMAP - 1))

        # Check if loaded or unable to load.
        if MapManager._check_tile_load(map_id, start_vector.x, start_vector.y, source_adt_x, source_adt_y) != MapTileStates.READY:
            return True, False, [end_vector]

        # Check if loaded or unable to load.
        if MapManager._check_tile_load(map_id, end_vector.x, end_vector.y, destination_adt_x, destination_adt_y) != MapTileStates.READY:
            return True, False, [end_vector]

        # Calculate path.
        namigator = MAPS_NAMIGATOR[map_id]
        navigation_path = namigator.find_path(start_vector.x, start_vector.y, start_vector.z,
                                              end_vector.x, end_vector.y, end_vector.z)

        if len(navigation_path) == 0:
            return True, False, [end_vector]

        # Pop starting location, we already have that and WoW client seems to crash when sending
        # movements with too short of a diff.
        del navigation_path[0]

        # Validate length again.
        if len(navigation_path) == 0:
            return True, False, [end_vector]

        from game.world.managers.abstractions.Vector import Vector
        vectors = [Vector(waypoint[0], waypoint[1], waypoint[2]) for waypoint in navigation_path]

        return False, False if len(vectors) > 0 else True, vectors

    @staticmethod
    def compute_path_length(_path):
        result = 0
        for i in range(len(_path)):
            delta_x = _path[i][0] - _path[i + 1][0]
            delta_y = _path[i][1] - _path[i + 1][1]
            delta_z = _path[i][2] - _path[i + 1][2]

            result += delta_x * delta_x + delta_y * delta_y + delta_z * delta_z

        return math.sqrt(result)

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
        if MapManager._check_tile_load(map_id, x, y, map_tile_x, map_tile_y) == MapTileStates.UNUSABLE:
            return False

        return True

    @staticmethod
    def calculate_z_for_object(world_object):
        return world_object.location.calculate_z(world_object.location.x, world_object.location.y, world_object.map_,
                                                 world_object.location.z)

    # noinspection PyBroadException
    @staticmethod
    def calculate_z(map_id, x, y, current_z=0.0) -> tuple:  # float, z_locked (Could not use map files Z)
        if not config.Server.Settings.use_nav_tiles and not config.Server.Settings.use_map_tiles:
            return current_z, False
        try:
            map_tile_x, map_tile_y, tile_local_x, tile_local_y = MapManager.calculate_tile(x, y, (RESOLUTION_ZMAP - 1))

            # No tile data available or busy loading.
            if MapManager._check_tile_load(map_id, x, y, map_tile_x, map_tile_y) != MapTileStates.READY:
                return current_z, False

            try:
                x_normalized = (RESOLUTION_ZMAP - 1) * (32.0 - (x / ADT_SIZE) - map_tile_x) - tile_local_x
                y_normalized = (RESOLUTION_ZMAP - 1) * (32.0 - (y / ADT_SIZE) - map_tile_y) - tile_local_y
                val_1 = MapManager.get_height(map_id, map_tile_x, map_tile_y, tile_local_x, tile_local_y)
                val_2 = MapManager.get_height(map_id, map_tile_x, map_tile_y, tile_local_x + 1, tile_local_y)
                top_height = MapManager._lerp(val_1, val_2, x_normalized)
                val_3 = MapManager.get_height(map_id, map_tile_x, map_tile_y, tile_local_x, tile_local_y + 1)
                val_4 = MapManager.get_height(map_id, map_tile_x, map_tile_y, tile_local_x + 1, tile_local_y + 1)
                bottom_height = MapManager._lerp(val_3, val_4, x_normalized)
                calculated_z = MapManager._lerp(top_height, bottom_height, y_normalized)  # Z
                # If maps Z is quite different, cascade into nav Z, if that also fails, current Z will be returned.
                if math.fabs(current_z - calculated_z) >= 1.0 and current_z:
                    return MapManager.calculate_nav_z(map_id, x, y, current_z)
                return calculated_z, False
            except:
                tile = MAPS_TILES[map_id][map_tile_x][map_tile_y]
                return tile.z_height_map[tile_local_x][tile_local_x], False
        except:
            Logger.error(traceback.format_exc())
            return current_z if current_z else 0.0, False

    @staticmethod
    def get_area_information(map_id, x, y):
        try:
            resolution = RESOLUTION_AREA_INFO - 1
            map_tile_x, map_tile_y, tile_local_x, tile_local_y = MapManager.calculate_tile(x, y, resolution)

            if MapManager._check_tile_load(map_id, x, y, map_tile_x, map_tile_y) != MapTileStates.READY:
                return None
            tile = MAPS_TILES[map_id][map_tile_x][map_tile_y]
            area_information = tile.get_area_at(tile_local_x, tile_local_y)
            return area_information if area_information else None
        except:
            Logger.error(traceback.format_exc())
            return None

    @staticmethod
    def get_liquid_information(map_id, x, y, z, ignore_z=False):
        if not config.Server.Settings.use_map_tiles:
            return None
        try:
            map_tile_x, map_tile_y, tile_local_x, tile_local_y = MapManager.calculate_tile(x, y, RESOLUTION_LIQUIDS - 1)

            if MapManager._check_tile_load(map_id, x, y, map_tile_x, map_tile_y) != MapTileStates.READY:
                return None

            tile = MAPS_TILES[map_id][map_tile_x][map_tile_y]
            liquids = tile.get_liquids_at(tile_local_x, tile_local_y)
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
        if MapManager._check_tile_load(map_id, x, y, map_tile_x, map_tile_y) != MapTileStates.READY:
            return False
        return True

    @staticmethod
    def _check_tile_load(map_id, location_x, location_y, map_tile_x, map_tile_y):
        # Check if the map is valid first.
        if map_id not in MAPS or map_id not in MAPS_TILES:
            Logger.warning(f'Wrong map, {map_id} not found.')
        else:
            try:
                tile = MAPS_TILES[map_id][map_tile_x][map_tile_y]
                if tile.is_ready() and tile.can_use():
                    return MapTileStates.READY
                # Loaded but has no maps or navs data.
                elif tile.is_ready() and not tile.can_use():
                    return MapTileStates.UNUSABLE
                elif not tile.is_loading() and not tile.is_initialized():
                    MapManager.enqueue_adt_tile_initialization(map_id, location_x, location_y)
                    return MapTileStates.LOADING
                # Initialized but still loading.
                elif tile.is_loading():
                    return MapTileStates.LOADING
            except:
                Logger.error(traceback.format_exc())
                Logger.error(f'Error retrieving tile information for the following position: '
                             f'Map ID: {map_id}, X: {location_x}, Y: {location_y}, '
                             f'Tile X: {map_tile_x}, Tile Y: {map_tile_y}.')
        return MapTileStates.UNUSABLE

    @staticmethod
    def calculate_tile(x, y, resolution):
        x = MapManager.validate_map_coord(x)
        y = MapManager.validate_map_coord(y)
        map_tile_x = int(32.0 - (x / ADT_SIZE))
        map_tile_y = int(32.0 - (y / ADT_SIZE))
        tile_local_x = int(resolution * (32.0 - (x / ADT_SIZE) - map_tile_x))
        tile_local_y = int(resolution * (32.0 - (y / ADT_SIZE) - map_tile_y))
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

        return MAPS_TILES[map_id][map_tile_x][map_tile_y].get_z_at(map_tile_local_x, map_tile_local_y)

    @staticmethod
    def validate_map_coord(coord):
        if coord > 32.0 * ADT_SIZE:
            return 32.0 * ADT_SIZE
        elif coord < -32.0 * ADT_SIZE:
            return -32 * ADT_SIZE
        else:
            return coord

    @staticmethod
    def get_map(map_id):
        return MAPS.get(map_id)

    @staticmethod
    def get_grid_manager_by_map_id(map_id) -> Optional[GridManager]:
        try:
            return MAPS[map_id].grid_manager
        except (KeyError, AttributeError, TypeError):
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
        try:
            grid_manager.update_object(world_object, old_grid_manager, has_changes=has_changes,
                                       has_inventory_changes=has_inventory_changes)
        except AttributeError:
            Logger.warning(f'Warning, did not find grid_manager for map: {world_object.map_}')

    @staticmethod
    def spawn_object(world_object_spawn=None, world_object_instance=None):
        map_ = world_object_spawn.map_ if world_object_spawn else world_object_instance.map_
        grid_manager = MapManager.get_grid_manager_by_map_id(map_)
        try:
            grid_manager.spawn_object(world_object_spawn, world_object_instance)
        except AttributeError:
            Logger.warning(f'Warning, did not find grid_manager for map: {map_}')

    @staticmethod
    def remove_object(world_object):
        MapManager.get_grid_manager_by_map_id(world_object.map_).remove_object(world_object)
        FarSightManager.remove_camera(world_object)

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
    def get_creature_spawn_by_id(map_id, spawn_id):
        return MapManager.get_grid_manager_by_map_id(map_id).get_creature_spawn_by_id(spawn_id)

    @staticmethod
    def get_unit_totem_by_totem_entry(unit, totem_entry):
        return MapManager.get_grid_manager_by_map_id(unit.map_).get_unit_totem_by_totem_entry(unit, totem_entry)

    @staticmethod
    def get_surrounding_creature_spawn_by_spawn_id(world_object, spawn_id):
        return MapManager.get_grid_manager_by_map_id(world_object.map_).get_surrounding_creature_spawn_by_spawn_id(
            world_object, spawn_id)

    @staticmethod
    def get_surrounding_units_by_location(vector, target_map, range_, include_players=False):
        grid_mgr = MapManager.get_grid_manager_by_map_id(target_map)
        try:
            return grid_mgr.get_surrounding_units_by_location(vector, target_map, range_, include_players)
        except AttributeError:
            return [{}, {}]

    @staticmethod
    def get_surrounding_players_by_location(vector, target_map, range_):
        grid_mgr = MapManager.get_grid_manager_by_map_id(target_map)
        try:
            return grid_mgr.get_surrounding_players_by_location(vector, target_map, range_)
        except AttributeError:
            return [{}, {}]

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
    def update_dynobjects():
        for map_id, map_ in MAPS.items():
            map_.grid_manager.update_dynobjects()

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
