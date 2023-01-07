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
        self.grid_manager = GridManager(map_id, active_cell_callback)
        self.name = self.dbc_map.MapName_enUS

    # Start update threads.
    def initialize(self):
        # Load creatures and gameobjects.
        self._load_map_creatures()
        self._load_map_gameobjects()
        pass

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
