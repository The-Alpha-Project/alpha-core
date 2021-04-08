from network.packet.PacketReader import *
from game.world.managers.objects.player.guild.GuildManager import GuildManager


class GuildCreateHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        guild_name = PacketReader.read_string(reader.data, 0).strip()
        player_mgr = world_session.player_mgr
        GuildManager.create_guild(player_mgr, guild_name)

        return 0
