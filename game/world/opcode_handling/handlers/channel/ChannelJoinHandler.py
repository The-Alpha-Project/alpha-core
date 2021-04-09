from network.packet.PacketReader import *
from game.world.managers.objects.ChannelManager import ChannelManager


class ChannelJoinHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        channel = PacketReader.read_string(reader.data, 0).strip()
        offset = len(channel) + 1
        skip_pass = len(reader.data) == offset + 1
        password = '' if skip_pass else PacketReader.read_string(reader.data,offset, 0).strip()
        ChannelManager.join_channel(world_session.player_mgr, channel, password)

        return 0
