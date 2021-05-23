from network.packet.PacketReader import *
from network.packet.PacketWriter import *


class PlayedTimeHandler(object):

    @staticmethod
    def handle(world_session, socket: int, reader: PacketReader) -> int:
        # In seconds
        data: bytes = pack('<2I',
                    int(world_session.player_mgr.player.totaltime),
                    int(world_session.player_mgr.player.leveltime))
        world_session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_PLAYED_TIME, data))

        return 0
