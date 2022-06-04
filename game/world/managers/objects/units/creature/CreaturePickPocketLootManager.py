from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.objects.loot.LootManager import LootManager
from utils.constants.MiscCodes import LootTypes


class CreaturePickPocketLootManager(LootManager):
    def __init__(self, creature_mgr):
        super(CreaturePickPocketLootManager, self).__init__(creature_mgr)

    # override
    def generate_loot(self, requester):
        super().clear()
        super().generate_money()
        loot_collection = self.generate_loot_groups(self.loot_template)
        for loot_item in self.process_loot_groups(loot_collection, requester):
            self.add_loot(loot_item)

    # override
    def populate_loot_template(self):
        return WorldDatabaseManager.PickPocketingLootTemplateHolder\
            .pickpocketing_loot_template_get_by_entry(self.world_object.creature_template.pickpocket_loot_id)

    # override
    def get_loot_type(self, player, creature):
        return LootTypes.LOOT_TYPE_PICKLOCK
