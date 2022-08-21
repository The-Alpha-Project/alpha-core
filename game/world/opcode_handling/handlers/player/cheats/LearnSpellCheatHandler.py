from game.world.opcode_handling.HandlerValidator import HandlerValidator
from utils.Logger import Logger
from struct import unpack


class LearnSpellCheatHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode, disconnect=False)
        if not player_mgr:
            return res

        if not player_mgr.is_gm:
            Logger.anticheat(f'Player {player_mgr.player.name} ({player_mgr.guid}) tried to learn spell.')
            return 0

        if len(reader.data) >= 4:  # Avoid handling empty learn spell cheat packet.
            spell_id = unpack('<I', reader.data[:4])[0]
            player_mgr.spell_manager.learn_spell(spell_id)

        return 0
