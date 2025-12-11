from game.world.managers.objects.units.player.guild.GuildManager import GuildManager
from utils.constants.MiscCodes import GuildCommandResults, GuildTypeCommand, GuildRank


class GuildDisbandHandler:

    @staticmethod
    def handle(world_session, reader):
        player_mgr = world_session.player_mgr

        if not player_mgr.guild_manager:
            GuildManager.send_guild_command_result(player_mgr, GuildTypeCommand.GUILD_CREATE_S, '',
                                                   GuildCommandResults.GUILD_PLAYER_NOT_IN_GUILD)
        elif player_mgr.guild_manager.get_rank(player_mgr.guid) != GuildRank.GUILDRANK_GUILD_MASTER:
            GuildManager.send_guild_command_result(player_mgr, GuildTypeCommand.GUILD_FOUNDER_S, '',
                                                   GuildCommandResults.GUILD_PERMISSIONS)
        else:
            player_mgr.guild_manager.disband()

        return 0
