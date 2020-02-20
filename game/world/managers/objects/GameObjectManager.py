from game.world.managers.objects.ObjectManager import ObjectManager
from utils.constants.ObjectCodes import ObjectTypes, ObjectTypeIds


class GameObjectManager(ObjectManager):
    def __init__(self, **kwargs):
        super().__init__(**kwargs)

    # override
    def get_type(self):
        return ObjectTypes.TYPE_GAMEOBJECT

    # override
    def get_type_id(self):
        return ObjectTypeIds.TYPEID_GAMEOBJECT
