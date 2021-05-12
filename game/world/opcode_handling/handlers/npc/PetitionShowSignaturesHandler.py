from struct import unpack
from game.world.managers.objects.player.guild.PetitionManager import PetitionManager

CHARTER_ENTRY = 5863
CHARTER_DISPLAY_ID = 9199
CHARTER_COST = 1000


class PetitionShowSignaturesHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 8:  # Avoid handling empty petition show signatures packet
            peittion_guid = unpack('<Q', reader.data[:8])[0]
            lo_petition_guid = unpack('<H', reader.data[:2])[0]  # This represents charter item instance guid
            petition = PetitionManager.get_petition(lo_petition_guid)

            if petition:
                packet = PetitionManager.build_signatures_packet(peittion_guid, lo_petition_guid, petition)
                world_session.player_mgr.session.enqueue_packet(packet)

        return 0
