from game.world.managers.objects.units.player.trade.TradeManager import TradeManager
from game.world.opcode_handling.HandlerValidator import HandlerValidator


class UnacceptTradeHandler:

    @staticmethod
    def handle(world_session, reader):
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode)
        if not player_mgr:
            return res

        if not TradeManager.validate_active_trade(player_mgr):
            return 0

        player_mgr.trade_data.set_accepted(False)

        return 0
