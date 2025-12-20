from game.world.managers.objects.units.player.guild.GuildManager import GuildManager
from network.packet.PacketReader import *


class GuildQueryHandler:

    @staticmethod
    def handle(world_session, reader):
        if len(reader.data) > 1:  # Avoid handling empty Guild Query packet.
            # No ranks/permissions on 0.5.3 client.
            guild_id = GuildManager.extract_real_guild_id(unpack('<1I', reader.data[:4])[0])
            player = world_session.player_mgr

            for guild_manager in GuildManager.GUILDS.values():
                if guild_manager.guild.guild_id == guild_id:
                    if player:
                        player.enqueue_packet(guild_manager.build_guild_query())
                    else:  # This opcode is requested by char enum if there is no guild cache on client.
                        world_session.enqueue_packet(guild_manager.build_guild_query())

        return 0
