from game.world.managers.objects.ObjectManager import ObjectManager
from utils.constants.MiscCodes import LootTypes


class LootSelection:
    def __init__(self, world_object: ObjectManager, loot_type: LootTypes):
        self.object_guid = world_object.guid
        self.loot_type = loot_type

    def get_loot_manager(self, world_object):
        if self.loot_type == LootTypes.LOOT_TYPE_PICKLOCK:
            return world_object.pickpocket_loot_manager
        else:
            return world_object.loot_manager
