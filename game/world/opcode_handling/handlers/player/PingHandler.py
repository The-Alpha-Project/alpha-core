from network.packet.PacketReader import *
from network.packet.PacketWriter import *


class PingHandler(object):

    @staticmethod
    def handle(world_session, reader: PacketReader) -> int:
        if len(reader.data) >= 4:  # Avoid handling empty ping packet.
            world_session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_PONG, reader.data))

        return 0
