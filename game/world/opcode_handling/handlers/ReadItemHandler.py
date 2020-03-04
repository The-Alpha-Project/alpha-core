from struct import pack, unpack

from network.packet.PacketWriter import *
from utils.constants.ItemCodes import InventoryError, InventorySlots


class ReadItemHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        # Seems CMSG_READ_ITEM is only called if the item is in the backpack, weird.
        if len(reader.data) >= 2:  # Avoid handling empty read item packet
            bag, slot = unpack('<2B', reader.data[:2])
            if bag == 0xFF:
                bag = InventorySlots.SLOT_INBACKPACK.value
            item = world_session.player_mgr.inventory.get_item(bag, slot)
            data = b''

            # TODO: Better handling of this: check if player can use item, etc.
            if item:
                data += pack('<2Q', item.guid, item.guid)
                socket.sendall(PacketWriter.get_packet(OpCode.SMSG_READ_ITEM_OK, data))
            else:
                world_session.player_mgr.inventory.send_equip_error(InventoryError.EQUIP_ERR_ITEM_NOT_FOUND)

        return 0
