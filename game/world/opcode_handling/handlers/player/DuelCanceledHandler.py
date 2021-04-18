class DuelCanceledHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        world_session.player_mgr.duel_manager.handle_duel_canceled(world_session.player_mgr)
        return 0
