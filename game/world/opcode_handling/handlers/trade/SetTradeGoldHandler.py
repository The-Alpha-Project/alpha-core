from struct import unpack

from game.world.managers.objects.units.player.trade.TradeManager import TradeManager
from game.world.opcode_handling.HandlerValidator import HandlerValidator


class SetTradeGoldHandler:

    @staticmethod
    def handle(world_session, reader):
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode)
        if not player_mgr:
            return res

        if not TradeManager.validate_active_trade(player_mgr):
            return 0

        # Avoid handling an empty set trade gold packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=4):
            return 0

        money = unpack('<I', reader.data[:4])[0]
        if money > player_mgr.coinage:
            money = player_mgr.coinage

        # Keep parity with client/vmangos behavior: setting 0 clears offered gold.
        player_mgr.trade_data.set_money(money)

        return 0
