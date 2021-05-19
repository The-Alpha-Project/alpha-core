from struct import unpack

from game.world.managers.maps.MapManager import MapManager
from game.world.managers.objects.player.TradeManager import TradeManager
from utils.constants.MiscCodes import TradeStatus


class InitiateTradeHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 8:  # Avoid handling empty initiate trade packet.
            guid = unpack('<Q', reader.data[:8])[0]
            if guid > 0:
                trade_player = MapManager.get_surrounding_player_by_guid(world_session.player_mgr, guid)
                trade_status = None
                if not trade_player or not trade_player.is_alive:
                    trade_status = TradeStatus.TRADE_STATUS_PLAYER_NOT_FOUND
                if not world_session.player_mgr.is_alive:
                    trade_status = TradeStatus.TRADE_STATUS_DEAD
                if world_session.player_mgr.trade_data:
                    trade_status = TradeStatus.TRADE_STATUS_ALREADY_TRADING
                if world_session.player_mgr.team != trade_player.team:
                    trade_status = TradeStatus.TRADE_STATUS_WRONG_FACTION

                if trade_status:
                    TradeManager.send_trade_status(world_session.player_mgr, trade_status)
                    return 0

                world_session.player_mgr.trade_data = TradeManager.TradeData(world_session.player_mgr, trade_player)
                trade_player.trade_data = TradeManager.TradeData(trade_player, world_session.player_mgr)

                TradeManager.send_trade_request(world_session.player_mgr, trade_player)
                TradeManager.send_trade_request(trade_player, world_session.player_mgr)

        return 0
