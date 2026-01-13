from random import choice, randint
from typing import Optional

from database.world.WorldDatabaseManager import WorldDatabaseManager
from database.world.WorldModels import SpawnsCreatures
from game.world.managers.abstractions.Vector import Vector
from game.world.managers.objects.units.creature.CreatureBuilder import CreatureBuilder
from game.world.managers.objects.units.creature.CreatureManager import CreatureManager
from utils.Logger import Logger
from utils.constants.MiscCodes import PoolType


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
        self.location = self.get_default_location()
        self.addon = creature_spawn.addon
        self.creature_instance: Optional[CreatureManager] = None
        self.respawn_timer = 0
        self.respawn_time = 0
        self.tmp_respawn_time = 0  # Set by scripts, does not overwrite default respawn time.
        self.last_tick = 0
        self.borrowed = False
        self.pool = None

    def update(self, now):
        if now <= self.last_tick or self.last_tick <= 0 or self.borrowed:
            self.last_tick = now
            return

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

    def generate_or_add_to_pool_if_needed(self, pool_manager):
        # By template entry.
        pool = WorldDatabaseManager.PoolsHolder.get_creature_spawn_pool_template_by_template_entry(
            self._get_creature_entry())

        if not pool:  # By spawn guid.
            pool = WorldDatabaseManager.PoolsHolder.get_creature_pool_by_spawn_id(self.spawn_id)
            if not pool:  # Orphan spawn.
                return

        pool_template = WorldDatabaseManager.PoolsHolder.get_pool_template_by_entry(pool.pool_entry)
        if not pool_template:
            Logger.warning(f'Unable to locate pool template for entry {pool.pool_entry}, {pool.description}.')
            return

        pool_of_pool = WorldDatabaseManager.PoolsHolder.get_pool_pool_by_entry(pool.pool_entry)
        if pool_of_pool:  # Is part of a master pool.
            master_pool_template = WorldDatabaseManager.PoolsHolder.get_pool_template_by_entry(pool_of_pool.mother_pool)
            self.pool = pool_manager.add_pool(PoolType.CREATURE, self, pool, pool_template, master_pool_template)
        else:
            self.pool = pool_manager.add_pool(PoolType.CREATURE, self, pool, pool_template)

    def lend_creature_instance(self, creature):
        if self.creature_instance:
            if creature.guid == self.creature_instance.guid:
                self.borrowed = True
                return True
        return False

    def set_respawn_time(self, respawn_secs=0):
        if respawn_secs and respawn_secs != self.tmp_respawn_time:
            self.respawn_timer = 0
            self.tmp_respawn_time = respawn_secs

    def is_spawned(self):
        return self.creature_instance and self.creature_instance.is_spawned

    def restore_creature_instance(self, creature):
        if self.creature_instance:
            if creature.guid == self.creature_instance.guid:
                self.borrowed = False
                return True
        return False

    def spawn(self, from_pool=False):
        self.respawn_timer = 0
        self.tmp_respawn_time = 0

        # Delegate spawning of new creature to pool.
        if self.pool and not from_pool:
            return self.pool.spawn(caller=self) > 0

        creature_template_id = self._get_creature_entry()

        if not creature_template_id:
            Logger.warning(f'Found creature spawn with non existent creature template(s). '
                           f'Spawn id:{self.creature_spawn.spawn_id}. ')
            return False

        creature_location = self.get_default_location()
        self.respawn_time = randint(self.creature_spawn.spawntimesecsmin, self.creature_spawn.spawntimesecsmax)
        self.creature_instance = CreatureBuilder.create(creature_template_id, creature_location,
                                                        self.map_id, self.instance_id,
                                                        health_percent=self.health_percent,
                                                        mana_percent=self.mana_percent,
                                                        addon=self.addon,
                                                        wander_distance=self.creature_spawn.wander_distance,
                                                        movement_type=self.creature_spawn.movement_type,
                                                        spawn_id=self.spawn_id)

        self.creature_instance.spawn(owner=self)
        return True

    def _update_respawn(self, elapsed):
        if self._get_respawn_time() <= 0:
            return

        self.respawn_timer += elapsed

        # Destroy the current creature instance body when respawn timer is about to expire.
        if self.creature_instance and self.creature_instance.is_spawned:
            if self.respawn_timer >= self.respawn_time * 0.8:
                self.creature_instance.despawn()
                self.creature_instance = None

        # Spawn a new creature instance when needed.
        if self.respawn_timer >= self._get_respawn_time():
            self.spawn()

    def _get_respawn_time(self):
        return self.tmp_respawn_time if self.tmp_respawn_time else self.respawn_time

    def get_default_location(self):
        return Vector(self.creature_spawn.position_x, self.creature_spawn.position_y,
                      self.creature_spawn.position_z, self.creature_spawn.orientation)

    def _get_creature_entry(self):
        return choice(list(filter((0).__ne__, [self.creature_spawn.spawn_entry1,
                                               self.creature_spawn.spawn_entry2,
                                               self.creature_spawn.spawn_entry3,
                                               self.creature_spawn.spawn_entry4])))
