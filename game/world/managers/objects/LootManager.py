from typing import NamedTuple

from game.world.managers.objects.item.ItemManager import ItemManager


class LootHolder(NamedTuple):
    item: ItemManager
    quantity: int


class LootManager(object):
    def __init__(self, worldobject):
        self.worldobject = worldobject
        self.current_money = 0
        self.current_loot = []
        self.loot_template = self.populate_loot_template()

    # Needs overriding
    def generate_loot(self):
        pass

    # Needs overriding
    def populate_loot_template(self):
        return None

    def get_loot_in_slot(self, slot):
        if slot < len(self.current_loot):
            return self.current_loot[slot]
        return None

    def do_loot(self, slot):
        if slot < len(self.current_loot):
            self.current_loot.pop(slot)

    def clear_money(self):
        self.current_money = 0

    def has_money(self):
        return self.current_money > 0

    def has_items(self):
        return len(self.current_loot) > 0

    def has_loot(self):
        return self.has_money() or self.has_items()

    def clear(self):
        self.clear_money()
        self.current_loot.clear()
