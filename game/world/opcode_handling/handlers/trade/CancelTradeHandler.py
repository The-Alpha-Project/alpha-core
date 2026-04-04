from game.world.managers.objects.units.player.trade.TradeManager import TradeManager
from game.world.opcode_handling.HandlerValidator import HandlerValidator


class CancelTradeHandler:

    @staticmethod
    def handle(world_session, reader):
        # The client can emit a trailing cancel-trade packet while tearing down the UI on logout.
        # By then the session may already have detached its player manager.
        player_mgr, res = HandlerValidator.validate_session(
            world_session,
            reader.opcode,
            disconnect=False,
            log_missing_player=False
        )
        if not player_mgr:
            return res

        if not player_mgr.trade_data:
            return 0

        TradeManager.cancel_trade(player_mgr)

        return 0
