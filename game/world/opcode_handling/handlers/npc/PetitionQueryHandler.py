from struct import unpack

from game.world.managers.objects.units.player.guild.PetitionManager import PetitionManager
from game.world.opcode_handling.HandlerValidator import HandlerValidator


class PetitionQueryHandler:

    @staticmethod
    def handle(world_session, reader):
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode)
        if not player_mgr:
            return res

        # Avoid handling an empty petition query packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=12):
            return 0

        petition_id, petition_item_guid = unpack('<IQ', reader.data[:12])
        if petition_id <= 0 or petition_item_guid <= 0:
            return 0

        petition = PetitionManager.get_petition(petition_item_guid)
        if not petition or petition.petition_id != petition_id:
            return 0

        packet = PetitionManager.build_petition_query(petition)
        world_session.enqueue_packet(packet)

        return 0
