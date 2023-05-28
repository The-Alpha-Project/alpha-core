from database.realm.RealmDatabaseManager import RealmDatabaseManager
from game.world.managers.objects.units.player.guild.GuildManager import GuildManager
from network.packet.PacketWriter import *
from utils.constants.MiscCodes import GuildCommandResults, GuildTypeCommand
from utils.constants.OpCodes import OpCode


class GuildInfoHandler(object):

    @staticmethod
    def handle(world_session, reader):
        player = world_session.player_mgr

        if not player.guild_manager:
            GuildManager.send_guild_command_result(player, GuildTypeCommand.GUILD_CREATE_S, '',
                                                   GuildCommandResults.GUILD_PLAYER_NOT_IN_GUILD)
        else:
            # Guild name
            name_bytes = PacketWriter.string_to_bytes(player.guild_manager.guild.name)
            data = pack(
                f'<{len(name_bytes)}s',
                name_bytes
            )

            accounts = RealmDatabaseManager.guild_get_accounts(guild_id=player.guild_manager.guild.guild_id)
            creation_date = player.guild_manager.guild.creation_date
            # Day, Month, Years, Players, Nº Accounts
            data += pack(
                '<5I',
                creation_date.day,
                creation_date.month,
                creation_date.year,
                len(player.guild_manager.members),
                len(accounts)
            )
            player.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_GUILD_INFO, data))

        return 0
