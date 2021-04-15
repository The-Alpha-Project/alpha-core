from network.packet.PacketReader import *
from game.world.managers.objects.ChannelManager import ChannelManager


class ChannelLeaveHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        channel = PacketReader.read_string(reader.data, 0).capitalize()
        ChannelManager.leave_channel(world_session.player_mgr, channel)

        return 0
