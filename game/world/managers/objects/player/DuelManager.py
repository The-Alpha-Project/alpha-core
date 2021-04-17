from database.world.WorldModels import SpawnsGameobjects
from game.world.managers.GridManager import GridManager
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.objects.GameObjectManager import GameObjectManager
from utils.constants.ObjectCodes import HighGuid


class DuelManager(object):
    def __init__(self, owner):
        self.owner = owner

    def request_duel(self, player_mgr):
        print(f'{self.owner.player.name} requested a duel to {player_mgr.player.name}')

        go_template = WorldDatabaseManager.gameobject_template_get_by_entry(21680)[0]
        if go_template:
            print(go_template.display_id)
            go_template.scale = 1
            instance = SpawnsGameobjects()
            instance.spawn_id = 0
            instance.spawn_entry = 21680
            instance.spawn_map = self.owner.map_
            instance.spawn_rotation0 = 0
            instance.spawn_orientation = 0
            instance.spawn_rotation2 = 0
            instance.spawn_rotation1 = 0
            instance.spawn_rotation3 = 0
            instance.spawn_positionX = self.owner.location.x
            instance.spawn_positionY = self.owner.location.y
            instance.spawn_positionZ = self.owner.location.z
            instance.spawn_state = True

            gobject_mgr = GameObjectManager(
                gobject_template=go_template,  # go_template returns wrapped in a tuple...
                gobject_instance=instance
            )

            gobject_mgr.load()



