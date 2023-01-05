from struct import pack

from network.packet.PacketWriter import PacketWriter, OpCode
from utils.ConfigManager import config
from utils.Logger import Logger
from utils.constants.MiscCodes import ChannelNotifications, ChannelMemberFlags
from utils.constants.UnitCodes import Teams


class Channel(object):
    def __init__(self, name, members, password, is_default, owner, announce, moderators=None, banned=None, muted=None):
        self.name: str = name
        self.members: list = members
        self.password: str = password
        self.is_default: bool = is_default
        self.owner = owner
        self.announce: bool = announce
        self.moderated: bool = False
        self.moderators: list = moderators if moderators else []
        self.banned: list = banned if banned else []
        self.muted: list = muted if muted else []

    # Addon channels should always start with 'Addon' plus description. e.g. 'AddonAuras'.
    def is_addon(self):
        if not config.Server.General.enable_addons_chat_api:
            return False
        name = self.name.lower()
        return str.startswith(name, '_addon') and not name == '_addon'

    def members_count(self):
        return len(self.members)

    def get_members(self):
        return list(self.members)

    def set_password(self, password):
        self.password = password

    def password_ok(self, password):
        return self.password == password

    def should_announce(self):
        return self.announce

    def toggle_announce(self):
        self.announce = not self.announce

    def is_muted(self, player_mgr):
        return player_mgr in self.muted

    def mute(self, player_mgr):
        self.muted.append(player_mgr)

    def unmute(self, player_mgr):
        self.muted.remove(player_mgr)

    def is_banned(self, player_mgr):
        return player_mgr in self.banned

    def is_moderator(self, player_mgr):
        return player_mgr in self.moderators

    def set_owner(self, player_mgr):
        self.owner = player_mgr

    def is_owner(self, player_mgr):
        return self.owner == player_mgr

    def player_in_channel(self, player_mgr):
        return player_mgr in self.members

    def toggle_moderation(self):
        self.moderated = not self.moderated

    def is_moderated(self):
        return self.moderated

    def add_moderator(self, player_mgr):
        self.moderators.append(player_mgr)

    def remove_moderator(self, player_mgr):
        self.moderators.remove(player_mgr)

    def add_member(self, player_mgr):
        self.members.append(player_mgr)

    def remove_member(self, player_mgr):
        self.members.remove(player_mgr)

    def add_ban(self, player_mgr):
        self.banned.append(player_mgr)

    def remove_ban(self, player_mgr):
        self.banned.remove(player_mgr)

    def broadcast_to_channel(self, sender, packet, ignore=None):
        if self.is_muted(sender):
            packet = ChannelManager.build_notify_packet(self.name, ChannelNotifications.SELF_MUTED)
            ChannelManager.send_to_player(sender, packet)
            return

        for player in list(self.members):
            if ignore and player in ignore or player.friends_manager.has_ignore(sender.guid):
                continue
            player.enqueue_packet(packet)

    def get_channel_list_packet(self):
        name_bytes = PacketWriter.string_to_bytes(self.name)
        # TODO '0x3' Unknown 'channelflags', seems unused by client.
        data = pack(f'<{len(name_bytes)}sBI', name_bytes, 0x3, self.members_count())

        for member in list(self.members):
            data += pack('<Q', member.guid)
            mode = 0
            if self.is_muted(member):
                mode |= ChannelMemberFlags.VOICE
            if self.is_moderator(member) or self.is_owner(member):
                mode |= ChannelMemberFlags.MODERATOR
            data += pack('<B', mode)

        return PacketWriter.get_packet(OpCode.SMSG_CHANNEL_LIST, data)

    def flush(self):
        self.muted.clear()
        self.banned.clear()
        self.moderators.clear()
        self.members.clear()
        self.owner = None


