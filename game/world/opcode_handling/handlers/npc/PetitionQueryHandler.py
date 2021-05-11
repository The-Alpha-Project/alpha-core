from struct import unpack
from game.world.managers.objects.player.guild.PetitionManager import PetitionManager


class PetitionQueryHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        # NPC needs 0x80 | 0x40 flag
        if len(reader.data) >= 12:  # Avoid handling empty petition query packet
            lo_petition_guid = unpack('<H', reader.data[:2])[0]  # We just need the lo_guid

            petition = PetitionManager.get_petition(lo_petition_guid)
            if petition:
                packet = PetitionManager.build_petition_query(lo_petition_guid, petition)
                world_session.player_mgr.session.enqueue_packet(packet)

        return 0
