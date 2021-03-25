from struct import pack, unpack, error, calcsize


class MinimapPingHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 8:  # Avoid handling empty minimap ping packet
            x, y = unpack('<2f', reader.data[:8])

            if world_session.player_mgr and world_session.player_mgr.group_manager:
                world_session.player_mgr.group_manager.send_minimap_ping(world_session.player_mgr, x, y)

        return 0
