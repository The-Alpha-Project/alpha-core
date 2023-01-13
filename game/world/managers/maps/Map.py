from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.maps.GridManager import GridManager
from game.world.managers.maps.helpers.Constants import MapType
from utils.Logger import Logger


class Map:
    def __init__(self, map_id, active_cell_callback, instance_id):
        self.id = map_id
        self.dbc_map = DbcDatabaseManager.map_get_by_id(map_id)
        self.instance_id = instance_id
        self.grid_manager = GridManager(map_id, instance_id, active_cell_callback)
        self.name = self.dbc_map.MapName_enUS

    def initialize(self):
        # Load creatures and gameobjects.
        self._load_map_creatures()
        self._load_map_gameobjects()

    def _load_map_creatures(self):
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
            Logger.progress(f'Loading creatures for map {self.name}, Instance {self.instance_id}...', count, length)

    def _load_map_gameobjects(self):
        from game.world.managers.objects.gameobjects.GameObjectSpawn import GameObjectSpawn
        gobject_spawns = WorldDatabaseManager.gameobject_get_all_spawns_by_map_id(self.dbc_map.ID)
        if not gobject_spawns:
            return
        count = 0
        length = len(gobject_spawns)
        for gobject_spawn in gobject_spawns:
            gameobject_spawn = GameObjectSpawn(gobject_spawn, instance_id=self.instance_id)
            gameobject_spawn.spawn_gameobject()
            count += 1
            Logger.progress(f'Loading gameobjects Map {self.name}, Instance {self.instance_id}...', count, length)

    def is_dungeon(self):
        return self.dbc_map.IsInMap == MapType.INSTANCE

    def is_pvp(self):
        return self.dbc_map.PVP == 1

    # GridManager.
    def is_active_cell(self, cell_coords):
        return self.grid_manager.is_active_cell(cell_coords)

    def spawn_object(self, world_object_spawn=None, world_object_instance=None):
        self.grid_manager.spawn_object(world_object_spawn, world_object_instance)

    def update_object(self, world_object, old_map, has_changes=False, has_inventory_changes=False):
        self.grid_manager.update_object(world_object, old_map, has_changes, has_inventory_changes)

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

    def get_surrounding_gameobject_by_spawn_id(self, world_object, spawn_id_):
        return self.grid_manager.get_surrounding_creature_spawn_by_spawn_id(world_object, spawn_id_)

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

    def deactivate_cells(self):
        self.grid_manager.deactivate_cells()
