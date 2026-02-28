from game.world.WorldSessionStateHandler import WorldSessionStateHandler
from game.world.managers.objects.units.player.ChannelManager import ChannelManager
from game.world.managers.objects.units.ChatManager import ChatManager
from game.world.opcode_handling.HandlerValidator import HandlerValidator
from network.packet.PacketReader import *
from utils.constants.MiscCodes import ChannelNotifications


class ChannelMuteHandler:

    @staticmethod
    def handle_mute(world_session, reader):
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode)
        if not player_mgr:
            return res
        # Avoid handling an empty or truncated packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=1):
            return 0

        channel_name = PacketReader.read_string(reader.data, 0).strip().capitalize()
        offset = len(channel_name) + 1
        # Determine optional-field presence from packet length.
        has_player = HandlerValidator.validate_packet_length(reader, exact_length=offset + 1)
        player_name = '' if has_player else PacketReader.read_string(reader.data, offset, 0).strip()[:-1]

        channel = ChannelManager.get_channel(channel_name, player_mgr)
        # Check if channel exists.
        if not channel:
            packet = ChannelManager.build_notify_packet(channel_name, ChannelNotifications.NOT_MEMBER)
            ChannelManager.send_to_player(player_mgr, packet)
            return 0

        target_player_mgr = WorldSessionStateHandler.find_player_by_name(player_name)
        if target_player_mgr:
            ChannelManager.add_mute(channel, player_mgr, target_player_mgr)
        else:
            ChatManager.send_system_message(world_session, f'No player named [{player_name}] is currently playing.')

        return 0

    @staticmethod
    def handle_unmute(world_session, reader):
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode)
        if not player_mgr:
            return res
        # Avoid handling an empty or truncated packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=1):
            return 0

        channel_name = PacketReader.read_string(reader.data, 0).capitalize()
        offset = len(channel_name) + 1
        # Determine optional-field presence from packet length.
        has_player = HandlerValidator.validate_packet_length(reader, exact_length=offset + 1)
        player_name = '' if has_player else PacketReader.read_string(reader.data, offset, 0).strip()[:-1]

        channel = ChannelManager.get_channel(channel_name, player_mgr)
        # Check if channel exists.
        if not channel:
            packet = ChannelManager.build_notify_packet(channel_name, ChannelNotifications.NOT_MEMBER)
            ChannelManager.send_to_player(player_mgr, packet)
            return 0

        target_player_mgr = WorldSessionStateHandler.find_player_by_name(player_name)
        if target_player_mgr:
            ChannelManager.remove_mute(channel, player_mgr, target_player_mgr)
        else:
            ChatManager.send_system_message(world_session, f'No player named [{player_name}] is currently playing.')

        return 0
