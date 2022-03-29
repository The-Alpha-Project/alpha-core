from network.packet.PacketReader import *
from network.packet.PacketWriter import *
from utils.constants.MiscCodes import FriendResults


class FriendDeleteIgnoreHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 8:  # Avoid handling empty friend delete ignore packet.
            guid = unpack('<Q', reader.data[:8])[0]
            if world_session.player_mgr.friends_manager.has_friend(guid):
                world_session.player_mgr.friends_manager.remove_ignore(guid)
            else:
                data = pack('<B', FriendResults.FRIEND_NOT_FOUND)
                world_session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_FRIEND_STATUS, data))

        return 0
