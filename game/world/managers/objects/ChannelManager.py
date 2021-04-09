from struct import pack
from typing import NamedTuple
from network.packet.PacketWriter import PacketWriter, OpCode
from game.world.managers.objects.player.PlayerManager import *

class Channel(NamedTuple):
    name: str
    members: list
    password: str
    is_default: bool
    owner: object

# TODO, Localized channels e.g. [General - Zone], CHANNEL commands /chathelp
class ChannelManager(object):
    # Default channels
    CHANNELS = {
        'General':Channel('General', [], '', True, None),
        'Trade':Channel('Trade', [], '', True, None),
        'Local Defense':Channel('LocalDefense', [], '', True, None),
        'Looking for group':Channel('LookingForGroup', [], '', True, None)}

    @staticmethod
    def join_channel(player_mgr, channel, password=None):
        if channel not in ChannelManager.CHANNELS:
            ChannelManager.CHANNELS[channel] = Channel(channel, [], password if password else '', True, player_mgr)
        if player_mgr in ChannelManager.CHANNELS[channel].members:
            return
        if password and password != ChannelManager.CHANNELS[channel].password:
            return

        ChannelManager.CHANNELS[channel].members.append(player_mgr)

        channel_name_bytes = PacketWriter.string_to_bytes(channel)
        data = pack('<B%us' % len(channel_name_bytes), 2, channel_name_bytes)
        packet = PacketWriter.get_packet(OpCode.SMSG_CHANNEL_NOTIFY, data)
        player_mgr.session.request.sendall(packet)

    @staticmethod
    def leave_channel(player_mgr, channel):
        if channel not in ChannelManager.CHANNELS:
            return
        if player_mgr not in ChannelManager.CHANNELS[channel].members:
            return

        ChannelManager.CHANNELS[channel].members.remove(player_mgr)

        # Pop channel if is left with 0 players and its not a default channel.
        if len(ChannelManager.CHANNELS[channel].members) == 0 and not ChannelManager.CHANNELS[channel].is_default:
            ChannelManager.CHANNELS.pop(channel)

        channel_name_bytes = PacketWriter.string_to_bytes(channel)
        data = pack('<B%us' % len(channel_name_bytes), 3, channel_name_bytes)
        packet = PacketWriter.get_packet(OpCode.SMSG_CHANNEL_NOTIFY, data)
        player_mgr.session.request.sendall(packet)

    @staticmethod
    def join_default_channels(player_mgr):
        ChannelManager.join_channel(player_mgr, 'General')
        ChannelManager.join_channel(player_mgr, 'Trade')

    @staticmethod
    def leave_all_channels(player_mgr):
        for channel in ChannelManager.CHANNELS.values():
            if player_mgr in channel.members:
                ChannelManager.leave_channel(player_mgr, channel.name)

    @staticmethod
    def broadcast_to_channel(player_mgr, channel, packet):
        if channel not in ChannelManager.CHANNELS:
            return
        if player_mgr not in ChannelManager.CHANNELS[channel].members:
            return

        for player in ChannelManager.CHANNELS[channel].members:
            player.session.request.sendall(packet)
