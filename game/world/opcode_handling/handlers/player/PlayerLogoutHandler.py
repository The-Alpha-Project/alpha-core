

class PlayerLogoutHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        world_session.player_mgr.logout()

        return 0
