from struct import unpack


class SetTargetHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 8:  # Avoid handling empty set target packet
            guid = unpack('<Q', reader.data[:8])[0]
            if world_session.player_mgr:
                world_session.player_mgr.current_target = guid

        return 0
