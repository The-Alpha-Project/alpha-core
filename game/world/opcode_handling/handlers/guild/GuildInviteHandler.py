from network.packet.PacketReader import *
from game.world.WorldSessionStateHandler import WorldSessionStateHandler
from network.packet.PacketWriter import *
from game.world.managers.objects.player.guild.GuildManager import GuildManager
from utils.constants.ObjectCodes import GuildCommandResults, GuildTypeCommand, GuildRank


class GuildInviteHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        target_name = PacketReader.read_string(reader.data, 0).strip()
        target_player_mgr = WorldSessionStateHandler.find_player_by_name(target_name)
        player_mgr = world_session.player_mgr

        if not player_mgr.guild_manager:
            GuildManager.send_guild_command_result(player_mgr, GuildTypeCommand.GUILD_INVITE_S, '',
                                                   GuildCommandResults.GUILD_PLAYER_NOT_IN_GUILD)
        elif player_mgr.guild_manager.get_guild_rank(player_mgr) > GuildRank.GUILDRANK_OFFICER:
            GuildManager.send_guild_command_result(player_mgr, GuildTypeCommand.GUILD_INVITE_S, '',
                                                   GuildCommandResults.GUILD_PERMISSIONS)
        elif not target_player_mgr:
            GuildManager.send_guild_command_result(player_mgr, GuildTypeCommand.GUILD_INVITE_S, target_name,
                                                   GuildCommandResults.GUILD_PLAYER_NOT_FOUND)
        elif target_player_mgr.guild_manager:
            GuildManager.send_guild_command_result(player_mgr, GuildTypeCommand.GUILD_INVITE_S, target_name,
                                                   GuildCommandResults.GUILD_ALREADY_IN_GUILD)
        elif target_player_mgr.team != player_mgr.team:
            GuildManager.send_guild_command_result(player_mgr, GuildTypeCommand.GUILD_INVITE_S, '',
                                                   GuildCommandResults.GUILD_NOT_ALLIED)
        else:
            if player_mgr.guild_manager.invite_member(player_mgr, target_player_mgr):
                GuildManager.send_guild_command_result(player_mgr, GuildTypeCommand.GUILD_INVITE_S, target_name,
                                                       GuildCommandResults.GUILD_U_HAVE_INVITED)

                name_bytes = PacketWriter.string_to_bytes(player_mgr.player.name)
                data = pack(
                    f'<{len(name_bytes)}s',
                    name_bytes,
                )

                guild_name_bytes = PacketWriter.string_to_bytes(player_mgr.guild_manager.guild_name)
                data += pack(
                    f'<{len(guild_name_bytes)}s',
                    guild_name_bytes,
                )

                target_player_mgr.session.request.sendall(PacketWriter.get_packet(OpCode.SMSG_GUILD_INVITE, data))

        return 0
