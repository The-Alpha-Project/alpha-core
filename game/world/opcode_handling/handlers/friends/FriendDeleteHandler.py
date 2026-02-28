from game.world.opcode_handling.HandlerValidator import HandlerValidator
from network.packet.PacketReader import *


class FriendDeleteHandler:

    @staticmethod
    def handle(world_session, reader):
        # Avoid handling an empty friend delete packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=8):
            return 0
        guid = unpack('<Q', reader.data[:8])[0]
        world_session.player_mgr.friends_manager.remove_friend(guid)

        return 0
