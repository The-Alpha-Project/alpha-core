from game.world.managers.objects.units.player.guild.GuildManager import GuildManager
from utils.constants.MiscCodes import GuildCommandResults, GuildTypeCommand, GuildRank


class GuildInviteAcceptHandler:

    @staticmethod
    def handle(world_session, reader):
        player_mgr = world_session.player_mgr

        if player_mgr.guid in GuildManager.PENDING_INVITES:
            inviter = GuildManager.PENDING_INVITES[player_mgr.guid].inviter
            GuildManager.PENDING_INVITES.pop(player_mgr.guid)
            # The invited player could have joined or created another guild meanwhile, and the inviter could have
            # left, or lost the right to invite.
            if not player_mgr.guild_manager and inviter and inviter.guild_manager and \
                    inviter.guild_manager.get_rank(inviter.guid) <= GuildRank.GUILDRANK_OFFICER:
                inviter.guild_manager.add_new_member(player_mgr)
        else:
            GuildManager.send_guild_command_result(player_mgr, GuildTypeCommand.GUILD_INVITE_S, '',
                                                   GuildCommandResults.GUILD_INTERNAL)

        return 0
