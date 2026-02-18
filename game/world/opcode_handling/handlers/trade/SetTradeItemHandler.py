from struct import unpack

from game.world.managers.objects.units.player.trade.TradeManager import TradeManager
from utils.constants.ItemCodes import InventorySlots


class SetTradeItemHandler:

    @staticmethod
    def handle(world_session, reader):
        if not world_session.player_mgr.trade_data:
            return 0

        if len(reader.data) >= 3:  # Avoid handling empty set trade item packet.
            trade_slot, bag, slot = unpack('<3B', reader.data[:3])

            if bag == 0xFF:
                bag = InventorySlots.SLOT_INBACKPACK.value

            item = world_session.player_mgr.inventory.get_item(bag, slot)
            if not item:
                return 0

            if trade_slot >= TradeManager.TRADE_SLOT_COUNT:
                TradeManager.cancel_trade(world_session.player_mgr)
                return 0

            world_session.player_mgr.trade_data.set_item(trade_slot, item)

        return 0
