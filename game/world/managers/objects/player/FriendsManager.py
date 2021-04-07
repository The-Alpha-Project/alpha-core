from struct import pack
from game.world.WorldSessionStateHandler import WorldSessionStateHandler
from network.packet.PacketWriter import PacketWriter, OpCode
from utils.constants.ObjectCodes import FriendResults


class FriendsManager(object):

    def __init__(self, owner):
        self.friends = {}  # Should be DB R/W
        self.ignores = {}  # Should be DB R/W
        self.owner = owner

    def add_friend(self, player_mgr):
        if player_mgr.guid not in self.friends:
            self.friends[player_mgr.guid] = player_mgr.guid  # Err, need a hashset or something.

            status = FriendResults.FRIEND_ADDED_ONLINE if player_mgr.is_online else FriendResults.FRIEND_ADDED_OFFLINE
            data = pack('<BQ', status, player_mgr.guid)

            if status == FriendResults.FRIEND_ADDED_ONLINE:
                data += pack('<B3I', 1, player_mgr.zone, player_mgr.level, player_mgr.player.class_)

            self.owner.session.request.sendall(PacketWriter.get_packet(OpCode.SMSG_FRIEND_STATUS, data))
            self.send_friends()

    def remove_friend(self, player_mgr):
        if player_mgr.guid in self.friends:
            self.friends.pop(player_mgr.guid)
            data = pack('<BQ', FriendResults.FRIEND_REMOVED, player_mgr.guid)
            self.owner.session.request.sendall(PacketWriter.get_packet(OpCode.SMSG_FRIEND_STATUS, data))
            self.send_friends()

    def remove_ignore(self, player_mgr):
        if player_mgr.guid in self.ignores:
            self.ignores.pop(player_mgr.guid)
            data = pack('<BQ', FriendResults.FRIEND_IGNORE_REMOVED, player_mgr.guid)
            self.owner.session.request.sendall(PacketWriter.get_packet(OpCode.SMSG_FRIEND_STATUS, data))
            self.send_ignores()

    def has_friend(self, player_mgr):
        return player_mgr.guid in self.friends

    def has_ignore(self, player_mgr):
        return player_mgr.guid in self.ignores

    # TODO: Ignore also affects duel, mail, lfg and channels.
    def add_ignore(self, player_mgr):
        if player_mgr.guid not in self.ignores:
            self.ignores[player_mgr.guid] = player_mgr.guid
            data = pack('<BQ', FriendResults.FRIEND_IGNORE_ADDED, player_mgr.guid)
            packet = PacketWriter.get_packet(OpCode.SMSG_FRIEND_STATUS, data)
            self.owner.session.request.sendall(packet)
            self.send_ignores()

    def send_friends(self):
        data = pack('<B', len(self.friends))

        for friend in self.friends:
            player_mgr = WorldSessionStateHandler.find_player_by_guid(friend)
            if player_mgr:
                data += pack('<QB3I', player_mgr.guid, 1, player_mgr.zone, player_mgr.level, player_mgr.player.class_)

        packet = PacketWriter.get_packet(OpCode.SMSG_FRIEND_LIST, data)
        self.owner.session.request.sendall(packet)

    def send_ignores(self):
        data = pack('<B', len(self.ignores))

        for ignore in self.ignores.values():
            player_mgr = WorldSessionStateHandler.find_player_by_guid(ignore)
            if player_mgr:
                data += pack('<Q', player_mgr.guid)

        packet = PacketWriter.get_packet(OpCode.SMSG_IGNORE_LIST, data)
        self.owner.session.request.sendall(packet)

    def send_friends_and_ignores(self):
        self.send_friends()
        self.send_ignores()

    # This should be called OnLogin player event, once we can fill from DB
    def send_online_notification(self):
        for friend in self.friends:
            player_mgr = WorldSessionStateHandler.find_player_by_guid(friend)
            if player_mgr:
                data = pack('<BQB3I', FriendResults.FRIEND_ONLINE, self.owner.guid, 1, self.owner.zone, self.owner.level,
                            self.owner.player.class_)
                packet = PacketWriter.get_packet(OpCode.SMSG_FRIEND_STATUS, data)
                player_mgr.session.request.sendall(packet)

    def send_offline_notification(self):
        for friend in self.friends:
            player_mgr = WorldSessionStateHandler.find_player_by_guid(friend)
            if player_mgr:
                data = pack('<BQB', FriendResults.FRIEND_OFFLINE, self.owner.guid, 0)
                packet = PacketWriter.get_packet(OpCode.SMSG_FRIEND_STATUS, data)
                player_mgr.session.request.sendall(packet)

    # OnLevelUp, ZoneChange, Etc, update self on our friends lists.
    def send_update_to_friends(self):
        for friend in self.friends:
            player_mgr = WorldSessionStateHandler.find_player_by_guid(friend)
            if player_mgr and player_mgr.friends_manager:
                player_mgr.friends_manager.send_friends()
