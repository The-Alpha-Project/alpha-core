from network.packet.PacketReader import PacketReader
from struct import unpack


class LearnSpellCheatHandler(object):

    @staticmethod
    def handle(world_session, socket, reader: PacketReader) -> int:
        if len(reader.data) >= 4:  # Avoid handling empty learn spell cheat packet.
            if not world_session.player_mgr.is_gm:
                return 0

            spell_id = unpack('<I', reader.data[:4])[0]
            world_session.player_mgr.spell_manager.learn_spell(spell_id)

        return 0
