from game.world.opcode_handling.HandlerValidator import HandlerValidator
from network.packet.PacketReader import *


class PlayerLogoutHandler(object):

    @staticmethod
    def handle(world_session, reader: PacketReader) -> int:
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode, disconnect=True)
        if not player_mgr:
            return res

        player_mgr.logout()

        return 0
