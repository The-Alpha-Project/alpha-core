from network.packet.PacketReader import *
from network.packet.PacketWriter import *
from utils.constants.ObjectCodes import FriendResults
from game.world.WorldSessionStateHandler import WorldSessionStateHandler


class FriendDeleteIgnoreHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 8:
            guid = unpack('<Q', reader.data[:8])[0]
            target_player_mgr = WorldSessionStateHandler.find_player_by_guid(guid)

            if not target_player_mgr:
                data = pack('<B', FriendResults.FRIEND_IGNORE_NOT_FOUND)
                world_session.player_mgr.session.request.sendall(PacketWriter.get_packet(OpCode.SMSG_FRIEND_STATUS, data))
            elif not world_session.player_mgr.friends_manager.has_ignore(target_player_mgr):
                data = pack('<B', FriendResults.FRIEND_IGNORE_NOT_FOUND)
                world_session.player_mgr.session.request.sendall(PacketWriter.get_packet(OpCode.SMSG_FRIEND_STATUS, data))
            else:
                world_session.player_mgr.friends_manager.remove_ignore(target_player_mgr)

        return 0