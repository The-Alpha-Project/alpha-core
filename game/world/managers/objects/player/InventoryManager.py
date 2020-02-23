from database.realm.RealmDatabaseManager import RealmDatabaseManager
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.objects.item.ItemManager import ItemManager
from game.world.managers.objects.item.ContainerManager import ContainerManager
from utils.constants.ItemCodes import InventoryTypes, InventorySlots
from utils.constants.UpdateFields import PlayerFields


class InventoryManager(object):
    def __init__(self, owner):
        self.containers = dict()
        self.owner = owner

    def load_items(self, world_session):
        # Add backpack
        self.containers[InventorySlots.SLOT_INBACKPACK] = ContainerManager(is_backpack=True,
                                                                           owner=world_session.player_mgr.guid)

        character_inventory = RealmDatabaseManager.character_get_inventory(world_session.realm_db_session,
                                                                           world_session.player_mgr.guid)

        # First load bags
        for item_instance in character_inventory:
            item_template = WorldDatabaseManager.item_template_get_by_entry(world_session.world_db_session,
                                                                            item_instance.item_template)
            if item_template and item_template.inventory_type == InventoryTypes.BAG:
                container_mgr = ContainerManager(
                    owner=world_session.player_mgr.guid,
                    item_template=item_template,
                    item_instance=item_instance
                )
                if 19 <= container_mgr.current_slot <= 22 or 63 <= container_mgr.current_slot <= 68:
                    self.containers[item_instance.slot] = container_mgr

        # Then load items
        for item_instance in character_inventory:
            item_template = WorldDatabaseManager.item_template_get_by_entry(world_session.world_db_session,
                                                                            item_instance.item_template)
            if item_template:
                item_mgr = ItemManager(
                    item_template=item_template,
                    item_instance=item_instance
                )
                if not item_mgr.is_container() and (19 <= item_mgr.current_slot <= 22 or
                                                    63 <= item_mgr.current_slot <= 68):
                    if item_instance.bag in self.containers:
                        self.containers[item_instance.bag] = item_mgr

    def get_backpack(self):
        return self.containers[InventorySlots.SLOT_INBACKPACK]

    def build_update(self, update_packet_factory):
        for item in self.get_backpack():
            update_packet_factory.update(update_packet_factory.player_values,
                                         update_packet_factory.updated_player_fields,
                                         PlayerFields.PLAYER_FIELD_INV_SLOT_1 + item.current_slot * 2, item.guid, 'Q')

    def send_inventory_update(self):
        for container in self.containers:
            if not container.is_backpack:
                pass