class ChannelManager(object):
    # General and Trade channels weren't zone specific until Patch 0.5.5.
    DEFAULT_GENERAL = 'General'
    DEFAULT_TRADE = 'Trade'

    # Default channels.
    CHANNELS = {
        Teams.TEAM_ALLIANCE:
            {
                DEFAULT_GENERAL: Channel(DEFAULT_GENERAL, [], '', True, None, False),
                DEFAULT_TRADE: Channel(DEFAULT_TRADE, [], '', True, None, False)
            },
        Teams.TEAM_HORDE:
            {
                DEFAULT_GENERAL: Channel(DEFAULT_GENERAL, [], '', True, None, False),
                DEFAULT_TRADE: Channel(DEFAULT_TRADE, [], '', True, None, False)
            }
    }

    ADDON_CHANNELS = dict()

    @staticmethod
    def toggle_moderation(channel, sender):
        if not ChannelManager.default_checks(channel, sender, check_owner=True, check_moderator=True):
            return

        channel.toggle_moderation()

        flag = channel.is_moderated()
        notify = ChannelNotifications.MODERATION_ON if not flag else ChannelNotifications.MODERATION_OFF
        packet = ChannelManager.build_notify_packet(channel.name, notify, target1=sender)
        if channel.should_announce():
            channel.broadcast_to_channel(sender, packet)
        else:
            ChannelManager.send_to_player(sender, packet)

    @staticmethod
    def toggle_announce(channel, sender):
        if not ChannelManager.default_checks(channel, sender, check_owner=True, check_moderator=True):
            return

        channel.toggle_announce()

        flag = channel.should_announce()
        notify = ChannelNotifications.ANNOUNCEMENTS_ON if not flag else ChannelNotifications.ANNOUNCEMENTS_OFF
        packet = ChannelManager.build_notify_packet(channel.name, notify, target1=sender)
        if flag:
            channel.broadcast_to_channel(sender, packet)
        else:
            ChannelManager.send_to_player(sender, packet)

    @staticmethod
    def add_mute(channel, sender, target_player):
        if not ChannelManager.default_checks(channel.name, sender, check_owner=True, check_moderator=True,
                                             target_player=target_player):
            return
        if channel.is_muted(target_player):  # Already muted, ignore.
            return
        flags = [ChannelMemberFlags.VOICE, ChannelMemberFlags.OWNER]
        notification = ChannelNotifications.MEMBER_FLAG_CHANGE
        packet = ChannelManager.build_notify_packet(channel.name, notification, target_player, flags=flags)

        channel.mute(target_player)

        if channel.should_announce():
            channel.broadcast_to_channel(sender, packet)
        else:  # 1 on 1.
            ChannelManager.send_to_player(sender, packet)
            ChannelManager.send_to_player(target_player, packet)

    @staticmethod
    def remove_mute(channel, sender, target_player):
        if not ChannelManager.default_checks(channel, sender, check_owner=True, check_moderator=True,
                                             target_player=target_player):
            return
        if not channel.is_muted(target_player):  # Already not muted, ignore.
            return
        flags = [ChannelMemberFlags.OWNER, ChannelMemberFlags.VOICE]
        notification = ChannelNotifications.MEMBER_FLAG_CHANGE
        packet = ChannelManager.build_notify_packet(channel.name, notification, target_player, flags=flags)

        channel.unmute(target_player)

        if channel.should_announce():
            channel.broadcast_to_channel(sender, packet)
        else:  # 1 on 1.
            ChannelManager.send_to_player(sender, packet)
            ChannelManager.send_to_player(target_player, packet)

    @staticmethod
    def add_mod(channel, sender, target_player):
        if not ChannelManager.default_checks(channel, sender, check_owner=True, check_moderator=False,
                                             target_player=target_player):
            return
        if channel.is_moderator(target_player):  # Already mod, ignore.
            return
        flags = [ChannelMemberFlags.OWNER, ChannelMemberFlags.MODERATOR]
        notification = ChannelNotifications.MEMBER_FLAG_CHANGE
        packet = ChannelManager.build_notify_packet(channel.name, notification, target_player, flags=flags)
        channel.add_moderator(target_player)

        if channel.should_announce():
            channel.broadcast_to_channel(sender, packet)
        else:  # 1 on 1
            ChannelManager.send_to_player(sender, packet)
            ChannelManager.send_to_player(target_player, packet)

    @staticmethod
    def remove_mod(channel, sender, target_player):
        if not ChannelManager.default_checks(channel, sender, check_owner=True, check_moderator=False,
                                             target_player=target_player):
            return
        if channel.is_moderator(target_player):  # Already not mod, ignore.
            flags = [ChannelMemberFlags.MODERATOR, ChannelMemberFlags.OWNER]
            notification = ChannelNotifications.MEMBER_FLAG_CHANGE
            packet = ChannelManager.build_notify_packet(channel.name, notification, target_player, flags=flags)

            channel.remove_moderator(target_player)
            if channel.should_announce():
                channel.broadcast_to_channel(sender, packet)
            else:  # 1 on 1.
                ChannelManager.send_to_player(sender, packet)
                ChannelManager.send_to_player(target_player, packet)

    @staticmethod
    def kick_player(channel, sender, target_player, banned=False):
        if not ChannelManager.default_checks(channel, sender, check_owner=True, check_moderator=True,
                                             target_player=target_player):
            return
        packet = ChannelManager.build_notify_packet(channel.name, ChannelNotifications.KICKED, target_player, sender)
        if channel.should_announce():
            channel.broadcast_to_channel(sender, packet, ignore=[target_player])
        else:
            # Send to sender
            ChannelManager.send_to_player(sender, packet)

        # Send to target, if we haven't sent banned message already.
        if not banned:
            ChannelManager.send_to_player(target_player, packet)

        ChannelManager.leave_channel(target_player, channel)

    @staticmethod
    def get_owner(channel, sender):
        packet = ChannelManager.build_notify_packet(channel.name, ChannelNotifications.CHANNEL_OWNER,
                                                    player_name=sender.get_name())
        ChannelManager.send_to_player(sender, packet)

    @staticmethod
    def set_owner(channel, sender, target_player):
        if not ChannelManager.default_checks(channel, sender, check_owner=True, check_moderator=True,
                                             target_player=target_player):
            return
        packet = ChannelManager.build_notify_packet(channel.name, ChannelNotifications.OWNER_CHANGED, target_player)
        if channel.should_announce():
            channel.broadcast_to_channel(sender, packet)
        else:  # 1 on 1.
            ChannelManager.send_to_player(sender, packet)
            ChannelManager.send_to_player(target_player, packet)
        channel.set_owner(target_player)

    @staticmethod
    def set_password(channel, sender, password):
        if not ChannelManager.default_checks(channel, sender, check_owner=True, check_moderator=True):
            return
        packet = ChannelManager.build_notify_packet(channel.name, ChannelNotifications.PASSWORD_CHANGED, sender)
        if channel.should_announce():
            channel.broadcast_to_channel(sender, packet)
        else:
            ChannelManager.send_to_player(sender, packet)
        channel.set_password(password)

    @staticmethod
    def ban_player(channel, sender, target_player):
        if not ChannelManager.default_checks(channel, sender, check_owner=True, check_moderator=True,
                                             target_player=target_player):
            return

        if not channel.is_banned(target_player):
            packet = ChannelManager.build_notify_packet(channel.name, ChannelNotifications.BANNED, target_player, sender)
            channel.add_ban(target_player)

            if channel.should_announce():
                channel.broadcast_to_channel(sender, packet)
            else:  # Send to sender.
                ChannelManager.send_to_player(sender, packet)

            # Send to target
            ChannelManager.send_to_player(target_player, packet)

            if channel.is_moderator(channel.name, target_player):
                ChannelManager.remove_mod(channel, sender, target_player)

            ChannelManager.kick_player(channel, sender, target_player, banned=True)

    @staticmethod
    def unban_player(channel, sender, target_player):
        if not ChannelManager.default_checks(channel, sender, check_owner=True, check_moderator=True):
            return
        if not channel.is_banned(target_player):
            notification = ChannelNotifications.PLAYER_NOT_FOUND
            target_name = target_player.get_name()
            packet = ChannelManager.build_notify_packet(channel.name, notification, player_name=target_name)
            ChannelManager.send_to_player(sender, packet)
        else:
            notification = ChannelNotifications.UNBANNED
            packet = ChannelManager.build_notify_packet(channel.name, notification, target_player, sender)
            channel.remove_ban(target_player)

            if channel.should_announce():
                channel.broadcast_to_channel(sender, packet)
            else:  # 1 on 1.
                ChannelManager.send_to_player(sender, packet)
                ChannelManager.send_to_player(target_player, packet)

    @staticmethod
    def invite_player(channel, sender, target_player):
        if not ChannelManager.default_checks(channel, sender, check_owner=True, check_moderator=True):
            return

        if channel.is_banned(target_player):
            packet = ChannelManager.build_notify_packet(channel.name, ChannelNotifications.PLAYER_BANNED)
            ChannelManager.send_to_player(sender, packet)
        elif not ChannelManager._can_communicate_with_(sender, target_player):
            packet = ChannelManager.build_notify_packet(channel.name, ChannelNotifications.WRONG_FACTION)
            ChannelManager.send_to_player(sender, packet)
        elif channel.player_in_channel(target_player):
            packet = ChannelManager.build_notify_packet(channel.name, ChannelNotifications.PLAYER_ALREADY_MEMBER)
            ChannelManager.send_to_player(sender, packet)
        else:
            packet = ChannelManager.build_notify_packet(channel.name, ChannelNotifications.INVITE, target1=sender)
            ChannelManager.send_to_player(target_player, packet)

    @staticmethod
    def join_channel(player_mgr, channel_name, password=''):
        # Create channel if needed.
        if not ChannelManager._channel_exist(channel_name, player_mgr):
            channel = Channel(
                    name=channel_name.capitalize(),
                    members=[],
                    password=password if password else '',
                    is_default=False,
                    owner=player_mgr,
                    announce=True,
                    moderators=[player_mgr])

            # Handle AddOn channel.
            if channel.is_addon():
                Logger.success(f'Registered addon channel [{channel_name}].')
                ChannelManager.ADDON_CHANNELS[channel_name] = channel
            else:
                ChannelManager.CHANNELS[player_mgr.team][channel_name] = channel
        # Existent channel.
        else:
            channel = ChannelManager.get_channel(channel_name, player_mgr)

        if channel.player_in_channel(player_mgr):
            packet = ChannelManager.build_notify_packet(channel_name, ChannelNotifications.PLAYER_ALREADY_MEMBER, player_mgr)
            ChannelManager.send_to_player(player_mgr, packet)
        elif not channel.password_ok(password):
            packet = ChannelManager.build_notify_packet(channel_name, ChannelNotifications.WRONG_PASSWORD)
            ChannelManager.send_to_player(player_mgr, packet)
        elif channel.is_banned(player_mgr):
            packet = ChannelManager.build_notify_packet(channel_name, ChannelNotifications.PLAYER_BANNED)
            ChannelManager.send_to_player(player_mgr, packet)
        else:
            channel.add_member(player_mgr)

            if channel.should_announce():
                packet = ChannelManager.build_notify_packet(channel_name, ChannelNotifications.PLAYER_JOINED, player_mgr)
                channel.broadcast_to_channel(player_mgr, packet, ignore=[player_mgr])

            # Send direct message upon join, this gets the player inside channel on client.
            packet = ChannelManager.build_notify_packet(channel_name, ChannelNotifications.YOU_JOINED)
            ChannelManager.send_to_player(player_mgr, packet)

    @staticmethod
    def leave_channel(player_mgr, channel, logout=False):
        if not ChannelManager.default_checks(channel, player_mgr):
            return

        channel.remove_member(player_mgr)
        if channel.should_announce():
            notification = ChannelNotifications.PLAYER_LEFT
            packet = ChannelManager.build_notify_packet(channel.name, notification, target1=player_mgr)
            channel.broadcast_to_channel(player_mgr, packet)

        if not logout:
            packet = ChannelManager.build_notify_packet(channel.name, ChannelNotifications.YOU_LEFT)
            ChannelManager.send_to_player(player_mgr, packet)

        ChannelManager.check_if_remove(channel, player_mgr)

    @staticmethod
    def default_checks(channel, sender, check_owner=False, check_moderator=False, target_player=None):
        if not channel.player_in_channel(sender):
            packet = ChannelManager.build_notify_packet(channel.name, ChannelNotifications.NOT_MEMBER)
            ChannelManager.send_to_player(sender, packet)
            return False
        # Check owner rights
        elif check_owner and not channel.is_owner(sender):
            packet = ChannelManager.build_notify_packet(channel.name, ChannelNotifications.NOT_OWNER)
            ChannelManager.send_to_player(sender, packet)
            return False
        # Check moderator rights
        elif check_moderator and not channel.is_moderator(sender):
            packet = ChannelManager.build_notify_packet(channel.name, ChannelNotifications.NOT_MODERATOR)
            ChannelManager.send_to_player(sender, packet)
            return False
        elif target_player and not channel.player_in_channel(target_player):
            packet = ChannelManager.build_notify_packet(channel.name, ChannelNotifications.PLAYER_NOT_FOUND,
                                                        player_name=target_player.get_name())
            ChannelManager.send_to_player(sender, packet)
        elif target_player and target_player == sender:  # Avoid self ban / kick
            return False
        else:
            return True

    @staticmethod
    def check_if_remove(channel, player_mgr):
        # Pop channel if it's left with 0 players, and it's not a default channel.
        if channel.is_default:
            return
        if channel.members_count() == 0:
            channel.flush()
            if channel.is_addon():
                ChannelManager.ADDON_CHANNELS.pop(channel.name)
            else:
                ChannelManager.CHANNELS[player_mgr.team].pop(channel.name)

    @staticmethod
    def send_channel_members_list(channel, sender):
        ChannelManager.send_to_player(sender, channel.get_channel_list_packet())

    @staticmethod
    def join_default_channels(player_mgr):
        ChannelManager.join_channel(player_mgr, ChannelManager.DEFAULT_GENERAL)
        ChannelManager.join_channel(player_mgr, ChannelManager.DEFAULT_TRADE)

    @staticmethod
    def leave_all_channels(player_mgr, logout=False):
        for channel in ChannelManager.get_all_channels(player_mgr):
            if not channel.player_in_channel(player_mgr):
                continue
            ChannelManager.leave_channel(player_mgr, channel, logout=logout)

    @staticmethod
    def send_to_player(player_mgr, packet):
        player_mgr.enqueue_packet(packet)

    @staticmethod
    def build_notify_packet(channel_name, notification_type, target1=None, target2=None, player_name=None, flags=None):
        channel_name_bytes = PacketWriter.string_to_bytes(channel_name)
        data = pack(f'<B{len(channel_name_bytes)}s', notification_type, channel_name_bytes)

        if target1:
            data += pack('<Q', target1.guid)
        if target2:
            data += pack('<Q', target2.guid)
        if player_name:
            sender_name_bytes = PacketWriter.string_to_bytes(player_name)
            data += pack(f'<{len(sender_name_bytes)}s', sender_name_bytes)
        if flags:
            data += pack('<2B', flags[0], flags[1])

        return PacketWriter.get_packet(OpCode.SMSG_CHANNEL_NOTIFY, data)

    @staticmethod
    def get_all_channels(player_mgr):
        channels = []
        for channel_name, channel in list(ChannelManager.CHANNELS[player_mgr.team].items()):
            channels.append(channel)
        for channel in list(ChannelManager.ADDON_CHANNELS.values()):
            channels.append(channel)
        return channels

    @staticmethod
    def get_channel(channel_name, player_mgr):
        if not ChannelManager._channel_exist(channel_name, player_mgr):
            return None
        if channel_name in ChannelManager.ADDON_CHANNELS:
            return ChannelManager.ADDON_CHANNELS[channel_name]
        return ChannelManager.CHANNELS[player_mgr.team][channel_name]

    @staticmethod
    def _channel_exist(channel_name, player_mgr):
        return channel_name in ChannelManager.ADDON_CHANNELS or \
               player_mgr.team in ChannelManager.CHANNELS and channel_name in ChannelManager.CHANNELS[player_mgr.team]

    @staticmethod
    def _can_communicate_with_(player1_mgr, player2_mgr):
        return player1_mgr.team == player2_mgr.team
