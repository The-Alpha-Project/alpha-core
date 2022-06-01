from random import randint, uniform, choices

from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.objects.units.LootHolder import LootHolder
from game.world.managers.objects.units.LootManager import LootManager
from game.world.managers.objects.item.ItemManager import ItemManager
from utils.constants.ItemCodes import ItemClasses
from utils.constants.MiscCodes import LootTypes


class CreatureLootManager(LootManager):
    def __init__(self, creature_mgr):
        super(CreatureLootManager, self).__init__(creature_mgr)

    # override
    def generate_loot(self, requester):
        self.clear()

        money = randint(self.world_object.creature_template.gold_min, self.world_object.creature_template.gold_max)
        self.current_money = money

        # TODO, handle referenced loot. (negative mincountOrRef)
        #  This points to any other loot table.
        loot_items = [loot_item for loot_item in self.loot_template if loot_item.mincountOrRef > 0]
        # For now, randomly pick 2..4 items.
        for loot_item in choices(loot_items, k=randint(min(2, len(loot_items)), min(4, len(loot_items)))):
            chance = float(round(uniform(0.0, 1.0), 2) * 100)
            item_template = WorldDatabaseManager.ItemTemplateHolder.item_template_get_by_entry(loot_item.item)
            if item_template:

                # Check if this is a quest item and if the player or group needs it.
                if requester and item_template.class_ == ItemClasses.ITEM_CLASS_QUEST:  # Quest item
                    if not requester.player_or_group_require_quest_item(item_template.entry):
                        continue  # Move on to next item.

                item_chance = loot_item.ChanceOrQuestChance
                item_chance = item_chance if item_chance > 0 else item_chance * -1

                if item_chance >= 100 or chance - item_chance < 0:
                    item = ItemManager.generate_item_from_entry(item_template.entry)
                    if item:
                        self.current_loot.append(LootHolder(item, randint(loot_item.mincountOrRef, loot_item.maxcount)))

    # override
    def populate_loot_template(self):
        return WorldDatabaseManager.CreatureLootTemplateHolder\
            .creature_loot_template_get_by_creature(self.world_object.entry)

    # override
    def get_loot_type(self, player, creature):
        loot_type = LootTypes.LOOT_TYPE_NOTALLOWED

        # Not tagged, anyone can loot.
        if not creature.killed_by:
            loot_type = LootTypes.LOOT_TYPE_CORPSE
        # Killer has party and loot_method allows player to loot.
        elif creature.killed_by and creature.killed_by.group_manager and creature.killed_by.group_manager.is_party_member(player.guid):
            if player.guid in creature.killed_by.group_manager.get_allowed_looters(creature):
                loot_type = LootTypes.LOOT_TYPE_CORPSE
        # No party but looter is the actual killer.
        elif creature.killed_by == player:
            loot_type = LootTypes.LOOT_TYPE_CORPSE

        return loot_type
