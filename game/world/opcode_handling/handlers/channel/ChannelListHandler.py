from game.world.managers.objects.units.player.ChannelManager import ChannelManager
from network.packet.PacketReader import *
from utils.constants.MiscCodes import ChannelNotifications


class ChannelListHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        channel_name = PacketReader.read_string(reader.data, 0).strip().capitalize()

        channel = ChannelManager.get_channel(channel_name, world_session.player_mgr)
        # Check if channel exists.
        if not channel:
            packet = ChannelManager.build_notify_packet(channel_name, ChannelNotifications.NOT_MEMBER)
            ChannelManager.send_to_player(world_session.player_mgr, packet)
            return 0

        ChannelManager.send_channel_members_list(channel, world_session.player_mgr)

        return 0
