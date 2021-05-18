class RepopRequestHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        world_session.player_mgr.repop()

        return 0
