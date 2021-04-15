from utils.constants.ObjectCodes import ChannelNotifications, ChannelMemberFlags
from utils.constants.UnitCodes import Teams
from network.packet.PacketWriter import *
from game.world.managers.objects.player.PlayerManager import *
from game.world.opcode_handling.handlers.player.NameQueryHandler import NameQueryHandler


# TODO: In need of a cleanup / refactor
class Channel(object):
    def __init__(self, name, members, password, is_default, owner, announce, moderators=None, banned=None, muted=None):
        self.name = name
        self.members = members
        self.password = password
        self.is_default = is_default
        self.owner = owner
        self.announce = announce
        self.moderated = False
        self.moderators = moderators if moderators else []
        self.banned = banned if banned else []
        self.muted = muted if muted else []

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

    # Default channels
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

    @staticmethod
    def toggle_moderation(channel, sender):
        if ChannelManager.default_checks(channel, sender, check_owner=True, check_moderator=True):
            flag = ChannelManager.CHANNELS[sender.team][channel].moderated
            ChannelManager.CHANNELS[sender.team][channel].moderated = not flag  # Flip
            notify = ChannelNotifications.MODERATION_ON if not flag else ChannelNotifications.MODERATION_OFF
            packet = ChannelManager.build_notify_packet(channel, notify, target1=sender)
            if ChannelManager._should_announce(channel, sender):
                ChannelManager.broadcast_to_channel(sender, channel, packet)
            else:
                ChannelManager.send_to_player(sender, packet)

    @staticmethod
    def toggle_announce(channel, sender):
        if ChannelManager.default_checks(channel, sender, check_owner=True, check_moderator=True):
            flag = ChannelManager.CHANNELS[sender.team][channel].announce
            ChannelManager.CHANNELS[sender.team][channel].announce = not flag  # Flip
            notify = ChannelNotifications.ANNOUNCEMENTS_ON if not flag else ChannelNotifications.ANNOUNCEMENTS_OFF
            packet = ChannelManager.build_notify_packet(channel, notify, target1=sender)
            if ChannelManager._should_announce(channel, sender):
                ChannelManager.broadcast_to_channel(sender, channel, packet)
            else:
                ChannelManager.send_to_player(sender, packet)

    @staticmethod
    def add_mute(channel, sender, target_player):
        if ChannelManager.default_checks(channel, sender, check_owner=True, check_moderator=True, target_player=target_player):
            if ChannelManager._is_muted(channel, target_player): #Already muted, ignore
                packet = ChannelManager.build_notify_packet(channel, ChannelNotifications.MEMBER_FLAG_CHANGE,
                                                            target_player, flags=[ChannelMemberFlags.VOICE,
                                                                                  ChannelMemberFlags.OWNER])
                ChannelManager.CHANNELS[sender.team][channel].muted.append(target_player)
                if ChannelManager._should_announce(channel, sender):
                    ChannelManager.broadcast_to_channel(sender, channel, packet)
                else:  # 1 on 1
                    ChannelManager.send_to_player(sender, packet)
                    ChannelManager.send_to_player(target_player, packet)

    @staticmethod
    def remove_mute(channel, sender, target_player):
        if ChannelManager.default_checks(channel, sender, check_owner=True, check_moderator=True, target_player=target_player):
            if not ChannelManager._is_muted(channel, target_player): #Already not muted, ignore
                packet = ChannelManager.build_notify_packet(channel, ChannelNotifications.MEMBER_FLAG_CHANGE,
                                                            target_player, flags=[ChannelMemberFlags.OWNER,
                                                                                  ChannelMemberFlags.VOICE])
                ChannelManager.CHANNELS[sender.team][channel].muted.remove(target_player)

                if ChannelManager._should_announce(channel, sender):
                    ChannelManager.broadcast_to_channel(sender, channel, packet)
                else:  # 1on1
                    ChannelManager.send_to_player(sender, packet)
                    ChannelManager.send_to_player(target_player, packet)

    @staticmethod
    def add_mod(channel, sender, target_player):
        if ChannelManager.default_checks(channel, sender, check_owner=True, check_moderator=False, target_player=target_player):
            if not ChannelManager._is_moderator(channel, target_player): # Already mod, ignore
                packet = ChannelManager.build_notify_packet(channel, ChannelNotifications.MEMBER_FLAG_CHANGE,
                                                            target_player, flags=[ChannelMemberFlags.OWNER,
                                                                                  ChannelMemberFlags.MODERATOR])
                ChannelManager.CHANNELS[sender.team][channel].moderators.append(target_player)

                if ChannelManager._should_announce(channel, sender):
                    ChannelManager.broadcast_to_channel(sender, channel, packet)
                else:  # 1 on 1
                    ChannelManager.send_to_player(sender, packet)
                    ChannelManager.send_to_player(target_player, packet)

    @staticmethod
    def remove_mod(channel, sender, target_player):
        if ChannelManager.default_checks(channel, sender, check_owner=True, check_moderator=False, target_player=target_player):
            if ChannelManager._is_moderator(channel, target_player): # Already not mod, ignore
                packet = ChannelManager.build_notify_packet(channel, ChannelNotifications.MEMBER_FLAG_CHANGE,
                                                            target_player, flags=[ChannelMemberFlags.MODERATOR,
                                                                                  ChannelMemberFlags.OWNER])
                ChannelManager.CHANNELS[sender.team][channel].moderators.remove(target_player)

                if ChannelManager._should_announce(channel, sender):
                    ChannelManager.broadcast_to_channel(sender, channel, packet)
                else:  # 1 on 1
                    ChannelManager.send_to_player(sender, packet)
                    ChannelManager.send_to_player(target_player, packet)

    @staticmethod
    def kick_player(channel, sender, target_player, banned=False):
        if ChannelManager.default_checks(channel, sender, check_owner=True, check_moderator=True, target_player=target_player):
            packet = ChannelManager.build_notify_packet(channel, ChannelNotifications.KICKED, target_player, sender)
            if ChannelManager._should_announce(channel, sender):
                ChannelManager.broadcast_to_channel(sender, channel, packet, [target_player])
            else:
                # Send to sender
                ChannelManager.send_to_player(sender, packet)

            # Send to target, if we haven't sent banned message already.
            if not banned:
                ChannelManager.send_to_player(target_player, packet)

            ChannelManager.leave_channel(target_player, channel)

    @staticmethod
    def get_owner(channel, sender):
        if channel in ChannelManager.CHANNELS[sender.team]:
            packet = ChannelManager.build_notify_packet(channel, ChannelNotifications.CHANNEL_OWNER,
                                                        player_name=sender.player.name)
            ChannelManager.send_to_player(sender, packet)
        else:
            packet = ChannelManager.build_notify_packet(channel, ChannelNotifications.NOT_MEMBER)
            ChannelManager.send_to_player(sender, packet)

    @staticmethod
    def set_owner(channel, sender, target_player):
        if ChannelManager.default_checks(channel, sender, check_owner=True, check_moderator=False, target_player=target_player):
            packet = ChannelManager.build_notify_packet(channel, ChannelNotifications.OWNER_CHANGED, target_player)
            if ChannelManager._should_announce(channel, sender):
                ChannelManager.broadcast_to_channel(sender, channel, packet)
            else:  # 1on1
                ChannelManager.send_to_player(sender, packet)
                ChannelManager.send_to_player(target_player, packet)

            ChannelManager.CHANNELS[sender.team][channel].owner = target_player

    @staticmethod
    def set_password(channel, sender, password):
        if ChannelManager.default_checks(channel, sender, check_owner=True, check_moderator=True):
            packet = ChannelManager.build_notify_packet(channel, ChannelNotifications.PASSWORD_CHANGED, sender)
            if ChannelManager._should_announce(channel, sender):
                ChannelManager.broadcast_to_channel(sender, channel, packet)
            else:
                ChannelManager.send_to_player(sender, packet)

            ChannelManager.CHANNELS[sender.team][channel].password = password

    @staticmethod
    def ban_player(channel, sender, target_player):
        if ChannelManager.default_checks(channel, sender, check_owner=True, check_moderator=True, target_player=target_player):
            if not ChannelManager._is_banned(channel, target_player):
                packet = ChannelManager.build_notify_packet(channel, ChannelNotifications.BANNED, target_player, sender)
                ChannelManager.CHANNELS[sender.team][channel].banned.append(target_player)

                if ChannelManager._should_announce(channel, sender):
                    ChannelManager.broadcast_to_channel(sender, channel, packet)
                else:  # Send to sender
                    ChannelManager.send_to_player(sender, packet)

                # Send to target
                ChannelManager.send_to_player(target_player, packet)

                if ChannelManager._is_moderator(channel, target_player):
                    ChannelManager.remove_mod(channel, sender, target_player)

                ChannelManager.kick_player(channel, sender, target_player, banned=True)

    @staticmethod
    def unban_player(channel, sender, target_player):
        if ChannelManager.default_checks(channel, sender, check_owner=True, check_moderator=True):
            if not ChannelManager._is_banned(channel, target_player):
                packet = ChannelManager.build_notify_packet(channel, ChannelNotifications.PLAYER_NOT_FOUND,
                                                            player_name=target_player.player.name)
                ChannelManager.send_to_player(sender, packet)
            else:
                packet = ChannelManager.build_notify_packet(channel, ChannelNotifications.UNBANNED, target_player,
                                                            sender)
                ChannelManager.CHANNELS[sender.team][channel].banned.remove(target_player)

                if ChannelManager._should_announce(channel, sender):
                    ChannelManager.broadcast_to_channel(sender, channel, packet)
                else:  # 1on1
                    ChannelManager.send_to_player(sender, packet)
                    ChannelManager.send_to_player(target_player, packet)

    @staticmethod
    def invite_player(channel, sender, target_player):
        if ChannelManager.default_checks(channel, sender, check_owner=True, check_moderator=True):
            if ChannelManager._is_banned(channel, target_player):
                packet = ChannelManager.build_notify_packet(channel, ChannelNotifications.PLAYER_BANNED)
                ChannelManager.send_to_player(sender, packet)
            elif not ChannelManager._can_communicate_with_(sender, target_player):
                packet = ChannelManager.build_notify_packet(channel, ChannelNotifications.WRONG_FACTION)
                ChannelManager.send_to_player(sender, packet)
            elif ChannelManager._in_channel(channel, target_player):
                packet = ChannelManager.build_notify_packet(channel, ChannelNotifications.PLAYER_ALREADY_MEMBER)
                ChannelManager.send_to_player(sender, packet)
            else:
                packet = ChannelManager.build_notify_packet(channel, ChannelNotifications.INVITE, target1=sender)
                ChannelManager.send_to_player(target_player, packet)

    @staticmethod
    def join_channel(player_mgr, channel, password=''):
        if not ChannelManager._exist(channel, player_mgr):
            ChannelManager.CHANNELS[player_mgr.team][channel] = Channel(
                    name=channel.capitalize(),
                    members=[],
                    password=password if password else '',
                    is_default=True,
                    owner=player_mgr,
                    announce=True,
                    moderators=[player_mgr])

        if ChannelManager._in_channel(channel, player_mgr):
            packet = ChannelManager.build_notify_packet(channel, ChannelNotifications.PLAYER_ALREADY_MEMBER, player_mgr)
            ChannelManager.send_to_player(player_mgr, packet)
        elif not ChannelManager._password_ok(channel, player_mgr, password):
            packet = ChannelManager.build_notify_packet(channel, ChannelNotifications.WRONG_PASSWORD)
            ChannelManager.send_to_player(player_mgr, packet)
        elif ChannelManager._is_banned(channel, player_mgr):
            packet = ChannelManager.build_notify_packet(channel, ChannelNotifications.PLAYER_BANNED)
            ChannelManager.send_to_player(player_mgr, packet)
        else:
            ChannelManager.CHANNELS[player_mgr.team][channel].members.append(player_mgr)

            if ChannelManager._should_announce(channel, player_mgr):
                packet = ChannelManager.build_notify_packet(channel, ChannelNotifications.PLAYER_JOINED, player_mgr)
                ChannelManager.broadcast_to_channel(player_mgr, channel, packet, ignore=[player_mgr])

            # Send direct message upon join, this gets the player inside channel on client.
            packet = ChannelManager.build_notify_packet(channel, ChannelNotifications.YOU_JOINED)
            ChannelManager.send_to_player(player_mgr, packet)

    @staticmethod
    def leave_channel(player_mgr, channel, logout=False):
        if ChannelManager.default_checks(channel, player_mgr):
            ChannelManager.CHANNELS[player_mgr.team][channel].members.remove(player_mgr)

            if ChannelManager._should_announce(channel, player_mgr):
                packet = ChannelManager.build_notify_packet(channel, ChannelNotifications.PLAYER_LEFT, target1=player_mgr)
                ChannelManager.broadcast_to_channel(player_mgr, channel, packet)

            if not logout:
                packet = ChannelManager.build_notify_packet(channel, ChannelNotifications.YOU_LEFT)
                ChannelManager.send_to_player(player_mgr, packet)

            ChannelManager.check_if_remove(channel, player_mgr)

    @staticmethod
    def default_checks(channel, sender, check_owner=False, check_moderator=False, target_player=None):
        # Check if channel exist and if requester is in that channel
        if not ChannelManager._exist(channel, sender) or not ChannelManager._in_channel(channel, sender):
            packet = ChannelManager.build_notify_packet(channel, ChannelNotifications.NOT_MEMBER)
            ChannelManager.send_to_player(sender, packet)
            return False
        # Check owner rights
        elif check_owner and not ChannelManager._is_owner(channel, sender):
            packet = ChannelManager.build_notify_packet(channel, ChannelNotifications.NOT_OWNER)
            ChannelManager.send_to_player(sender, packet)
            return False
        # Check moderator rights
        elif check_moderator and not ChannelManager._is_moderator(channel, sender):
            packet = ChannelManager.build_notify_packet(channel, ChannelNotifications.NOT_MODERATOR)
            ChannelManager.send_to_player(sender, packet)
            return False
        elif target_player and not ChannelManager._in_channel(channel, target_player):
            packet = ChannelManager.build_notify_packet(channel, ChannelNotifications.PLAYER_NOT_FOUND,
                                                        player_name=target_player.player.name)
            ChannelManager.send_to_player(sender, packet)
        elif target_player and target_player == sender: # Avoid self ban/kick
            return False
        else:
            return True

    @staticmethod
    def check_if_remove(channel, player_mgr):
        # Pop channel if its left with 0 players and its not a default channel.
        if channel in ChannelManager.CHANNELS[player_mgr.team]:
            if ChannelManager.CHANNELS[player_mgr.team][channel].is_default:
                return
            elif len(ChannelManager.CHANNELS[player_mgr.team][channel].members) == 0:
                ChannelManager.CHANNELS[player_mgr.team][channel].flush()
                ChannelManager.CHANNELS[player_mgr.team].pop(channel)

    @staticmethod
    def list_channel(channel, sender):
        if not ChannelManager._exist(channel, sender):
            packet = ChannelManager.build_notify_packet(channel, ChannelNotifications.NOT_MEMBER)
            ChannelManager.send_to_player(sender, packet)
        else:
            len_members = len(ChannelManager.CHANNELS[sender.team][channel].members)
            name_bytes = PacketWriter.string_to_bytes(ChannelManager.CHANNELS[sender.team][channel].name)
            data = pack(f'<{len(name_bytes)}sBI', name_bytes, 0x3, len_members)  # TODO '0x3' Unknown flags.

            for member in ChannelManager._get_members(channel, sender):
                data += pack('<Q', member.guid)
                mode = 0
                if ChannelManager._is_muted(channel, member):
                    mode |= ChannelMemberFlags.VOICE
                if ChannelManager._is_moderator(channel, member) or ChannelManager._is_owner(channel, member):
                    mode |= ChannelMemberFlags.MODERATOR
                data += pack('<B', mode)

            packet = PacketWriter.get_packet(OpCode.SMSG_CHANNEL_LIST, data)
            ChannelManager.send_to_player(sender, packet)

    @staticmethod
    def join_default_channels(player_mgr):
        ChannelManager.join_channel(player_mgr, ChannelManager.DEFAULT_GENERAL)
        ChannelManager.join_channel(player_mgr, ChannelManager.DEFAULT_TRADE)

    @staticmethod
    def leave_all_channels(player_mgr, logout=False):
        for channel in ChannelManager.CHANNELS[player_mgr.team].values():
            if player_mgr in channel.members:
                ChannelManager.leave_channel(player_mgr, channel.name.capitalize(), logout=logout)

    @staticmethod
    def send_to_player(player_mgr, packet):
        player_mgr.session.request.sendall(packet)

    @staticmethod
    def broadcast_to_channel(sender, channel, packet, ignore=None):
        if not ChannelManager._exist(channel, sender):
            packet = ChannelManager.build_notify_packet(channel, ChannelNotifications.NOT_MEMBER)
            ChannelManager.send_to_player(sender, packet)
        elif ChannelManager._is_muted(sender, channel):
            packet = ChannelManager.build_notify_packet(channel, ChannelNotifications.SELF_MUTED)
            ChannelManager.send_to_player(sender, packet)
        else:
            for player in ChannelManager._get_members(channel, sender):
                if ignore and player in ignore:
                    continue
                player.session.request.sendall(packet)

    @staticmethod
    def build_notify_packet(channel, notification_type, target1=None, target2=None, player_name=None, flags=None):
        channel_name_bytes = PacketWriter.string_to_bytes(channel)
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
    def _exist(channel, player_mgr):
        return player_mgr.team in ChannelManager.CHANNELS and channel in ChannelManager.CHANNELS[player_mgr.team]

    @staticmethod
    def _is_default(channel, player_mgr):
        return ChannelManager.CHANNELS[player_mgr.team][channel].is_default

    @staticmethod
    def _get_members(channel, player_mgr):
        return list(ChannelManager.CHANNELS[player_mgr.team][channel].members)

    @staticmethod
    def _password_ok(channel, player_mgr, password):
        return ChannelManager.CHANNELS[player_mgr.team][channel].password == password

    @staticmethod
    def _should_announce(channel, player_mgr):
        return ChannelManager.CHANNELS[player_mgr.team][channel].announce

    @staticmethod
    def _can_communicate_with_(player1_mgr, player2_mgr):
        return player1_mgr.team == player2_mgr.team

    @staticmethod
    def _is_muted(channel, player_mgr):
        return player_mgr in ChannelManager.CHANNELS[player_mgr.team][channel].muted

    @staticmethod
    def _is_banned(channel, player_mgr):
        return player_mgr in ChannelManager.CHANNELS[player_mgr.team][channel].banned

    @staticmethod
    def _is_moderator(channel, player_mgr):
        return player_mgr in ChannelManager.CHANNELS[player_mgr.team][channel].moderators

    @staticmethod
    def _is_owner(channel, player_mgr):
        return ChannelManager.CHANNELS[player_mgr.team][channel].owner == player_mgr

    @staticmethod
    def _in_channel(channel, player_mgr):
        return player_mgr in ChannelManager.CHANNELS[player_mgr.team][channel].members