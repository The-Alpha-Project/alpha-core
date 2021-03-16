from random import randint, uniform
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.objects.item.ItemManager import ItemManager


class LootManager(object):

    @staticmethod
    def generate_creature_loot(creature):
        if creature.creature_template:
            money = randint(creature.creature_template.gold_min, creature.creature_template.gold_max)
            creature.money = money
            chance = float(round(uniform(0.0, 1.0), 2) * 100)

            item = None
            loot_template = WorldDatabaseManager.CreatureLootTemplateHolder\
                .creature_loot_template_get_by_creature(creature.entry)
            for loot_item in loot_template:
                item_template = WorldDatabaseManager.item_template_get_by_entry(loot_item.item)
                if item_template:
                    item_chance = loot_item.ChanceOrQuestChance
                    item_chance = item_chance if item_chance > 0 else item_chance * -1

                    if item_chance >= 100 or chance - item_chance < 0:
                        item = ItemManager.generate_item_from_entry(item_template.entry)
                        if item:
                            break

                    chance -= item_chance

            if item:
                creature.loot.append(item)
