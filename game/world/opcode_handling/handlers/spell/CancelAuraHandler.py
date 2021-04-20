from struct import unpack


class CancelAuraHandler(object):
    @staticmethod
    def handle(world_session, socket, reader):
        spell_id = unpack('<I', reader.data[:4])
        if not spell_id:
            return
        world_session.player_mgr.aura_manager.cancel_auras_by_spell_id(spell_id[0])
        return 0
