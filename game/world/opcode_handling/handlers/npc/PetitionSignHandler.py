from struct import unpack

from game.world.WorldSessionStateHandler import WorldSessionStateHandler
from game.world.managers.objects.units.player.PlayerManager import PlayerManager
from game.world.managers.objects.units.player.guild.GuildManager import GuildManager
from game.world.managers.objects.units.player.guild.PetitionManager import PetitionManager
from game.world.opcode_handling.HandlerValidator import HandlerValidator
from utils.constants.ItemCodes import PetitionError
from utils.constants.MiscCodes import GuildTypeCommand, GuildCommandResults


class PetitionSignHandler:

    @staticmethod
    def handle(world_session, reader):
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode)
        if not player_mgr:
            return res

        # Avoid handling an empty petition sign packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=8):
            return 0

        petition_guid = unpack('<Q', reader.data[:8])[0]
        if petition_guid <= 0:
            return 0

        petition = PetitionManager.get_petition(petition_guid)
        if not petition:
            PetitionManager.send_petition_sign_result(player_mgr, PetitionError.PETITION_UNKNOWN_ERROR)
            return 0

        if petition.owner_guid == player_mgr.guid:
            PetitionManager.send_petition_sign_result(player_mgr, PetitionError.PETITION_CHARTER_CREATOR)
            return 0

        if player_mgr.guild_manager:
            PetitionManager.send_petition_sign_result(player_mgr, PetitionError.PETITION_ALREADY_IN_GUILD)
            return 0

        if player_mgr.guid in GuildManager.PENDING_INVITES:
            GuildManager.send_guild_command_result(player_mgr, GuildTypeCommand.GUILD_INVITE_S,
                                                   player_mgr.get_name(),
                                                   GuildCommandResults.ALREADY_INVITED_TO_GUILD)
            return 0

        petition_owner = WorldSessionStateHandler.find_player_by_guid(petition.owner_guid)
        owner_team = petition_owner.team if petition_owner else \
            PlayerManager.get_team_for_race(petition.character.race if petition.character else 0)
        if owner_team and owner_team != player_mgr.team:
            GuildManager.send_guild_command_result(player_mgr, GuildTypeCommand.GUILD_CREATE_S, '',
                                                   GuildCommandResults.GUILD_NOT_ALLIED)
            return 0

        PetitionManager.sign_petition(petition, player_mgr, petition_owner)

        return 0
