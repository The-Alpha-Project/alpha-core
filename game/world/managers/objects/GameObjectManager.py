from game.world.managers.objects.ObjectManager import ObjectManager
from utils.constants.ObjectCodes import ObjectTypes, ObjectTypeIds, HighGuid


class GameObjectManager(ObjectManager):
    def __init__(self, **kwargs):
        super().__init__(**kwargs)

        self.guid = self.guid | HighGuid.HIGHGUID_GAMEOBJECT

    # override
    def get_type(self):
        return ObjectTypes.TYPE_GAMEOBJECT

    # override
    def get_type_id(self):
        return ObjectTypeIds.TYPEID_GAMEOBJECT
