from game.world.managers.objects.units.player.TradeManager import TradeManager


class CancelTradeHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if not world_session or not world_session.player_mgr or not world_session.player_mgr.trade_data:
            return 0

        TradeManager.cancel_trade(world_session.player_mgr)

        return 0
