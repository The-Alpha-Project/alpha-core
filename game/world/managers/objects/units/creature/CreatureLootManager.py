from random import randint

from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.objects.loot.LootManager import LootManager
from utils.constants.MiscCodes import LootTypes


class CreatureLootManager(LootManager):
    def __init__(self, creature_mgr):
        super(CreatureLootManager, self).__init__(creature_mgr)

    # override
    def generate_money(self):
        money = randint(self.world_object.creature_template.gold_min, self.world_object.creature_template.gold_max)
        self.current_money = money

    # override
    def generate_loot(self, requester):
        self.clear()
        self.generate_money()
        loot_collection = self.generate_loot_groups(self.loot_template)
        for loot_item in self.process_loot_groups(loot_collection, requester):
            self.add_loot(loot_item, requester)

    # override
    def populate_loot_template(self):
        creature_loot_template = WorldDatabaseManager.CreatureLootTemplateHolder\
            .creature_loot_template_get_by_loot_id(self.world_object.creature_template.loot_id)
        # Merge normal creature loot template with skinning loot template as the only way to obtain leather in 0.5.3 was
        # to loot it from beasts.
        # From 0.5.5 patch notes:
        #     "New Skinning tradeskill added. Most leather and hides will need to be acquired by skinning rather than
        #      by drops."
        # This might look a bit hacky but it allows us to still easily benefit from future changes from VMaNGOS to
        # this table in case they are needed.
        # TODO: Only doing it if a normal template exists to avoid adding loot to creatures like critters. Try to find
        #  out if this is correct and critters didn't drop leather back in the day. Might be a hard thing to prove.
        if len(creature_loot_template) > 0:
            creature_loot_template += WorldDatabaseManager.SkinningLootTemplateHolder\
                .skinning_loot_template_get_by_loot_id(self.world_object.creature_template.skinning_loot_id)
        return creature_loot_template

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
