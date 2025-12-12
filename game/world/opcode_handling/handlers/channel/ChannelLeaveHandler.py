from game.world.managers.objects.units.player.ChannelManager import ChannelManager
from network.packet.PacketReader import *
from utils.constants.MiscCodes import ChannelNotifications


class ChannelLeaveHandler:

    @staticmethod
    def handle(world_session, reader):
        channel_name = PacketReader.read_string(reader.data, 0).capitalize()

        channel = ChannelManager.get_channel(channel_name, world_session.player_mgr)
        # Check if channel exists.
        if not channel:
            packet = ChannelManager.build_notify_packet(channel_name, ChannelNotifications.NOT_MEMBER)
            ChannelManager.send_to_player(world_session.player_mgr, packet)
            return 0

        ChannelManager.leave_channel(world_session.player_mgr, channel)

        return 0
