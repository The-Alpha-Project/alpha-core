from game.world.opcode_handling.HandlerValidator import HandlerValidator
import time

from network.packet.PacketReader import *
from network.packet.PacketWriter import *


class PingHandler:

    @staticmethod
    def handle(world_session, reader: PacketReader) -> int:
        # Avoid handling an empty ping packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=4):
            return 0
        if world_session.player_mgr and world_session.player_mgr.online:
            world_session.player_mgr.last_ping = time.time()
            world_session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_PONG, reader.data))

        return 0
