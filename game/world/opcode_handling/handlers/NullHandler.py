class NullHandler(object):

    @staticmethod
    def handle(world_session, reader):
        # Just silently ignore.
        return 1
