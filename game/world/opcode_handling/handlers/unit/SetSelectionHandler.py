from game.world.opcode_handling.HandlerValidator import HandlerValidator
from struct import unpack


class SetSelectionHandler:

    @staticmethod
    def handle(world_session, reader):
        # Avoid handling an empty set selection packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=8):
            return 0
        guid = unpack('<Q', reader.data[:8])[0]
        if world_session.player_mgr and world_session.player_mgr.current_selection != guid:
            world_session.player_mgr.set_current_selection(guid)

        return 0
