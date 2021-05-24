from struct import unpack
from database.realm.RealmDatabaseManager import RealmDatabaseManager
from database.realm.RealmModels import CharacterButton


# Max 120 buttons according to client.
class SetActionButtonHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 5:  # Avoid handling set action button packet.
            index = unpack('<B', reader.data[:1])[0]
            action = unpack('<i', reader.data[1:5])[0]

            button = RealmDatabaseManager.character_get_button(world_session.player_mgr.player.guid, index)
            if button:
                button.action = action
                RealmDatabaseManager.character_update_button(button)
            else:
                button = CharacterButton()
                button.owner = world_session.player_mgr.player.guid
                button.index = index
                button.action = action
                RealmDatabaseManager.character_add_button(button)

        return 0