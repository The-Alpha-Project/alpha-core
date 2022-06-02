from struct import unpack

from utils.constants.ItemCodes import InventoryError, InventorySlots, ItemDynFlags


class OpenItemHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 2:  # Avoid handling empty open item packet.
            bag, slot = unpack('<2B', reader.data[:2])
            if bag == 0xFF:
                bag = InventorySlots.SLOT_INBACKPACK.value
            item = world_session.player_mgr.inventory.get_item(bag, slot)

            if not item:
                world_session.player_mgr.inventory.send_equip_error(InventoryError.BAG_ITEM_NOT_FOUND)

            # TODO: Better handling of this: check if player can use item, etc.
            if not item.has_flag(ItemDynFlags.ITEM_DYNFLAG_UNLOCKED):
                world_session.player_mgr.inventory.send_equip_error(InventoryError.BAG_ITEM_LOCKED)
            elif item.loot_manager:
                if not item.loot_manager.has_loot():
                    item.loot_manager.generate_loot(world_session.player_mgr)
                world_session.player_mgr.send_loot(item.loot_manager)

        return 0
