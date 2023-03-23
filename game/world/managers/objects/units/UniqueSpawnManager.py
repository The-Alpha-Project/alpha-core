import random
from database.world.WorldDatabaseManager import WorldDatabaseManager
from utils.Logger import Logger

class UniqueSpawnManager:
    UNIQUE_CREATURE_SPAWNS = []
    UNIQUE_CREATURE_ENTRIES = []
    def __init__(self, map):
        self.map = map
        self.UNIQUE_CREATURE_SPAWNS = []
        self.UNIQUE_CREATURE_ENTRIES = []

    def add_unique_creature_entry(self, entry):
        if entry not in self.UNIQUE_CREATURE_ENTRIES:
            self.UNIQUE_CREATURE_ENTRIES.append(entry)

    def respawn_unique_creature(self, entry):
        if entry not in self.UNIQUE_CREATURE_SPAWNS:
            from game.world.managers.objects.units.creature.CreatureSpawn import CreatureSpawn

            spawns = WorldDatabaseManager.creature_spawn_get_by_map_id_and_entry(self.map.dbc_map.ID, entry)
            spawn = random.choice(spawns)

            creature_spawn = CreatureSpawn(spawn, instance_id=self.map.instance_id, is_unique=True)
            creature_spawn.spawn_creature()

            self.UNIQUE_CREATURE_SPAWNS.append(entry)

    def on_unique_creature_despawn(self, entry):
        self.UNIQUE_CREATURE_SPAWNS.remove(entry)

    def spawn_all_unique_creatures(self):
        from game.world.managers.objects.units.creature.CreatureSpawn import CreatureSpawn
        for entry in self.UNIQUE_CREATURE_ENTRIES:
            spawns = WorldDatabaseManager.creature_spawn_get_by_map_id_and_entry(self.map.dbc_map.ID, entry)
            spawn = random.choice(spawns)

            creature_spawn = CreatureSpawn(spawn, instance_id=self.map.instance_id, is_unique=True)
            creature_spawn.spawn_creature()

            self.UNIQUE_CREATURE_SPAWNS.append(entry)