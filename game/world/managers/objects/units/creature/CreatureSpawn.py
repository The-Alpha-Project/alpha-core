from random import choice, randint
from typing import Optional

from database.world.WorldDatabaseManager import WorldDatabaseManager
from database.world.WorldModels import SpawnsCreatures
from game.world.managers.abstractions.Vector import Vector
from game.world.managers.maps.MapManager import MapManager
from game.world.managers.objects.units.creature.CreatureManager import CreatureManager
from utils.Logger import Logger


class CreatureSpawn:
    CURRENT_HIGHEST_GUID = 0

    def __init__(self, creature_spawn):
        self.creature_spawn: SpawnsCreatures = creature_spawn
        self.spawn_id = creature_spawn.spawn_id
        self.movement_type = creature_spawn.movement_type
        self.wander_distance = creature_spawn.wander_distance
        self.health_percent = creature_spawn.health_percent
        self.mana_percent = creature_spawn.mana_percent
        self.map_ = creature_spawn.map
        self.location = self._get_location()
        self.addon = creature_spawn.addon
        self.spawn_location = self._get_location()
        self.creature_instance: Optional[CreatureManager] = None
        self.respawn_timer = 0
        self.respawn_time = 0
        self.time_to_live_timer = 0
        self.last_tick = 0

    def spawn_creature(self):
        CreatureSpawn.CURRENT_HIGHEST_GUID += 1
        creature_template = self._generate_creature_template()

        if not creature_template:
            Logger.warning(f'Found creature spawn with non existent creature template(s). Spawn id: '
                           f'{self.creature_spawn.spawn_id}. ')
            return False

        creature_location = self._get_location()
        self.respawn_time = randint(10, 20)
        self.creature_instance = CreatureManager.create(CreatureSpawn.CURRENT_HIGHEST_GUID, creature_template,
                                                        creature_location, self.map_,
                                                        self.health_percent, self.mana_percent,
                                                        wander_distance=self.creature_spawn.wander_distance,
                                                        movement_type=self.creature_spawn.movement_type)

        MapManager.spawn_object(self, self.creature_instance)
        return True

    def update(self, now):
        if now > self.last_tick > 0:
            elapsed = now - self.last_tick
            creature = self.creature_instance
            if creature:
                if creature.is_alive and creature.is_spawned and creature.initialized:
                    # Time to live checks, return false if destroyed.
                    if not self._update_time_to_live(elapsed):
                        return
                    creature.update(now)
                elif (not creature.is_alive or not creature.is_spawned) and creature.initialized:
                    self._update_respawn(elapsed)
            else:
                self._update_respawn(elapsed)

        self.last_tick = now
        return self.creature_instance.guid if self.creature_instance else 0

    def _update_respawn(self, elapsed):
        self.respawn_timer += elapsed
        if self.respawn_timer >= self.respawn_time:
            self.spawn_creature()
        # Destroy body when creature is about to respawn.
        elif self.creature_instance:
            print(self.respawn_timer)
            if self.creature_instance.is_spawned and self.respawn_timer >= self.respawn_time * 0.8:
                self.despawn()

    def _update_time_to_live(self, elapsed):
        if self.time_to_live_timer > 0:
            self.time_to_live_timer -= elapsed
            # Time to live expired, destroy.
            if self.time_to_live_timer <= 0:
                self.creature_instance.despawn(destroy=True)
                self.creature_instance = None
                return False
        return True

    def despawn(self):
        if self.creature_instance:
            self.respawn_timer = 0
            self.creature_instance.despawn(destroy=True)
            self.creature_instance = None

    # Detaches a creature instance from this spawn. (e.g. Taming)
    def dettach_creature_instance(self):
        if self.creature_instance:
            self.respawn_timer = 0
            self.creature_instance = None

    def _get_location(self):
        return Vector(self.creature_spawn.position_x, self.creature_spawn.position_y,
                      self.creature_spawn.position_z, self.creature_spawn.orientation)

    def _get_creature_entry(self):
        return choice(list(filter((0).__ne__, [self.creature_spawn.spawn_entry1,
                                               self.creature_spawn.spawn_entry2,
                                               self.creature_spawn.spawn_entry3,
                                               self.creature_spawn.spawn_entry4])))

    def _generate_creature_template(self):
        return WorldDatabaseManager.CreatureTemplateHolder.creature_get_by_entry(self._get_creature_entry())

