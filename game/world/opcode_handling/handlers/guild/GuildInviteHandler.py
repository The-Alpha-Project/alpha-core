from game.world.WorldSessionStateHandler import WorldSessionStateHandler
from game.world.managers.objects.units.player.guild.GuildManager import GuildManager
from network.packet.PacketReader import *
from network.packet.PacketWriter import *
from utils.constants.MiscCodes import GuildCommandResults, GuildTypeCommand, GuildRank


class GuildInviteHandler:

    @staticmethod
    def handle(world_session, reader):
        if len(reader.data) > 1:  # Avoid handling empty Guild Invite packet.
            target_name = PacketReader.read_string(reader.data, 0).strip()
            target_player_mgr = WorldSessionStateHandler.find_player_by_name(target_name)
            player_mgr = world_session.player_mgr

            if not player_mgr.guild_manager:
                GuildManager.send_guild_command_result(player_mgr, GuildTypeCommand.GUILD_INVITE_S, '',
                                                       GuildCommandResults.GUILD_PLAYER_NOT_IN_GUILD)
            elif player_mgr.guild_manager.get_rank(player_mgr.guid) > GuildRank.GUILDRANK_OFFICER:
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

                    name_bytes = PacketWriter.string_to_bytes(player_mgr.get_name())
                    data = pack(
                        f'<{len(name_bytes)}s',
                        name_bytes
                    )

                    guild_name_bytes = PacketWriter.string_to_bytes(player_mgr.guild_manager.guild.name)
                    data += pack(
                        f'<{len(guild_name_bytes)}s',
                        guild_name_bytes
                    )

                    target_player_mgr.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_GUILD_INVITE, data))

        return 0
