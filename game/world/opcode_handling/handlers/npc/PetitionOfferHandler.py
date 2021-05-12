from struct import unpack
from game.world.WorldSessionStateHandler import WorldSessionStateHandler
from game.world.managers.objects.player.guild.PetitionManager import PetitionManager


class PetitionOfferHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        # NPC needs 0x80 | 0x40 flag
        if len(reader.data) >= 16:  # Avoid handling empty petition offer packet
            petition_guid = unpack('<Q', reader.data[:8])[0]
            lo_petition_guid = unpack('<H', reader.data[:2])[0]  # We just need the lo_guid
            lo_player_target_guid = unpack('<H', reader.data[8:10])[0]  # Same

            if lo_petition_guid > 0:
                # TODO: Check if target is not enemy.
                petition = PetitionManager.get_petition(lo_petition_guid)
                target_plyr = WorldSessionStateHandler.find_player_by_guid(lo_player_target_guid)
                if petition and target_plyr:
                    packet = PetitionManager.build_signatures_packet(petition_guid, lo_petition_guid, petition)
                    target_plyr.session.enqueue_packet(packet)

        return 0
