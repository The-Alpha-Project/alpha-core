from game.world.opcode_handling.HandlerValidator import HandlerValidator
from struct import unpack


class CancelChannellingHandler:

    @staticmethod
    def handle(world_session, reader):
        # Avoid handling an empty cancel channelling packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=4):
            return 0
        spell_id = unpack('<I', reader.data[:4])[0]
        world_session.player_mgr.spell_manager.remove_cast_by_id(spell_id, interrupted=True)
        return 0
