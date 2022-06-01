from random import randint, uniform, choices

from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.objects.units.LootHolder import LootHolder
from game.world.managers.objects.units.LootManager import LootManager
from game.world.managers.objects.item.ItemManager import ItemManager
from utils.constants.ItemCodes import ItemClasses
from utils.constants.MiscCodes import LootTypes, GameObjectTypes


class GameObjectLootManager(LootManager):
    def __init__(self, object_mgr):
        super(GameObjectLootManager, self).__init__(object_mgr)

    # override
    def generate_loot(self, requester):
        self.clear()

        # TODO, handle referenced loot. (negative mincountOrRef)
        #  This points to any other loot table.
        loot_items = [loot_item for loot_item in self.loot_template if loot_item.mincountOrRef > 0]
        # For now, randomly pick 2..4 items.
        for loot_item in choices(loot_items, k=randint(min(2, len(loot_items)), min(4, len(loot_items)))):
            chance = float(round(uniform(0.0, 1.0), 2) * 100)
            item_template = WorldDatabaseManager.ItemTemplateHolder.item_template_get_by_entry(loot_item.item)
            if item_template:
                # Check if this is a quest item and if the player or group needs it.
                if requester and item_template.class_ == ItemClasses.ITEM_CLASS_QUEST:  # Quest item
                    if not requester.player_or_group_require_quest_item(item_template.entry):
                        continue  # Move on to next item.

                item_chance = loot_item.ChanceOrQuestChance
                item_chance = item_chance if item_chance > 0 else item_chance * -1

                # TODO: ChanceOrQuestChance = 0 on Gameobjects equals 100% chance?
                if item_chance >= 100 or chance - item_chance < 0 or loot_item.ChanceOrQuestChance == 0:
                    item = ItemManager.generate_item_from_entry(item_template.entry)
                    if item:
                        self.current_loot.append(LootHolder(item, randint(loot_item.mincountOrRef, loot_item.maxcount)))

    # override
    def populate_loot_template(self):
        # Handle Chest
        # TODO: Investigate db fields 'data'[0/3/N] and 'groupid' so we can filter the loot table properly.
        if self.world_object.gobject_template.type == GameObjectTypes.TYPE_CHEST:
            loot_template_id = self.world_object.gobject_template.data1
            return WorldDatabaseManager.GameObjectLootTemplateHolder.gameobject_loot_template_get_by_entry(loot_template_id)

        if self.world_object.gobject_template.type == GameObjectTypes.TYPE_FISHINGNODE:
            return WorldDatabaseManager.FishingLootTemplateHolder.flishing_loot_template_get_by_entry(self.world_object.zone)

        return []

    # override
    def get_loot_type(self, player, gameobject):
        if gameobject.gobject_template.type == GameObjectTypes.TYPE_FISHINGNODE:
            return LootTypes.LOOT_TYPE_FISHING
        return LootTypes.LOOT_TYPE_CORPSE
