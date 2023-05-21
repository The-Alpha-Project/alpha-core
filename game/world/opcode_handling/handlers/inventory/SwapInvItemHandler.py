from struct import unpack

from utils.constants.ItemCodes import InventorySlots


class SwapInvItemHandler(object):

    @staticmethod
    def handle(world_session, reader):
        if len(reader.data) >= 2:  # Avoid handling empty swap inv item packet.
            source_slot, dest_slot = unpack('<2B', reader.data[:2])
            bag = InventorySlots.SLOT_INBACKPACK.value
            world_session.player_mgr.inventory.swap_item(bag, source_slot, bag, dest_slot)
        return 0
