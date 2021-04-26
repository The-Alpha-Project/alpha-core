class NullHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        # Just silently ignore.
        return 1
