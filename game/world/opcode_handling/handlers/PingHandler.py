from struct import pack, unpack

from network.packet.PacketWriter import *


class PingHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        ping_data = unpack('<I', reader.data)[0]
        data = pack('<L', ping_data)
        socket.sendall(PacketWriter.get_packet(OpCode.SMSG_PONG, data))

        return 0
