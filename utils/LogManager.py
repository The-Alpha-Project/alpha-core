from datetime import datetime
from pathlib import Path

from utils.constants.MiscCodes import ChatMsgs
from utils.ConfigManager import config

class LogManager:
    LOG_PATH = 'etc/logs'
    CHAT_LOG_FILE = 'chat.log'

    @staticmethod
    def log_chat(player_mgr, msg, chat_type):
        if config.Server.Logging.log_player_chat:
            date = datetime.now().strftime('%d-%m-%Y %H:%M:%S')
            log_type = None

            if chat_type == ChatMsgs.CHAT_MSG_SAY:
                log_type = 'Say'
            elif chat_type == ChatMsgs.CHAT_MSG_YELL:
                log_type = 'Yell'
            elif chat_type == ChatMsgs.CHAT_MSG_EMOTE:
                log_type = 'Emote'
            elif chat_type == ChatMsgs.CHAT_MSG_PARTY:
                log_type = 'Party'
            elif chat_type == ChatMsgs.CHAT_MSG_GUILD:
                log_type = 'Guild'
            elif chat_type == ChatMsgs.CHAT_MSG_OFFICER:
                log_type = 'Officer'

            LogManager._write_to_log(f'{date} [CHAT] (GUID {player_mgr.guid}, NAME {player_mgr.get_name()}, MAP {player_mgr.map_}, POS {LogManager._get_location_string(player_mgr)}): [{log_type}] {player_mgr.get_name()}:{player_mgr.guid} : {msg}')

    @staticmethod
    def log_channel(player_mgr, msg, channel_name):
        if config.Server.Logging.log_player_chat:
            date = datetime.now().strftime('%d-%m-%Y %H:%M:%S')
            LogManager._write_to_log(f'{date} [CHAT] (GUID {player_mgr.guid}, NAME {player_mgr.get_name()}, MAP {player_mgr.map_}, POS {LogManager._get_location_string(player_mgr)}): [Channel: {channel_name}] {player_mgr.get_name()}:{player_mgr.guid} : {msg}')

    @staticmethod
    def log_whisper(player_mgr, msg, target_player_mgr):
        if config.Server.Logging.log_player_chat:
            date = datetime.now().strftime('%d-%m-%Y %H:%M:%S')
            LogManager._write_to_log(f'{date} [CHAT] (GUID {player_mgr.guid}, NAME {player_mgr.get_name()}, MAP {player_mgr.map_}, POS {LogManager._get_location_string(player_mgr)}): [Whisper] {player_mgr.get_name()}:{player_mgr.guid} -> {target_player_mgr.get_name()}:{target_player_mgr.guid} : {msg}\n')

    @staticmethod
    def _write_to_log(msg):
        Path(LogManager.LOG_PATH).mkdir(parents=True, exist_ok=True)
        with open (f'{LogManager.LOG_PATH}/{LogManager.CHAT_LOG_FILE}', 'a+') as log:
            log.write(f'{msg}\n')
            log.close()

    @staticmethod
    def _get_location_string(player_mgr):
        return f'{float("{:.5f}".format(player_mgr.location.x))}, {float("{:.5f}".format(player_mgr.location.y))}, {float("{:.5f}".format(player_mgr.location.z))}'