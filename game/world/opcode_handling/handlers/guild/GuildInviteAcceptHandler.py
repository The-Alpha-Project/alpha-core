from game.world.managers.objects.units.player.guild.GuildManager import GuildManager
from utils.constants.MiscCodes import GuildCommandResults, GuildTypeCommand


class GuildInviteAcceptHandler(object):

    @staticmethod
    def handle(world_session, reader):
        player_mgr = world_session.player_mgr

        if player_mgr.guid in GuildManager.PENDING_INVITES:
            inviter = GuildManager.PENDING_INVITES[player_mgr.guid].inviter
            GuildManager.PENDING_INVITES.pop(player_mgr.guid)
            if inviter and inviter.guild_manager:  # Invited could have left right after sending the invite.
                inviter.guild_manager.add_new_member(player_mgr)
        else:
            GuildManager.send_guild_command_result(player_mgr, GuildTypeCommand.GUILD_INVITE_S, '',
                                                   GuildCommandResults.GUILD_INTERNAL)

        return 0
