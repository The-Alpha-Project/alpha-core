from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.objects.loot.LootManager import LootManager
from utils.constants.MiscCodes import LootTypes


class CreatureLootManager(LootManager):
    def __init__(self, creature_mgr):
        super(CreatureLootManager, self).__init__(creature_mgr)

    # override
    def generate_loot(self, requester):
        super().clear()
        super().generate_money()
        loot_collection = self.generate_loot_groups(self.loot_template)
        for loot_item in self.process_loot_groups(loot_collection, requester):
            self.add_loot(loot_item, requester)

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
