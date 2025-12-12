from struct import unpack
from database.realm.RealmDatabaseManager import RealmDatabaseManager
from database.realm.RealmModels import CharacterSpellButton
from game.world.opcode_handling.HandlerValidator import HandlerValidator


class NewSpellSlotHandler:

    @staticmethod
    def handle(world_session, reader):
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode, disconnect=True)
        if not player_mgr:
            return res

        if len(reader.data) >= 8:  # Avoid handling empty new spell slot packet.
            # Abilities index < 0
            # Spells index > 0
            # No zero, reserved for 'hidden' spells/abilities.
            spell, index = unpack('<Ii', reader.data[:8])

            spell_button = RealmDatabaseManager.character_get_spell_button(player_mgr.player.guid, spell)
            if spell_button:
                spell_button.index = index
                RealmDatabaseManager.character_update_spell_button(spell_button)
            else:
                button = CharacterSpellButton()
                button.owner = world_session.player_mgr.player.guid
                button.index = index
                button.spell = spell
                RealmDatabaseManager.character_add_spell_button(button)

        return 0
