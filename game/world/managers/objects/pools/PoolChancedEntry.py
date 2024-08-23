from typing import NamedTuple
from game.world.managers.objects.gameobjects.GameObjectSpawn import GameObjectSpawn


class PoolChancedEntry(NamedTuple):
    spawn: GameObjectSpawn
    chance: float
