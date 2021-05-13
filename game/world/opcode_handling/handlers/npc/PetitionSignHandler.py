from struct import unpack
from game.world.WorldSessionStateHandler import WorldSessionStateHandler
from game.world.managers.objects.player.guild.PetitionManager import PetitionManager


class PetitionSignHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 8:  # Avoid handling empty petition sign packet
            lo_petition_guid = unpack('<H', reader.data[:2])[0]  # We just need the lo_guid

            if lo_petition_guid > 0:
                petition = PetitionManager.get_petition(lo_petition_guid)
                petition_owner = WorldSessionStateHandler.find_player_by_guid(petition.owner_guid)
                if petition and petition_owner:
                    PetitionManager.sign_petition(petition, world_session.player_mgr, petition_owner)

        return 0
