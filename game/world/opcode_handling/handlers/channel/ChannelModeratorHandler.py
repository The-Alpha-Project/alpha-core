from network.packet.PacketReader import *
from game.world.managers.objects.ChannelManager import ChannelManager


class ChannelModeratorHandler(object):

    @staticmethod
    def handle_mod(world_session, socket, reader):
        channel = PacketReader.read_string(reader.data, 0).strip()
        offset = len(channel) + 1
        has_player = len(reader.data) == offset + 1
        player_name = '' if has_player else PacketReader.read_string(reader.data, offset, 0).strip()

        print('MOD ' + channel + ' ' + player_name)
        return 0

    @staticmethod
    def handle_unmod(world_session, socket, reader):
        channel = PacketReader.read_string(reader.data, 0).strip()
        offset = len(channel) + 1
        has_player = len(reader.data) == offset + 1
        player_name = '' if has_player else PacketReader.read_string(reader.data, offset, 0).strip()

        print('UNMOD ' + channel + ' ' + player_name)
        return 0

    @staticmethod
    def handle_moderate(world_session, socket, reader):
        channel = PacketReader.read_string(reader.data, 0).strip()
        offset = len(channel) + 1
        has_player = len(reader.data) == offset + 1
        player_name = '' if has_player else PacketReader.read_string(reader.data, offset, 0).strip()

        print('MODERATE ' + channel + ' ' + player_name)
        return 0