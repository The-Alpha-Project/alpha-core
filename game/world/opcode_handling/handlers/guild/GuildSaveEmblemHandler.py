from struct import unpack

from game.world.managers.objects.units.player.guild.GuildManager import GuildManager
from utils.constants.MiscCodes import GuildEmblemResult, GuildRank

EMBLEM_COST = 100000


class GuildSaveEmblemHandler:

    @staticmethod
    def handle(world_session, reader):
        # Tabard can only be set once.
        # Client CGPlayer_C::SaveTabard only sends this when all emblem fields are -1; otherwise it
        #  shows GERR_GUILDEMBLEM_COLORSPRESENT and never submits a new emblem.
        if len(reader.data) >= 20:  # Avoid handling empty guild save emblem packet.
            style, color, border_style, border_color, background_color = unpack('<5I', reader.data[:20])

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
