from random import randint, uniform, choices

from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.objects.LootManager import LootManager, LootHolder
from game.world.managers.objects.item.ItemManager import ItemManager
from utils.Logger import Logger
from utils.constants.ItemCodes import ItemClasses
from utils.constants.MiscCodes import LootTypes, GameObjectTypes


class GameObjectLootManager(LootManager):
    def __init__(self, object_mgr):
        super(GameObjectLootManager, self).__init__(object_mgr)

    # override
    def generate_loot(self, requester):
        self.clear()

        # TODO: Even if called on parent, this is not properly set as with CreatureLootManager.
        if len(self.loot_template) == 0:
            self.loot_template = self.populate_loot_template()

        # For now, randomly pick 3..7 items.
        for loot_item in choices(self.loot_template, k=randint(min(3, len(self.loot_template)), min(7, len(self.loot_template)))):
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

        return []

    # override
    def get_loot_type(self, player, gameobject):
        return LootTypes.LOOT_TYPE_CORPSE
