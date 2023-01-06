from random import randint
from typing import Optional

from database.world.WorldModels import SpawnsGameobjects
from game.world.managers.abstractions.Vector import Vector
from game.world.managers.maps.MapManager import MapManager
from game.world.managers.objects.gameobjects.GameObjectBuilder import GameObjectBuilder
from game.world.managers.objects.gameobjects.GameObjectManager import GameObjectManager
from utils.Logger import Logger


class GameObjectSpawn:
    def __init__(self, gameobject_spawn, instance_id):
        self.gameobject_spawn: SpawnsGameobjects = gameobject_spawn
        self.spawn_id = gameobject_spawn.spawn_id
        self.map_ = gameobject_spawn.spawn_map
        self.instance_id = instance_id
        self.location = self._get_location()
        self.gameobject_instance: Optional[GameObjectManager] = None
        self.respawn_timer = 0
        self.respawn_time = 0
        self.last_tick = 0

    def update(self, now):
        if now > self.last_tick > 0:
            elapsed = now - self.last_tick
            gameobject = self.gameobject_instance
            if gameobject:
                if not gameobject.is_spawned and gameobject.initialized:
                    self._update_respawn(elapsed)
            else:
                self._update_respawn(elapsed)

        self.last_tick = now

    def spawn_gameobject(self):
        gameobject_template_id = self._generate_gameobject_template()

        if not gameobject_template_id:
            Logger.warning(f'Found gameobject spawn with non existent gameobject template(s). '
                           f'Spawn id:{self.gameobject_spawn.spawn_id}. ')
            return False

        gameobject_location = self._get_location()
        self.respawn_timer = 0
        self.respawn_time = randint(self.gameobject_spawn.spawn_spawntimemin, self.gameobject_spawn.spawn_spawntimemax)
        self.gameobject_instance = GameObjectBuilder.create(gameobject_template_id, gameobject_location,
                                                            self.map_, self.instance_id,
                                                            self.gameobject_spawn.spawn_state,
                                                            rot0=self.gameobject_spawn.spawn_rotation0,
                                                            rot1=self.gameobject_spawn.spawn_rotation1,
                                                            rot2=self.gameobject_spawn.spawn_rotation2,
                                                            rot3=self.gameobject_spawn.spawn_rotation3,
                                                            spawn_id=self.spawn_id)

        MapManager.spawn_object(world_object_spawn=self, world_object_instance=self.gameobject_instance)
        return True

    def _update_respawn(self, elapsed):
        self.respawn_timer += elapsed
        # Spawn a new gameobject instance when needed.
        if self.respawn_timer >= self.respawn_time:
            self.spawn_gameobject()

    def _get_location(self):
        return Vector(self.gameobject_spawn.spawn_positionX, self.gameobject_spawn.spawn_positionY,
                      self.gameobject_spawn.spawn_positionZ, self.gameobject_spawn.spawn_orientation)

    def _get_gameobject_entry(self):
        return self.gameobject_spawn.spawn_entry

    def _generate_gameobject_template(self):
        return self._get_gameobject_entry()

