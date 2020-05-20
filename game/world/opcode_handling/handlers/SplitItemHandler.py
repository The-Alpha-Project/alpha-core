from struct import unpack
from database.realm.RealmDatabaseManager import RealmDatabaseManager
from utils.constants.ItemCodes import InventorySlots


class SplitItemHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 5:  # Avoid handling empty sell item packet
            source_bag_slot, source_slot, dest_bag_slot, dest_slot, count = unpack('<5B', reader.data[:5])
            inventory = world_session.player_mgr.inventory

            if source_bag_slot == 255:
                source_bag_slot = InventorySlots.SLOT_INBACKPACK
            if dest_bag_slot == 255:
                dest_bag_slot = InventorySlots.SLOT_INBACKPACK

            source_item = inventory.get_item(source_bag_slot, source_slot)
            if not source_item or count <= 0 or source_item.item_instance.stackcount < count:
                return 0

            if not inventory.add_item_to_slot(dest_bag_slot, dest_slot, item=source_item,
                                              item_template=source_item.item_template, count=count):
                return 0
            source_item.item_instance.stackcount -= count
            RealmDatabaseManager.character_inventory_update_item(source_item.item_instance)
            inventory.owner.send_update_self()
        return 0
