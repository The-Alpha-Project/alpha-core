from game.world.objects.UnitManager import UnitManager


class PlayerManager(UnitManager):

    def __init__(self, player):
        self.player = player
