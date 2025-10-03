import traceback
import math
from functools import lru_cache
from multiprocessing import RLock
from os import path
import time

import _queue
from random import choice
from typing import Optional

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from game.world.managers.maps.helpers.Constants import ADT_SIZE, RESOLUTION_ZMAP, RESOLUTION_AREA_INFO, \
    RESOLUTION_LIQUIDS, BLOCK_SIZE
from game.world.managers.maps.Map import Map, MapType
from game.world.managers.maps.MapTile import MapTile
from game.world.managers.maps.helpers.LiquidInformation import LiquidInformation
from game.world.managers.maps.helpers.MapUtils import MapUtils
from game.world.managers.maps.helpers.Namigator import Namigator
from utils.ConfigManager import config
from utils.GitUtils import GitUtils
from utils.Logger import Logger
from utils.PathManager import PathManager
from utils.constants.MiscCodes import MapsNoNavs, MapTileStates


MAPS: dict[int, dict[int, Map]] = {}
MAP_LIST: list[int] = DbcDatabaseManager.map_get_all_ids()
# Holds .map files tiles information per Map.
MAPS_TILES = dict()
# Holds namigator instances, one instance per common Map.
MAPS_NAMIGATOR: dict[int, Namigator] = dict()

AREAS = {}
AREA_LIST = DbcDatabaseManager.area_get_all_ids()
LIQUIDS_CACHE = {}
PENDING_TILE_INITIALIZATION = {}
PENDING_TILE_INITIALIZATION_QUEUE = _queue.SimpleQueue()
QUEUE_LOCK = RLock()


