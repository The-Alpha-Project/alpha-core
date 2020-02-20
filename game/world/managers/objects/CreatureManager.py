from game.world.managers.objects.UnitManager import UnitManager
from utils.constants.ObjectCodes import ObjectTypes, ObjectTypeIds


class CreatureManager(UnitManager):
    def __init__(self, creature_template, **kwargs):
        super().__init__(**kwargs)

        self.creature_template = creature_template

    # override
    def get_type(self):
        return ObjectTypes.TYPE_UNIT

    # override
    def get_type_id(self):
        return ObjectTypeIds.TYPEID_UNIT
