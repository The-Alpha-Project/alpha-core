from network.packet.PacketReader import *
from network.packet.PacketWriter import *
from utils.constants.ObjectCodes import FriendResults
from game.world.WorldSessionStateHandler import WorldSessionStateHandler


class FriendAddHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        target_name = PacketReader.read_string(reader.data, 0).strip()
        target_player_mgr = WorldSessionStateHandler.find_player_by_name(target_name)
        friend_result = None

        if not target_player_mgr:
            friend_result = FriendResults.FRIEND_NOT_FOUND
        elif world_session.player_mgr.team != target_player_mgr.team:
            friend_result = FriendResults.FRIEND_ENEMY
        elif world_session.player_mgr.guid == target_player_mgr.guid:
            friend_result = FriendResults.FRIEND_SELF
        elif world_session.player_mgr.friends_manager.has_friend(target_player_mgr):
            friend_result = FriendResults.FRIEND_ALREADY

        if not friend_result:
            world_session.player_mgr.friends_manager.add_friend(target_player_mgr)
        else:
            data = pack('<B', friend_result)
            world_session.player_mgr.session.request.sendall(PacketWriter.get_packet(OpCode.SMSG_FRIEND_STATUS, data))

        return 0
