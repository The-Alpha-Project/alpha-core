from random import randint, uniform, choices

from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.objects.units.LootManager import LootManager
from utils.constants.MiscCodes import LootTypes
from utils.constants.ItemCodes import ItemClasses
from utils.constants.ItemCodes import ItemFlags


class ItemLootManager(LootManager):
    def __init__(self, item_mgr):
        super(ItemLootManager, self).__init__(item_mgr)

    # override
    def generate_loot(self, requester):
        # Circular refs.
        from game.world.managers.objects.units.LootHolder import LootHolder
        from game.world.managers.objects.item.ItemManager import ItemManager
        self.clear()

        # TODO, handle referenced loot. (negative mincountOrRef)
        #  This points to any other loot table.
        loot_items = [loot_item for loot_item in self.loot_template if loot_item.mincountOrRef > 0]
        # For now, randomly pick 2..4 items.
        for loot_item in choices(loot_items, k=randint(min(2, len(loot_items)), min(4, len(loot_items)))):
            chance = float(round(uniform(0.0, 1.0), 2) * 100)
            item_template = WorldDatabaseManager.ItemTemplateHolder.item_template_get_by_entry(loot_item.item)
            if item_template:
                # Check if this is a quest item and if the player needs it.
                if requester and item_template.class_ == ItemClasses.ITEM_CLASS_QUEST:  # Quest item.
                    if not requester.player_or_group_require_quest_item(item_template.entry, only_self=True):
                        continue  # Move on to next item.

                item_chance = loot_item.ChanceOrQuestChance
                item_chance = item_chance if item_chance > 0 else item_chance * -1

                # TODO: ChanceOrQuestChance = 0 on Items equals 100% chance?
                if item_chance >= 100 or chance - item_chance < 0 or loot_item.ChanceOrQuestChance == 0:
                    item = ItemManager.generate_item_from_entry(item_template.entry)
                    if item:
                        self.current_loot.append(LootHolder(item, randint(loot_item.mincountOrRef, loot_item.maxcount)))

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
