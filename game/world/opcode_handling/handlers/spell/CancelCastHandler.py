from struct import unpack


class CancelCastHandler(object):

    @staticmethod
    def handle(world_session, reader):
        if len(reader.data) >= 4:  # Avoid handling empty cancel cast packet.
            spell_id = unpack('<I', reader.data[:4])[0]
            current_cast = world_session.player_mgr.spell_manager.get_casting_spell()
            if not current_cast or current_cast.spell_entry.ID != spell_id:
                return 0
            world_session.player_mgr.spell_manager.remove_cast(current_cast, interrupted=True)
        return 0
