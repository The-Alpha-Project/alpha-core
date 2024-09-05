from random import randint
from statistics import mean

from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.objects.loot.LootManager import LootManager
from utils.constants.MiscCodes import LootTypes, GameObjectTypes


class GameObjectLootManager(LootManager):
    def __init__(self, object_mgr):
        super(GameObjectLootManager, self).__init__(object_mgr)

    # override
    def generate_money(self, requester):
        money = randint(self.world_object.gobject_template.mingold, self.world_object.gobject_template.maxgold)

        # Handle chests with no gold data.
        if not money and self.world_object.gobject_template.type == GameObjectTypes.TYPE_CHEST:
            money = self._generate_money_by_surrounding_units_mean()

        self.current_money = money

    # It can be estimated, that chests should contain about 5 times the average gold that a typical mob in the area.
    # https://github.com/The-Alpha-Project/alpha-core/issues/699
    def _generate_money_by_surrounding_units_mean(self):
        money = 0
        multiplier = randint(3, 5)
        # Find surrounding normal creatures.
        surrounding_units = \
            [u for u in self.world_object.get_map().get_surrounding_units(self.world_object).values()
             if not u.creature_template.rank]
        if surrounding_units:
            min_gold = mean([u.creature_template.gold_min for u in surrounding_units])
            max_gold = mean([u.creature_template.gold_max for u in surrounding_units])
            money = randint(int(min_gold), int(max_gold)) * multiplier
        return money

    # override
    def generate_loot(self, requester):
        self.clear()
        self.generate_money(requester)
        loot_collection = self.generate_loot_groups(self.loot_template)
        for loot_item in self.process_loot_groups(loot_collection, requester):
            self.add_loot(loot_item, requester)

    # override
    def populate_loot_template(self):
        # Handle Chest.
        if self.world_object.gobject_template.type == GameObjectTypes.TYPE_CHEST:
            loot_template_id = self.world_object.gobject_template.data1
            return WorldDatabaseManager.GameObjectLootTemplateHolder.gameobject_loot_template_get_by_loot_id(loot_template_id)

        if self.world_object.gobject_template.type == GameObjectTypes.TYPE_FISHINGNODE:
            return WorldDatabaseManager.FishingLootTemplateHolder.fishing_loot_template_get_by_loot_id(self.world_object.zone)

        return []

    # override
    def get_loot_type(self, player, gameobject):
        if gameobject.gobject_template.type == GameObjectTypes.TYPE_FISHINGNODE:
            return LootTypes.LOOT_TYPE_FISHING
        return LootTypes.LOOT_TYPE_CORPSE
