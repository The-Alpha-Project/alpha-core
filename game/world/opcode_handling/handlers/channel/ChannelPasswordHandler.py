from game.world.managers.objects.units.player.ChannelManager import ChannelManager
from network.packet.PacketReader import *


class ChannelPasswordHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        channel = PacketReader.read_string(reader.data, 0).strip().capitalize()
        offset = len(channel) + 1
        skip_pass = len(reader.data) == offset + 1
        password = '' if skip_pass else PacketReader.read_string(reader.data, offset, 0).strip()
        ChannelManager.set_password(channel, world_session.player_mgr, password)

        return 0
