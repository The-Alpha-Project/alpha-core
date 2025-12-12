from game.world.opcode_handling.HandlerValidator import HandlerValidator
from network.packet.PacketReader import *


class RepopRequestHandler:

    @staticmethod
    def handle(world_session, reader: PacketReader) -> int:
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode, disconnect=True)
        if not player_mgr:
            return res

        # Ignore if player is update locked or already alive.
        if player_mgr.update_lock or player_mgr.is_alive:
            return 0

        player_mgr.resurrect(release_spirit=True)

        return 0
