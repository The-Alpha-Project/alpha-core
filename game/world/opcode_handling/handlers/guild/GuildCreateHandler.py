from game.world.managers.objects.units.player.guild.GuildManager import GuildManager
from network.packet.PacketReader import *


class GuildCreateHandler:

    @staticmethod
    def handle(world_session, reader):
        if len(reader.data) > 1:  # Avoid handling empty Guild Create packet.
            if not world_session.account_mgr.is_gm():
                return 0
            guild_name = PacketReader.read_string(reader.data, 0).strip()
            player_mgr = world_session.player_mgr
            GuildManager.create_guild(player_mgr, guild_name)

        return 0
