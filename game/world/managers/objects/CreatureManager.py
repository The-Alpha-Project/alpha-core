from game.world.managers.objects.UnitManager import UnitManager
from utils.constants.ObjectCodes import ObjectTypes, ObjectTypeIds, HighGuid


class CreatureManager(UnitManager):
    def __init__(self,
                 creature_template,
                 creature_instance,
                 **kwargs):
        super().__init__(**kwargs)

        self.creature_template = creature_template
        self.creature_instance = creature_instance

        self.guid = (creature_instance.guid if creature_instance else 0) | HighGuid.HIGHGUID_UNIT

    # override
    def get_type(self):
        return ObjectTypes.TYPE_UNIT

    # override
    def get_type_id(self):
        return ObjectTypeIds.TYPEID_UNIT
