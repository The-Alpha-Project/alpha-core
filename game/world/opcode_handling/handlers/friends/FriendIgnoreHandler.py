from network.packet.PacketReader import *
from network.packet.PacketWriter import *
from utils.constants.ObjectCodes import FriendResults
from game.world.WorldSessionStateHandler import WorldSessionStateHandler
from database.realm.RealmDatabaseManager import RealmDatabaseManager


class FriendIgnoreHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        target_name = PacketReader.read_string(reader.data, 0).strip()
        online_player = WorldSessionStateHandler.find_player_by_name(target_name)
        offline_player = None
        friend_result_error = None

        # Try to pull the character from DB.
        if not online_player:
            offline_player = RealmDatabaseManager.character_get_by_name(target_name)

        target_guid = online_player.guid if online_player else offline_player.guid if offline_player else None

        if not online_player and not offline_player:
            friend_result_error = FriendResults.FRIEND_NOT_FOUND
        elif world_session.player_mgr.guid == target_guid:
            friend_result_error = FriendResults.FRIEND_IGNORE_SELF
        elif world_session.player_mgr.friends_manager.has_ignore(target_guid):
            friend_result_error = FriendResults.FRIEND_IGNORE_ALREADY

        if not friend_result_error:
            world_session.player_mgr.friends_manager.add_ignore(target_guid)
        else:
            data = pack('<B', friend_result_error)
            world_session.player_mgr.session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_FRIEND_STATUS, data))

        return 0
