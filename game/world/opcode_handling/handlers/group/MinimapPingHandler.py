from game.world.opcode_handling.HandlerValidator import HandlerValidator
from struct import unpack


class MinimapPingHandler:

    @staticmethod
    def handle(world_session, reader):
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode)
        if not player_mgr:
            return res

        # Avoid handling an empty minimap ping packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=8):
            return 0
        x, y = unpack('<2f', reader.data[:8])
        group_manager = player_mgr.group_manager

        if not group_manager:
            return 0

        group_manager.send_minimap_ping(player_mgr.guid, x, y)

        return 0
