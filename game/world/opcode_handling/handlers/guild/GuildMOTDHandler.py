from game.world.managers.objects.player.guild.GuildManager import GuildManager
from network.packet.PacketReader import *
from utils.constants.MiscCodes import GuildCommandResults, GuildTypeCommand, GuildRank


class GuildMOTDHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if reader.data:  # Handle null data.
            motd = PacketReader.read_string(reader.data, 0).strip()
            player_mgr = world_session.player_mgr

            if not player_mgr.guild_manager:
                GuildManager.send_guild_command_result(player_mgr, GuildTypeCommand.GUILD_INVITE_S, '',
                                                       GuildCommandResults.GUILD_PLAYER_NOT_IN_GUILD)
            elif player_mgr.guild_manager.get_rank(player_mgr.guid) > GuildRank.GUILDRANK_OFFICER:
                GuildManager.send_guild_command_result(player_mgr, GuildTypeCommand.GUILD_INVITE_S, '',
                                                       GuildCommandResults.GUILD_PERMISSIONS)
            else:
                player_mgr.guild_manager.set_motd(motd)
        elif world_session.player_mgr.guild_manager:
            world_session.player_mgr.guild_manager.send_motd(world_session.player_mgr)

        return 0