# noinspection PyBroadException
class MapManager:
    NAMIGATOR_LOADED = False
    NAMIGATOR_FAILED = False

    @staticmethod
    def initialize_world_and_pvp_maps():
        for map_id in MAP_LIST:
            dbc_map = DbcDatabaseManager.map_get_by_id(map_id)
            # Initialize common and PvP maps. (We handle PvP maps as common)
            if dbc_map.IsInMap != MapType.COMMON and dbc_map.PVP != 1:
                continue
            # World/Pvp maps use map_id as instance id.
            MapManager._build_map(map_id, map_id)

    @staticmethod
    def has_navs(map_id):
        return not MapsNoNavs.has_value(map_id)

    @staticmethod
    @lru_cache
    def is_dungeon_map_id(map_id):
        dbc_map = DbcDatabaseManager.map_get_by_id(map_id)
        return not dbc_map.IsInMap and not dbc_map.PVP

    @staticmethod
    def _build_map(map_id, instance_id):
        if map_id in MAPS and instance_id in MAPS[map_id]:
            Logger.warning(f'Tried to instantiate an existent map. Map {map_id}, Instance {instance_id}')
            return

        # Initialize instances dictionary.
        if map_id not in MAPS:
            MAPS[map_id] = dict()

        new_map = Map(map_id, MapManager.on_cell_turn_active, MapManager.on_cell_turn_inactive, instance_id=instance_id, map_manager=MapManager)
        MAPS[map_id][instance_id] = new_map
        new_map.initialize()
        MapManager._build_map_namigator(new_map)
        MapManager._build_map_adt_tiles(new_map)
        return new_map

    @staticmethod
    def _build_map_namigator(map_: Map):
        if not MapManager.has_navs(map_.map_id) or MapManager.NAMIGATOR_FAILED or map_.map_id in MAPS_NAMIGATOR \
                or not config.Server.Settings.use_nav_tiles:
            return

        try:
            from namigator import pathfind
            nav_root_path = PathManager.get_navs_path()
            nav_map_path = PathManager.get_nav_map_path(map_.name)
            if not path.exists(nav_root_path) or not path.exists(nav_map_path):
                Logger.warning(f'[Namigator] Skip {map_.name} ID {map_.map_id}, no data.')
                return
            MAPS_NAMIGATOR[map_.map_id] = pathfind.Map(nav_root_path, f'{map_.name}')
            Logger.success(f'[Namigator] Successfully loaded for map {map_.name}')
            MapManager.NAMIGATOR_LOADED = True
        except ImportError:
            Logger.error('[Namigator] Unable to load module.')
            MapManager.NAMIGATOR_FAILED = True
            pathfind = None  # Required.
            Logger.error(traceback.format_exc())
            return

    @staticmethod
    def get_active_maps():
        active_maps = []
        for map_id, instances in list(MAPS.items()):
            for instance_map in list(instances.values()):
                active_maps.append(instance_map)
        return active_maps

    @staticmethod
    def get_active_tiles_count():
        return len([loaded for loaded in PENDING_TILE_INITIALIZATION.values() if loaded])

    @staticmethod
    def enqueue_adt_tile_load(map_id, adt_x, adt_y):
        with QUEUE_LOCK:
            adt_key = f'{map_id},{adt_x},{adt_y}'
            if adt_key in PENDING_TILE_INITIALIZATION:
                return

            PENDING_TILE_INITIALIZATION[adt_key] = True
            to_load_data = f'{map_id},{adt_x},{adt_y}'
            PENDING_TILE_INITIALIZATION_QUEUE.put(to_load_data)

    @staticmethod
    def _build_map_adt_tiles(map_: Map):
        if map_.map_id in MAPS_TILES:
            return

        MAPS_TILES[map_.map_id] = [[None for _ in range(BLOCK_SIZE)] for _ in range(BLOCK_SIZE)]
        for adt_x in range(BLOCK_SIZE):
            for adt_y in range(BLOCK_SIZE):
                MAPS_TILES[map_.map_id][adt_x][adt_y] = MapTile(map_, adt_x, adt_y)

        Logger.success(f'[MAP] Successfully built ADT tiles for map {map_.name}')
        return

    @staticmethod
    def initialize_pending_tiles():
        if PENDING_TILE_INITIALIZATION_QUEUE.empty():
            return
        key = PENDING_TILE_INITIALIZATION_QUEUE.get()
        map_id, adt_x, adt_y = str(key).rsplit(',')
        MapManager.initialize_adt_tile(int(map_id), int(adt_x), int(adt_y))

    @staticmethod
    def initialize_adt_tile(map_id, adt_x, adt_y):
        if map_id not in MAP_LIST:
            return False

        # Map namigator instance, if available.
        namigator = MAPS_NAMIGATOR[map_id] if (map_id in MAPS_NAMIGATOR and MapManager.NAMIGATOR_LOADED) else None

        if MAPS_TILES[map_id][adt_x][adt_y].initialized:
            return False

        MAPS_TILES[map_id][adt_x][adt_y].initialize(namigator)

        return True

    @staticmethod
    def get_map(map_id, instance_id) -> Optional[Map]:
        try:
            return MAPS[map_id][instance_id]
        except (KeyError, AttributeError, TypeError):
            Logger.error(f'Unable to retrieve Map for Id {map_id}, Instance {instance_id}')
        return None

    @staticmethod
    def get_or_create_instance_map(instance_token) -> Map:
        if instance_token.map_id not in MAPS:
            MAPS[instance_token.map_id] = dict()
        # If the instance does not exist, create it.
        if instance_token.id not in MAPS[instance_token.map_id]:
            instance_map = MapManager._build_map(instance_token.map_id, instance_token.id)
        else:
            instance_map = MAPS[instance_token.map_id][instance_token.id]
        return instance_map

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
    def get_liquid_or_create(liquid_type, height, use_float_16):
        key = f'{liquid_type}.{round(height, 4)}'
        if key not in LIQUIDS_CACHE:
            LIQUIDS_CACHE[key] = LiquidInformation(liquid_type, height, use_float_16)
        return LIQUIDS_CACHE[key]

    @staticmethod
    def on_cell_turn_active(map_id, adt_x, adt_y):
        MapManager.enqueue_adt_tile_load(map_id, adt_x, adt_y)

    @staticmethod
    def on_cell_turn_inactive(map_id, adt_x, adt_y):
        # Normal Tile unload (.map)
        tile = MAPS_TILES[map_id][adt_x][adt_y]
        if tile and tile.is_ready():
            Logger.info(f'[Map] Unloading map tile, Map:{map_id} Tile:{adt_x},{adt_y}')
            tile.unload()

        # Namigator unload (.nav)
        if (map_id in MAPS_NAMIGATOR and MapManager.has_navs(map_id) and not MapManager.NAMIGATOR_FAILED
                and config.Server.Settings.use_nav_tiles) and MAPS_NAMIGATOR[map_id].adt_loaded(adt_y, adt_x):
            MAPS_NAMIGATOR[map_id].unload_adt(adt_y, adt_x)
            Logger.info(f'[Namigator] Unloading nav ADT, Map:{map_id} Tile:{adt_x},{adt_y}')

        adt_key = f'{map_id},{adt_x},{adt_y}'
        if adt_key in PENDING_TILE_INITIALIZATION:
            del PENDING_TILE_INITIALIZATION[adt_key]

    @staticmethod
    def validate_map_files():
        if not config.Server.Settings.use_map_tiles:
            return True

        if not MapTile.validate_version():
            return False

        return True

    @staticmethod
    def validate_namigator_bindings():
        if not config.Server.Settings.use_nav_tiles:
            return True

        if not GitUtils.check_download_namigator_bindings():
            return False

        return True

    @staticmethod
    def calculate_z_for_object(w_object):
        return MapManager.calculate_z(w_object.map_id, w_object.location.x, w_object.location.y, w_object.location.z)

    # noinspection PyBroadException
    @staticmethod
    def calculate_z(map_id, x, y, current_z=0.0, is_rand_point=False) -> tuple:
        # float, z_locked (Could not use map files Z)
        if not config.Server.Settings.use_nav_tiles and not config.Server.Settings.use_map_tiles:
            return current_z, False
        try:
            adt_x, adt_y, cell_x, cell_y = MapUtils.calculate_tile(x, y)

            # No tile data available or busy loading.
            if MapManager._check_tile_load(map_id, x, y, adt_x, adt_y) != MapTileStates.READY:
                return current_z, False

            # Always prioritize Namigator if enabled.
            if config.Server.Settings.use_nav_tiles:
                nav_z, z_locked = MapManager.calculate_nav_z(map_id, x, y, current_z, is_rand_point=is_rand_point)
                if not z_locked:
                    return nav_z, False

            # Check if we have .map data for this request.
            tile = MAPS_TILES[map_id][adt_x][adt_y]
            if not tile or not tile.has_maps:
                return current_z, True

            try:
                calculated_z = MapManager.get_normalized_height_for_cell(map_id, x, y, adt_x, adt_y, cell_x, cell_y)
                # Tolerance.
                tol = 1.1 if not is_rand_point else 2
                # If Z goes outside boundaries, expand our search.
                if (math.fabs(current_z - calculated_z) > tol) and current_z:
                    found, z2 = MapManager.get_near_height(map_id, x, y, adt_x, adt_y, cell_x, cell_y, current_z, tol)
                    # Not locked if found, else current z locked.
                    return (z2, False) if found else (current_z, True)
                # First Z was valid.
                return calculated_z, False
            except:
                tile = MAPS_TILES[map_id][adt_x][adt_y]
                return tile.z_height_map[cell_x][cell_y], False
        except:
            Logger.error(traceback.format_exc())
            return current_z if current_z else 0.0, False

    @staticmethod
    def calculate_nav_z(map_id, x, y, current_z=0.0, is_rand_point=False) -> tuple:  # float, bool result negation
        # If nav tiles disabled or unable to load Namigator, return current Z as locked.
        if not config.Server.Settings.use_nav_tiles or not MapManager.NAMIGATOR_LOADED:
            return current_z, True

        if map_id not in MAPS:
            return current_z, True

        if map_id not in MAPS_NAMIGATOR:
            return current_z, True

        adt_x, adt_y = MapUtils.get_tile(x, y)
        # Check if we need to load adt.
        if MapManager._check_tile_load(map_id, x, y, adt_x, adt_y) != MapTileStates.READY:
            return current_z, True

        # Query available heights.
        heights = MAPS_NAMIGATOR[map_id].query_heights(float(x), float(y))

        # Direct Z query.
        query_z = MAPS_NAMIGATOR[map_id].query_z(x, y, current_z, x, y)
        if query_z:
            heights.append(query_z)

        if len(heights) == 0:
            if not is_rand_point:
                Logger.warning(f'[NAMIGATOR] Unable to find Z for Map {map_id} ADT [{adt_x},{adt_y}] {x} {y} {current_z}')
            return current_z, True

        # We are only interested in the resulting Z near to the Z we know.
        heights = sorted(heights, key=lambda _z: abs(current_z - _z))

        return heights[0], False

    @staticmethod
    def los_check(map_id, src_loc, dst_loc, doodads=False):
        # No nav tiles or unable to load Namigator, can't check LoS.
        if not config.Server.Settings.use_nav_tiles or not MapManager.NAMIGATOR_LOADED:
            return True

        # Grab namigator instance if available.
        namigator = MAPS_NAMIGATOR.get(map_id, None)
        if not namigator:
            return True

        # Calculate source adt coordinates for x,y.
        src_adt_x, src_adt_y = MapUtils.get_tile(src_loc.x, src_loc.y)

        # Calculate destination adt coordinates for x,y.
        dst_adt_x, dst_adt_y = MapUtils.get_tile(dst_loc.x, dst_loc.y)

        # Check if loaded or unable to load, return True if this fails.
        initial_source_tile_state = MapManager._check_tile_load(map_id, src_loc.x, src_loc.y, src_adt_x, src_adt_y)
        if initial_source_tile_state != MapTileStates.READY:
            # If tile is loading return false.
            return initial_source_tile_state != MapTileStates.LOADING

        # Check if loaded or unable to load, return True if this fails.
        initial_dest_tile_state = MapManager._check_tile_load(map_id, dst_loc.x, dst_loc.y, dst_adt_x, dst_adt_y)
        if initial_dest_tile_state != MapTileStates.READY:
            # If tile is loading return false.
            return initial_dest_tile_state != MapTileStates.LOADING

        return namigator.line_of_sight(src_loc.x, src_loc.y, src_loc.z, dst_loc.x, dst_loc.y, dst_loc.z, doodads)

    @staticmethod
    def can_reach_object(src_object, dst_object):
        if src_object.map_id != dst_object.map_id:
            return False

        # If nav tiles disabled or unable to load Namigator, return as True.
        if not config.Server.Settings.use_nav_tiles or not MapManager.NAMIGATOR_LOADED:
            return True

        # We don't have navs loaded for a given map, return True.
        if src_object.map_id not in MAPS_NAMIGATOR:
            return True

        failed, in_place, _ = MapManager.calculate_path(src_object.map_id, src_object.location, dst_object.location)
        return not failed

    @staticmethod
    def find_point_in_between_vectors(map_id, offset, start_location, end_location):
        # If nav tiles disabled or unable to load Namigator, return None..
        if not config.Server.Settings.use_nav_tiles or not MapManager.NAMIGATOR_LOADED:
            return None

        # We don't have navs loaded for a given map, return None..
        namigator = MAPS_NAMIGATOR.get(map_id, None)
        if not namigator:
            return None

        return namigator.find_point_in_between_vectors(offset, start_location.x, start_location.y, start_location.z,
                                                       end_location.x, end_location.y, end_location.z)

    @staticmethod
    def calculate_path(map_id, src_loc, dst_loc, los=False) -> tuple:  # bool failed, in_place, path list.
        # If nav tiles disabled or unable to load Namigator, return the end_vector as found.
        if not config.Server.Settings.use_nav_tiles or not MapManager.NAMIGATOR_LOADED:
            return False, False, [dst_loc]

        # We don't have navs loaded for a given map, return end vector.
        namigator = MAPS_NAMIGATOR.get(map_id, None)
        if not namigator:
            return False, False, [dst_loc]

        # At destination, return end vector.
        if src_loc == dst_loc:
            return False, False, [dst_loc]

        # Too short of a path, return end vector.
        if src_loc.distance(dst_loc) < 1.0:
            return False, False, [dst_loc]

        # Calculate source adt coordinates for x,y.
        src_adt_x, src_adt_y = MapUtils.get_tile(src_loc.x, src_loc.y)

        # Calculate destination adt coordinates for x,y.
        dst_adt_x, dst_adt_y = MapUtils.get_tile(dst_loc.x, dst_loc.y)

        # Check if loaded or unable to load.
        if MapManager._check_tile_load(map_id, src_loc.x, src_loc.y, src_adt_x, src_adt_y) != MapTileStates.READY:
            return True, False, [dst_loc]

        # Check if loaded or unable to load.
        if MapManager._check_tile_load(map_id, dst_loc.x, dst_loc.y, dst_adt_x, dst_adt_y) != MapTileStates.READY:
            return True, False, [dst_loc]

        # Calculate path.
        navigation_path = namigator.find_path(src_loc.x, src_loc.y, src_loc.z, dst_loc.x, dst_loc.y, dst_loc.z)

        if len(navigation_path) == 0:
            if not los:
                Logger.warning(f'Unable to find path, map {map_id} loc {src_loc} end {dst_loc}')
            return True, False, [dst_loc]

        # Pop starting location, we already have that and WoW client seems to crash when sending
        # movements with too short of a diff.
        del navigation_path[0]

        # Validate length again.
        if len(navigation_path) == 0:
            if not los:
                Logger.warning(f'Unable to find path, map {map_id} loc {src_loc} end {dst_loc}')
            return True, False, [dst_loc]

        from game.world.managers.abstractions.Vector import Vector
        vectors = [Vector(waypoint[0], waypoint[1], waypoint[2]) for waypoint in navigation_path]

        return False, False if len(vectors) > 0 else True, vectors

    @staticmethod
    def validate_teleport_destination(map_id, x, y):
        # Can't validate if not using tile files, so return as True.
        if not config.Server.Settings.use_map_tiles:
            return True

        # Check valid ID.
        if map_id not in MAP_LIST:
            return False

        # Some instances don't have tiles, only WMOs; always allow teleporting inside one.
        if map_id > 1:
            return True

        # Validate position is within map boundaries.
        if not MapUtils.is_valid_position(x, y):
            return False

        return True

    @staticmethod
    def get_cell_height(map_id, adt_x, adt_y, cell_x, cell_y):
        if cell_x > RESOLUTION_ZMAP:
            adt_x = int(adt_x + 1)
            cell_x = int(cell_x - RESOLUTION_ZMAP)
        elif cell_x < 0:
            adt_x = int(adt_x - 1)
            cell_x = int(-cell_x - 1)

        if cell_y > RESOLUTION_ZMAP:
            adt_y = int(adt_y + 1)
            cell_y = int(cell_y - RESOLUTION_ZMAP)
        elif cell_y < 0:
            adt_y = int(adt_y - 1)
            cell_y = int(-cell_y - 1)

        return MAPS_TILES[map_id][adt_x][adt_y].get_z_at(cell_x, cell_y)

    @staticmethod
    def get_normalized_height_for_cell(map_id, x, y, adt_x, adt_y, cell_x, cell_y):
        x_normalized = (RESOLUTION_ZMAP - 1) * (32.0 - (x / ADT_SIZE) - adt_x) - cell_x
        y_normalized = (RESOLUTION_ZMAP - 1) * (32.0 - (y / ADT_SIZE) - adt_y) - cell_y
        val_1 = MapManager.get_cell_height(map_id, adt_x, adt_y, cell_x, cell_y)
        val_2 = MapManager.get_cell_height(map_id, adt_x, adt_y, cell_x + 1, cell_y)
        top_height = MapManager._lerp(val_1, val_2, x_normalized)
        val_3 = MapManager.get_cell_height(map_id, adt_x, adt_y, cell_x, cell_y + 1)
        val_4 = MapManager.get_cell_height(map_id, adt_x, adt_y, cell_x + 1, cell_y + 1)
        bottom_height = MapManager._lerp(val_3, val_4, x_normalized)
        return MapManager._lerp(top_height, bottom_height, y_normalized)  # Z

    @staticmethod
    def get_near_height(map_id, x, y, adt_x, adt_y, cell_x, cell_y, current_z, tolerance=1.0):
        for i in range(-2, 2):
            for j in range(-2, 2):
                height = MapManager.get_normalized_height_for_cell(map_id, x, y, adt_x, adt_y, cell_x + i, cell_y + j)
                if abs(current_z - height) < tolerance:
                    return True, height
        # Not found.
        return False, current_z

    @staticmethod
    def get_area_information(map_id, x, y):
        if not config.Server.Settings.use_map_tiles:
            return None
        try:
            adt_x, adt_y, cell_x, cell_y = MapUtils.calculate_tile(x, y, RESOLUTION_AREA_INFO - 1)

            if MapManager._check_tile_load(map_id, x, y, adt_x, adt_y) != MapTileStates.READY:
                return None

            tile = MAPS_TILES[map_id][adt_x][adt_y]
            area_information = tile.get_area_at(cell_x, cell_y)
            return area_information if area_information else None
        except:
            Logger.error(traceback.format_exc())
            return None

    @staticmethod
    def get_liquid_information(map_id, x, y, z, ignore_z=False):
        if not config.Server.Settings.use_map_tiles:
            return None
        try:
            adt_x, adt_y, cell_x, cell_y = MapUtils.calculate_tile(x, y, RESOLUTION_LIQUIDS - 1)

            tile_state = MapManager._check_tile_load(map_id, x, y, adt_x, adt_y)
            if tile_state != MapTileStates.READY:
                return None

            tile = MAPS_TILES[map_id][adt_x][adt_y]
            liquids = tile.get_liquids_at(cell_x, cell_y)
            return liquids if liquids and liquids.get_height() > z else liquids if liquids and ignore_z else None
        except:
            Logger.error(traceback.format_exc())
            return None

    @staticmethod
    def find_liquid_location_in_range(world_object, min_range, max_range):
        if not MapManager._validate_liquid_tile(world_object.map_id, world_object.location.x, world_object.location.y):
            return None

        # Circular ref.
        from game.world.managers.abstractions.Vector import Vector
        start_range = min(2, min_range)
        start_location = world_object.location
        map_ = world_object.get_map()
        liquids_vectors = []
        while start_range <= max_range:
            fx = start_location.x + start_range * math.cos(start_location.o)
            fy = start_location.y + start_range * math.sin(start_location.o)
            fz = start_location.z
            liquid_info = map_.get_liquid_information(fx, fy, fz, ignore_z=True)
            if liquid_info:
                liquid_vector = Vector(fx, fy, liquid_info.get_height())
                if map_.los_check(world_object.get_ray_position(), liquid_vector):
                    liquids_vectors.append(liquid_vector)
            start_range += 1

        if len(liquids_vectors) == 0:
            return None

        # Should contain at least 1 element by now.
        return choice(liquids_vectors)

    @staticmethod
    def _validate_liquid_tile(map_id, x, y):
        adt_x, adt_y = MapUtils.get_tile(x, y)
        if MapManager._check_tile_load(map_id, x, y, adt_x, adt_y) != MapTileStates.READY:
            return False
        return True

    @staticmethod
    def _check_tile_load(map_id, location_x, location_y, adt_x, adt_y):
        # Check if the map is valid first.
        if map_id not in MAPS or map_id not in MAPS_TILES:
            Logger.warning(f'Wrong map, {map_id} not found.')
        else:
            try:
                tile = MAPS_TILES[map_id][adt_x][adt_y]
                if tile.is_ready() and tile.can_use():
                    return MapTileStates.READY
                # Loaded but has no maps or navs data.
                elif tile.is_ready() and not tile.can_use():
                    return MapTileStates.UNUSABLE
                # Initialized but still loading.
                elif tile.is_loading():
                    return MapTileStates.LOADING
            except:
                Logger.error(f'Error retrieving tile information for the following position: '
                             f'Map ID: {map_id}, X: {location_x}, Y: {location_y}, '
                             f'Tile X: {adt_x}, Tile Y: {adt_y}.')
        return MapTileStates.UNUSABLE

    @staticmethod
    def _lerp(value1, value2, amount):
        return value1 + ((value2 - value1) * amount)

    @staticmethod
    def update_creatures():
        for map_id, instances in list(MAPS.items()):
            for instance_map in list(instances.values()):
                instance_map.update_creatures()

    @staticmethod
    def update_gameobjects():
        for map_id, instances in list(MAPS.items()):
            for instance_map in list(instances.values()):
                instance_map.update_gameobjects()

    @staticmethod
    def update_transports():
        for map_id, instances in list(MAPS.items()):
            for instance_map in list(instances.values()):
                instance_map.update_transports()

    @staticmethod
    def update_dynobjects():
        for map_id, instances in list(MAPS.items()):
            for instance_map in list(instances.values()):
                instance_map.update_dynobjects()

    @staticmethod
    def update_spawns():
        for map_id, instances in list(MAPS.items()):
            for instance_map in list(instances.values()):
                instance_map.update_spawns()

    @staticmethod
    def update_corpses():
        for map_id, instances in list(MAPS.items()):
            for instance_map in list(instances.values()):
                instance_map.update_corpses()

    @staticmethod
    def update_map_scripts_and_events():
        now = time.time()
        for map_id, instances in list(MAPS.items()):
            for instance_map in list(instances.values()):
                instance_map.update_map_scripts_and_events(now)

    @staticmethod
    def deactivate_cells():
        for map_id, instances in list(MAPS.items()):
            for instance_map in list(instances.values()):
                instance_map.deactivate_cells()
