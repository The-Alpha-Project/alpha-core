from struct import pack, unpack
import time

from network.packet.PacketWriter import *


class TimeQueryHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        seconds = int(time.time())
        data = pack('<I', seconds)
        world_session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_QUERY_TIME_RESPONSE, data))

        return 0
