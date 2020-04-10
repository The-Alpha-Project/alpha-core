from game.world.managers.objects.UnitManager import UnitManager
from utils.constants.ObjectCodes import ObjectTypes, ObjectTypeIds, HighGuid


class CreatureManager(UnitManager):
    def __init__(self, creature_template, **kwargs):
        super().__init__(**kwargs)

        self.guid = self.guid | HighGuid.HIGHGUID_UNIT
        self.creature_template = creature_template

    # override
    def get_type(self):
        return ObjectTypes.TYPE_UNIT

    # override
    def get_type_id(self):
        return ObjectTypeIds.TYPEID_UNIT
