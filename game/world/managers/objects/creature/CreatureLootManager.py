from random import randint, uniform
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.objects.item.ItemManager import ItemManager


class CreatureLootManager(object):
    def __init__(self, creature_mgr):
        self.creature_mgr = creature_mgr
        self.current_money = 0
        self.current_loot = []
        self.loot_template = WorldDatabaseManager.CreatureLootTemplateHolder\
            .creature_loot_template_get_by_creature(self.creature_mgr.entry)

    def generate_creature_loot(self):
        # TODO: Implement loot group handling
        money = randint(self.creature_mgr.creature_template.gold_min, self.creature_mgr.creature_template.gold_max)
        self.current_money = money

        for loot_item in self.loot_template:
            chance = float(round(uniform(0.0, 1.0), 2) * 100)
            item_template = WorldDatabaseManager.item_template_get_by_entry(loot_item.item)
            if item_template:
                item_chance = loot_item.ChanceOrQuestChance
                item_chance = item_chance if item_chance > 0 else item_chance * -1

                if item_chance >= 100 or chance - item_chance < 0:
                    item = ItemManager.generate_item_from_entry(item_template.entry)
                    if item:
                        self.current_loot.append(item)

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
