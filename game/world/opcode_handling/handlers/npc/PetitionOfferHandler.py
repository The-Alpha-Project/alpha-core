from struct import unpack

from game.world.WorldSessionStateHandler import WorldSessionStateHandler
from game.world.managers.objects.units.player.guild.GuildManager import GuildManager
from game.world.managers.objects.units.player.guild.PetitionManager import PetitionManager
from utils.constants.ItemCodes import PetitionError
from utils.constants.MiscCodes import GuildTypeCommand, GuildCommandResults


class PetitionOfferHandler:

    @staticmethod
    def handle(world_session, reader):
        if len(reader.data) >= 16:  # Avoid handling empty petition offer packet.
            petition_item_guid, target_player_guid = unpack('<2Q', reader.data[:16])
            target_player_mgr = WorldSessionStateHandler.find_player_by_guid(target_player_guid)
            if petition_item_guid > 0:
                # If target not found.
                if not target_player_mgr:
                    GuildManager.send_guild_command_result(world_session.player_mgr, GuildTypeCommand.GUILD_INVITE_S,
                                                           'Player',
                                                           GuildCommandResults.GUILD_PLAYER_NOT_FOUND)
                    return 0

                # If target is from the opposite faction.
                if target_player_mgr.team != world_session.player_mgr.team:
                    GuildManager.send_guild_command_result(world_session.player_mgr, GuildTypeCommand.GUILD_INVITE_S,
                                                           '',
                                                           GuildCommandResults.GUILD_NOT_ALLIED)
                    return 0

                # If target is already in a guild.
                if target_player_mgr.guild_manager:
                    GuildManager.send_guild_command_result(world_session.player_mgr, GuildTypeCommand.GUILD_INVITE_S,
                                                           target_player_mgr.get_name(),
                                                           GuildCommandResults.GUILD_ALREADY_IN_GUILD)
                    return 0

                petition = PetitionManager.get_petition(petition_item_guid)
                if petition:
                    packet = PetitionManager.build_signatures_packet(petition)
                    target_player_mgr.enqueue_packet(packet)
                else:
                    PetitionManager.send_petition_sign_result(world_session.player_mgr,
                                                              PetitionError.PETITION_UNKNOWN_ERROR)

        return 0
