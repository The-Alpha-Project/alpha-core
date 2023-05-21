from struct import unpack

from game.world.managers.maps.MapManager import MapManager
from game.world.managers.objects.units.player.trade.TradeData import TradeData
from game.world.managers.objects.units.player.trade.TradeManager import TradeManager
from utils.constants.MiscCodes import TradeStatus


class InitiateTradeHandler(object):

    @staticmethod
    def handle(world_session, reader):
        if len(reader.data) >= 8:  # Avoid handling empty initiate trade packet.
            guid = unpack('<Q', reader.data[:8])[0]
            if guid > 0:
                player = world_session.player_mgr
                trade_player = MapManager.get_surrounding_player_by_guid(world_session.player_mgr, guid)
                trade_status = None
                if not trade_player or not trade_player.is_alive:
                    trade_status = TradeStatus.TRADE_STATUS_PLAYER_NOT_FOUND
                if trade_player.friends_manager.has_ignore(player.guid):
                    trade_status = TradeStatus.TRADE_STATUS_PLAYER_IGNORED
                elif not player.is_alive:
                    trade_status = TradeStatus.TRADE_STATUS_DEAD
                elif player.trade_data:
                    trade_status = TradeStatus.TRADE_STATUS_ALREADY_TRADING
                elif player.team != trade_player.team:
                    trade_status = TradeStatus.TRADE_STATUS_WRONG_FACTION

                if trade_status:
                    TradeManager.send_trade_status(player, trade_status)
                    return 0

                world_session.player_mgr.trade_data = TradeData(player, trade_player)
                trade_player.trade_data = TradeData(trade_player, player)

                TradeManager.send_trade_request(player, trade_player)
                TradeManager.send_trade_request(trade_player, player)

        return 0
