from struct import pack, unpack
import time

from network.packet.PacketWriter import *


class TimeQueryHandler(object):

    @staticmethod
    def handle(world_session, socket, packet):
        seconds = int(time.time())
        data = pack('<I', seconds)
        socket.sendall(PacketWriter.get_packet(OpCode.SMSG_QUERY_TIME_RESPONSE, data))

        return 0
