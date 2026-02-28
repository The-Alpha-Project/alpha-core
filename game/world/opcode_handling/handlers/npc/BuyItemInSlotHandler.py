from struct import unpack
from game.world.managers.objects.units.creature.utils.VendorUtils import VendorUtils
from game.world.opcode_handling.HandlerValidator import HandlerValidator


class BuyItemInSlotHandler:

    @staticmethod
    def handle(world_session, reader):
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode, disconnect=True)
        if not player_mgr:
            return res

        if not player_mgr.is_alive:
            return 0

        # Avoid handling an empty buy item packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=22):
            return 0

        vendor_guid, item, bag_guid, slot, count = unpack('<QIQ2B', reader.data[:22])
        if vendor_guid <= 0:
            return 0

        VendorUtils.handle_buy_item(player_mgr, vendor_guid, item, count, bag_guid, slot)

        return 0
