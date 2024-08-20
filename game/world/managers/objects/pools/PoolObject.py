class PoolObject:
    def __init__(self, pool_entry, chance, description, flags, max_limit=1, is_master=False):
        self.pool_entry = pool_entry
        self.chance = chance
        self.description = description
        self.flags = flags
        self.pools = dict()
        self.spawns = dict()
        self.max_limit = max_limit
        self.is_master = is_master

    def get_or_create_pool(self, pool_entry, chance, description, flags, max_limit=1, is_master=False):
        if pool_entry not in self.pools:
            self.pools[pool_entry] = PoolObject(pool_entry, chance, description, flags, max_limit=max_limit,
                                                is_master=is_master)
        return self.pools[pool_entry]

    def add_spawn(self, spawn):
        self.spawns[spawn.spawn_id] = spawn
