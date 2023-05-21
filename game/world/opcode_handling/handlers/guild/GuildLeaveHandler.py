from game.world.managers.objects.units.player.guild.GuildManager import GuildManager
from utils.constants.MiscCodes import GuildCommandResults, GuildTypeCommand, GuildRank


class GuildLeaveHandler(object):

    @staticmethod
    def handle(world_session, reader):
        player = world_session.player_mgr

        if not player.guild_manager:
            GuildManager.send_guild_command_result(player, GuildTypeCommand.GUILD_INVITE_S, '',
                                                   GuildCommandResults.GUILD_PLAYER_NOT_IN_GUILD)
        elif player.guild_manager.get_rank(player.guid) == GuildRank.GUILDRANK_GUILD_MASTER and player.guild_manager.has_members():  # GM should use disband.
            GuildManager.send_guild_command_result(player, GuildTypeCommand.GUILD_QUIT_S, '',
                                                   GuildCommandResults.GUILD_LEADER_LEAVE)
        elif player.guild_manager.get_rank(player.guid) == GuildRank.GUILDRANK_GUILD_MASTER and not player.guild_manager.has_members():
            player.guild_manager.disband()
        else:
            player.guild_manager.leave(player.guid)

        return 0
