from struct import unpack

from game.world.managers.objects.units.player.guild.PetitionManager import PetitionManager
from game.world.opcode_handling.HandlerValidator import HandlerValidator


class PetitionShowSignaturesHandler:

    @staticmethod
    def handle(world_session, reader):
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode)
        if not player_mgr:
            return res

        # Avoid handling an empty petition show signatures packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=8):
            return 0

        petition_item_guid = unpack('<Q', reader.data[:8])[0]
        if petition_item_guid <= 0:
            return 0

        if player_mgr.guild_manager:
            return 0

        petition_item = player_mgr.inventory.get_item_by_guid(petition_item_guid)
        if not petition_item:
            return 0

        petition = PetitionManager.get_petition(petition_item_guid)
        if not petition:
            return 0
        if petition.owner_guid != player_mgr.guid:
            return 0

        packet = PetitionManager.build_signatures_packet(petition)
        world_session.enqueue_packet(packet)

        return 0
