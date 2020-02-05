from game.world.managers.ObjectManager import ObjectManager
from utils.ConfigManager import config
from utils.constants.ObjectCodes import ObjectTypes


class GameObjectManager(ObjectManager):
    def __init__(self, **kwargs):
        super().__init__(**kwargs)

    def get_type(self):
        return ObjectTypes.TYPE_GAMEOBJECT
