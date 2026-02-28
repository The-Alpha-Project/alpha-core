from game.world.opcode_handling.HandlerValidator import HandlerValidator
from struct import unpack


class LootReleaseHandler:

    @staticmethod
    def handle(world_session, reader):
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode)
        if not player_mgr:
            return res

        # Avoid handling an empty loot release packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=8):
            return 0
        guid = unpack('<Q', reader.data[:8])[0]
        loot_selection = player_mgr.loot_selection
        if not loot_selection or loot_selection.object_guid != guid:
            return 0

        player_mgr.send_loot_release(loot_selection)

        return 0
