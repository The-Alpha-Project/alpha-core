from utils.ConfigManager import config
from utils.Logger import Logger

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.maps.GridManager import GridManager
from game.world.managers.maps.MapEventManager import MapEventManager
from game.world.managers.maps.helpers.Constants import MapType
from game.world.managers.objects.script.ScriptHandler import ScriptHandler


class Map:
    def __init__(self, map_id, active_cell_callback, instance_id, map_manager):
        self.map_id = map_id
        self.map_manager = map_manager
        self.dbc_map = DbcDatabaseManager.map_get_by_id(map_id)
        self.instance_id = instance_id
        self.name = self.dbc_map.MapName_enUS
        self.grid_manager = GridManager(map_id, instance_id, active_cell_callback)
        self.script_handler = ScriptHandler(self)
        self.map_event_manager = MapEventManager()

    def initialize(self):
        # Load creatures and gameobjects.
        self._load_map_creatures()
        self._load_map_gameobjects()

    def _load_map_creatures(self):
        if not config.Server.Settings.load_creatures:
            return
        from game.world.managers.objects.units.creature.CreatureSpawn import CreatureSpawn
        creature_spawns = WorldDatabaseManager.creature_spawn_get_by_map_id(self.dbc_map.ID)
        if not creature_spawns:
            return
        count = 0
        length = len(creature_spawns)
        for creature_spawn in creature_spawns:
            creature_spawn = CreatureSpawn(creature_spawn, instance_id=self.instance_id)
            creature_spawn.spawn_creature()
            count += 1
            Logger.progress(f'Loading creatures for Map {self.name}, Instance {self.instance_id}...', count, length)

    def _load_map_gameobjects(self):
        if not config.Server.Settings.load_gameobjects:
            return
        from game.world.managers.objects.gameobjects.GameObjectSpawn import GameObjectSpawn
        gobject_spawns = WorldDatabaseManager.gameobject_get_all_spawns_by_map_id(self.dbc_map.ID)
        if not gobject_spawns:
            return
        count = 0
        length = len(gobject_spawns)
        for gobject_spawn in gobject_spawns:
            gameobject_spawn = GameObjectSpawn(gobject_spawn, instance_id=self.instance_id)
            gameobject_spawn.spawn()
            count += 1
            Logger.progress(f'Loading gameobjects Map {self.name}, Instance {self.instance_id}...', count, length)

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

    # OOC Events

    def set_random_ooc_event(self, source, target, event, forced=False):
        self.script_handler.set_random_ooc_event(source, target, event, forced=forced)

    # Scripts.

    def enqueue_script(self, source, target, script_type, script_id, delay=0.0, ooc_event=None):
        self.script_handler.enqueue_script(source, target, script_type, script_id, delay=delay, ooc_event=ooc_event)

    # Map helpers.

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

    def calculate_z_for_object(self, world_object):
        return self.map_manager.calculate_z_for_object(world_object)

    def calculate_z(self, x, y, current_z=0.0, is_rand_point=False) -> tuple:  # float, z_locked (Could not use map files Z)
        return self.map_manager.calculate_z(self.map_id, x, y, current_z=current_z, is_rand_point=is_rand_point)

    def los_check(self, start_vector, end_vector):
        return self.map_manager.los_check(self.map_id, start_vector, end_vector)

    def get_tile(self, x, y):
        return self.map_manager.get_tile(x, y)

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

    # Objects updates.
    def update_creatures(self):
        self.grid_manager.update_creatures()

    def update_gameobjects(self):
        self.grid_manager.update_gameobjects()

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
