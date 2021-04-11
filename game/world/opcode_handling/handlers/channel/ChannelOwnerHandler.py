from network.packet.PacketReader import *
from game.world.managers.objects.ChannelManager import ChannelManager


class ChannelOwnerHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        channel = PacketReader.read_string(reader.data, 0).strip()
        ChannelManager.get_owner(channel, world_session.player_mgr)
        return 0

    @staticmethod
    def handle_set_owner(world_session, socket, reader):
        channel = PacketReader.read_string(reader.data, 0).strip()

        offset = len(channel) + 1
        has_player = len(reader.data) == offset + 1
        player_name = '' if has_player else PacketReader.read_string(reader.data, offset, 0).strip()

        print('SET OWNR ' + channel + ' ' + player_name)
        return 0