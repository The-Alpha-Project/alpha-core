from struct import pack, unpack

from network.packet.PacketWriter import *


class PlayedTimeHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        # In seconds
        data = pack('<2I',
                    int(world_session.player_mgr.player.totaltime),
                    int(world_session.player_mgr.player.leveltime))
        world_session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_PLAYED_TIME, data))

        return 0
