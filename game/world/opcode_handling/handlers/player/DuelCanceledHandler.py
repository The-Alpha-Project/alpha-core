from game.world.opcode_handling.HandlerValidator import HandlerValidator
from network.packet.PacketReader import PacketReader
from utils.Logger import Logger


class DuelCanceledHandler(object):

    @staticmethod
    def handle(world_session, reader: PacketReader) -> int:
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode, disconnect=True)
        if not player_mgr:
            return res

        # You can trigger cancel by using /yield without being in a duel.
        duel_arbiter = player_mgr.get_duel_arbiter()
        if duel_arbiter:
            duel_arbiter.handle_duel_canceled(player_mgr)
        else:
            Logger.warning(f'Unable to locate duel arbiter. {reader.opcode_str()}')

        return 0
