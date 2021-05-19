from struct import unpack

from game.world.managers.maps.MapManager import MapManager


class ZoneUpdateHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 4:  # Avoid handling empty zone update packet.
            zone = unpack('<I', reader.data[:4])[0]
            player = world_session.player_mgr

            # Update player zone if needed by using map files.
            zone = MapManager.find_zone_by_location(player.location.x, player.location.y, player.map_)
            if zone:
                world_session.player_mgr.zone = zone
            
            world_session.player_mgr.friends_manager.send_update_to_friends()
            if world_session.player_mgr.group_manager:
                world_session.player_mgr.group_manager.send_update()

        return 0
