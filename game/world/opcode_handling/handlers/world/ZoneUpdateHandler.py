from struct import unpack


class ZoneUpdateHandler(object):

    @staticmethod
    def handle(world_session, reader):
        # TODO: Seems like this packet is not being *always* sent on zone change, investigate why to see if we are doing
        #  something wrong or it's just a client issue. A really hacky solution would be to implement a timer to check
        #  every X seconds if the zone has changed.
        if len(reader.data) >= 4:  # Avoid handling empty zone update packet.
            zone = unpack('<I', reader.data[:4])[0]
            world_session.player_mgr.on_zone_change(zone)

        return 0
