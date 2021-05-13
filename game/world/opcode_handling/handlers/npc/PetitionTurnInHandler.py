from struct import unpack
from game.world.WorldSessionStateHandler import WorldSessionStateHandler
from game.world.managers.objects.player.guild.PetitionManager import PetitionManager


class PetitionTurnInHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 8:  # Avoid handling empty petition turn in packet
            lo_petition_guid = unpack('<H', reader.data[:2])[0]  # We just need the lo_guid

            if lo_petition_guid > 0:
                petition = PetitionManager.get_petition(lo_petition_guid)
                PetitionManager.turn_in_petition(world_session.player_mgr, petition.owner_guid, petition)

        return 0