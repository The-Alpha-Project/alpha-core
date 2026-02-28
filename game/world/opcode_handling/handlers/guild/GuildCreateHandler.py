from game.world.opcode_handling.HandlerValidator import HandlerValidator
from game.world.managers.objects.units.player.guild.GuildManager import GuildManager
from network.packet.PacketReader import *


class GuildCreateHandler:

    @staticmethod
    def handle(world_session, reader):
        # Avoid handling an empty Guild Create packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=2):
            return 0
        if not world_session.account_mgr.is_gm():
            return 0
        guild_name = PacketReader.read_string(reader.data, 0).strip()
        player_mgr = world_session.player_mgr
        GuildManager.create_guild(player_mgr, guild_name)

        return 0
