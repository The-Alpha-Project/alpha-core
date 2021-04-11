from network.packet.PacketReader import *
from game.world.managers.objects.ChannelManager import ChannelManager


class ChannelAnnounceHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        channel = PacketReader.read_string(reader.data, 0).strip()
        ChannelManager.toggle_announce(channel, world_session.player_mgr)
        return 0