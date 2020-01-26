from struct import pack, unpack

from network.packet.PacketWriter import *


class PingHandler(object):

    @staticmethod
    def handle(socket, packet):
        ping_data = unpack(
            '<I', packet[6:]
        )
        fmt = PacketWriter.get_packet_header_format(OpCode.SMSG_PONG) + 'L'
        header = PacketWriter.get_packet_header(OpCode.SMSG_PONG, fmt)
        packet = pack(
            fmt,
            header[0],
            header[1],
            header[2],
            header[3],
            header[4],
            header[5],
            ping_data[0]
        )
        socket.sendall(packet)
