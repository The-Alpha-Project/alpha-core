from struct import pack

from database.realm.RealmDatabaseManager import RealmDatabaseManager
from database.realm.RealmModels import CharacterSocial
from game.world.WorldSessionStateHandler import WorldSessionStateHandler
from game.world.managers.maps.MapManager import MapManager
from game.world.opcode_handling.handlers.player.NameQueryHandler import NameQueryHandler
from network.packet.PacketWriter import PacketWriter, OpCode
from utils.constants.MiscCodes import FriendResults, FriendStatus


class FriendsManager(object):

    # TODO: These values are from 1.12.1, confirm if they are the same for 0.5.3.
    MAX_FRIEND_LIMIT = 50
    MAX_IGNORE_LIMIT = 25

    def __init__(self, owner):
        self.owner = owner
        self.friends: dict[int, CharacterSocial] = {}

    def load_from_db(self, character_social_list):
        if character_social_list:
            for entry in character_social_list:
                self.friends[entry.friend] = entry

    def try_add_friend(self, target_name):
        online_player = WorldSessionStateHandler.find_player_by_name(target_name)
        target_guid = 0
        target_team = 0

        # Try to pull the character from DB.
        if not online_player:
            offline_player = RealmDatabaseManager.character_get_by_name(target_name)
            if offline_player:
                target_guid = offline_player.guid
                from game.world.managers.objects.units.player.PlayerManager import PlayerManager
                target_team = PlayerManager.get_team_for_race(offline_player.race)
                status = FriendResults.FRIEND_ADDED_OFFLINE
            else:
                status = FriendResults.FRIEND_NOT_FOUND
        else:
            target_guid = online_player.guid
            target_team = online_player.team
            status = FriendResults.FRIEND_ADDED_ONLINE

        if status != FriendResults.FRIEND_NOT_FOUND:
            if self.owner.team != target_team:
                status = FriendResults.FRIEND_ENEMY
            elif self.owner.guid == target_guid:
                status = FriendResults.FRIEND_SELF
            elif self.owner.friends_manager.has_friend(target_guid):
                status = FriendResults.FRIEND_ALREADY
            elif self.count_friends() >= FriendsManager.MAX_FRIEND_LIMIT:
                status = FriendResults.FRIEND_LIST_FULL

            # No error, proceed to add friend to the list.
            if status == FriendResults.FRIEND_ADDED_ONLINE or status == FriendResults.FRIEND_ADDED_OFFLINE:
                if self.has_ignore(target_guid):
                    self.friends[target_guid].ignore = False
                    RealmDatabaseManager.character_update_social(self.friends[target_guid])
                    data = pack('<BQ', FriendResults.FRIEND_IGNORE_REMOVED, target_guid)
                    self.owner.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_FRIEND_STATUS, data))
                else:
                    self.friends[target_guid] = self._create_friend(target_guid)
                    RealmDatabaseManager.character_add_friend(self.friends[target_guid])

        data = pack('<BQ', status, target_guid)
        self.owner.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_FRIEND_STATUS, data))

    def _create_friend(self, player_guid, ignored=False):
        friend = CharacterSocial()
        friend.guid = self.owner.guid
        friend.friend = player_guid
        friend.ignore = ignored
        return friend

    def remove_friend(self, player_guid):
        if self.has_friend(player_guid):
            status = FriendResults.FRIEND_REMOVED
            RealmDatabaseManager.character_social_delete_friend(self.friends[player_guid])
            self.friends.pop(player_guid)
        else:
            status = FriendResults.FRIEND_NOT_FOUND

        data = pack('<BQ', status, player_guid)
        self.owner.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_FRIEND_STATUS, data))

    def remove_ignore(self, player_guid):
        if self.has_ignore(player_guid):
            status = FriendResults.FRIEND_IGNORE_REMOVED
            RealmDatabaseManager.character_social_delete_friend(self.friends[player_guid])
            self.friends.pop(player_guid)
        else:
            status = FriendResults.FRIEND_IGNORE_NOT_FOUND

        data = pack('<BQ', status, player_guid)
        self.owner.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_FRIEND_STATUS, data))

    def count_friends(self):
        return len([friend for friend in self.friends.values() if friend.ignore == 0])

    def count_ignored(self):
        return len([friend for friend in self.friends.values() if friend.ignore > 0])

    def has_friend(self, player_guid):
        return player_guid in self.friends and self.friends[player_guid].ignore == 0

    def has_ignore(self, player_guid):
        return player_guid in self.friends and self.friends[player_guid].ignore > 0

    # TODO: Ignore also affects duel
    def try_add_ignore(self, target_name):
        online_player = WorldSessionStateHandler.find_player_by_name(target_name)
        target_guid = 0

        # Try to pull the character from DB.
        if not online_player:
            offline_player = RealmDatabaseManager.character_get_by_name(target_name)
            if offline_player:
                target_guid = offline_player.guid
                status = FriendResults.FRIEND_IGNORE_ADDED
            else:
                status = FriendResults.FRIEND_IGNORE_NOT_FOUND
        else:
            target_guid = online_player.guid
            status = FriendResults.FRIEND_IGNORE_ADDED

        if status != FriendResults.FRIEND_IGNORE_NOT_FOUND:
            if self.owner.guid == target_guid:
                status = FriendResults.FRIEND_IGNORE_SELF
            elif self.owner.friends_manager.has_ignore(target_guid):
                status = FriendResults.FRIEND_IGNORE_ALREADY
            elif self.count_ignored() >= FriendsManager.MAX_IGNORE_LIMIT:
                status = FriendResults.FRIEND_IGNORE_FULL

            # No error, proceed to add ignored player to the list.
            if status == FriendResults.FRIEND_IGNORE_ADDED:
                if self.has_friend(target_guid):
                    self.friends[target_guid].ignore = True
                    RealmDatabaseManager.character_update_social(self.friends[target_guid])
                    data = pack('<BQ', FriendResults.FRIEND_REMOVED, target_guid)
                    self.owner.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_FRIEND_STATUS, data))
                else:
                    self.friends[target_guid] = self._create_friend(target_guid, ignored=True)
                    RealmDatabaseManager.character_add_friend(self.friends[target_guid])

        data = pack('<BQ', status, target_guid)
        self.owner.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_FRIEND_STATUS, data))

    def send_friends_and_ignores(self):
        self.send_friends()
        self.send_ignores()

    def send_friends(self):
        friends_list = [f for f in self.friends.values() if f.ignore == 0]
        data = pack('<B', len(friends_list))

        for entry in friends_list:
            player_mgr = WorldSessionStateHandler.find_player_by_guid(entry.friend)
            # If player is online.
            if player_mgr and player_mgr.online:
                self.owner.enqueue_packet(NameQueryHandler.get_query_details(player_mgr.player))
                data += pack(
                    '<QB3I',
                    player_mgr.guid,
                    FriendStatus.FRIEND_STATUS_ONLINE,
                    MapManager.get_parent_zone_id(player_mgr.zone, player_mgr.map_id),
                    player_mgr.level,
                    player_mgr.class_
                )
            # If player is offline.
            else:
                data += pack('QB', entry.friend, FriendStatus.FRIEND_STATUS_OFFLINE)

        packet = PacketWriter.get_packet(OpCode.SMSG_FRIEND_LIST, data)
        self.owner.enqueue_packet(packet)

    def send_ignores(self):
        ignore_list = [f for f in self.friends.values() if f.ignore > 0]
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
                    FriendStatus.FRIEND_STATUS_ONLINE,
                    MapManager.get_parent_zone_id(self.owner.zone, self.owner.map_id),
                    self.owner.level,
                    self.owner.class_
                )
                packet = PacketWriter.get_packet(OpCode.SMSG_FRIEND_STATUS, data)
                player_mgr.enqueue_packet(packet)

    def send_offline_notification(self):
        have_me_as_friend = RealmDatabaseManager.character_get_friends_of(self.owner.guid)
        for friend in have_me_as_friend:
            player_mgr = WorldSessionStateHandler.find_player_by_guid(friend.guid)
            if player_mgr and not player_mgr.friends_manager.has_ignore(self.owner.guid):
                data = pack('<BQB', FriendResults.FRIEND_OFFLINE, self.owner.guid, FriendStatus.FRIEND_STATUS_OFFLINE)
                packet = PacketWriter.get_packet(OpCode.SMSG_FRIEND_STATUS, data)
                player_mgr.enqueue_packet(packet)

    def send_update_to_friends(self):
        have_me_as_friend = RealmDatabaseManager.character_get_friends_of(self.owner.guid)
        for friend in have_me_as_friend:
            player_mgr = WorldSessionStateHandler.find_player_by_guid(friend.guid)
            if player_mgr:
                player_mgr.friends_manager.send_friends()
