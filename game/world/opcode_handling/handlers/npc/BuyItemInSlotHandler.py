from struct import unpack
from game.world.managers.objects.units.creature.utils.VendorUtils import VendorUtils


class BuyItemInSlotHandler(object):

    @staticmethod
    def handle(world_session, reader):
        if len(reader.data) >= 22:  # Avoid handling empty buy item packet.
            vendor_guid, item, bag_guid, slot, count = unpack('<QIQ2B', reader.data[:22])
            if vendor_guid > 0:
                VendorUtils.handle_buy_item(world_session.player_mgr, vendor_guid, item, count, bag_guid, slot)

        return 0
