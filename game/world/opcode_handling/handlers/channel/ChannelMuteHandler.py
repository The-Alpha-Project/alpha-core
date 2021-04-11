from network.packet.PacketReader import *
from game.world.managers.objects.ChannelManager import ChannelManager


class ChannelMuteHandler(object):

    @staticmethod
    def handle_mute(world_session, socket, reader):
        channel = PacketReader.read_string(reader.data, 0).strip()
        offset = len(channel) + 1
        has_player = len(reader.data) == offset + 1
        player_name = '' if has_player else PacketReader.read_string(reader.data, offset, 0).strip()

        print('MUTE ' + channel + ' ' + player_name)
        return 0

    @staticmethod
    def handle_unmute(world_session, socket, reader):
        channel = PacketReader.read_string(reader.data, 0).strip()
        offset = len(channel) + 1
        has_player = len(reader.data) == offset + 1
        player_name = '' if has_player else PacketReader.read_string(reader.data, offset, 0).strip()

        print('UMUTE ' + channel + ' ' + player_name)
        return 0