from game.world.managers.objects.units.player.ChannelManager import ChannelManager
from game.world.opcode_handling.HandlerValidator import HandlerValidator
from network.packet.PacketReader import *
from utils.constants.MiscCodes import ChannelNotifications


class ChannelListHandler:

    @staticmethod
    def handle(world_session, reader):
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode)
        if not player_mgr:
            return res
        # Avoid handling an empty or truncated packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=1):
            return 0

        channel_name = PacketReader.read_string(reader.data, 0).strip().capitalize()

        channel = ChannelManager.get_channel(channel_name, player_mgr)
        # Check if channel exists.
        if not channel:
            packet = ChannelManager.build_notify_packet(channel_name, ChannelNotifications.NOT_MEMBER)
            ChannelManager.send_to_player(player_mgr, packet)
            return 0

        ChannelManager.send_channel_members_list(channel, player_mgr)

        return 0
