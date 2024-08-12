from struct import unpack
from utils.constants.ItemCodes import InventorySlots


class SwapItemHandler(object):

    @staticmethod
    def handle(world_session, reader):
        if len(reader.data) >= 4:  # Avoid handling empty swap item packet.
            dest_bag, dest_slot, source_bag, source_slot = unpack('<4B', reader.data[:4])
            inventory = world_session.player_mgr.inventory

            if dest_bag == 0xFF:
                dest_bag = InventorySlots.SLOT_INBACKPACK.value
            if source_bag == 0xFF:
                source_bag = InventorySlots.SLOT_INBACKPACK.value

            world_session.player_mgr.inventory.swap_item(source_bag, source_slot, dest_bag, dest_slot)

        return 0
