from game.world.WorldSessionStateHandler import WorldSessionStateHandler
from game.world.managers.objects.units.player.ChannelManager import ChannelManager
from game.world.managers.objects.units.ChatManager import ChatManager
from network.packet.PacketReader import *
from utils.constants.MiscCodes import ChannelNotifications


# Client does not route /kick properly for channels, need to use /script ChannelKick(channel "name" or index, "player")
class ChannelKickHandler:

    @staticmethod
    def handle(world_session, reader):
        channel_name = PacketReader.read_string(reader.data, 0).strip().capitalize()
        offset = len(channel_name) + 1
        has_player = len(reader.data) == offset + 1
        player_name = '' if has_player else PacketReader.read_string(reader.data, offset, 0).strip()[:-1]

        channel = ChannelManager.get_channel(channel_name, world_session.player_mgr)
        # Check if channel exists.
        if not channel:
            packet = ChannelManager.build_notify_packet(channel_name, ChannelNotifications.NOT_MEMBER)
            ChannelManager.send_to_player(world_session.player_mgr, packet)
            return 0

        target_player_mgr = WorldSessionStateHandler.find_player_by_name(player_name)
        if target_player_mgr:
            ChannelManager.kick_player(channel, world_session.player_mgr, target_player_mgr)
        else:
            ChatManager.send_system_message(world_session, f'No player named [{player_name}] is currently playing.')

        return 0
