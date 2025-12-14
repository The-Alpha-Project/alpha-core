from struct import unpack

from game.world.managers.objects.units.player.trade.TradeManager import TradeManager


class ClearTradeItemHandler:

    @staticmethod
    def handle(world_session, reader):
        if not world_session or not world_session.player_mgr or not world_session.player_mgr.trade_data:
            return 0

        if len(reader.data) >= 1:  # Avoid handling empty clear trade item packet.
            trade_slot = unpack('<B', reader.data[:1])[0]
            if trade_slot > TradeManager.TRADE_SLOT_COUNT:
                return 0

            world_session.player_mgr.trade_data.clear_item(trade_slot)

        return 0
