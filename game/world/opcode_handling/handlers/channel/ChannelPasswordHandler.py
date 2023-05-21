from game.world.managers.objects.units.player.ChannelManager import ChannelManager
from network.packet.PacketReader import *
from utils.constants.MiscCodes import ChannelNotifications


class ChannelPasswordHandler(object):

    @staticmethod
    def handle(world_session, reader):
        channel_name = PacketReader.read_string(reader.data, 0).strip().capitalize()
        offset = len(channel_name) + 1
        skip_pass = len(reader.data) == offset + 1
        password = '' if skip_pass else PacketReader.read_string(reader.data, offset, 0).strip()

        channel = ChannelManager.get_channel(channel_name, world_session.player_mgr)
        # Check if channel exists.
        if not channel:
            packet = ChannelManager.build_notify_packet(channel_name, ChannelNotifications.NOT_MEMBER)
            ChannelManager.send_to_player(world_session.player_mgr, packet)
            return 0

        ChannelManager.set_password(channel, world_session.player_mgr, password)

        return 0
