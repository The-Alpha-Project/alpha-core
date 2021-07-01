from struct import unpack


class ZoneUpdateHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 4:  # Avoid handling empty zone update packet.
            zone = unpack('<I', reader.data[:4])[0]
            player_mgr = world_session.player_mgr
            player_mgr.zone = zone

            # Exploration handling.
            world_session.player_mgr.check_update_zone()

            # Update friends and group.
            player_mgr.friends_manager.send_update_to_friends()
            if player_mgr.group_manager:
                player_mgr.group_manager.send_update()

        return 0
