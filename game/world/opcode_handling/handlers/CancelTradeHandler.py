from game.world.managers.objects.player.TradeManager import TradeManager
from utils.constants.ObjectCodes import TradeStatuses


class CancelTradeHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if not world_session.player_mgr.trade_data:
            return 0

        TradeManager.send_trade_status(world_session.player_mgr.trade_data.other_player,
                                       TradeStatuses.TRADE_STATUS_CANCELLED)
        world_session.player_mgr.trade_data.other_player.trade_data = None

        TradeManager.send_trade_status(world_session.player_mgr, TradeStatuses.TRADE_STATUS_CANCELLED)
        world_session.player_mgr.trade_data = None

        return 0
