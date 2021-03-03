from struct import unpack
from database.realm.RealmDatabaseManager import RealmDatabaseManager
from utils.constants.ItemCodes import InventorySlots, InventoryError


class SplitItemHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 5:  # Avoid handling empty split item packet
            source_bag_slot, source_slot, dest_bag_slot, dest_slot, count = unpack('<5B', reader.data[:5])
            inventory = world_session.player_mgr.inventory

            if source_bag_slot == 0xFF or source_bag_slot == InventorySlots.SLOT_BANK_END:
                source_bag_slot = InventorySlots.SLOT_INBACKPACK.value
            if dest_bag_slot == 0xFF or dest_bag_slot == InventorySlots.SLOT_BANK_END:
                dest_bag_slot = InventorySlots.SLOT_INBACKPACK.value

            source_item = inventory.get_item(source_bag_slot, source_slot)
            if source_item.item_instance.stackcount < count:
                inventory.send_equip_error(InventoryError.BAG_ITEM_TOO_FEW_TO_SPLIT, source_item, None)
                return 0

            if not source_item or count <= 0:
                inventory.send_equip_error(InventoryError.BAG_ITEM_SPLIT_FAILED, source_item, None)
                return 0

            if not inventory.add_item_to_slot(dest_bag_slot, dest_slot, item=source_item,
                                              item_template=source_item.item_template, count=count):
                return 0
            source_item.item_instance.stackcount -= count
            RealmDatabaseManager.character_inventory_update_item(source_item.item_instance)
            inventory.owner.send_update_self(force_inventory_update=True)
        return 0
