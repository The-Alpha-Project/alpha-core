from struct import unpack


class CancelAuraHandler(object):
    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 4:  # Avoid handling empty cancel aura packet
            spell_id = unpack('<I', reader.data[:4])[0]
            world_session.player_mgr.aura_manager.cancel_auras_by_spell_id(spell_id)
        return 0
