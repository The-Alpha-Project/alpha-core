from random import choice, randint
from typing import Optional

from database.world.WorldModels import SpawnsCreatures
from game.world.managers.abstractions.Vector import Vector
from game.world.managers.maps.MapManager import MapManager
from game.world.managers.objects.units.creature.CreatureBuilder import CreatureBuilder
from game.world.managers.objects.units.creature.CreatureManager import CreatureManager
from utils.Logger import Logger


class CreatureSpawn:
    def __init__(self, creature_spawn, instance_id):
        self.creature_spawn: SpawnsCreatures = creature_spawn
        self.spawn_id = creature_spawn.spawn_id
        self.movement_type = creature_spawn.movement_type
        self.wander_distance = creature_spawn.wander_distance
        self.health_percent = creature_spawn.health_percent
        self.mana_percent = creature_spawn.mana_percent
        self.map_id = creature_spawn.map
        self.instance_id = instance_id
        self.location = self._get_location()
        self.addon = creature_spawn.addon
        self.creature_instance: Optional[CreatureManager] = None
        self.respawn_timer = 0
        self.respawn_time = 0
        self.last_tick = 0
        self.borrowed = False

    def update(self, now):
        if now > self.last_tick > 0:
            # Skip update if creature instance is charmed.
            if not self.borrowed:
                elapsed = now - self.last_tick
                creature = self.creature_instance
                if creature:
                    if (not creature.is_alive or not creature.is_spawned) and creature.initialized:
                        self._update_respawn(elapsed)
                else:
                    self._update_respawn(elapsed)

        self.last_tick = now

    def detach_creature_from_spawn(self, creature):
        if self.creature_instance:
            if creature.guid == self.creature_instance.guid:
                self.creature_instance.spawn_id = 0
                self.creature_instance = None
                return True
        return False

    def lend_creature_instance(self, creature):
        if self.creature_instance:
            if creature.guid == self.creature_instance.guid:
                self.borrowed = True
                return True
        return False

    def restore_creature_instance(self, creature):
        if self.creature_instance:
            if creature.guid == self.creature_instance.guid:
                self.borrowed = False
                return True
        return False

    def spawn_creature(self):
        creature_template_id = self._generate_creature_template()

        if not creature_template_id:
            Logger.warning(f'Found creature spawn with non existent creature template(s). '
                           f'Spawn id:{self.creature_spawn.spawn_id}. ')
            return False

        creature_location = self._get_location()
        self.respawn_timer = 0
        self.respawn_time = randint(self.creature_spawn.spawntimesecsmin, self.creature_spawn.spawntimesecsmax)
        self.creature_instance = CreatureBuilder.create(creature_template_id, creature_location,
                                                        self.map_id, self.instance_id,
                                                        health_percent=self.health_percent,
                                                        mana_percent=self.mana_percent,
                                                        addon=self.addon,
                                                        wander_distance=self.creature_spawn.wander_distance,
                                                        movement_type=self.creature_spawn.movement_type,
                                                        spawn_id=self.spawn_id)

        MapManager.spawn_object(world_object_spawn=self, world_object_instance=self.creature_instance)
        return True

    def _update_respawn(self, elapsed):
        self.respawn_timer += elapsed

        # Destroy the current creature instance body when respawn timer is about to expire.
        if self.creature_instance and self.creature_instance.is_spawned:
            if self.respawn_timer >= self.respawn_time * 0.8:
                self.creature_instance.destroy()
                self.creature_instance = None

        # Spawn a new creature instance when needed.
        if self.respawn_timer >= self.respawn_time:
            self.spawn_creature()

    def _get_location(self):
        return Vector(self.creature_spawn.position_x, self.creature_spawn.position_y,
                      self.creature_spawn.position_z, self.creature_spawn.orientation)

    def _get_creature_entry(self):
        return choice(list(filter((0).__ne__, [self.creature_spawn.spawn_entry1,
                                               self.creature_spawn.spawn_entry2,
                                               self.creature_spawn.spawn_entry3,
                                               self.creature_spawn.spawn_entry4])))

    def _generate_creature_template(self):
        return self._get_creature_entry()

