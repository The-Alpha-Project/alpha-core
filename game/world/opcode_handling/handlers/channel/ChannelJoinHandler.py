from game.world.managers.objects.units.player.ChannelManager import ChannelManager
from game.world.opcode_handling.HandlerValidator import HandlerValidator
from network.packet.PacketReader import *


class ChannelJoinHandler:

    @staticmethod
    def handle(world_session, reader):
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode)
        if not player_mgr:
            return res
        # Avoid handling an empty or truncated packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=1):
            return 0

        channel = PacketReader.read_string(reader.data, 0).strip().capitalize()
        offset = len(channel) + 1
        # Determine optional password presence without triggering a validation warning.
        skip_pass = len(reader.data) == offset + 1
        password = '' if skip_pass else PacketReader.read_string(reader.data, offset, 0).strip()
        ChannelManager.join_channel(player_mgr, channel, password)

        return 0
