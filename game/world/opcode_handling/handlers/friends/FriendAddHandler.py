from database.realm.RealmDatabaseManager import RealmDatabaseManager
from game.world.WorldSessionStateHandler import WorldSessionStateHandler
from game.world.managers.objects.units.player.FriendsManager import FriendsManager
from game.world.managers.objects.units.player.PlayerManager import PlayerManager
from network.packet.PacketReader import *
from network.packet.PacketWriter import *
from utils.constants.MiscCodes import FriendResults


class FriendAddHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        target_name = PacketReader.read_string(reader.data, 0).strip()
        world_session.player_mgr.friends_manager.try_add_friend(target_name)

        return 0
