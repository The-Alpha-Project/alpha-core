from database.world.WorldDatabaseManager import WorldDatabaseManager
from utils.Logger import Logger


class LootMapper:

    # Find loot on available Loot template holders, all these checks are done against dictionaries, should not be that
    # expensive.
    @staticmethod
    def find_loot_by_loot_id(loot_id):
        loot = WorldDatabaseManager.CreatureLootTemplateHolder.creature_loot_template_get_by_creature(loot_id)
        if loot:
            return loot
        loot = WorldDatabaseManager.PickPocketingLootTemplateHolder.pickpocketing_loot_template_get_by_entry(loot_id)
        if loot:
            return loot
        loot = WorldDatabaseManager.ReferenceLootTemplateHolder.reference_loot_template_get_by_entry(loot_id)
        if loot:
            return loot
        loot = WorldDatabaseManager.FishingLootTemplateHolder.fishing_loot_template_get_by_entry(loot_id)
        if loot:
            return loot
        loot = WorldDatabaseManager.GameObjectLootTemplateHolder.gameobject_loot_template_get_by_entry(loot_id)
        if loot:
            return loot
        loot = WorldDatabaseManager.ItemLootTemplateHolder.item_loot_template_get_by_entry(loot_id)
        if loot:
            return loot

        if not loot:
            Logger.warning(f'Unable to locate referenced loot for id {loot_id}.')

        return None
