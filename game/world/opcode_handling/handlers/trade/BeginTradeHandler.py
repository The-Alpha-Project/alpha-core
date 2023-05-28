from game.world.managers.objects.units.player.trade.TradeManager import TradeManager
from utils.constants.MiscCodes import TradeStatus


class BeginTradeHandler(object):

    @staticmethod
    def handle(world_session, reader):
        if not world_session.player_mgr.trade_data:
            return 0

        TradeManager.send_trade_status(world_session.player_mgr, TradeStatus.TRADE_STATUS_INITIATED)
        TradeManager.send_trade_status(world_session.player_mgr.trade_data.other_player,
                                       TradeStatus.TRADE_STATUS_INITIATED)

        return 0
