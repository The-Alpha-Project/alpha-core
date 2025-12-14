from game.world.opcode_handling.HandlerValidator import HandlerValidator
from network.packet.PacketReader import *
from network.packet.PacketWriter import *


class PlayedTimeHandler:

    @staticmethod
    def handle(world_session, reader: PacketReader) -> int:
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode, disconnect=True)
        if not player_mgr:
            return res

        # In seconds
        data = pack('<2I',
                    int(player_mgr.player.totaltime),
                    int(player_mgr.player.leveltime))
        player_mgr.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_PLAYED_TIME, data))

        return 0
