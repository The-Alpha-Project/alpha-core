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
    def __init__(self, map_id, active_cell_callback, instance_id):
        self.id = map_id
        self.map_ = DbcDatabaseManager.map_get_by_id(map_id)
        self.instance_id = instance_id
        self.grid_manager = GridManager(map_id, active_cell_callback)
        self.name = self.map_.MapName_enUS
        self.schedulers = []
        self.check_state_scheduler = self._build_scheduler(self.check_schedulers_state, seconds=10.0, max_instances=1)

    # Start update threads.
    def initialize(self):

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

        # Pause/Resume threads if no active cells.
        self.check_state_scheduler.start()

    def check_schedulers_state(self):
        has_active_cells = self.grid_manager.has_active_cells()
        self.start() if has_active_cells else self.pause()

    def _load_map_creatures(self):
        from game.world.managers.objects.units.creature.CreatureSpawn import CreatureSpawn
        creature_spawns = WorldDatabaseManager.creature_spawn_get_by_map_id(self.map_.ID)
        if not creature_spawns:
            return
        count = 0
        length = len(creature_spawns)
        for creature_spawn in creature_spawns:
            creature_spawn = CreatureSpawn(creature_spawn, instance_id=self.instance_id)
            creature_spawn.spawn_creature()
            count += 1
            Logger.progress(f'Loading creature spawns for map {self.map_.MapName_enUS}, Instance {self.instance_id}...',
                            count, length)

    def _load_map_gameobjects(self):
        from game.world.managers.objects.gameobjects.GameObjectSpawn import GameObjectSpawn
        gobject_spawns = WorldDatabaseManager.gameobject_get_all_spawns_by_map_id(self.map_.ID)
        if not gobject_spawns:
            return
        count = 0
        length = len(gobject_spawns)
        for gobject_spawn in gobject_spawns:
            gameobject_spawn = GameObjectSpawn(gobject_spawn, instance_id=self.instance_id)
            gameobject_spawn.spawn_gameobject()
            count += 1
            Logger.progress(f'Loading gameobject for Map {self.map_.MapName_enUS}, Instance {self.instance_id}...',
                            count, length)

    def _is_active(self):
        return any(scheduler.running for scheduler in self.schedulers)

    # noinspection PyMethodMayBeStatic
    def _build_scheduler(self, function, seconds, max_instances):
        scheduler = BackgroundScheduler()
        scheduler._daemon = True
        scheduler.add_job(function, 'interval', seconds=seconds, max_instances=max_instances)
        return scheduler

    def is_dungeon(self):
        return self.map_.IsInMap == MapType.INSTANCE

    def is_pvp(self):
        return self.map_.PVP == 1

    def pause(self):
        if self._is_active():
            print('Pause')
            for scheduler in self.schedulers:
                scheduler.pause()

    def start(self):
        if not self._is_active():
            print('Start')
            for scheduler in self.schedulers:
                scheduler.start()

    def destroy(self):
        for scheduler in self.schedulers:
            scheduler.shutdown()
        self.check_state_scheduler.shutdown()
        self.check_state_scheduler = None
        self.instance_id = -1
        self.grid_manager = None
        self.schedulers.clear()
