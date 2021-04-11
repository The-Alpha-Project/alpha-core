from utils.constants.ObjectCodes import ChannelNotifications
from utils.constants.UnitCodes import Teams
from network.packet.PacketWriter import *
from game.world.managers.objects.player.PlayerManager import *

# Channels were not localized until 0.5.5
# TODO: Complete CHANNEL commands.
class Channel(object):
    def __init__(self, name, members, password, is_default, owner, announce, moderators=None, banned=None, muted=None):
        self.name = name
        self.members = members
        self.password = password
        self.is_default = is_default
        self.owner = owner
        self.announce = announce
        self.moderators = moderators if moderators else []
        self.banned = banned if banned else []
        self.muted = muted if muted else []


class ChannelManager(object):
    # Default channels
    CHANNELS = {
        Teams.TEAM_ALLIANCE:
            {
            'General':Channel('General', [], '', True, None, True),
            'Trade':Channel('Trade', [], '', True, None, True)
            },
        Teams.TEAM_HORDE:
            {
            'General': Channel('General', [], '', True, None, True),
            'Trade': Channel('Trade', [], '', True, None, True)
            }
    }

    @staticmethod
    def has_players(team, channel):
        return channel in ChannelManager.CHANNELS[team] and len(ChannelManager.CHANNELS[team][channel].members) > 0

    @staticmethod
    def kick_player(channel, sender, target_player):
        if channel in ChannelManager.CHANNELS[sender.team]:
            if sender == target_player:
                packet = ChannelManager.build_notify_packet(channel, ChannelNotifications.ChannelOwner,
                                                            player_name=sender.player.name)
                ChannelManager.send_to_player(sender, packet)
            elif sender not in ChannelManager.CHANNELS[sender.team][channel].members:
                packet = ChannelManager.build_notify_packet(channel, ChannelNotifications.NotMember)
                ChannelManager.send_to_player(sender, packet)
            elif sender != ChannelManager.CHANNELS[sender.team][channel].owner:
                packet = ChannelManager.build_notify_packet(channel, ChannelNotifications.NotOwner)
                ChannelManager.send_to_player(sender, packet)
            elif sender.team != target_player.team:
                packet = ChannelManager.build_notify_packet(channel, ChannelNotifications.WrongFaction)
                ChannelManager.send_to_player(sender, packet)
            elif target_player not in ChannelManager.CHANNELS[sender.team][channel].members:
                packet = ChannelManager.build_notify_packet(channel, ChannelNotifications.PlayerNotFound,
                                                            player_name=target_player.player.name)
                ChannelManager.send_to_player(sender, packet)
            else:
                packet = ChannelManager.build_notify_packet(channel, ChannelNotifications.Kicked, target_player, sender)
                if ChannelManager.CHANNELS[sender.team][channel].announce:
                    ChannelManager.broadcast_to_channel(sender, channel, packet)
                else:  # 1on1
                    ChannelManager.send_to_player(sender, packet)
                    ChannelManager.send_to_player(target_player, packet)

                ChannelManager.leave_channel(target_player, channel)
        else:
            packet = ChannelManager.build_notify_packet(channel, ChannelNotifications.NotMember)
            ChannelManager.send_to_player(sender, packet)

    @staticmethod
    def get_owner(channel, player_mgr):
        packet = ChannelManager.build_notify_packet(channel, ChannelNotifications.ChannelOwner,
                                                    player_name=player_mgr.player.name)
        ChannelManager.send_to_player(player_mgr, packet)

    @staticmethod
    def set_owner(channel, sender, player_mgr):
        pass

    @staticmethod
    def set_password(channel, sender, player_mgr):
        pass

    @staticmethod
    def list_channel(channel, sender, player_mgr):
        pass

    @staticmethod
    def ban_player(channel, sender, target_player):
        if channel in ChannelManager.CHANNELS[sender.team]:
            if sender == target_player:
                packet = ChannelManager.build_notify_packet(channel, ChannelNotifications.ChannelOwner,
                                                            player_name=sender.player.name)
                ChannelManager.send_to_player(sender, packet)
            elif sender not in ChannelManager.CHANNELS[sender.team][channel].members:
                packet = ChannelManager.build_notify_packet(channel, ChannelNotifications.NotMember)
                ChannelManager.send_to_player(sender, packet)
            elif sender != ChannelManager.CHANNELS[sender.team][channel].owner:
                packet = ChannelManager.build_notify_packet(channel, ChannelNotifications.NotOwner)
                ChannelManager.send_to_player(sender, packet)
            elif sender.team != target_player.team:
                packet = ChannelManager.build_notify_packet(channel, ChannelNotifications.WrongFaction)
                ChannelManager.send_to_player(sender, packet)
            elif target_player not in ChannelManager.CHANNELS[sender.team][channel].members:
                packet = ChannelManager.build_notify_packet(channel, ChannelNotifications.PlayerNotFound,
                                                            player_name=target_player.player.name)
                ChannelManager.send_to_player(sender, packet)
            elif target_player not in ChannelManager.CHANNELS[sender.team][channel].banned:
                packet = ChannelManager.build_notify_packet(channel, ChannelNotifications.Banned, target_player, sender)
                ChannelManager.CHANNELS[sender.team][channel].banned.append(target_player)

                if ChannelManager.CHANNELS[sender.team][channel].announce:
                    ChannelManager.broadcast_to_channel(sender, channel, packet)
                else: #1on1
                    ChannelManager.send_to_player(sender, packet)
                    ChannelManager.send_to_player(target_player, packet)

                ChannelManager.kick_player(channel, sender, target_player)
        else:
            packet = ChannelManager.build_notify_packet(channel, ChannelNotifications.NotMember)
            ChannelManager.send_to_player(sender, packet)

    @staticmethod
    def unban_player(channel, sender, target_player):
        if channel in ChannelManager.CHANNELS[sender.team]:
            if sender == target_player:
                packet = ChannelManager.build_notify_packet(channel, ChannelNotifications.ChannelOwner,
                                                            player_name=sender.player.name)
                ChannelManager.send_to_player(sender, packet)
            elif sender != ChannelManager.CHANNELS[sender.team][channel].owner:
                packet = ChannelManager.build_notify_packet(channel, ChannelNotifications.NotOwner)
                ChannelManager.send_to_player(sender, packet)
            elif sender.team != target_player.team:
                packet = ChannelManager.build_notify_packet(channel, ChannelNotifications.WrongFaction)
                ChannelManager.send_to_player(sender, packet)
            elif target_player not in ChannelManager.CHANNELS[sender.team][channel].banned:
                packet = ChannelManager.build_notify_packet(channel, ChannelNotifications.PlayerNotFound,
                                                            player_name=target_player.player.name)
                ChannelManager.send_to_player(sender, packet)
            elif target_player in ChannelManager.CHANNELS[sender.team][channel].banned:
                packet = ChannelManager.build_notify_packet(channel, ChannelNotifications.Unbanned, target_player, sender)
                ChannelManager.CHANNELS[sender.team][channel].banned.remove(target_player)

                if ChannelManager.CHANNELS[sender.team][channel].announce:
                    ChannelManager.broadcast_to_channel(sender, channel, packet)
                else:  # 1on1
                    ChannelManager.send_to_player(sender, packet)
                    ChannelManager.send_to_player(target_player, packet)
        else:
            packet = ChannelManager.build_notify_packet(channel, ChannelNotifications.NotMember)
            ChannelManager.send_to_player(sender, packet)

    @staticmethod
    def invite_player(channel, sender, target_player):
        if channel in ChannelManager.CHANNELS[sender.team]:
            if sender == target_player:
                packet = ChannelManager.build_notify_packet(channel, ChannelNotifications.PlayerAlreadyMember)
                ChannelManager.send_to_player(sender, packet)
            elif sender not in ChannelManager.CHANNELS[sender.team][channel].members:
                packet = ChannelManager.build_notify_packet(channel, ChannelNotifications.NotMember)
                ChannelManager.send_to_player(sender, packet)
            elif sender != ChannelManager.CHANNELS[sender.team][channel].owner:
                packet = ChannelManager.build_notify_packet(channel, ChannelNotifications.NotOwner)
                ChannelManager.send_to_player(sender, packet)
            elif target_player in ChannelManager.CHANNELS[sender.team][channel].banned:
                packet = ChannelManager.build_notify_packet(channel, ChannelNotifications.PlayerBanned)
                ChannelManager.send_to_player(sender, packet)
            elif target_player in ChannelManager.CHANNELS[sender.team][channel].members:
                packet = ChannelManager.build_notify_packet(channel, ChannelNotifications.PlayerAlreadyMember, target_player)
                ChannelManager.send_to_player(sender, packet)
            elif sender.team != target_player.team:
                packet = ChannelManager.build_notify_packet(channel, ChannelNotifications.WrongFaction)
                ChannelManager.send_to_player(sender, packet)
            else:
                packet = ChannelManager.build_notify_packet(channel, ChannelNotifications.Invite, target1=sender)
                ChannelManager.send_to_player(target_player, packet)
        else:
            packet = ChannelManager.build_notify_packet(channel, ChannelNotifications.NotMember)
            ChannelManager.send_to_player(sender, packet)

    @staticmethod
    def announce(channel, sender):
        if channel in ChannelManager.CHANNELS[sender.team]:
            if sender not in ChannelManager.CHANNELS[sender.team][channel].members:
                packet = ChannelManager.build_notify_packet(channel, ChannelNotifications.NotMember)
                ChannelManager.send_to_player(sender, packet)
            elif sender != ChannelManager.CHANNELS[sender.team][channel].owner:
                packet = ChannelManager.build_notify_packet(channel, ChannelNotifications.NotOwner)
                ChannelManager.send_to_player(sender, packet)
            else:
                flag = ChannelManager.CHANNELS[sender.team][channel].announce
                ChannelManager.CHANNELS[sender.team][channel].announce = not flag #flip
                notify = ChannelNotifications.AnnouncementsOn if flag else ChannelNotifications.AnnouncementsOff
                packet = ChannelManager.build_notify_packet(channel, notify, target1=sender)
                if ChannelManager.CHANNELS[sender.team][channel].announce:
                    ChannelManager.broadcast_to_channel(sender, channel, packet)
                else:
                    ChannelManager.send_to_player(sender, packet)
        else:
            packet = ChannelManager.build_notify_packet(channel, ChannelNotifications.NotMember)
            ChannelManager.send_to_player(sender, packet)

    @staticmethod
    def join_channel(player_mgr, channel, password=''):
        if channel not in ChannelManager.CHANNELS[player_mgr.team]:
            ChannelManager.CHANNELS[player_mgr.team][channel] = Channel(
                    name=channel,
                    members=[],
                    password=password if password else '',
                    is_default=True,
                    owner=player_mgr,
                    announce=False,
                    moderators=[player_mgr])

        if player_mgr in ChannelManager.CHANNELS[player_mgr.team][channel].members:
            packet = ChannelManager.build_notify_packet(channel, ChannelNotifications.PlayerAlreadyMember, player_mgr)
            ChannelManager.send_to_player(player_mgr, packet)
        elif password != ChannelManager.CHANNELS[player_mgr.team][channel].password:
            packet = ChannelManager.build_notify_packet(channel, ChannelNotifications.WrongPassword)
            ChannelManager.send_to_player(player_mgr, packet)
        elif player_mgr in ChannelManager.CHANNELS[player_mgr.team][channel].banned:
            packet = ChannelManager.build_notify_packet(channel, ChannelNotifications.PlayerBanned)
            ChannelManager.send_to_player(player_mgr, packet)
        else:
            ChannelManager.CHANNELS[player_mgr.team][channel].members.append(player_mgr)

            if ChannelManager.CHANNELS[player_mgr.team][channel].announce:
                packet = ChannelManager.build_notify_packet(channel, ChannelNotifications.PlayerJoined, player_mgr)
                ChannelManager.broadcast_to_channel(player_mgr, channel, packet, ignore=player_mgr)

            # Send direct message upon join, this gets the player inside channel on client.
            packet = ChannelManager.build_notify_packet(channel, ChannelNotifications.YouJoined)
            ChannelManager.send_to_player(player_mgr, packet)

    @staticmethod
    def leave_channel(player_mgr, channel):
        if channel not in ChannelManager.CHANNELS[player_mgr.team] or player_mgr not in ChannelManager.CHANNELS[player_mgr.team][channel].members:
            packet = ChannelManager.build_notify_packet(channel, ChannelNotifications.NotMember)
            ChannelManager.send_to_player(player_mgr, packet)
            return

        if ChannelManager.CHANNELS[player_mgr.team][channel].announce:
            packet = ChannelManager.build_notify_packet(channel, ChannelNotifications.PlayerLeft, target1=player_mgr)
            ChannelManager.broadcast_to_channel(player_mgr, channel, packet)
        else:
            packet = ChannelManager.build_notify_packet(channel, ChannelNotifications.YouLeft)
            ChannelManager.send_to_player(player_mgr, packet)

        ChannelManager.CHANNELS[player_mgr.team][channel].members.remove(player_mgr)
        # Pop channel if is left with 0 players and its not a default channel.
        if len(ChannelManager.CHANNELS[player_mgr.team][channel].members) == 0 \
                and not ChannelManager.CHANNELS[player_mgr.team][channel].is_default:
            ChannelManager.CHANNELS[player_mgr.team].pop(channel)

    @staticmethod
    def join_default_channels(player_mgr):
        ChannelManager.join_channel(player_mgr, 'General')
        ChannelManager.join_channel(player_mgr, 'Trade')

    @staticmethod
    def leave_all_channels(player_mgr):
        for channel in ChannelManager.CHANNELS[player_mgr.team].values():
            if player_mgr in channel.members:
                ChannelManager.leave_channel(player_mgr, channel.name)

    @staticmethod
    def send_to_player(player_mgr, packet):
        player_mgr.session.request.sendall(packet)

    @staticmethod
    def broadcast_to_channel(sender, channel, packet, ignore=None):
        if channel not in ChannelManager.CHANNELS[sender.team]:
            print(f'Channel not found {Teams(sender.team)} {channel}')
            return

        for player in ChannelManager.CHANNELS[sender.team][channel].members:
            if ignore and ignore == player:
                continue

            player.session.request.sendall(packet)

    @staticmethod
    def build_notify_packet(channel, notification_type, target1=None, target2=None, player_name=None):
        channel_name_bytes = PacketWriter.string_to_bytes(channel)
        data = pack('<B%us' % len(channel_name_bytes), notification_type, channel_name_bytes)

        if target1:
            data += pack('<Q', target1.guid)
        if target2:
            data += pack('<Q', target2.guid)
        if player_name:
            sender_name_bytes = PacketWriter.string_to_bytes(player_name)
            data += pack('<%us'  % len(sender_name_bytes), sender_name_bytes)

        return PacketWriter.get_packet(OpCode.SMSG_CHANNEL_NOTIFY, data)
