from game.world.managers.objects.units.player.ChannelManager import ChannelManager
from network.packet.PacketReader import *


class ChannelLeaveHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        channel = PacketReader.read_string(reader.data, 0).capitalize()
        ChannelManager.leave_channel(world_session.player_mgr, channel)

        return 0
