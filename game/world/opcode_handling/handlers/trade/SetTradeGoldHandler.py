from struct import unpack


class SetTradeGoldHandler(object):

    @staticmethod
    def handle(world_session, reader):
        if not world_session.player_mgr.trade_data:
            return 0

        if len(reader.data) >= 4:  # Avoid handling empty set trade gold packet.
            money = unpack('<I', reader.data[:4])[0]
            if money <= 0:
                return 0

            if money > world_session.player_mgr.coinage:
                money = world_session.player_mgr.coinage

            world_session.player_mgr.trade_data.set_money(money)

        return 0
