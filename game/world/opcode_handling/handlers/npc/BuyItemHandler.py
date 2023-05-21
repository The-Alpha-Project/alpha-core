from struct import unpack
from game.world.managers.objects.units.creature.utils.VendorUtils import VendorUtils


class BuyItemHandler(object):

    @staticmethod
    def handle(world_session, reader):
        if len(reader.data) >= 13:  # Avoid handling empty buy item packet.
            vendor_guid, item, count, auto_equip = unpack('<QI2B', reader.data[:14])

            if vendor_guid > 0:
                VendorUtils.handle_buy_item(world_session.player_mgr, vendor_guid, item, count)

        return 0
