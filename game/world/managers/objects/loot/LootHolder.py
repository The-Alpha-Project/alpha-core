from typing import NamedTuple
from game.world.managers.objects.item.ItemManager import ItemManager
from utils.constants.ItemCodes import ItemClasses


class LootHolder(NamedTuple):
    item: ItemManager
    quantity: int

    def is_quest_item(self):
        return self.item.item_template.class_ == ItemClasses.ITEM_CLASS_QUEST

    def get_item_entry(self):
        return self.item.item_template.entry
