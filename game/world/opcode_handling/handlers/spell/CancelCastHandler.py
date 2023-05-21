from struct import unpack


class CancelCastHandler(object):

    @staticmethod
    def handle(world_session, reader):
        if len(reader.data) >= 4:  # Avoid handling empty cancel cast packet.
            spell_id = unpack('<I', reader.data[:4])[0]
            world_session.player_mgr.spell_manager.remove_cast_by_id(spell_id, interrupted=True)
        return 0
