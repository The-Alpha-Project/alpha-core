from network.packet.PacketReader import *
from game.world.managers.objects.player.guild.GuildManager import GuildManager
from utils.constants.ObjectCodes import GuildCommandResults, GuildTypeCommand, GuildRank


class GuildMOTDHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        motd = PacketReader.read_string(reader.data, 0).strip()
        player_mgr = world_session.player_mgr

        if not player_mgr.guild_manager:
            GuildManager.send_guild_command_result(player_mgr, GuildTypeCommand.GUILD_INVITE_S, '',
                                                   GuildCommandResults.GUILD_PLAYER_NOT_IN_GUILD)
        elif not motd:
            player_mgr.guild_manager.send_motd()
        elif player_mgr.guild_manager.get_rank(player_mgr.guid) > GuildRank.GUILDRANK_OFFICER:
            GuildManager.send_guild_command_result(player_mgr, GuildTypeCommand.GUILD_INVITE_S, '',
                                                   GuildCommandResults.GUILD_PERMISSIONS)
        else:
            player_mgr.guild_manager.set_motd(motd)

        return 0
