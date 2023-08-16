from __future__ import annotations

import random
from random import randint
from typing import TYPE_CHECKING, Optional

from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.maps.MapManager import MapManager

if TYPE_CHECKING:
    from database.world.WorldModels import SpawnsCreatures, SpawnsCreaturesPool
    from game.world.managers.objects.units.creature.CreatureManager import (
        CreatureManager,
    )


class CreatureRespawnManager:
    def __init__(
        self, creature_manager: CreatureManager, creature_instance: SpawnsCreatures
    ):
        self.creature_manager = creature_manager
        self.creature_instance = creature_instance

    @staticmethod
    def load_creature(creature_instance: SpawnsCreatures) -> set[int]:
        """Return loaded creature instance spawn ids (SpawnsCreatures.spawn_id)"""
        spawn_id = creature_instance.spawn_id
        pools = CreatureRespawnManager._get_pools_by_spawn_id(spawn_id)
        if pools:
            creature_manager_to_load = (
                CreatureRespawnManager._create_creature_from_pools(pools)
            )
            spawn_ids_loaded = (
                CreatureRespawnManager._mark_all_spawn_ids_from_pool_as_loaded(pools)
            )
        else:
            # TODO Refactor to avoid circular import?
            from game.world.managers.objects.units.creature.CreatureManager import (
                CreatureManager,
            )

            creature_manager_to_load = CreatureManager(
                creature_template=creature_instance.creature_template,
                creature_instance=creature_instance,
            )
            spawn_ids_loaded = {spawn_id}

        CreatureRespawnManager._send_update_if_was_created(creature_manager_to_load)
        return spawn_ids_loaded

    def respawn_creature(self):
        pools = self._get_pools_by_spawn_id(self.creature_instance.spawn_id)
        if pools:
            self._respawn_creature_from_pools(pools)
        else:
            self._respawn_creature_from_instance()

    @staticmethod
    def _get_pools_by_spawn_id(spawn_id):
        return WorldDatabaseManager.SpawnsCreaturesPoolHolder.creature_spawn_pools_get_by_spawn_id(
            spawn_id
        )

    def _respawn_creature_from_pools(self, pools):
        new_creature_manager = self._create_creature_from_pools(pools)
        self.creature_manager.despawn(destroy=True)
        self._send_update_if_was_created(new_creature_manager)

    @staticmethod
    def _mark_all_spawn_ids_from_pool_as_loaded(
        pools: list[SpawnsCreaturesPool],
    ) -> set[int]:
        return {pool.spawn_id for pool in pools}

    @staticmethod
    def _create_creature_from_pools(
        pools: list[SpawnsCreaturesPool],
    ) -> Optional[CreatureManager]:
        spawns, chances = zip(*[(pool.spawn, pool.chance) for pool in pools])
        rolled_instance = CreatureRespawnManager._roll_creature_instance(
            list(spawns), list(chances)
        )

        # TODO Refactor to avoid circular import?
        from game.world.managers.objects.units.creature.CreatureManager import (
            CreatureManager,
        )

        return (
            CreatureManager(
                creature_template=rolled_instance.creature_template,
                creature_instance=rolled_instance,
            )
            if rolled_instance
            else None
        )

    @staticmethod
    def _roll_creature_instance(spawns, chances) -> Optional[SpawnsCreatures]:
        total_chance = sum(chances)
        return (
            CreatureRespawnManager._select_spawn_explicit_chances(spawns, chances)
            if total_chance <= 100.0
            else CreatureRespawnManager._select_spawn_equal_chances(spawns)
        )

    @staticmethod
    def _select_spawn_explicit_chances(spawns, chances) -> Optional[SpawnsCreatures]:
        rolled_instances = random.choices(
            population=spawns + [None], weights=chances + [100.0 - sum(chances)]
        )
        return next(iter(rolled_instances))

    @staticmethod
    def _select_spawn_equal_chances(spawns) -> SpawnsCreatures:
        return random.choice(spawns)

    @staticmethod
    def _send_update_if_was_created(creature_manager: Optional[CreatureManager]):
        if creature_manager:
            MapManager.update_object(creature_manager)

    def _respawn_creature_from_instance(self):
        # Set all property values before making this creature visible.
        self.creature_manager.location = self.creature_manager.spawn_position.copy()
        self.creature_manager.set_health(self.creature_manager.max_health)
        self.creature_manager.set_mana(self.creature_manager.max_power_1)

        self.creature_manager.loot_manager.clear()
        self.creature_manager.set_lootable(False)

        if (
            self.creature_manager.killed_by
            and self.creature_manager.killed_by.group_manager
        ):
            self.creature_manager.killed_by.group_manager.clear_looters_for_victim(
                self.creature_manager
            )
        self.creature_manager.killed_by = None

        self.creature_manager.respawn_time = randint(
            self.creature_instance.spawntimesecsmin,
            self.creature_instance.spawntimesecsmax,
        )

        # Update its cell position if needed (Died far away from spawn location cell)
        MapManager.update_object(self.creature_manager)
        # Make this creature visible to its surroundings.
        MapManager.respawn_object(self.creature_manager)
