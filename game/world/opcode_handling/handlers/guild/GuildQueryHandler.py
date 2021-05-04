from network.packet.PacketReader import *
from network.packet.PacketWriter import *
from game.world.managers.objects.player.guild.GuildManager import GuildManager


class GuildQueryHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if reader.data:  # Handle null data.
            # No ranks/permissions on 0.5.3 client.
            guild_id = unpack('<1I', reader.data[:4])[0]
            player = world_session.player_mgr

            # TODO, Fix this, go back to guid key...
            for guild_manager in GuildManager.GUILDS.values():
                if guild_manager.guild.guild_id == guild_id:
                    guild = guild_manager.guild
                    data = pack('<1I', guild_id)

                    name_bytes = PacketWriter.string_to_bytes(guild.name)
                    data += pack(
                        f'<{len(name_bytes)}s',
                        name_bytes
                    )

                    data += pack('<5i', guild.emblem_style, guild.emblem_color, guild.border_style, guild.border_color, guild.background_color)
                    player.session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_GUILD_QUERY_RESPONSE, data))

        return 0
