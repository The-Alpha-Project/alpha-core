from game.world.managers.objects.units.player.ChannelManager import ChannelManager
from network.packet.PacketReader import *


class ChannelJoinHandler:

    @staticmethod
    def handle(world_session, reader):
        channel = PacketReader.read_string(reader.data, 0).strip().capitalize()
        offset = len(channel) + 1
        skip_pass = len(reader.data) == offset + 1
        password = '' if skip_pass else PacketReader.read_string(reader.data, offset, 0).strip()
        ChannelManager.join_channel(world_session.player_mgr, channel, password)

        return 0
