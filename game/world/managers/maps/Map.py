from game.world.managers.maps.helpers.MapUtils import MapUtils
from game.world.managers.objects.pools.PoolManager import PoolManager
from utils.ConfigManager import config
from utils.Logger import Logger

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.maps.GridManager import GridManager
from game.world.managers.maps.MapEventManager import MapEventManager
from game.world.managers.maps.helpers.Constants import MapType
from game.world.managers.objects.script.ScriptHandler import ScriptHandler
from utils.constants.MiscCodes import PoolType


class Map:
    def __init__(self, map_id, active_cell_callback, inactive_cell_callback, instance_id, map_manager):
        self.map_id = map_id
        self.map_manager = map_manager
        self.dbc_map = DbcDatabaseManager.map_get_by_id(map_id)
        self.instance_id = instance_id
        self.name = self.dbc_map.MapName_enUS
        self.grid_manager = GridManager(map_id, instance_id, active_cell_callback, inactive_cell_callback)
        self.script_handler = ScriptHandler(self)
        self.map_event_manager = MapEventManager()
        self.pool_manager = PoolManager()

    def initialize(self):
        # Load creatures and gameobjects.
        self._load_map_creatures()
        self._load_map_gameobjects()

    def _load_map_creatures(self):
        if not config.Server.Settings.load_creatures:
            return

        creature_spawns = WorldDatabaseManager.creature_spawn_get_by_map_id(self.dbc_map.ID)
        if not creature_spawns:
            return

        # Create spawn instances and fill this map pool manager.
        creature_spawns_instances = self._load_creatures_pools_data(creature_spawns)

        # Spawn orphan creatures.
        count = 0
        length = len(creature_spawns_instances)
        for creature_spawn_instance in creature_spawns_instances:
            creature_spawn_instance.spawn()
            count += 1
            Logger.progress(f'Spawning creatures, Map {self.name}, Instance {self.instance_id}...', count, length)

        # Spawn pools.
        count = 0
        creature_pools = self.pool_manager.get_pools_for_type(PoolType.CREATURE)
        length = len(creature_pools)
        for creature_pool in creature_pools:
            creature_pool.spawn()
            count += 1
            Logger.progress(f'Spawning creature pool, Map {self.name}, Instance {self.instance_id}...', count, length)

    def _load_map_gameobjects(self):
        if not config.Server.Settings.load_gameobjects:
            return

        gobject_spawns = WorldDatabaseManager.gameobject_get_all_spawns_by_map_id(self.dbc_map.ID)
        if not gobject_spawns:
            return

        # Create spawn instances and fill this map pool manager.
        gobject_spawns_instances = self._load_gameobjects_pools_data(gobject_spawns)

        # Spawn orphan objects.
        count = 0
        length = len(gobject_spawns_instances)
        for gobject_spawn_instance in gobject_spawns_instances:
            gobject_spawn_instance.spawn()
            count += 1
            Logger.progress(f'Spawning gameobjects, Map {self.name}, Instance {self.instance_id}...', count, length)

        # Spawn pools.
        count = 0
        go_pools = self.pool_manager.get_pools_for_type(PoolType.GAMEOBJECT)
        length = len(go_pools)
        for gobject_pool in go_pools:
            gobject_pool.spawn()
            count += 1
            Logger.progress(f'Spawning gameobjects pools, Map {self.name}, Instance {self.instance_id}...', count, length)

    def _load_gameobjects_pools_data(self, gobject_spawns):
        from game.world.managers.objects.gameobjects.GameObjectSpawn import GameObjectSpawn
        go_spawn_instances = []

        count = 0
        length = len(gobject_spawns)
        for gobject_spawn in gobject_spawns:
            go_spawn_instance = GameObjectSpawn(gobject_spawn, instance_id=self.instance_id)
            if config.Server.Settings.load_pools:
                go_spawn_instance.generate_or_add_to_pool_if_needed(self.pool_manager)
            if not go_spawn_instance.pool:
                go_spawn_instances.append(go_spawn_instance)
            count += 1
            Logger.progress(f'Loading gameobjects, Map {self.name}, Instance {self.instance_id}...', count, length)

        return go_spawn_instances

    def _load_creatures_pools_data(self, creature_spawns):
        from game.world.managers.objects.units.creature.CreatureSpawn import CreatureSpawn
        creature_spawn_instances = []

        count = 0
        length = len(creature_spawns)
        for creature_spawn in creature_spawns:
            creature_spawn_instance = CreatureSpawn(creature_spawn, instance_id=self.instance_id)
            if config.Server.Settings.load_pools:
                creature_spawn_instance.generate_or_add_to_pool_if_needed(self.pool_manager)
            if not creature_spawn_instance.pool:
                creature_spawn_instances.append(creature_spawn_instance)
            count += 1
            Logger.progress(f'Loading creatures, Map {self.name}, Instance {self.instance_id}...', count, length)

        return creature_spawn_instances

    def is_dungeon(self):
        return self.dbc_map.IsInMap == MapType.INSTANCE

    def is_pvp(self):
        return self.dbc_map.PVP == 1

    # Map events.

    def add_event(self, source, target, map_id, event_id, time_limit, success_condition, success_script,
                  failure_condition, failure_script):
        self.map_event_manager.add_event(source, target, map_id, event_id, time_limit, success_condition,
                                         success_script, failure_condition, failure_script)

    def end_event(self, event_id, success):
        self.map_event_manager.end_event(event_id, success)

    def add_event_target(self, target, event_id, success_condition, success_script, failure_condition, failure_script):
        self.map_event_manager.add_event_target(target, event_id, success_condition, success_script, failure_condition,
                                                failure_script)

    def remove_event_target(self, target, event_id, condition_id, options):
        self.map_event_manager.remove_event_target(target, event_id, condition_id, options)

    def set_event_data(self, event_id, index, data, options):
        self.map_event_manager.set_event_data(event_id, index, data, options)

    def edit_map_event_data(self, event_id, success_condition, success_script, failure_condition, failure_script):
        self.map_event_manager.edit_map_event_data(event_id, success_condition, success_script, failure_condition,
                                                   failure_script)

    def send_event_data(self, event_id, data_index, options):
        self.map_event_manager.send_event_data(event_id, data_index, options)

    def get_map_event_data(self, event_id):
        return self.map_event_manager.get_map_event_data(event_id)

    def is_event_active(self, event_id):
        return self.map_event_manager.is_event_active(event_id)

    # Scripts.

    def enqueue_script(self, source, target, script_type, script_id, delay=0.0, event=None):
        self.script_handler.enqueue_script(source, target, script_type, script_id, delay=delay, event=event)

    # Map helpers.

    def get_liquid_or_create(self, liquid_type, l_min, l_max, use_float_16):
        return self.map_manager.get_liquid_or_create(liquid_type, l_min, l_max, use_float_16)

    def find_liquid_location_in_range(self, world_object, min_range, max_range):
        return self.map_manager.find_liquid_location_in_range(world_object, min_range, max_range)

    def get_area_information(self, x, y):
        return self.map_manager.get_area_information(self.map_id, x, y)

    def get_parent_zone_id(self, zone_id):
        return self.map_manager.get_parent_zone_id(zone_id, self.map_id)

    def can_reach_object(self, source_object, target_object):
        return self.map_manager.can_reach_object(source_object, target_object)

    def get_liquid_information(self, x, y, z, ignore_z=False):
        return self.map_manager.get_liquid_information(self.map_id, x, y, z, ignore_z=ignore_z)

    def get_area_number_by_zone_id(self, zone_id):
        return self.map_manager.get_area_number_by_zone_id(zone_id)

    def validate_teleport_destination(self, x, y, map_id=-1):
        map_id = self.map_id if map_id == -1 else map_id
        return self.map_manager.validate_teleport_destination(map_id, x, y)

    def calculate_path(self, start_vector, end_vector, los=False) -> tuple:  # bool failed, in_place, path list.
        return self.map_manager.calculate_path(self.map_id, start_vector, end_vector, los=los)

    def find_point_in_between_vectors(self, offset, start_location, end_location):
        return self.map_manager.find_point_in_between_vectors(self.map_id, offset, start_location, end_location)

    def calculate_z_for_object(self, world_object):
        return self.map_manager.calculate_z_for_object(world_object)

    def calculate_z(self, x, y, current_z=0.0, is_rand_point=False) -> tuple:  # float, z_locked (Could not use map files Z)
        return self.map_manager.calculate_z(self.map_id, x, y, current_z=current_z, is_rand_point=is_rand_point)

    def los_check(self, start_vector, end_vector, doodads=False):
        return self.map_manager.los_check(self.map_id, start_vector, end_vector, doodads=doodads)

    def get_tile(self, x, y):
        return MapUtils.get_tile(x, y)

    # GridManager helpers.

    def spawn_object(self, world_object_spawn=None, world_object_instance=None):
        self.grid_manager.spawn_object(world_object_spawn, world_object_instance)

    def update_object(self, world_object, has_changes=False, has_inventory_changes=False):
        self.grid_manager.update_object(world_object, has_changes, has_inventory_changes)

    def remove_object(self, world_object, update_players=True):
        self.grid_manager.remove_object(world_object, update_players)

    def unit_should_relocate(self, world_object, destination, destination_map, destination_instance):
        return self.grid_manager.unit_should_relocate(world_object, destination, destination_map, destination_instance)

    def send_surrounding(self, packet, world_object, include_self=True, exclude=None, use_ignore=False):
        self.grid_manager.send_surrounding(packet, world_object, include_self, exclude, use_ignore)

    def send_surrounding_in_range(self, packet, world_object, range_, include_self=True, exclude=None, use_ignore=False):
        self.grid_manager.send_surrounding_in_range(packet, world_object, range_, include_self, exclude, use_ignore)

    def get_surrounding_objects(self, world_object, object_types):
        return self.grid_manager.get_surrounding_objects(world_object, object_types)

    def get_surrounding_players(self, world_object):
        return self.grid_manager.get_surrounding_players(world_object)

    def get_surrounding_units(self, world_object, include_players=False):
        return self.grid_manager.get_surrounding_units(world_object, include_players)

    def get_creature_spawn_by_id(self, spawn_id):
        return self.grid_manager.get_creature_spawn_by_id(spawn_id)

    def get_gameobject_spawn_by_id(self, spawn_id):
        return self.grid_manager.get_gameobject_spawn_by_id(spawn_id)

    def get_surrounding_units_by_location(self, vector, target_map, target_instance, range_, include_players=False):
        return self.grid_manager.get_surrounding_units_by_location(vector, target_map, target_instance, range_, include_players)

    def get_surrounding_players_by_location(self, vector, target_map, target_instance, range_):
        return self.grid_manager.get_surrounding_players_by_location(vector, target_map, target_instance, range_)

    def get_surrounding_gameobjects(self, world_object):
        return self.grid_manager.get_surrounding_gameobjects(world_object)

    def get_surrounding_player_by_guid(self, world_object, guid):
        return self.grid_manager.get_surrounding_player_by_guid(world_object, guid)

    def get_surrounding_unit_by_guid(self, world_object, guid, include_players=False):
        return self.grid_manager.get_surrounding_unit_by_guid(world_object, guid, include_players)

    def get_surrounding_creature_spawn_by_spawn_id(self, world_object, spawn_id):
        return self.grid_manager.get_surrounding_creature_spawn_by_spawn_id(world_object, spawn_id)

    def get_surrounding_gameobject_by_guid(self, world_object, guid):
        return self.grid_manager.get_surrounding_gameobject_by_guid(world_object, guid)

    def get_surrounding_gameobject_spawn_by_spawn_id(self, world_object, spawn_id):
        return self.grid_manager.get_surrounding_gameobject_spawn_by_spawn_id(world_object, spawn_id)

    def is_active_cell(self, cell_coords):
        return self.grid_manager.is_active_cell(cell_coords)

    def is_active_cell_for_location(self, location):
        return self.grid_manager.is_active_cell_for_location(location)

    def get_active_cell_count(self):
        return self.grid_manager.get_active_cell_count()

    def activate_cell_by_world_object(self, world_object):
        self.grid_manager.activate_cell_by_world_object(world_object)

    # Objects updates.
    def update_creatures(self):
        self.grid_manager.update_creatures()

    def update_gameobjects(self):
        self.grid_manager.update_gameobjects()

    def update_transports(self):
        self.grid_manager.update_transports()

    def update_dynobjects(self):
        self.grid_manager.update_dynobjects()

    def update_spawns(self):
        self.grid_manager.update_spawns()

    def update_corpses(self):
        self.grid_manager.update_corpses()

    def update_map_scripts_and_events(self, now):
        self.map_event_manager.update(now)
        self.script_handler.update(now)

    def deactivate_cells(self):
        self.grid_manager.deactivate_cells()
