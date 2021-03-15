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

            _creature_loot = []
            for lt in LootManager.CREATURE_LOOT_TEMPLATES:
                if lt.entry == creature.entry:
                    _creature_loot.append(lt)

            if _creature_loot:
                chance = float(round(uniform(0.0, 1.0), 2) * 100)
                for loot_temp in _creature_loot:
                    item_chance = loot_temp.ChanceOrQuestChance
                    item_chance = item_chance if item_chance > 0 else item_chance * -1

                    if item_chance >= 100:
                        creature.loot.append(loot_temp.item)
                        break

                    chance -= item_chance
                    if chance <= 0:
                        item = ItemManager.generate_item_from_creature(creature.guid, loot_temp.item)

                        if item:
                            creature.loot.append(item)
                            break

            # print('[DEBUG] Loot generated:')
            # print(f"[DEBUG]\tMoney: {creature.money}")
            # print('[DEBUG] Items:')
            # for l in creature.loot:
            #    print(f'[DEBUG]\t{l.item_template.name}')

    @staticmethod
    def load_creature_loot_templates():
        creature_loot_templates, session = WorldDatabaseManager.creature_get_loot_template()
        length = len(creature_loot_templates)
        count = 0

        for c_template in creature_loot_templates:
            LootManager.CREATURE_LOOT_TEMPLATES.append(c_template)
            count += 1
            Logger.progress('Loading creature loot templates...', count, length)

        session.close()
        return length
