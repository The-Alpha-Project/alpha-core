from struct import unpack
from database.realm.RealmDatabaseManager import RealmDatabaseManager
from database.realm.RealmModels import CharacterButton
from game.world.opcode_handling.HandlerValidator import HandlerValidator


class SetActionButtonHandler:

    @staticmethod
    def handle(world_session, reader):
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode, disconnect=True)
        if not player_mgr:
            return res

        if len(reader.data) >= 5:  # Avoid handling empty set action button packet.
            index, action = unpack('<Bi', reader.data[:5])

            button = RealmDatabaseManager.character_get_button(player_mgr.player.guid, index)
            if button:
                if action == 0:  # Delete
                    RealmDatabaseManager.character_delete_button(button)
                else:  # Update
                    button.action = action
                    RealmDatabaseManager.character_update_button(button)
            elif index or action:
                button = CharacterButton()
                button.owner = player_mgr.player.guid
                button.index = index
                button.action = action
                RealmDatabaseManager.character_add_button(button)

        return 0
