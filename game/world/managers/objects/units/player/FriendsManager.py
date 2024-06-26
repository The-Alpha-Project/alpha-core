from struct import pack

from database.realm.RealmDatabaseManager import RealmDatabaseManager
from database.realm.RealmModels import CharacterSocial
from game.world.WorldSessionStateHandler import WorldSessionStateHandler
from game.world.opcode_handling.handlers.player.NameQueryHandler import NameQueryHandler
from network.packet.PacketWriter import PacketWriter
from utils.constants.MiscCodes import FriendResults, FriendStatus
from utils.constants.OpCodes import OpCode


class FriendsManager(object):

    # TODO: These values are from 1.12.1, confirm if they are the same for 0.5.3.
    MAX_FRIEND_LIMIT = 50
    MAX_IGNORE_LIMIT = 25

    def __init__(self, owner):
        self.owner = owner
        self.friends: dict[int, CharacterSocial] = {}
        self.ignored: dict[int, CharacterSocial] = {}

    def load_from_db(self, character_social_list):
        if character_social_list:
            for entry in character_social_list:
                if entry.ignore:
                    self.ignored[entry.other_guid] = entry
                else:
                    self.friends[entry.other_guid] = entry

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
                self.friends[target_guid] = self._create_social(target_guid)
                RealmDatabaseManager.character_add_social(self.friends[target_guid])

        data = pack('<BQ', status, target_guid)
        self.owner.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_FRIEND_STATUS, data))

    def _create_social(self, player_guid, ignored=False):
        character_social = CharacterSocial()
        character_social.guid = self.owner.guid
        character_social.other_guid = player_guid
        character_social.ignore = ignored
        return character_social

    def remove_friend(self, player_guid):
        if self.has_friend(player_guid):
            status = FriendResults.FRIEND_REMOVED
            RealmDatabaseManager.character_social_delete_social(self.friends[player_guid])
            self.friends.pop(player_guid)
        else:
            status = FriendResults.FRIEND_NOT_FOUND

        data = pack('<BQ', status, player_guid)
        self.owner.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_FRIEND_STATUS, data))

    def remove_ignore(self, player_guid):
        if self.has_ignore(player_guid):
            status = FriendResults.FRIEND_IGNORE_REMOVED
            RealmDatabaseManager.character_social_delete_social(self.ignored[player_guid])
            self.ignored.pop(player_guid)
        else:
            status = FriendResults.FRIEND_IGNORE_NOT_FOUND

        data = pack('<BQ', status, player_guid)
        self.owner.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_FRIEND_STATUS, data))

    def count_friends(self):
        return len(self.friends)

    def count_ignored(self):
        return len(self.ignored)

    def has_friend(self, player_guid):
        return player_guid in self.friends

    def has_ignore(self, player_guid):
        return player_guid in self.ignored

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
                self.ignored[target_guid] = self._create_social(target_guid, ignored=True)
                RealmDatabaseManager.character_add_social(self.ignored[target_guid])

        data = pack('<BQ', status, target_guid)
        self.owner.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_FRIEND_STATUS, data))

    def send_friends_and_ignores(self):
        self.send_friends()
        self.send_ignores()

    def send_friends(self):
        data = pack('<B', len(self.friends))

        for entry in self.friends.values():
            player_mgr = WorldSessionStateHandler.find_player_by_guid(entry.other_guid)
            # If player is offline.
            if not player_mgr or not player_mgr.online:
                data += pack('QB', entry.other_guid, FriendStatus.FRIEND_STATUS_OFFLINE)
                continue
            # If player is online.
            self.owner.enqueue_packet(NameQueryHandler.get_query_details(player_mgr.player))
            data += pack('<QB3I', player_mgr.guid, FriendStatus.FRIEND_STATUS_ONLINE,
                         player_mgr.get_map().get_parent_zone_id(player_mgr.zone), player_mgr.level, player_mgr.class_)

        packet = PacketWriter.get_packet(OpCode.SMSG_FRIEND_LIST, data)
        self.owner.enqueue_packet(packet)

    def send_ignores(self):
        data = pack('<B', len(self.ignored))

        for entry in self.ignored.values():
            data += pack('<Q', entry.other_guid)  # Ignored player guid.

        packet = PacketWriter.get_packet(OpCode.SMSG_IGNORE_LIST, data)
        self.owner.enqueue_packet(packet)

    def _get_online_notification_packet(self):
        data = pack(
            '<BQB3I',
            FriendResults.FRIEND_ONLINE,
            self.owner.guid,
            FriendStatus.FRIEND_STATUS_ONLINE,
            self.owner.get_map().get_parent_zone_id(self.owner.zone),
            self.owner.level,
            self.owner.class_
        )
        return PacketWriter.get_packet(OpCode.SMSG_FRIEND_STATUS, data)

    def _get_offline_notification_packet(self):
        data = pack(
            '<BQB',
            FriendResults.FRIEND_OFFLINE,
            self.owner.guid,
            FriendStatus.FRIEND_STATUS_OFFLINE
        )
        return PacketWriter.get_packet(OpCode.SMSG_FRIEND_STATUS, data)

    def _send_friend_notification_packet(self, packet_to_send):
        for player_social in RealmDatabaseManager.character_get_friends_of(self.owner.guid):
            player_mgr = WorldSessionStateHandler.find_player_by_guid(player_social.guid)
            if player_mgr:
                player_mgr.enqueue_packet(packet_to_send)

    def send_online_notification(self):
        self._send_friend_notification_packet(self._get_online_notification_packet())

    def send_offline_notification(self):
        self._send_friend_notification_packet(self._get_offline_notification_packet())

    def send_update_to_friends(self):
        for player_social in RealmDatabaseManager.character_get_friends_of(self.owner.guid):
            player_mgr = WorldSessionStateHandler.find_player_by_guid(player_social.guid)
            if player_mgr:
                player_mgr.friends_manager.send_friends()
