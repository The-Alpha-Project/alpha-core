from network.packet.PacketReader import *
from game.world.managers.objects.player.guild.GuildManager import GuildManager
from utils.constants.ObjectCodes import GuildCommandResults, GuildTypeCommand


class GuildMOTDHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        motd = PacketReader.read_string(reader.data, 0).strip()
        player_mgr = world_session.player_mgr

        if not player_mgr.guild_manager:
            GuildManager.send_guild_command_result(player_mgr, GuildTypeCommand.GUILD_INVITE_S, '',
                                                   GuildCommandResults.GUILD_PLAYER_NOT_IN_GUILD)
        # TODO Maybe officer could also set MOTD
        elif player_mgr != player_mgr.guild_manager.guild_master:
            GuildManager.send_guild_command_result(player_mgr, GuildTypeCommand.GUILD_INVITE_S, '',
                                                   GuildCommandResults.GUILD_PERMISSIONS)
        elif motd:
            player_mgr.guild_manager.set_motd(motd)

        return 0
