from game.world.opcode_handling.HandlerValidator import HandlerValidator
from network.packet.PacketReader import *


class FriendIgnoreHandler:

    @staticmethod
    def handle(world_session, reader):
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode)
        if not player_mgr:
            return res
        # Avoid handling an empty or truncated packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=1):
            return 0

        target_name = PacketReader.read_string(reader.data, 0).strip()
        player_mgr.friends_manager.try_add_ignore(target_name)

        return 0
