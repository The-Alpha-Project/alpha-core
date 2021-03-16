from utils.Logger import Logger
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

            _item_templates = []
            for lt in LootManager.CREATURE_LOOT_TEMPLATES:
                if lt.entry == creature.entry:
                    item_template = WorldDatabaseManager.item_template_get_by_entry(lt.item)
                    if item_template:
                        _item_templates.append(lt)

            if _item_templates:
                chance = float(round(uniform(0.0, 1.0), 2) * 100)
                for loot_temp in _item_templates:
                    item_chance = loot_temp.ChanceOrQuestChance
                    item_chance = item_chance if item_chance > 0 else item_chance * -1

                    item = None
                    if item_chance >= 100:
                        item = ItemManager.generate_item_from_entry(loot_temp.item)

                    chance -= item_chance
                    if chance <= 0:
                        item = ItemManager.generate_item_from_entry(loot_temp.item)

                    if item:
                        print(f'Item: entry {item.entry} dID {item.display_id} name {item.item_template.name}')
                        creature.loot.append(item)
                        break

        print('[DEBUG] Loot generated:')
        print(f"[DEBUG]\tMoney: {creature.money}")
        print('[DEBUG] Items:')
        for item in creature.loot:
            print(f'[DEBUG]\t{item.item_template.name}')