from struct import unpack
from utils.constants.ItemCodes import InventorySlots


class UseItemHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 2:  # Avoid handling empty use item packet.
            bag, slot = unpack('<2B', reader.data[:2])

            if bag == 0xFF:
                bag = InventorySlots.SLOT_INBACKPACK.value

            item = world_session.player_mgr.inventory.get_item(bag, slot)
            if not item:
                return 0

            world_session.player_mgr.spell_manager.handle_item_cast_attempt(item, world_session.player_mgr)
        return 0
