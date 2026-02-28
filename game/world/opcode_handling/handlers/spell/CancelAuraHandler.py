from game.world.opcode_handling.HandlerValidator import HandlerValidator
from struct import unpack


class CancelAuraHandler:
    @staticmethod
    def handle(world_session, reader):
        # Avoid handling an empty cancel aura packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=4):
            return 0
        spell_id = unpack('<I', reader.data[:4])[0]
        world_session.player_mgr.aura_manager.handle_player_cancel_aura_request(spell_id)
        return 0
