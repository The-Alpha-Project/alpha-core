from game.world.opcode_handling.HandlerValidator import HandlerValidator
from network.packet.PacketReader import PacketReader


class DuelCanceledHandler(object):

    @staticmethod
    def handle(world_session, reader: PacketReader) -> int:
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode, disconnect=True)
        if not player_mgr:
            return res

        # You can trigger cancel by using /yield without being in a duel.
        if player_mgr.duel_manager:
            player_mgr.duel_manager.handle_duel_canceled(player_mgr)

        return 0
