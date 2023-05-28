import time

from network.packet.PacketWriter import *
from utils.constants.OpCodes import OpCode


class TimeQueryHandler(object):

    @staticmethod
    def handle(world_session, reader):
        seconds = int(time.time())
        data = pack('<I', seconds)
        world_session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_QUERY_TIME_RESPONSE, data))

        return 0
