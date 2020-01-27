from struct import pack, unpack

from network.packet.PacketWriter import *


class CharEnumHandler(object):

    @staticmethod
    def handle(world_session, socket, packet):
        fmt = PacketWriter.get_packet_header_format(OpCode.SMSG_CHAR_ENUM) + 'B'
        header = PacketWriter.get_packet_header(OpCode.SMSG_CHAR_ENUM, fmt)
        packet = pack(
            fmt,
            header[0], header[1], header[2], header[3], header[4], header[5],
            0
        )
        socket.sendall(packet)

        return 0
