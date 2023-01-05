import threading
from enum import IntEnum

from apscheduler.schedulers.background import BackgroundScheduler

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.maps.GridManager import GridManager
from utils.Logger import Logger


class MapType(IntEnum):
    INSTANCE = 0
    COMMON = 1


class Map:
    def __init__(self, map_id, active_cell_callback):
        self.id = map_id
        self.map_ = DbcDatabaseManager.map_get_by_id(map_id)
        self.grid_manager = GridManager(map_id, active_cell_callback)
        self.name = self.map_.MapName_enUS
        self.schedulers = []

    # Start update threads.
    def initialize(self):
        Logger.info(f'Initializing map {self.map_.ID}.')
        self.schedulers = [
            self._build_scheduler(self.grid_manager.update_spawns, seconds=1.0, max_instances=1),
            self._build_scheduler(self.grid_manager.update_creatures, seconds=0.2, max_instances=1),
            self._build_scheduler(self.grid_manager.update_gameobjects, seconds=1.0, max_instances=1),
            self._build_scheduler(self.grid_manager.update_corpses, seconds=10.0, max_instances=1),
            self._build_scheduler(self.grid_manager.update_dynobjects, seconds=1.0, max_instances=1),
        ]

        # Load creatures and gameobjects.
        self._load_map_creatures()
        self._load_map_gameobjects()

        # Start schedulers if needed.
        if not self._is_active():
            for scheduler in self.schedulers:
                scheduler.start()

    def _load_map_creatures(self):
        from game.world.managers.objects.units.creature.CreatureSpawn import CreatureSpawn
        creature_spawns = WorldDatabaseManager.creature_spawn_get_by_map_id(self.map_.ID)
        if not creature_spawns:
            return

        Logger.info(f'Spawning creatures in map [{self.map_.MapName_enUS}].')
        count = 0
        for creature_spawn in creature_spawns:
            creature_spawn = CreatureSpawn(creature_spawn)
            creature_spawn.spawn_creature()
            count += 1
        Logger.success(f'Spawned {count} creatures.')

    def _load_map_gameobjects(self):
        from game.world.managers.objects.gameobjects.GameObjectSpawn import GameObjectSpawn
        gobject_spawns = WorldDatabaseManager.gameobject_get_all_spawns_by_map_id(self.map_.ID)
        if not gobject_spawns:
            return
        Logger.info(f'Spawning gameobjects in map [{self.map_.MapName_enUS}].')
        count = 0
        for gobject_spawn in gobject_spawns:
            gameobject_spawn = GameObjectSpawn(gobject_spawn)
            gameobject_spawn.spawn_gameobject()
            count += 1

        Logger.success(f'Spawned {count} gameobjects.')

    def _is_active(self):
        return any(scheduler.running for scheduler in self.schedulers)

    def _build_scheduler(self, function, seconds, max_instances):
        scheduler = BackgroundScheduler()
        scheduler._daemon = True
        scheduler.add_job(function, 'interval', seconds=seconds, max_instances=max_instances)
        return scheduler

    def is_dungeon(self):
        return self.map_.IsInMap == MapType.INSTANCE

    def is_pvp(self):
        return self.map_.PVP == 1
