from game.world.opcode_handling.HandlerValidator import HandlerValidator
from struct import unpack

from utils.constants.ItemCodes import InventorySlots


class SwapInvItemHandler:

    @staticmethod
    def handle(world_session, reader):
        # Avoid handling an empty swap inv item packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=2):
            return 0
        source_slot, dest_slot = unpack('<2B', reader.data[:2])
        bag = InventorySlots.SLOT_INBACKPACK.value
        inventory = world_session.player_mgr.inventory

        world_session.player_mgr.inventory.swap_item(bag, source_slot, bag, dest_slot)

        return 0
