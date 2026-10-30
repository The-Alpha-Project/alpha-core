import random
import time
import traceback
from threading import RLock

from database.auth.AuthDatabaseManager import AuthDatabaseManager
from database.realm.RealmDatabaseManager import *
from utils.Logger import Logger
from utils.constants.SaveCodes import SaveReason


WORLD_SESSIONS = []

# Storing players and sessions by different parameters to keep searches O(1)
# TODO Find better way to do this?
PLAYERS_BY_GUID = {}
PLAYER_BY_NAME = {}
SESSION_BY_GUID = {}
SESSION_BY_NAME = {}
PLAYER_SAVE_LOCKS = {}
PLAYER_LAST_SAVE_AT = {}
PLAYER_LAST_FULL_SAVE_AT = {}
PLAYER_SAVE_STATE_LOCK = RLock()
INFO_SAVE_REASONS = {
    SaveReason.LOGOUT,
    SaveReason.LEVEL_CHANGE,
    SaveReason.QUEST_REWARD,
    SaveReason.TELEPORT,
    SaveReason.SHUTDOWN,
    SaveReason.BANK_SLOT,
}
QUIET_SAVE_REASONS = {
    SaveReason.PERIODIC,
    SaveReason.MONEY,
    SaveReason.XP,
    SaveReason.ZONE_CHANGE,
}


