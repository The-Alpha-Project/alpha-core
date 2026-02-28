from struct import unpack

from game.world.managers.objects.units.player.guild.PetitionManager import PetitionManager
from game.world.opcode_handling.HandlerValidator import HandlerValidator
from utils.Logger import Logger
from utils.constants.ItemCodes import PetitionError


class PetitionTurnInHandler:

    @staticmethod
    def handle(world_session, reader):
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode)
        if not player_mgr:
            return res

        # Avoid handling an empty petition turn in packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=8):
            return 0

        petition_item_guid = unpack('<Q', reader.data[:8])[0]
        if petition_item_guid <= 0:
            return 0

        petition_item = player_mgr.inventory.get_item_by_guid(petition_item_guid)
        if not petition_item:
            PetitionManager.send_petition_turn_in_result(player_mgr, PetitionError.PETITION_UNKNOWN_ERROR)
            return 0

        petition = PetitionManager.get_petition(petition_item_guid)
        if not petition:
            PetitionManager.send_petition_turn_in_result(player_mgr, PetitionError.PETITION_UNKNOWN_ERROR)
            Logger.error(f'Invalid guild petition turn in, guid {petition_item_guid}.')
            return 0

        PetitionManager.turn_in_petition(player_mgr, petition.owner_guid, petition)

        return 0
