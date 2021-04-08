from network.packet.PacketReader import *
from network.packet.PacketWriter import *
from utils.constants.ObjectCodes import FriendResults
from game.world.WorldSessionStateHandler import WorldSessionStateHandler


class FriendDeleteHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 8:  # Avoid handling empty friend delete packet
            guid = unpack('<Q', reader.data[:8])[0]
            target_player_mgr = WorldSessionStateHandler.find_player_by_guid(guid)
            friend_result = None

            if not target_player_mgr:
                friend_result = FriendResults.FRIEND_NOT_FOUND
            elif not world_session.player_mgr.friends_manager.has_friend(target_player_mgr):
                friend_result = FriendResults.FRIEND_NOT_FOUND

            if not friend_result:
                world_session.player_mgr.friends_manager.remove_friend(target_player_mgr)
            else:
                data = pack('<B', friend_result)
                world_session.player_mgr.session.request.sendall(PacketWriter.get_packet(OpCode.SMSG_FRIEND_STATUS, data))

        return 0