class WorldSessionStateHandler:
    _online_count_written = None
    _online_count_written_at = 0.0

    @staticmethod
    def _get_player_save_lock(player_guid):
        with PLAYER_SAVE_STATE_LOCK:
            if player_guid not in PLAYER_SAVE_LOCKS:
                PLAYER_SAVE_LOCKS[player_guid] = RLock()
            return PLAYER_SAVE_LOCKS[player_guid]

    @staticmethod
    def _get_last_save_at(player_guid, full_save=False):
        # Core saves (xp, money...) happen often, so full saves track their own time or they would never be due.
        with PLAYER_SAVE_STATE_LOCK:
            return (PLAYER_LAST_FULL_SAVE_AT if full_save else PLAYER_LAST_SAVE_AT).get(player_guid, 0.0)

    @staticmethod
    def _set_last_save_at(player_guid, save_timestamp, full_save=False):
        with PLAYER_SAVE_STATE_LOCK:
            PLAYER_LAST_SAVE_AT[player_guid] = save_timestamp
            if full_save:
                PLAYER_LAST_FULL_SAVE_AT[player_guid] = save_timestamp

    @staticmethod
    def _set_last_full_save_at(player_guid, save_timestamp):
        with PLAYER_SAVE_STATE_LOCK:
            PLAYER_LAST_FULL_SAVE_AT[player_guid] = save_timestamp

    @staticmethod
    def _log_save_success(player_mgr, reason, elapsed_ms, full_save):
        reason_label = reason.label
        message = (
            f'[Save] {reason_label} {"full" if full_save else "core"} save for '
            f'[{player_mgr.get_name()}] guid={player_mgr.player.guid} '
            f'level={player_mgr.level} xp={player_mgr.xp} '
            f'map={player_mgr.map_id} zone={player_mgr.zone} '
            f'pos=({player_mgr.location.x:.1f},{player_mgr.location.y:.1f},{player_mgr.location.z:.1f}) '
            f'online={int(player_mgr.online)} took {elapsed_ms:.1f}ms.'
        )

        if reason in INFO_SAVE_REASONS:
            Logger.info(message)
        elif reason not in QUIET_SAVE_REASONS:
            Logger.debug(message)

    @staticmethod
    def add(session):
        if session not in WORLD_SESSIONS:
            WORLD_SESSIONS.append(session)

    @staticmethod
    def push_active_player_session(session):
        lowercase_name = session.player_mgr.get_name().lower()

        # This is filled upon player successful login (in-world).
        PLAYERS_BY_GUID[session.player_mgr.guid] = session.player_mgr
        # Start the periodic full save at a random point within the interval, otherwise players logging in together
        # (e.g. after a restart) would keep being saved in the same tick.
        interval = WorldSessionStateHandler.get_saving_interval()
        WorldSessionStateHandler._set_last_full_save_at(session.player_mgr.guid,
                                                        time.monotonic() - random.uniform(0, interval))
        PLAYER_BY_NAME[lowercase_name] = session.player_mgr
        SESSION_BY_GUID[session.player_mgr.guid] = session
        SESSION_BY_NAME[lowercase_name] = session

    @staticmethod
    def pop_active_player(player_mgr):
        lowercase_name = player_mgr.get_name().lower()

        # Flushed when player leaves the world.
        if lowercase_name in PLAYER_BY_NAME:
            PLAYER_BY_NAME.pop(lowercase_name)
        if player_mgr.guid in PLAYERS_BY_GUID:
            PLAYERS_BY_GUID.pop(player_mgr.guid)

        if lowercase_name in SESSION_BY_NAME:
            SESSION_BY_NAME.pop(lowercase_name)
        if player_mgr.guid in SESSION_BY_GUID:
            SESSION_BY_GUID.pop(player_mgr.guid)

    @staticmethod
    def remove(session):
        if session in WORLD_SESSIONS:
            WORLD_SESSIONS.remove(session)
        if session.player_mgr:
            WorldSessionStateHandler.pop_active_player(session.player_mgr)

    @staticmethod
    def disconnect_old_session(new_session):
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
    def get_session_by_account_id(account_id):
        for session in WORLD_SESSIONS:
            if session.account_mgr and session.account_mgr.account.id == account_id:
                return session
        return None

    @staticmethod
    def get_session_by_character_guid(character_guid):
        return SESSION_BY_GUID.get(character_guid)

    @staticmethod
    def get_session_by_character_name(character_name):
        return SESSION_BY_NAME.get(character_name.lower())
    
    @staticmethod
    def find_player_by_guid(guid_to_search):
        return PLAYERS_BY_GUID.get(guid_to_search)

    @staticmethod
    def find_player_by_name(name_to_search):
        return PLAYER_BY_NAME.get(name_to_search.lower())

    @staticmethod
    def update_players():
        now = time.time()
        for session in WORLD_SESSIONS:
            if (session.player_mgr and session.player_mgr.online and not session.player_mgr.update_lock
                    and not session.player_mgr.logout_in_progress):
                # A failing player must not stop the update of every player after it.
                try:
                    session.player_mgr.update(now)
                except Exception as ex:
                    Logger.error(f'Error while updating [{session.player_mgr.get_name()}]: {ex}.')
                    Logger.error(traceback.format_exc())

    @staticmethod
    def get_saving_interval():
        # Zero or negative would save every player on every ticker loop without ever sleeping.
        return max(1.0, config.Server.Settings.realm_saving_interval_seconds)

    @staticmethod
    def save_due_characters():
        # Saving every player at once froze the world ticker for the whole batch once per interval. Instead, this runs
        # every few seconds and only saves the players whose last full save is older than the interval, so each player
        # is still saved once per interval but the work is spread across ticks.
        WorldSessionStateHandler.save_characters(
            min_interval_seconds=WorldSessionStateHandler.get_saving_interval())

    @staticmethod
    def save_characters(reason=SaveReason.PERIODIC, allow_locked=False, min_interval_seconds=0.0):
        online_player_count = 0
        for session in WorldSessionStateHandler.get_world_sessions():
            if not session.player_mgr or not session.player_mgr.online or session.player_mgr.logout_in_progress:
                continue

            online_player_count += 1
            WorldSessionStateHandler.save_character(session.player_mgr, reason=reason, full_save=True,
                                                    min_interval_seconds=min_interval_seconds,
                                                    allow_locked=allow_locked)

        # Only write the count when it changed, but still once per interval since the realm server resets it to 0
        # when it restarts.
        now = time.monotonic()
        if (online_player_count != WorldSessionStateHandler._online_count_written
                or now - WorldSessionStateHandler._online_count_written_at
                >= WorldSessionStateHandler.get_saving_interval()):
            # Set before writing, so a failing write is retried after an interval instead of every tick.
            WorldSessionStateHandler._online_count_written = online_player_count
            WorldSessionStateHandler._online_count_written_at = now
            AuthDatabaseManager.realm_set_online_player_count(config.Server.Connection.Realm.local_realm_id,
                                                              online_player_count)

    @staticmethod
    def save_character(player_mgr, reason=SaveReason.MANUAL, full_save=False, min_interval_seconds=0.0, allow_locked=False):
        if not player_mgr or not player_mgr.player:
            return False

        if not allow_locked and player_mgr.update_lock:
            return False

        player_guid = player_mgr.guid if player_mgr.guid else player_mgr.player.guid
        save_lock = WorldSessionStateHandler._get_player_save_lock(player_guid)

        try:
            with save_lock:
                save_started_at = time.perf_counter()
                now = time.monotonic()
                if min_interval_seconds > 0.0:
                    last_save_at = WorldSessionStateHandler._get_last_save_at(player_guid, full_save)
                    if now - last_save_at < min_interval_seconds:
                        return False

                if not allow_locked and player_mgr.update_lock:
                    return False

                player_mgr.synchronize_db_player()
                RealmDatabaseManager.character_update(player_mgr.player)

                if full_save:
                    player_mgr.enchantment_manager.save()  # Enchantments plus item duration.
                    player_mgr.pet_manager.save()
                    player_mgr.quest_manager.save()

                WorldSessionStateHandler._set_last_save_at(player_guid, now, full_save)
                elapsed_ms = (time.perf_counter() - save_started_at) * 1000
                WorldSessionStateHandler._log_save_success(player_mgr, reason, elapsed_ms, full_save)
                return True
        except Exception as ex:
            player_name = player_mgr.get_name() if player_mgr else '<unknown>'
            player_db_guid = player_mgr.player.guid if player_mgr and player_mgr.player else 0
            reason_label = reason.label
            Logger.error(
                f'Error while saving {player_name} ({player_db_guid}) into db during [{reason_label}] save: {ex}.'
            )
            Logger.error(traceback.format_exc())
            # Periodic saves are checked every few seconds, wait a full interval before retrying (e.g. db down).
            if full_save and min_interval_seconds > 0.0:
                WorldSessionStateHandler._set_last_full_save_at(player_guid, time.monotonic())
            return False
