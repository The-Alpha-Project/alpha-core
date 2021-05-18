from struct import unpack

from game.world.managers.objects.player.guild.PetitionManager import PetitionManager


class PetitionShowSignaturesHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 8:  # Avoid handling empty petition show signatures packet.
            petition_item_guid = unpack('<Q', reader.data[:8])[0]
            petition = PetitionManager.get_petition(petition_item_guid)

            if petition:
                packet = PetitionManager.build_signatures_packet(petition)
                world_session.player_mgr.session.enqueue_packet(packet)

        return 0
