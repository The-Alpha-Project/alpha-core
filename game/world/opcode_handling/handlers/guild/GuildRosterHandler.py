from game.world.managers.objects.units.player.guild.GuildManager import GuildManager
from network.packet.PacketWriter import *
from utils.constants.MiscCodes import GuildCommandResults, GuildTypeCommand
from utils.constants.OpCodes import OpCode


class GuildRosterHandler:

    @staticmethod
    def handle(world_session, reader):
        player = world_session.player_mgr

        if not player.guild_manager:
            GuildManager.send_guild_command_result(player, GuildTypeCommand.GUILD_CREATE_S, '',
                                                   GuildCommandResults.GUILD_PLAYER_NOT_IN_GUILD)
        else:
            guild_name = PacketWriter.string_to_bytes(player.guild_manager.guild.name)
            data = pack(
                f'<{len(guild_name)}s',
                guild_name
            )

            # Members count. One snapshot, members can join or leave on other threads meanwhile.
            members = list(player.guild_manager.members.values())
            data += pack('<I', len(members))
            data += pack('<I', GuildManager.get_account_count(members))

            for member in members:
                player_name = PacketWriter.string_to_bytes(member.character.name)
                data += pack(
                    f'<{len(player_name)}sI',
                    player_name,
                    member.rank
                )

            player.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_GUILD_ROSTER, data))

        return 0
