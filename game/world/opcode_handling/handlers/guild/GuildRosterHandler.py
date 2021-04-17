from network.packet.PacketWriter import *
from utils.constants.UnitCodes import Classes, Races
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.objects.player.guild.GuildManager import GuildManager
from utils.constants.ObjectCodes import GuildCommandResults, GuildTypeCommand
from utils.TextUtils import GameTextFormatter


class GuildRosterHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        player = world_session.player_mgr

        if not player.guild_manager:
            GuildManager.send_guild_command_result(player, GuildTypeCommand.GUILD_CREATE_S, '',
                                                   GuildCommandResults.GUILD_PLAYER_NOT_IN_GUILD)
        else:
            guild_name = PacketWriter.string_to_bytes(player.guild_manager.guild_name)
            data = pack(
                f'<{len(guild_name)}s',
                guild_name
            )

            # Members count
            data += pack('<I', len(player.guild_manager.members))
            # TODO: Number of accounts
            data += pack('<I', 0)

            for member in player.guild_manager.members.values():
                player_name = PacketWriter.string_to_bytes(member.player.name)
                data += pack(
                    f'<{len(player_name)}sI',
                    player_name,
                    member.guild_manager.get_guild_rank(member)
                )

            player.session.send_message(PacketWriter.get_packet(OpCode.SMSG_GUILD_ROSTER, data))

        return 0
