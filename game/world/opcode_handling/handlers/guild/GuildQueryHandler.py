from network.packet.PacketReader import *
from network.packet.PacketWriter import *
from game.world.managers.objects.player.guild.GuildManager import GuildManager


class GuildQueryHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        # No ranks/permissions on 0.5.3 client.
        guild_id = unpack('<1I', reader.data[:4])[0]
        player = world_session.player_mgr

        if guild_id in GuildManager.GUILDS:
            guild = GuildManager.GUILDS[guild_id]
            data = pack('<1I', guild_id)

            name_bytes = PacketWriter.string_to_bytes(guild.guild_name)
            data += pack(
                f'<{len(name_bytes)}s',
                name_bytes,
            )

            # TODO: EmblemStyle, EmblemColor, BorderStyle, BorderColor, BGColor
            data += pack('<5i', -1, -1, -1, -1, -1)
            player.session.request.sendall(PacketWriter.get_packet(OpCode.SMSG_GUILD_QUERY_RESPONSE, data))

        return 0
