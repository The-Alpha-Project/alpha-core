from struct import unpack
from game.world.WorldSessionStateHandler import WorldSessionStateHandler
from game.world.managers.objects.player.guild.GuildManager import GuildManager
from game.world.managers.objects.player.guild.PetitionManager import PetitionManager
from utils.constants.ItemCodes import PetitionError
from utils.constants.ObjectCodes import GuildTypeCommand, GuildCommandResults


class PetitionOfferHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 16:  # Avoid handling empty petition offer packet.
            petition_guid = unpack('<Q', reader.data[:8])[0]
            lo_petition_guid = unpack('<H', reader.data[:2])[0]  # We just need the lo_guid
            lo_player_target_guid = unpack('<H', reader.data[8:10])[0]  # Same
            target_player_mgr = WorldSessionStateHandler.find_player_by_guid(lo_player_target_guid)
            if lo_petition_guid > 0:
                if not target_player_mgr:
                    GuildManager.send_guild_command_result(world_session.player_mgr, GuildTypeCommand.GUILD_INVITE_S,
                                                           'Player',
                                                           GuildCommandResults.GUILD_PLAYER_NOT_FOUND)
                elif target_player_mgr.guild_manager:
                    GuildManager.send_guild_command_result(world_session.player_mgr, GuildTypeCommand.GUILD_INVITE_S,
                                                           target_player_mgr.player.name,
                                                           GuildCommandResults.GUILD_ALREADY_IN_GUILD)
                if target_player_mgr.team != world_session.player_mgr.team:
                    GuildManager.send_guild_command_result(world_session.player_mgr, GuildTypeCommand.GUILD_INVITE_S,
                                                           '',
                                                           GuildCommandResults.GUILD_NOT_ALLIED)
                else:
                    petition = PetitionManager.get_petition(lo_petition_guid)
                    if petition:
                        packet = PetitionManager.build_signatures_packet(petition_guid, lo_petition_guid, petition)
                        target_player_mgr.session.enqueue_packet(packet)
                    else:
                        PetitionManager.send_petition_sign_result(world_session.player_mgr, PetitionError.PETITION_UNKNOWN_ERROR)

        return 0
