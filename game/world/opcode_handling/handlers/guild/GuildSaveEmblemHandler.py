from struct import pack, unpack
from game.world.managers.objects.player.guild.GuildManager import GuildManager
from utils.constants.ObjectCodes import GuildEmblemResult, GuildRank

EMBLEM_COST = 10000


class GuildSaveEmblemHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        # NPC needs 0x80 | 0x40 flag
        if len(reader.data) >= 8:  # Avoid handling empty save emblem packet
            style, color, border_style, border_color, background_color = unpack('<5I', reader.data[:20])
            guid_vendor = unpack('<Q', reader.data[20:])[0]

            if not world_session.player_mgr.guild_manager:
                GuildManager.send_emblem_result(world_session.player_mgr, GuildEmblemResult.ERR_GUILDEMBLEM_NOGUILD)
            elif world_session.player_mgr.guild_manager.get_rank(
                    world_session.player_mgr.guid) != GuildRank.GUILDRANK_GUILD_MASTER:
                GuildManager.send_emblem_result(world_session.player_mgr,
                                                GuildEmblemResult.ERR_GUILDEMBLEM_NOTGUILDMASTER)
            elif world_session.player_mgr.coinage <= EMBLEM_COST:
                GuildManager.send_emblem_result(world_session.player_mgr,
                                                GuildEmblemResult.ERR_GUILDEMBLEM_NOTENOUGHMONEY)
            else:
                world_session.player_mgr.guild_manager.modify_emblem(world_session.player_mgr, style, color,
                                                                     border_style, border_color, background_color)
                world_session.player_mgr.mod_money(-EMBLEM_COST)

        return 0
