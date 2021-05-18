from game.world.managers.objects.player.guild.GuildManager import GuildManager
from utils.constants.MiscCodes import GuildCommandResults, GuildTypeCommand, GuildRank


class GuildLeaveHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        player = world_session.player_mgr

        if not player.guild_manager:
            GuildManager.send_guild_command_result(player, GuildTypeCommand.GUILD_INVITE_S, '',
                                                   GuildCommandResults.GUILD_PLAYER_NOT_IN_GUILD)
        elif player.guild_manager.get_rank(player.guid) == GuildRank.GUILDRANK_GUILD_MASTER:  # GM should use disband.
            GuildManager.send_guild_command_result(player, GuildTypeCommand.GUILD_INVITE_S, '',
                                                   GuildCommandResults.GUILD_INTERNAL)
        else:
            player.guild_manager.leave(player.guid)

        return 0
