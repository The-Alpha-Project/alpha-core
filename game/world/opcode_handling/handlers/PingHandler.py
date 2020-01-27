from struct import pack, unpack

from network.packet.PacketWriter import *


class PingHandler(object):

    @staticmethod
    def handle(world_session, socket, packet):
        ping_data = unpack(
            '<I', packet
        )

        data = pack('!L', ping_data[0])
        socket.sendall(PacketWriter.get_packet(OpCode.SMSG_PONG, data))

        return 0
