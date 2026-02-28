from struct import unpack
from game.world.managers.objects.units.player.trade.TradeData import TradeData
from game.world.managers.objects.units.player.trade.TradeManager import TradeManager
from game.world.opcode_handling.HandlerValidator import HandlerValidator
from utils.Formulas import Distances
from utils.constants.MiscCodes import TradeStatus
from utils.constants.UnitCodes import UnitFlags


class InitiateTradeHandler:

    @staticmethod
    def handle(world_session, reader):
        # Validate world session.
        player, res = HandlerValidator.validate_session(world_session, reader.opcode)
        if not player:
            return res

        # Avoid handling an empty initiate trade packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=8):
            return 0

        guid = unpack('<Q', reader.data[:8])[0]
        if guid <= 0:
            return 0

        if not player.is_alive:
            TradeManager.send_trade_status(player, TradeStatus.TRADE_STATUS_DEAD)
            return 0
        if player.unit_flags & UnitFlags.UNIT_FLAG_TAXI_FLIGHT:
            TradeManager.send_trade_status(player, TradeStatus.TRADE_STATUS_TOO_FAR_AWAY)
            return 0
        if TradeManager.has_active_trade(player):
            TradeManager.send_trade_status(player, TradeStatus.TRADE_STATUS_ALREADY_TRADING)
            return 0

        trade_player = player.get_map().get_surrounding_player_by_guid(player, guid)
        trade_status = None
        if trade_player == player:
            trade_status = TradeStatus.TRADE_STATUS_PLAYER_BUSY
        elif not trade_player:
            trade_status = TradeStatus.TRADE_STATUS_PLAYER_NOT_FOUND
        elif not trade_player.is_alive:
            trade_status = TradeStatus.TRADE_STATUS_DEAD
        elif trade_player.unit_flags & UnitFlags.UNIT_FLAG_TAXI_FLIGHT:
            trade_status = TradeStatus.TRADE_STATUS_TOO_FAR_AWAY
        elif not Distances.is_within_trade_distance(player, trade_player):
            trade_status = TradeStatus.TRADE_STATUS_TOO_FAR_AWAY
        elif trade_player.friends_manager.has_ignore(player.guid):
            trade_status = TradeStatus.TRADE_STATUS_PLAYER_IGNORED
        elif TradeManager.has_active_trade(trade_player):
            trade_status = TradeStatus.TRADE_STATUS_PLAYER_BUSY
        elif player.team != trade_player.team:
            trade_status = TradeStatus.TRADE_STATUS_WRONG_FACTION

        if trade_status:
            TradeManager.send_trade_status(player, trade_status)
            return 0

        player.trade_data = TradeData(player, trade_player)
        trade_player.trade_data = TradeData(trade_player, player)

        TradeManager.send_trade_request(player, trade_player)
        TradeManager.send_trade_request(trade_player, player)

        return 0
