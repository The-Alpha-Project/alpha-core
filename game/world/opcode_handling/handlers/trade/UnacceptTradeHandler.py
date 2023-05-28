class UnacceptTradeHandler(object):

    @staticmethod
    def handle(world_session, reader):
        if not world_session.player_mgr.trade_data:
            return 0

        world_session.player_mgr.trade_data.set_accepted(False)

        return 0
