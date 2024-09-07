from random import randint
from statistics import mean

from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.objects.loot.LootManager import LootManager
from utils.constants.MiscCodes import LootTypes, GameObjectTypes


class GameObjectLootManager(LootManager):
    def __init__(self, object_mgr):
        super(GameObjectLootManager, self).__init__(object_mgr)

    # override
    def generate_money(self, requester):
        self.current_money = randint(self.world_object.gobject_template.mingold, self.world_object.gobject_template.maxgold)

    # override
    def generate_loot(self, requester):
        self.clear()
        self.generate_money(requester)
        loot_collection = self.generate_loot_groups(self.loot_template)
        for loot_item in self.process_loot_groups(loot_collection, requester):
            self.add_loot(loot_item, requester)

    # override
    def populate_loot_template(self):
        # Handle Chest.
        if self.world_object.gobject_template.type == GameObjectTypes.TYPE_CHEST:
            loot_template_id = self.world_object.gobject_template.data1
            return WorldDatabaseManager.GameObjectLootTemplateHolder.gameobject_loot_template_get_by_loot_id(loot_template_id)

        if self.world_object.gobject_template.type == GameObjectTypes.TYPE_FISHINGNODE:
            return WorldDatabaseManager.FishingLootTemplateHolder.fishing_loot_template_get_by_loot_id(self.world_object.zone)

        return []

    # override
    def get_loot_type(self, player, gameobject):
        if gameobject.gobject_template.type == GameObjectTypes.TYPE_FISHINGNODE:
            return LootTypes.LOOT_TYPE_FISHING
        return LootTypes.LOOT_TYPE_CORPSE
