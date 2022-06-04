from random import uniform, randint


class LootManager(object):
    def __init__(self, world_object):
        self.world_object = world_object
        self.current_money = 0
        self.current_loot = []
        self.loot_template = self.populate_loot_template()
        self.active_looters = []

    # Needs overriding
    def generate_loot(self, requester):
        pass

    def generate_money(self):
        money = randint(self.world_object.creature_template.gold_min, self.world_object.creature_template.gold_max)
        self.current_money = money

    # Generates a complete dictionary { group_id : items }, includes referenced loot items.
    def generate_loot_groups(self, loot_template):
        loot_groups = {}
        loot_items = []
        for loot_item in loot_template:
            # Handle referenced loot template.
            if loot_item.mincountOrRef < 0:
                loot_items += self._fill_referenced_loot(-loot_item.mincountOrRef)
            # Handle normal loot items.
            else:
                loot_items.append(loot_item)

        for loot_item in loot_items:
            group_id = loot_item.groupid if not loot_item.ChanceOrQuestChance < 0 else 10
            if group_id not in loot_groups:
                loot_groups[group_id] = []
            loot_groups[group_id].append(loot_item)

        return loot_groups

    # Returns the final list of items available for looting.
    def process_loot_groups(self, loot_groups, requester) -> list:
        loot_item_result = []
        for group, loot_group_items in loot_groups.items():
            loot_item_result += self.process_loot_group(loot_group_items, requester)
        return loot_item_result

    def process_loot_group(self, group_loot_items: list, requester):
        loot_item_result = []
        for loot_item in group_loot_items:
            if self.skip_quest_item(loot_item, requester):
                continue
            if self.roll_item(loot_item):
                loot_item_result.append(loot_item)
        return loot_item_result

    # noinspection PyMethodMayBeStatic
    def skip_quest_item(self, loot_item, requester):
        # Check if this is a quest item and if the player or group needs it.
        if requester and loot_item.ChanceOrQuestChance < 0:
            if requester.player_or_group_require_quest_item(loot_item.item):
                return False
        return loot_item.ChanceOrQuestChance < 0

    # noinspection PyMethodMayBeStatic
    def roll_item(self, loot_item):
        roll = uniform(0.0, 1.0)
        item_chance = loot_item.ChanceOrQuestChance

        # Normal item.
        if item_chance > 0.0:
            chance = item_chance / 100
        # Quest item.
        elif item_chance < 0.0:
            chance = (item_chance * -1) / 100
        # Group item.
        else:
            chance = uniform(0.10, 0.15)

        if roll <= chance:
            return True
        return False

    def add_loot(self, loot_item):
        from game.world.managers.objects.loot.LootHolder import LootHolder
        from game.world.managers.objects.item.ItemManager import ItemManager
        item = ItemManager.generate_item_from_entry(loot_item.item)
        if item:
            self.current_loot.append(LootHolder(item, randint(loot_item.mincountOrRef, loot_item.maxcount)))

    def _fill_referenced_loot(self, loot_id):
        from game.world.managers.objects.loot.LootMapper import LootMapper
        loot_template = LootMapper.find_loot_by_loot_id(loot_id)
        if loot_template:
            # Recurse, there might be more nested referenced loot templates.
            return self.generate_loot_groups(loot_template)
        return []

    # Needs overriding
    def populate_loot_template(self):
        return None

    def get_loot_in_slot(self, slot):
        if slot < len(self.current_loot) and self.current_loot[slot]:
            return self.current_loot[slot]
        return None

    def do_loot(self, slot):
        if slot < len(self.current_loot):
            self.current_loot[slot] = None

    def clear_money(self):
        self.current_money = 0

    def has_money(self):
        return self.current_money > 0

    def has_items(self):
        return len([loot for loot in self.current_loot if loot]) > 0

    def has_loot(self):
        return self.has_money() or self.has_items()

    def get_loot_type(self, player, world_object):
        from utils.constants.MiscCodes import LootTypes
        return LootTypes.LOOT_TYPE_NOTALLOWED

    def add_active_looter(self, player_mgr):
        if player_mgr not in self.active_looters:
            self.active_looters.append(player_mgr)

    def remove_active_looter(self, player_mgr):
        if player_mgr in self.active_looters:
            self.active_looters.remove(player_mgr)

    def get_active_looters(self):
        return [looter for looter in self.active_looters if looter]

    def clear(self):
        self.clear_money()
        self.current_loot.clear()
        self.active_looters.clear()
