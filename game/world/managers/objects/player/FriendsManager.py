from struct import pack

from database.realm.RealmDatabaseManager import RealmDatabaseManager
from database.realm.RealmModels import CharacterSocial
from game.world.WorldSessionStateHandler import WorldSessionStateHandler
from game.world.managers.maps.MapManager import MapManager
from game.world.opcode_handling.handlers.player.NameQueryHandler import NameQueryHandler
from network.packet.PacketWriter import PacketWriter, OpCode
from utils.constants.MiscCodes import FriendResults


class FriendsManager(object):

    def __init__(self, owner):
        self.owner = owner
        self.friends = {}

    def load_from_db(self, character_social):
        if character_social:
            for entry in character_social:
                self.friends[entry.friend] = entry

    def add_friend(self, player_guid):
        if player_guid not in self.friends:
            self.friends[player_guid] = self._create_friend(player_guid)
            player_mgr = WorldSessionStateHandler.find_player_by_guid(player_guid)
            RealmDatabaseManager.character_add_friend(self.friends[player_guid])
            status = FriendResults.FRIEND_ADDED_ONLINE if player_mgr else FriendResults.FRIEND_ADDED_OFFLINE
            data = pack('<BQ', status, player_guid)

            if player_mgr and player_mgr.online:  # Player is online.
                data += pack(
                    '<B3I',
                    1,  # Online
                    MapManager.get_parent_zone_id(player_mgr.zone, player_mgr.map_),
                    player_mgr.level,
                    player_mgr.player.class_
                )
            self.owner.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_FRIEND_STATUS, data))
            self.send_friends()

    def _create_friend(self, player_guid, ignored=False):
        friend = CharacterSocial()
        friend.guid = self.owner.guid
        friend.friend = player_guid
        friend.ignore = ignored
        return friend

    def remove_friend(self, player_guid):
        if player_guid in self.friends:
            RealmDatabaseManager.character_social_delete_friend(self.friends[player_guid])
            self.friends.pop(player_guid)
            data = pack('<BQ', FriendResults.FRIEND_REMOVED, player_guid)
            self.owner.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_FRIEND_STATUS, data))
            self.send_friends()

    def remove_ignore(self, player_guid):
        if player_guid in self.friends:
            RealmDatabaseManager.character_social_delete_friend(self.friends[player_guid])
            self.friends.pop(player_guid)
            data = pack('<BQ', FriendResults.FRIEND_IGNORE_REMOVED, player_guid)
            self.owner.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_FRIEND_STATUS, data))
            self.send_ignores()

    def has_friend(self, player_guid):
        return player_guid in self.friends

    def has_ignore(self, player_guid):
        return player_guid in self.friends and self.friends[player_guid].ignore > 0

    # TODO: Ignore also affects duel
    def add_ignore(self, player_guid):
        if player_guid not in self.friends:
            self.friends[player_guid] = self._create_friend(player_guid, ignored=True)
            RealmDatabaseManager.character_add_friend(self.friends[player_guid])
        else:
            self.friends[player_guid].ignore = True
            RealmDatabaseManager.character_update_social([self.friends[player_guid]])

        data = pack('<BQ', FriendResults.FRIEND_IGNORE_ADDED, player_guid)
        packet = PacketWriter.get_packet(OpCode.SMSG_FRIEND_STATUS, data)
        self.owner.enqueue_packet(packet)
        self.send_ignores()

    def send_friends_and_ignores(self):
        self.send_friends()
        self.send_ignores()

    def send_friends(self):
        friends_list = [f for f in self.friends.values() if not f.ignore]
        data = pack('<B', len(friends_list))

        for entry in friends_list:
            player_mgr = WorldSessionStateHandler.find_player_by_guid(entry.friend)
            if player_mgr and player_mgr.online:
                self.owner.enqueue_packet(NameQueryHandler.get_query_details(player_mgr.player))
                data += pack(
                    '<QB3I',
                    player_mgr.guid,
                    1,  # Online
                    MapManager.get_parent_zone_id(player_mgr.zone, player_mgr.map_),
                    player_mgr.level,
                    player_mgr.player.class_
                )
            else:
                data += pack('QB', entry.friend, 0)  # Offline

        packet = PacketWriter.get_packet(OpCode.SMSG_FRIEND_LIST, data)
        self.owner.enqueue_packet(packet)

    def send_ignores(self):
        ignore_list = [f for f in self.friends.values() if f.ignore]
        data = pack('<B', len(ignore_list))

        for entry in ignore_list:
            data += pack('<Q', entry.friend)  # Ignored player guid.

        packet = PacketWriter.get_packet(OpCode.SMSG_IGNORE_LIST, data)
        self.owner.enqueue_packet(packet)

    def send_online_notification(self):
        have_me_as_friend = RealmDatabaseManager.character_get_friends_of(self.owner.guid)
        for friend in have_me_as_friend:
            player_mgr = WorldSessionStateHandler.find_player_by_guid(friend.guid)
            if player_mgr and not player_mgr.friends_manager.has_ignore(self.owner.guid):
                data = pack(
                    '<BQB3I',
                    FriendResults.FRIEND_ONLINE,
                    self.owner.guid,
                    1,  # Online
                    MapManager.get_parent_zone_id(self.owner.zone, self.owner.map_),
                    self.owner.level,
                    self.owner.player.class_
                )
                packet = PacketWriter.get_packet(OpCode.SMSG_FRIEND_STATUS, data)
                player_mgr.enqueue_packet(packet)
                player_mgr.friends_manager.send_friends()

    def send_offline_notification(self):
        have_me_as_friend = RealmDatabaseManager.character_get_friends_of(self.owner.guid)
        for friend in have_me_as_friend:
            player_mgr = WorldSessionStateHandler.find_player_by_guid(friend.guid)
            if player_mgr and not player_mgr.friends_manager.has_ignore(self.owner.guid):
                data = pack('<BQB', FriendResults.FRIEND_OFFLINE, self.owner.guid, 0)
                packet = PacketWriter.get_packet(OpCode.SMSG_FRIEND_STATUS, data)
                player_mgr.enqueue_packet(packet)
                player_mgr.friends_manager.send_friends()

    def send_update_to_friends(self):
        have_me_as_friend = RealmDatabaseManager.character_get_friends_of(self.owner.guid)
        for friend in have_me_as_friend:
            player_mgr = WorldSessionStateHandler.find_player_by_guid(friend.guid)
            if player_mgr:
                player_mgr.friends_manager.send_friends()
