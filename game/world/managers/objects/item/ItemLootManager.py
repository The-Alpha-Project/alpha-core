from random import randint

from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.objects.loot.LootManager import LootManager
from utils.constants.MiscCodes import LootTypes
from utils.constants.ItemCodes import ItemFlags


class ItemLootManager(LootManager):
    def __init__(self, item_mgr):
        super(ItemLootManager, self).__init__(item_mgr)
        self.depleted = False

    # override
    def generate_loot(self, requester):
        if self.depleted:
            return

        super().clear()
        self.generate_money(requester)
        loot_collection = self.generate_loot_groups(self.loot_template)
        for loot_item in self.process_loot_groups(loot_collection, requester):
            self.add_loot(loot_item, requester)

    # override
    def generate_money(self, requester):
        item_template = self.world_object.item_template
        self.current_money = randint(item_template.min_money_loot, item_template.max_money_loot)

    # override
    def populate_loot_template(self):
        # Check if the item has loot flag.
        if self.world_object.item_template.flags & ItemFlags.ITEM_FLAG_HAS_LOOT:
            loot_entry = self.world_object.item_template.entry
            return WorldDatabaseManager.ItemLootTemplateHolder.item_loot_template_get_by_entry(loot_entry)

        return []

    # override
    def get_loot_type(self, player, item):
        # No specific loot type for items.
        return LootTypes.LOOT_TYPE_CORPSE
