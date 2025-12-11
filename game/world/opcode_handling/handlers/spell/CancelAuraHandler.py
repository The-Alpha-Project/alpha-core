from struct import unpack


class CancelAuraHandler:
    @staticmethod
    def handle(world_session, reader):
        if len(reader.data) >= 4:  # Avoid handling empty cancel aura packet.
            spell_id = unpack('<I', reader.data[:4])[0]
            world_session.player_mgr.aura_manager.handle_player_cancel_aura_request(spell_id)
        return 0
