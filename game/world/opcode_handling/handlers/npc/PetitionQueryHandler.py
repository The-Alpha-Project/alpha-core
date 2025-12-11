from struct import unpack

from game.world.managers.objects.units.player.guild.PetitionManager import PetitionManager


class PetitionQueryHandler:

    @staticmethod
    def handle(world_session, reader):
        if len(reader.data) >= 12:  # Avoid handling empty petition query packet.
            petition_id, petition_item_guid = unpack('<IQ', reader.data[:12])

            petition = PetitionManager.get_petition(petition_item_guid)
            if petition:
                packet = PetitionManager.build_petition_query(petition)
                world_session.enqueue_packet(packet)

        return 0
