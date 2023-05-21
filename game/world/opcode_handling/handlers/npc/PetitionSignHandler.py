from struct import unpack

from game.world.WorldSessionStateHandler import WorldSessionStateHandler
from game.world.managers.objects.units.player.guild.PetitionManager import PetitionManager


class PetitionSignHandler(object):

    @staticmethod
    def handle(world_session, reader):
        if len(reader.data) >= 8:  # Avoid handling empty petition sign packet.
            petition_guid = unpack('<Q', reader.data[:8])[0]

            if petition_guid > 0:
                petition = PetitionManager.get_petition(petition_guid)
                petition_owner = WorldSessionStateHandler.find_player_by_guid(petition.owner_guid)
                if petition and petition_owner:
                    PetitionManager.sign_petition(petition, world_session.player_mgr, petition_owner)

        return 0
