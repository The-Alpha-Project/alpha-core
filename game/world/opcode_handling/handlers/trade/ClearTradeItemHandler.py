from struct import unpack

from game.world.managers.objects.units.player.trade.TradeManager import TradeManager
from game.world.opcode_handling.HandlerValidator import HandlerValidator


class ClearTradeItemHandler:

    @staticmethod
    def handle(world_session, reader):
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode)
        if not player_mgr:
            return res

        if not TradeManager.validate_active_trade(player_mgr):
            return 0

        # Avoid handling an empty clear trade item packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=1):
            return 0
        trade_slot = unpack('<B', reader.data[:1])[0]
        if trade_slot >= TradeManager.TRADE_SLOT_COUNT:
            TradeManager.cancel_trade(player_mgr)
            return 0

        player_mgr.trade_data.clear_item(trade_slot)

        return 0
