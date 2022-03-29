from struct import unpack

from game.world.managers.objects.units.player.TradeManager import TradeManager
from utils.constants.ItemCodes import InventorySlots
from utils.constants.MiscCodes import TradeStatus


class SetTradeItemHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if not world_session.player_mgr.trade_data:
            return 0

        if len(reader.data) >= 3:  # Avoid handling empty set trade item packet.
            trade_slot, bag, slot = unpack('<3B', reader.data[:3])

            if bag == 0xFF:
                bag = InventorySlots.SLOT_INBACKPACK.value

            item = world_session.player_mgr.inventory.get_item(bag, slot)
            if not item:
                return 0

            if trade_slot > TradeManager.TradeData.TRADE_SLOT_COUNT:
                TradeManager.send_trade_status(world_session.player_mgr, TradeStatus.TRADE_STATUS_CANCELLED)
                return 0

            world_session.player_mgr.trade_data.set_item(trade_slot, item)

        return 0
