from network.packet.PacketReader import *
from network.packet.PacketWriter import *
from utils.constants.ObjectCodes import FriendResults
from game.world.WorldSessionStateHandler import WorldSessionStateHandler


class FriendIgnoreHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        target_name = PacketReader.read_string(reader.data, 0).strip()
        target_player_mgr = WorldSessionStateHandler.find_player_by_name(target_name)

        if not target_player_mgr:
            data = pack('<B', FriendResults.FRIEND_NOT_FOUND)
            world_session.player_mgr.session.request.sendall(PacketWriter.get_packet(OpCode.SMSG_FRIEND_STATUS, data))
        elif world_session.player_mgr.guid == target_player_mgr.guid:
            data = pack('<B', FriendResults.FRIEND_IGNORE_SELF)
            world_session.player_mgr.session.request.sendall(PacketWriter.get_packet(OpCode.SMSG_FRIEND_STATUS, data))
        elif world_session.player_mgr.friends_manager.has_ignore(target_player_mgr):
            data = pack('<B', FriendResults.FRIEND_IGNORE_ALREADY)
            world_session.player_mgr.session.request.sendall(PacketWriter.get_packet(OpCode.SMSG_FRIEND_STATUS, data))
        else:
            world_session.player_mgr.friends_manager.add_ignore(target_player_mgr)

        return 0
