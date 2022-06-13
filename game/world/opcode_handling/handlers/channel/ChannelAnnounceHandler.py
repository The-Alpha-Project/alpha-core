from game.world.managers.objects.units.player.ChannelManager import ChannelManager
from network.packet.PacketReader import *


class ChannelAnnounceHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        channel = PacketReader.read_string(reader.data, 0).strip().capitalize()
        ChannelManager.toggle_announce(channel, world_session.player_mgr)

        return 0
