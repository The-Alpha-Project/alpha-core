from random import randint

from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.objects.loot.LootManager import LootManager
from utils.constants.MiscCodes import LootTypes, GameObjectTypes


class GameObjectLootManager(LootManager):
    def __init__(self, object_mgr):
        super(GameObjectLootManager, self).__init__(object_mgr)

    # override
    def generate_money(self, requester):
        self.current_money = randint(self.world_object.gobject_template.mingold, self.world_object.gobject_template.maxgold)

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
            from game.world.managers.maps.MapManager import MapManager
            zone = self.world_object.zone
            loot_template = WorldDatabaseManager.FishingLootTemplateHolder.fishing_loot_template_get_by_loot_id(zone)
            # Most sub areas have no loot of their own, fall back to their parent zone like vmangos.
            if not loot_template:
                parent_zone = MapManager.get_parent_zone_id(zone, self.world_object.map_id)
                loot_template = WorldDatabaseManager.FishingLootTemplateHolder\
                    .fishing_loot_template_get_by_loot_id(parent_zone)
            return loot_template

        return []

    # override
    def get_loot_type(self, player, gameobject):
        if gameobject.gobject_template.type == GameObjectTypes.TYPE_FISHINGNODE:
            return LootTypes.LOOT_TYPE_FISHING
        return LootTypes.LOOT_TYPE_CORPSE
