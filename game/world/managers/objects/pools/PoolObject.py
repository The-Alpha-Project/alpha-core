import random
from game.world.managers.objects.pools.PoolChancedEntry import PoolChancedEntry


class PoolObject:
    def __init__(self, pool_type, pool_entry, chance, description, flags, max_limit=1, is_master=False, master_pool=None):
        self.pool_type = pool_type
        self.pool_entry = pool_entry
        self.chance = chance
        self.description = description
        self.flags = flags
        self.pools = dict()
        self.equal_chanced: list[PoolChancedEntry] = list()
        self.explicit_chanced: list[PoolChancedEntry] = list()
        self.max_limit = max_limit
        self.is_master = is_master
        self.master_pool = master_pool

    def get_or_create_pool(self, pool_type, pool_entry, chance, description, flags, max_limit=1, is_master=False,
                           master_pool=None):
        if pool_entry not in self.pools:
            self.pools[pool_entry] = PoolObject(pool_type, pool_entry, chance, description, flags, max_limit=max_limit,
                                                is_master=is_master, master_pool=master_pool)
        return self.pools[pool_entry]

    def add_spawn(self, spawn, chance):
        if not chance:
            self.equal_chanced.append(PoolChancedEntry(spawn, chance))
        else:
            self.explicit_chanced.append(PoolChancedEntry(spawn, chance))

    def spawn(self, limit=0, caller=None):
        if self.is_master:
            return self._spawn_master()

        # Child pool spawn calls spawn(), delegate the action to its master pool.
        if caller and self.master_pool:
            return self.master_pool.spawn()

        spawned = 0
        max_limit = self.max_limit - len([chanced_entry for chanced_entry in self.equal_chanced + self.explicit_chanced
                                          if chanced_entry.spawn.is_spawned()])

        if not max_limit:
            return 0

        available_to_spawn_equal = [chanced_entry for chanced_entry in self.equal_chanced
                                    if not chanced_entry.spawn.is_spawned()]
        available_to_spawn_explicit = [chanced_entry for chanced_entry in self.explicit_chanced
                                       if not chanced_entry.spawn.is_spawned()]

        if available_to_spawn_explicit:
            # Pair each entry with its chance.
            entry_weight_pairs = [(entry, entry.chance) for entry in available_to_spawn_explicit]

            # Extract weights for selection.
            weights = [pair[1] for pair in entry_weight_pairs]

            # Select based on weights.
            count = min(len(entry_weight_pairs), max_limit)
            choices = random.choices(entry_weight_pairs, weights=weights, k=count)

            # Choices and their specific weights (chance).
            for choice, weight in choices:
                roll = random.random()
                if roll > weight / 100:
                    continue
                spawned += 1
                max_limit -= 1
                choice.spawn.spawn(from_pool=True)
                if limit and spawned >= limit:
                    return spawned

        if available_to_spawn_equal:
            count = min(len(available_to_spawn_equal), max_limit)
            choices = random.choices(available_to_spawn_equal, k=count)
            for choice in choices:
                spawned += 1
                choice.spawn.spawn(from_pool=True)
                if limit and spawned >= limit:
                    break

        return spawned

    def _spawn_master(self):
        if not self.can_spawn():
            return 0

        can_spawn_pools = [pool for pool in self.pools.values() if pool.can_spawn()]
        count = min(len(can_spawn_pools), self.max_limit)
        if not count:
            return 0

        spawned = 0

        child_pools = random.choices(can_spawn_pools, k=count)
        limit = self.max_limit - self.get_spawned_count()
        for pool in child_pools:
            count = pool.spawn()
            limit -= count
            spawned += count
            if not limit:
                break

        return spawned

    def get_available_spawns_count(self):
        if self.is_master:
            return sum([pool.get_available_spawns_count() for pool in self.pools.values()])

        return len([chanced_entry for chanced_entry in self.equal_chanced + self.explicit_chanced
                    if not chanced_entry.spawn.is_spawned()])

    def get_spawned_count(self):
        if self.is_master:
            return sum([pool.get_spawned_count() for pool in self.pools.values()])

        return len([chanced_entry for chanced_entry in self.equal_chanced + self.explicit_chanced
                    if chanced_entry.spawn.is_spawned()])

    def can_spawn(self):
        spawned_count = self.get_spawned_count()
        return spawned_count < self.max_limit
