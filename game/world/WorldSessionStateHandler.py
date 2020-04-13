import threading
from time import time

WORLD_SESSIONS = []


class WorldSessionStateHandler(object):

    @staticmethod
    def add(session):
        if session not in WORLD_SESSIONS:
            WORLD_SESSIONS.append(session)

    @staticmethod
    def remove(session):
        if session in WORLD_SESSIONS:
            WORLD_SESSIONS.remove(session)

    @staticmethod
    def disonnect_old_session(new_session):
        for session in WORLD_SESSIONS:
            if session.account_mgr and session.account_mgr.account.id == new_session.account_mgr.account.id:
                session.disconnect()
                break

    @staticmethod
    def get_world_sessions():
        return list(WORLD_SESSIONS)

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
            if session.player_mgr and session.player_mgr.is_online:
                if session.player_mgr.guid == guid_to_search:
                    return session.player_mgr
        return None

    @staticmethod
    def find_player_by_name(name_to_search):
        for session in WORLD_SESSIONS:
            if session.player_mgr and session.player_mgr.is_online:
                if session.player_mgr.player.name.lower() == name_to_search.lower():
                    return session.player_mgr
        return None

    @staticmethod
    def update_players():
        for session in WORLD_SESSIONS:
            if session.player_mgr and session.player_mgr.is_online:
                threading.Thread(target=session.player_mgr.update).start()
