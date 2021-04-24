from multiprocessing import Value
from database.realm.RealmDatabaseManager import *

WORLD_SESSIONS = []
CURRENT_SESSIONS = Value('i', 0)


class WorldSessionStateHandler(object):

    @staticmethod
    def add(session):
        if session not in WORLD_SESSIONS:
            CURRENT_SESSIONS.value += 1
            WORLD_SESSIONS.append(session)

    @staticmethod
    def remove(session):
        if session in WORLD_SESSIONS:
            CURRENT_SESSIONS.value -= 1
            WORLD_SESSIONS.remove(session)

    @staticmethod
    def disonnect_old_session(new_session):
        if not new_session or not new_session.account_mgr:
            return

        for session in WORLD_SESSIONS:
            if session.account_mgr and session.account_mgr.account.id == new_session.account_mgr.account.id:
                session.disconnect()
                break

    @staticmethod
    def get_world_sessions():
        return list(WORLD_SESSIONS)

    @staticmethod
    def get_process_shared_session_number():
        return CURRENT_SESSIONS.value

    @staticmethod
    def get_session_by_account_id(account_id):
        for session in WORLD_SESSIONS:
            if session.account_mgr and session.account_mgr.account.id == account_id:
                return session
        return None

    @staticmethod
    def get_session_by_character_guid(character_guid):
        for session in WORLD_SESSIONS:
            if session.player_mgr and session.player_mgr.guid == character_guid:
                return session
        return None

    @staticmethod
    def find_player_by_guid(guid_to_search):
        for session in WORLD_SESSIONS:
            if session.player_mgr and session.player_mgr.online:
                if session.player_mgr.guid == guid_to_search:
                    return session.player_mgr
        return None

    @staticmethod
    def find_player_by_name(name_to_search):
        for session in WORLD_SESSIONS:
            if session.player_mgr and session.player_mgr.online:
                if session.player_mgr.player.name.lower() == name_to_search.lower():
                    return session.player_mgr
        return None

    @staticmethod
    def update_players():
        for session in WORLD_SESSIONS:
            if session.player_mgr and session.player_mgr.online:
                if not session.player_mgr.update_lock:
                    session.player_mgr.update()

    @staticmethod
    def save_characters():
        try:
            for session in WorldSessionStateHandler.get_world_sessions():
                if session.player_mgr and session.player_mgr.online:
                    WorldSessionStateHandler.save_character(session.player_mgr)
        except AttributeError:
            pass

    @staticmethod
    def save_character(player_mgr):
        try:
            player_mgr.sync_player()
            RealmDatabaseManager.character_update(player_mgr.player)
        except AttributeError:
            pass