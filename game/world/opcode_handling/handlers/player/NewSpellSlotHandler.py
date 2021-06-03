from struct import unpack
from database.realm.RealmDatabaseManager import RealmDatabaseManager
from database.realm.RealmModels import CharacterSpellButton


class NewSpellSlotHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 8:  # Avoid handling empty new spell slot packet.
            # Abilities index < 0
            # Spells index > 0
            # No zero, reserved for 'hidden' spells/abilities.
            spell, index = unpack('<Ii', reader.data[:8])

            spell_button = RealmDatabaseManager.character_get_spell_button(world_session.player_mgr.player.guid, index)
            if spell_button:
                spell_button.spell = spell
                RealmDatabaseManager.character_update_spell_button(spell_button)
            else:
                button = CharacterSpellButton()
                button.owner = world_session.player_mgr.player.guid
                button.index = index
                button.spell = spell
                RealmDatabaseManager.character_add_spell_button(button)

        return 0
