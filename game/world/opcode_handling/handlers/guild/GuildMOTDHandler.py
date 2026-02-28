from game.world.managers.objects.units.player.guild.GuildManager import GuildManager
from game.world.opcode_handling.HandlerValidator import HandlerValidator
from network.packet.PacketReader import *
from utils.constants.MiscCodes import GuildCommandResults, GuildTypeCommand, GuildRank


class GuildMOTDHandler:

    @staticmethod
    def handle(world_session, reader):
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode)
        if not player_mgr:
            return res

        if reader.data:  # Handle null data.
            # Avoid handling an empty or truncated packet.
            if not HandlerValidator.validate_packet_length(reader, min_length=1):
                return 0
            motd = PacketReader.read_string(reader.data, 0).strip()

            if not player_mgr.guild_manager:
                GuildManager.send_guild_command_result(player_mgr, GuildTypeCommand.GUILD_INVITE_S, '',
                                                       GuildCommandResults.GUILD_PLAYER_NOT_IN_GUILD)
            # Only Guild Masters could set the Guild MotD in 0.5.3.
            # 0.5.4 patch notes: "Guild officers are now able to set a "Guild Message of the Day.""
            elif player_mgr.guild_manager.get_rank(player_mgr.guid) > GuildRank.GUILDRANK_GUILD_MASTER:
                GuildManager.send_guild_command_result(player_mgr, GuildTypeCommand.GUILD_INVITE_S, '',
                                                       GuildCommandResults.GUILD_PERMISSIONS)
            else:
                player_mgr.guild_manager.set_motd(motd)
        elif player_mgr.guild_manager:
            player_mgr.guild_manager.send_motd(player_mgr)

        return 0
