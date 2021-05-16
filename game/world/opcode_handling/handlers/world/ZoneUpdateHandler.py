from struct import unpack


class ZoneUpdateHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 4:  # Avoid handling empty zone update packet.
            zone = unpack('<I', reader.data[:4])[0]
            world_session.player_mgr.zone = zone
            world_session.player_mgr.friends_manager.send_update_to_friends()
            if world_session.player_mgr.group_manager:
                world_session.player_mgr.group_manager.send_update()

        return 0
