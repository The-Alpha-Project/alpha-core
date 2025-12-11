from database.realm.RealmDatabaseManager import RealmDatabaseManager
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

            # Members count
            data += pack('<I', len(player.guild_manager.members))
            accounts = RealmDatabaseManager.guild_get_accounts(guild_id=player.guild_manager.guild.guild_id)
            data += pack('<I', len(accounts))

            for member in player.guild_manager.members.values():
                player_name = PacketWriter.string_to_bytes(member.character.name)
                data += pack(
                    f'<{len(player_name)}sI',
                    player_name,
                    member.rank
                )

            player.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_GUILD_ROSTER, data))

        return 0
