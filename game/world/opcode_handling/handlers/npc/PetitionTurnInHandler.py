from struct import unpack

from game.world.managers.objects.units.player.guild.PetitionManager import PetitionManager
from utils.Logger import Logger


class PetitionTurnInHandler:

    @staticmethod
    def handle(world_session, reader):
        if len(reader.data) >= 8:  # Avoid handling empty petition turn in packet.
            petition_item_guid = unpack('<Q', reader.data[:8])[0]

            if petition_item_guid > 0:
                petition = PetitionManager.get_petition(petition_item_guid)
                if not petition:
                    Logger.error(f'Invalid guild petition turn in, guid {petition_item_guid}.')
                    return 0
                PetitionManager.turn_in_petition(world_session.player_mgr, petition.owner_guid, petition)

        return 0
