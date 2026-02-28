from game.world.opcode_handling.HandlerValidator import HandlerValidator
from struct import unpack


class ZoneUpdateHandler:

    @staticmethod
    def handle(world_session, reader):
        # TODO: Seems like this packet is not being *always* sent on zone change, investigate why to see if we are doing
        #  something wrong or it's just a client issue. A really hacky solution would be to implement a timer to check
        #  every X seconds if the zone has changed.
        # Avoid handling an empty zone update packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=4):
            return 0
        zone = unpack('<I', reader.data[:4])[0]
        world_session.player_mgr.on_zone_change(zone)

        return 0
