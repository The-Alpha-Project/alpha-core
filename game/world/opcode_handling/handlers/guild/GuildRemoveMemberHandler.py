from database.realm.RealmDatabaseManager import RealmDatabaseManager
from game.world.managers.objects.units.player.guild.GuildManager import GuildManager
from network.packet.PacketReader import *
from utils.constants.MiscCodes import GuildCommandResults, GuildTypeCommand, GuildRank


class GuildRemoveMemberHandler(object):

    @staticmethod
    def handle(world_session, reader):
        if len(reader.data) > 1:  # Avoid handling empty Guild Remove packet.
            target_name = PacketReader.read_string(reader.data, 0).strip()
            target_player_mgr = RealmDatabaseManager.character_get_by_name(target_name)
            player_mgr = world_session.player_mgr

            if not player_mgr.guild_manager:
                GuildManager.send_guild_command_result(player_mgr, GuildTypeCommand.GUILD_QUIT_S, '',
                                                       GuildCommandResults.GUILD_PLAYER_NOT_IN_GUILD)
            # Player does not exist.
            if not target_player_mgr:
                GuildManager.send_guild_command_result(player_mgr, GuildTypeCommand.GUILD_QUIT_S, target_name,
                                                       GuildCommandResults.GUILD_PLAYER_NOT_FOUND)
            # Member does not exist in the Guild.
            elif not player_mgr.guild_manager.has_member(target_player_mgr.guid):
                GuildManager.send_guild_command_result(player_mgr, GuildTypeCommand.GUILD_QUIT_S, target_name,
                                                       GuildCommandResults.GUILD_PLAYER_NOT_IN_GUILD)
            # Any rank below Officer is not allowed to kick another guild member.
            elif player_mgr.guild_manager.get_rank(player_mgr.guid) > GuildRank.GUILDRANK_OFFICER:
                GuildManager.send_guild_command_result(player_mgr, GuildTypeCommand.GUILD_INVITE_S, '',
                                                       GuildCommandResults.GUILD_PERMISSIONS)
            # Officers can't kick the Guild Master or another Officer.
            elif player_mgr.guild_manager.get_rank(target_player_mgr.guid) == GuildRank.GUILDRANK_OFFICER and player_mgr.guild_manager.get_rank(player_mgr.guid) <= GuildRank.GUILDRANK_OFFICER:
                GuildManager.send_guild_command_result(player_mgr, GuildTypeCommand.GUILD_INVITE_S, '',
                                                       GuildCommandResults.GUILD_PERMISSIONS)
            # GM self kick attempt.
            elif player_mgr.guild_manager.get_rank(target_player_mgr.guid) == GuildRank.GUILDRANK_GUILD_MASTER and player_mgr.guild_manager.get_rank(player_mgr.guid) == GuildRank.GUILDRANK_GUILD_MASTER:
                GuildManager.send_guild_command_result(player_mgr, GuildTypeCommand.GUILD_QUIT_S, '',
                                                       GuildCommandResults.GUILD_LEADER_LEAVE)
            else:
                player_mgr.guild_manager.remove_member(target_player_mgr.guid)

        return 0
