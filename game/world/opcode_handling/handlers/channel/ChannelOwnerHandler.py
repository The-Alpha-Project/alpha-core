from game.world.WorldSessionStateHandler import WorldSessionStateHandler
from game.world.managers.objects.units.player.ChannelManager import ChannelManager
from game.world.managers.objects.units.player.ChatManager import ChatManager
from network.packet.PacketReader import *
from utils.constants.MiscCodes import ChannelNotifications


class ChannelOwnerHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        channel_name = PacketReader.read_string(reader.data, 0).strip().capitalize()

        channel = ChannelManager.get_channel(channel_name, world_session.player_mgr)
        # Check if channel exists.
        if not channel:
            packet = ChannelManager.build_notify_packet(channel_name, ChannelNotifications.NOT_MEMBER)
            ChannelManager.send_to_player(world_session.player_mgr, packet)
            return 0

        ChannelManager.get_owner(channel, world_session.player_mgr)
        return 0

    @staticmethod
    def handle_set_owner(world_session, socket, reader):
        channel_name = PacketReader.read_string(reader.data, 0).capitalize()
        offset = len(channel_name) + 1
        has_player = len(reader.data) == offset + 1
        player_name = '' if has_player else PacketReader.read_string(reader.data, offset, 0).strip()[:-1]
        target_player_mgr = WorldSessionStateHandler.find_player_by_name(player_name)

        channel = ChannelManager.get_channel(channel_name, world_session.player_mgr)
        # Check if channel exists.
        if not channel:
            packet = ChannelManager.build_notify_packet(channel_name, ChannelNotifications.NOT_MEMBER)
            ChannelManager.send_to_player(world_session.player_mgr, packet)
            return 0

        if target_player_mgr:
            ChannelManager.set_owner(channel, world_session.player_mgr, target_player_mgr)
        else:
            ChatManager.send_system_message(world_session, f'No player named [{player_name}] is currently playing.')

        return 0
