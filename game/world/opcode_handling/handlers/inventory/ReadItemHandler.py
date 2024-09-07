from struct import unpack

from network.packet.PacketWriter import *
from utils.constants.ItemCodes import InventoryError, InventorySlots
from utils.constants.OpCodes import OpCode


class ReadItemHandler(object):

    @staticmethod
    def handle(world_session, reader):
        if len(reader.data) >= 2:  # Avoid handling empty read item packet.
            bag, slot = unpack('<2B', reader.data[:2])
            if bag == 0xFF:
                bag = InventorySlots.SLOT_INBACKPACK.value
            item = world_session.player_mgr.inventory.get_item(bag, slot)

            # TODO: Better handling of this: check if player can use item, etc.
            if item:
                data = pack('<2Q', item.guid, item.guid)
                world_session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_READ_ITEM_OK, data))
            else:
                world_session.player_mgr.inventory.send_equip_error(InventoryError.BAG_ITEM_NOT_FOUND)
                data = pack('<QIQ', item.guid, 0, item.guid)
                world_session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_READ_ITEM_FAILED, data))

        return 0
