from network.packet.PacketReader import *
from network.packet.PacketWriter import *
from utils.constants.ObjectCodes import FriendResults
from game.world.WorldSessionStateHandler import WorldSessionStateHandler


class FriendDeleteHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 8:  # Avoid handling empty friend delete packet
            guid = unpack('<Q', reader.data[:8])[0]
            if world_session.player_mgr.friends_manager.has_friend(guid):
                world_session.player_mgr.friends_manager.remove_friend(guid)
            else:
                data = pack('<B', FriendResults.FRIEND_NOT_FOUND)
                world_session.player_mgr.session.request.sendall(PacketWriter.get_packet(OpCode.SMSG_FRIEND_STATUS, data))

        return 0
