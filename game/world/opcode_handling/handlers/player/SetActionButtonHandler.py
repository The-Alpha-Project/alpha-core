from struct import unpack
from database.realm.RealmDatabaseManager import RealmDatabaseManager
from database.realm.RealmModels import CharacterButton


class SetActionButtonHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 5:  # Avoid handling empty set action button packet.
            index, action = unpack('<Bi', reader.data[:5])

            button = RealmDatabaseManager.character_get_button(world_session.player_mgr.player.guid, index)
            if button:
                if action == 0:  # Delete
                    RealmDatabaseManager.character_delete_button(button)
                else:  # Update
                    button.action = action
                    RealmDatabaseManager.character_update_button(button)
            else:
                button = CharacterButton()
                button.owner = world_session.player_mgr.player.guid
                button.index = index
                button.action = action
                RealmDatabaseManager.character_add_button(button)

        return 0
