from struct import pack, unpack

from network.packet.PacketWriter import *


class PingHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 4:  # Avoid handling empty ping packet
            socket.sendall(PacketWriter.get_packet(OpCode.SMSG_PONG, reader.data))

        return 0
