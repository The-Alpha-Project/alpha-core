from game.world.opcode_handling.HandlerValidator import HandlerValidator
from network.packet.PacketReader import PacketReader


class DuelAcceptHandler(object):

    @staticmethod
    def handle(world_session, reader: PacketReader) -> int:
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode, disconnect=True)
        if not player_mgr:
            return res

        if player_mgr.duel_manager:  # Ignore accept from duel-sender
            player_mgr.duel_manager.handle_duel_accept(player_mgr)

        return 0
