from network.packet.PacketReader import *
from game.world.managers.objects.ChannelManager import ChannelManager


class ChannelListHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        channel = PacketReader.read_string(reader.data, 0).strip().capitalize()
        ChannelManager.list_channel(channel, world_session.player_mgr)

        return 0