from game.world.WorldSessionStateHandler import WorldSessionStateHandler
from game.world.managers.objects.units.player import ChannelManager
from game.world.managers.objects.units.player.ChatManager import ChatManager
from network.packet.PacketReader import *


class ChannelBanHandler(object):

    @staticmethod
    def handle_ban(world_session, socket, reader):
        channel = PacketReader.read_string(reader.data, 0).strip().capitalize()
        offset = len(channel) + 1
        has_player = len(reader.data) == offset + 1
        player_name = '' if has_player else PacketReader.read_string(reader.data, offset, 0).strip()[:-1]

        target_player_mgr = WorldSessionStateHandler.find_player_by_name(player_name)
        if target_player_mgr:
            ChannelManager.ban_player(channel, world_session.player_mgr, target_player_mgr)
        else:
            ChatManager.send_system_message(world_session, f'No player named [{player_name}] is currently playing.')

        return 0

    @staticmethod
    def handle_unban(world_session, socket, reader):
        channel = PacketReader.read_string(reader.data, 0).strip().capitalize()
        offset = len(channel) + 1
        has_player = len(reader.data) == offset + 1
        player_name = '' if has_player else PacketReader.read_string(reader.data, offset, 0).strip()[:-1]

        target_player_mgr = WorldSessionStateHandler.find_player_by_name(player_name)
        if target_player_mgr:
            ChannelManager.unban_player(channel, world_session.player_mgr, target_player_mgr)
        else:
            ChatManager.send_system_message(world_session, f'No player named [{player_name}] is currently playing.')

        return 0
