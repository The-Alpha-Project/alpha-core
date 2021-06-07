

class DuelAcceptHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if world_session.player_mgr.duel_manager:  # Ignore accept from duel-sender
            world_session.player_mgr.duel_manager.handle_duel_accept(world_session.player_mgr)
        return 0
