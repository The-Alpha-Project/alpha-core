class DuelCanceledHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        world_session.player_mgr.duel_manager.handle_duel_canceled()
        return 0
