from network.packet.PacketWriter import *
from game.world.managers.objects.player.guild.GuildManager import GuildManager
from utils.constants.ObjectCodes import GuildCommandResults, GuildTypeCommand


class GuildInfoHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        player = world_session.player_mgr

        if not player.guild_manager:
            GuildManager.send_guild_command_result(player, GuildTypeCommand.GUILD_CREATE_S, '',
                                                   GuildCommandResults.GUILD_PLAYER_NOT_IN_GUILD)
        else:
            # GuildName + MOTD
            name_bytes = PacketWriter.string_to_bytes(player.guild_manager.guild_name + f"\nMessage of the day: {player.guild_manager.motd}")
            data = pack(
                '<%us' % len(name_bytes),
                name_bytes,
            )

            # TODO: Handle proper date, what is Accounts?
            # Day, Month, Years, Players, Accounts
            data += pack('<5I', 0, 0, 0, len(player.guild_manager.members), 0)
            player.session.request.sendall(PacketWriter.get_packet(OpCode.SMSG_GUILD_INFO, data))

        return 0
