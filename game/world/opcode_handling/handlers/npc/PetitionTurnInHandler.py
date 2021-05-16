from struct import unpack
from game.world.WorldSessionStateHandler import WorldSessionStateHandler
from game.world.managers.objects.player.guild.PetitionManager import PetitionManager


class PetitionTurnInHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 8:  # Avoid handling empty petition turn in packet.
            petition_item_guid = unpack('<Q', reader.data[:8])[0]

            if petition_item_guid > 0:
                petition = PetitionManager.get_petition(petition_item_guid)
                PetitionManager.turn_in_petition(world_session.player_mgr, petition.owner_guid, petition)

        return 0
