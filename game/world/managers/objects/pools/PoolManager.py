from game.world.managers.objects.pools.PoolObject import PoolObject


class PoolManager:
    def __init__(self):
        self.pools = dict()

    def add_pool(self, spawn, pool, pool_template, master_pool_template=None):
        mother_pool = None
        if master_pool_template:
            mother_pool = self.get_or_create_pool(master_pool_template.pool_entry, 0, master_pool_template.description,
                                                  master_pool_template.flags, master_pool_template.max_limit,
                                                  is_master=True)

        pool_entity = mother_pool if mother_pool else self
        pool_object = pool_entity.get_or_create_pool(pool.pool_entry, pool.chance, pool_template.description,
                                                     pool_template.flags, max_limit=pool_template.max_limit)
        pool_object.add_spawn(spawn, pool.chance)
        return pool_object

    def get_or_create_pool(self, pool_entry, chance, description, flags, max_limit, is_master=False):
        if pool_entry not in self.pools:
            self.pools[pool_entry] = PoolObject(pool_entry, chance, description, flags, max_limit=max_limit,
                                                is_master=is_master)
        return self.pools[pool_entry]

