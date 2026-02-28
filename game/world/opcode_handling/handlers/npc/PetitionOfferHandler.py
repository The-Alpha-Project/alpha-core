from struct import unpack

from game.world.WorldSessionStateHandler import WorldSessionStateHandler
from game.world.managers.objects.units.player.guild.GuildManager import GuildManager
from game.world.managers.objects.units.player.guild.PetitionManager import PetitionManager
from game.world.opcode_handling.HandlerValidator import HandlerValidator
from utils.constants.ItemCodes import PetitionError
from utils.constants.MiscCodes import GuildTypeCommand, GuildCommandResults


class PetitionOfferHandler:

    @staticmethod
    def handle(world_session, reader):
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode)
        if not player_mgr:
            return res

        # Avoid handling an empty petition offer packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=16):
            return 0

        petition_item_guid, target_player_guid = unpack('<2Q', reader.data[:16])
        if petition_item_guid <= 0 or target_player_guid <= 0:
            return 0

        petition = PetitionManager.get_petition(petition_item_guid)
        target_player_mgr = WorldSessionStateHandler.find_player_by_guid(target_player_guid)

        # If this player does not own the petition item, treat as invalid.
        if not player_mgr.inventory.get_item_by_guid(petition_item_guid):
            PetitionManager.send_petition_sign_result(player_mgr, PetitionError.PETITION_UNKNOWN_ERROR)
            return 0

        # If petition is invalid or doesn't belong to the offering player.
        if not petition or petition.owner_guid != player_mgr.guid:
            PetitionManager.send_petition_sign_result(player_mgr, PetitionError.PETITION_UNKNOWN_ERROR)
            return 0

        # If target not found.
        if not target_player_mgr:
            GuildManager.send_guild_command_result(player_mgr, GuildTypeCommand.GUILD_INVITE_S, 'Player',
                                                   GuildCommandResults.GUILD_PLAYER_NOT_FOUND)
            return 0

        # If target is from the opposite faction.
        if target_player_mgr.team != player_mgr.team:
            GuildManager.send_guild_command_result(player_mgr, GuildTypeCommand.GUILD_INVITE_S, '',
                                                   GuildCommandResults.GUILD_NOT_ALLIED)
            return 0

        # If target is already in a guild.
        if target_player_mgr.guild_manager:
            GuildManager.send_guild_command_result(player_mgr, GuildTypeCommand.GUILD_INVITE_S,
                                                   target_player_mgr.get_name(),
                                                   GuildCommandResults.GUILD_ALREADY_IN_GUILD)
            return 0

        # Keep parity with vmangos: cannot sign charter while already invited to a guild.
        if target_player_mgr.guid in GuildManager.PENDING_INVITES:
            GuildManager.send_guild_command_result(player_mgr, GuildTypeCommand.GUILD_INVITE_S,
                                                   target_player_mgr.get_name(),
                                                   GuildCommandResults.ALREADY_INVITED_TO_GUILD)
            return 0

        packet = PetitionManager.build_signatures_packet(petition)
        target_player_mgr.enqueue_packet(packet)

        return 0
