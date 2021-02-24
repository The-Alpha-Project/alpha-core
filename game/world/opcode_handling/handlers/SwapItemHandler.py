from struct import pack, unpack

from network.packet.PacketWriter import *
from utils.constants.ItemCodes import InventorySlots


class SwapItemHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 4:  # Avoid handling empty swap item packet
            dest_bag, dest_slot, source_bag, source_slot = unpack('<4B', reader.data[:4])
            if dest_bag == 0xFF or dest_bag == InventorySlots.SLOT_BANK_END:
                dest_bag = InventorySlots.SLOT_INBACKPACK.value
            if source_bag == 0xFF or source_bag == InventorySlots.SLOT_BANK_END:
                source_bag = InventorySlots.SLOT_INBACKPACK.value

            world_session.player_mgr.inventory.swap_item(source_bag, source_slot, dest_bag, dest_slot)
        return 0
