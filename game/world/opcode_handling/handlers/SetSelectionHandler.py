from struct import unpack


class SetSelectionHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 8:  # Avoid handling empty set selection packet
            guid = unpack('<Q', reader.data[:8])[0]
            if world_session.player_mgr:
                world_session.player_mgr.current_selection = guid

        return 0
