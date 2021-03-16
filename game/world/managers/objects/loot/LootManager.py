from random import randint, uniform
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.objects.item.ItemManager import ItemManager


class LootManager(object):
    CREATURE_LOOT_TEMPLATES = []

    @staticmethod
    def generate_creature_loot(creature):
        if creature.creature_template:
            money = randint(creature.creature_template.gold_min, creature.creature_template.gold_max)
            creature.money = money
            chance = float(round(uniform(0.0, 1.0), 2) * 100)

            item = None
            for lt in LootManager.CREATURE_LOOT_TEMPLATES:
                if lt.entry == creature.entry:
                    item_template = WorldDatabaseManager.item_template_get_by_entry(lt.item)
                    if item_template:
                        item_chance = lt.ChanceOrQuestChance
                        item_chance = item_chance if item_chance > 0 else item_chance * -1

                        if item_chance >= 100 or chance - item_chance < 0:
                            item = ItemManager.generate_item_from_entry(item_template.entry)
                            if item:
                                break

                        chance -= item_chance

            if item:
                creature.loot.append(item)


