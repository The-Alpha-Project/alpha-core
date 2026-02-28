from game.world.managers.objects.units.player.trade.TradeManager import TradeManager
from game.world.opcode_handling.HandlerValidator import HandlerValidator
from utils.constants.MiscCodes import TradeStatus


class BeginTradeHandler:

    @staticmethod
    def handle(world_session, reader):
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode)
        if not player_mgr:
            return res

        if not TradeManager.validate_active_trade(player_mgr):
            return 0

        TradeManager.send_trade_status(player_mgr, TradeStatus.TRADE_STATUS_INITIATED)
        TradeManager.send_trade_status(player_mgr.trade_data.other_player, TradeStatus.TRADE_STATUS_INITIATED)

        return 0
