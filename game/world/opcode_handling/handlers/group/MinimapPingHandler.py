from struct import pack, unpack, error, calcsize


class MinimapPingHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        x, y = unpack('<ff', reader.data[:64])

        if world_session.player_mgr and world_session.player_mgr.group_manager:
            world_session.player_mgr.group_manager.send_minimap_ping(world_session.player_mgr, x, y)
        return 0
