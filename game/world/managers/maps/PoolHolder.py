from random import choice, choices
from database.world.WorldDatabaseManager import WorldDatabaseManager

class PoolHolder:

    # key is pool entry, value is list of spawn_id
    # {1234: [9234], 4321: [2134], ...}
    ACTIVE_POOL_CREATURE_SPAWN_IDS: dict[int, list[int]] = {}
    ACTIVE_POOL_GAMEOBJECT_SPAWN_IDS: dict[int, list[int]] = {}

    @staticmethod
    def get_chosen_pool_creature_spawn(spawn_id):
        """get a randomized creature from a pool of creatures"""
        creature = None
        pool_entry = None
        creature_pools = PoolHolder._get_creature_pools_by_spawn_id(spawn_id)

        if creature_pools:
            spawns, chances = zip(*[(pool.creature_spawn, pool.chance) for pool in creature_pools])
            creature = PoolHolder._roll_spawn(
                list(spawns), list(chances)
            )
            pool_entry = creature_pools[0].pool_entry

        return creature, pool_entry

    @staticmethod
    def get_creature_spawn_ids_by_pool_entry(pool_entry):
        return PoolHolder.ACTIVE_POOL_CREATURE_SPAWN_IDS.get(pool_entry, None)

    @staticmethod
    def set_creature_pool_entry(pool_entry, spawn_ids):
        PoolHolder.ACTIVE_POOL_CREATURE_SPAWN_IDS.get[pool_entry, spawn_ids]

    @staticmethod
    def add_active_creature_spawn(pool_entry, spawn_id):
        ids = PoolHolder.ACTIVE_POOL_CREATURE_SPAWN_IDS.get(pool_entry, None)

        if ids:
            ids.append(spawn_id)
        else: 
            ids = [spawn_id]

        PoolHolder.ACTIVE_POOL_CREATURE_SPAWN_IDS[pool_entry] = ids

    @staticmethod
    def remove_active_creature_spawn(pool_entry, spawn_id):
        ids = PoolHolder.ACTIVE_POOL_CREATURE_SPAWN_IDS.get(pool_entry, None)
        ids.remove(spawn_id)
        PoolHolder.ACTIVE_POOL_CREATURE_SPAWN_IDS[pool_entry] = ids

    @staticmethod
    def _roll_spawn(spawns, chances):
        total_chance = sum(chances)

        return (
            PoolHolder._select_spawn_explicit_chances(spawns, chances)
            if total_chance != 0.0 and total_chance <= 100.0 
            else PoolHolder._select_spawn_equal_chances(spawns)
        )

    @staticmethod
    def _select_spawn_explicit_chances(spawns, chances):
        rolled_instances = choices(
            population=spawns + [None], weights=chances + [100.0 - sum(chances)]
        )
        return next(iter(rolled_instances))

    @staticmethod
    def _select_spawn_equal_chances(spawns):
        return choice(spawns)

    @staticmethod
    def _get_creature_pools_by_spawn_id(spawn_id):
        return WorldDatabaseManager.CreaturePoolsHolder.get_creature_pools_by_spawn_id(spawn_id)

