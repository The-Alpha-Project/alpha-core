from game.world.opcode_handling.HandlerValidator import HandlerValidator
from struct import unpack

from game.world.managers.objects.units.player.guild.GuildManager import GuildManager
from utils.constants.MiscCodes import GuildEmblemResult, GuildRank

EMBLEM_COST = 100000


class GuildSaveEmblemHandler:

    @staticmethod
    def handle(world_session, reader):
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode)
        if not player_mgr:
            return res

        # Tabard can only be set once.
        # Client CGPlayer_C::SaveTabard only sends this when all emblem fields are -1; otherwise it
        #  shows GERR_GUILDEMBLEM_COLORSPRESENT and never submits a new emblem.
        # Avoid handling an empty guild save emblem packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=20):
            return 0
        style, color, border_style, border_color, background_color = unpack('<5I', reader.data[:20])
        guild_manager = player_mgr.guild_manager

        if not guild_manager:
            GuildManager.send_emblem_result(player_mgr, GuildEmblemResult.ERR_GUILDEMBLEM_NOGUILD)
            return 0

        if guild_manager.get_rank(player_mgr.guid) != GuildRank.GUILDRANK_GUILD_MASTER:
            GuildManager.send_emblem_result(player_mgr,
                                            GuildEmblemResult.ERR_GUILDEMBLEM_NOTGUILDMASTER)
            return 0

        if player_mgr.coinage <= EMBLEM_COST:
            GuildManager.send_emblem_result(player_mgr,
                                            GuildEmblemResult.ERR_GUILDEMBLEM_NOTENOUGHMONEY)
            return 0

        guild_manager.modify_emblem(player_mgr, style, color, border_style, border_color, background_color)
        player_mgr.mod_money(-EMBLEM_COST)

        return 0
