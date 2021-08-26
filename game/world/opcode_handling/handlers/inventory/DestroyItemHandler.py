from struct import unpack

from utils.constants.ItemCodes import InventoryError, InventorySlots


class DestroyItemHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 3:  # Avoid handling empty destroy item packet.
            bag, source_slot, count = unpack('<3B', reader.data[:3])

            if bag == 0xFF:
                bag = InventorySlots.SLOT_INBACKPACK.value

            item = world_session.player_mgr.inventory.get_item(bag, source_slot)
            if not item:
                return 0

            if item.is_container() and not item.is_empty():
                world_session.player_mgr.inventory.send_equip_error(
                    InventoryError.BAG_NOT_EMPTY, item)
                return 0

            world_session.player_mgr.inventory.remove_item(bag, source_slot, True)

            if world_session.player_mgr.inventory.is_equipment_pos(bag, source_slot):
                world_session.player_mgr.set_dirty(dirty_inventory=True)
            else:
                world_session.player_mgr.send_update_self(force_inventory_update=True)
        return 0
