from struct import unpack

from game.world.WorldSessionStateHandler import WorldSessionStateHandler
from game.world.managers.objects.player.guild.GuildManager import GuildManager
from game.world.managers.objects.player.guild.PetitionManager import PetitionManager
from utils.constants.ItemCodes import PetitionError
from utils.constants.MiscCodes import GuildTypeCommand, GuildCommandResults


class PetitionOfferHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 16:  # Avoid handling empty petition offer packet.
            petition_item_guid, target_player_guid = unpack('<2Q', reader.data[:16])
            target_player_mgr = WorldSessionStateHandler.find_player_by_guid(target_player_guid)
            if petition_item_guid > 0:
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
                    petition = PetitionManager.get_petition(petition_item_guid)
                    if petition:
                        packet = PetitionManager.build_signatures_packet(petition)
                        target_player_mgr.enqueue_packet(packet)
                    else:
                        PetitionManager.send_petition_sign_result(world_session.player_mgr, PetitionError.PETITION_UNKNOWN_ERROR)

        return 0
