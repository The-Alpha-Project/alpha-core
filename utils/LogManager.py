import _queue
from datetime import datetime
from pathlib import Path

from utils.constants.MiscCodes import ChatMsgs
from utils.ConfigManager import config

class LogManager:
    LOG_PATH = 'etc/logs'
    CHAT_LOG_FILE = 'chat.log'
    
    def __init__(self, world_session) -> None:
        self.session = world_session
        self.chat_queue = _queue.SimpleQueue()

    def process_logs(self):
        while (self.session.keep_alive):
            log = self.chat_queue.get(block=True, timeout=None)

            if log:
                if log[0] == ChatMsgs.CHAT_MSG_SAY or log[0] == ChatMsgs.CHAT_MSG_YELL \
                    or log[0] == ChatMsgs.CHAT_MSG_EMOTE or log[0] == ChatMsgs.CHAT_MSG_PARTY \
                        or log[0] == ChatMsgs.CHAT_MSG_GUILD or log[0] == ChatMsgs.CHAT_MSG_OFFICER:
                    self._log_chat(log[0], log[1], log[2])
                elif log[0] == ChatMsgs.CHAT_MSG_CHANNEL:
                    self._log_channel(log[1], log[2], log[3])
                elif log[0] == ChatMsgs.CHAT_MSG_WHISPER:
                    self._log_whisper(log[1], log[2], log[3])

    def log_chat(self, player_mgr, msg, chat_type):
        if config.Server.Logging.log_player_chat:
            self.chat_queue.put_nowait((chat_type,
                                        player_mgr,
                                        msg))

    def log_channel(self, player_mgr, msg, channel_name):
        if config.Server.Logging.log_player_chat:
            self.chat_queue.put_nowait((ChatMsgs.CHAT_MSG_CHANNEL, 
                                        player_mgr, 
                                        msg,
                                        channel_name))

    def log_whisper(self, player_mgr, msg, target_player_mgr):
        if config.Server.Logging.log_player_chat:
            self.chat_queue.put_nowait((ChatMsgs.CHAT_MSG_WHISPER, 
                                        player_mgr, 
                                        msg,
                                        target_player_mgr))

    def _log_chat(self, chat_type, player_mgr, msg):
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

        self._write_to_log(f'{date} [CHAT] (GUID {player_mgr.guid}, NAME {player_mgr.get_name()}, MAP {player_mgr.map_}, POS {self._get_location_string(player_mgr)}): [{log_type}] {player_mgr.get_name()}:{player_mgr.guid} : {msg}')

    def _log_channel(self, player_mgr, msg, channel_name):
        date = datetime.now().strftime('%d-%m-%Y %H:%M:%S')
        self._write_to_log(f'{date} [CHAT] (GUID {player_mgr.guid}, NAME {player_mgr.get_name()}, MAP {player_mgr.map_}, POS {self._get_location_string(player_mgr)}): [Channel: {channel_name}] {player_mgr.get_name()}:{player_mgr.guid} : {msg}')

    def _log_whisper(self, player_mgr, msg, target_player_mgr):
        date = datetime.now().strftime('%d-%m-%Y %H:%M:%S')
        self._write_to_log(f'{date} [CHAT] (GUID {player_mgr.guid}, NAME {player_mgr.get_name()}, MAP {player_mgr.map_}, POS {self._get_location_string(player_mgr)}): [Whisper] {player_mgr.get_name()}:{player_mgr.guid} -> {target_player_mgr.get_name()}:{target_player_mgr.guid} : {msg}\n')

    def _write_to_log(self, msg):
        Path(LogManager.LOG_PATH).mkdir(parents=True, exist_ok=True)
        with open (f'{LogManager.LOG_PATH}/{LogManager.CHAT_LOG_FILE}', 'a+') as log:
            log.write(f'{msg}\n')
            log.close()

    def _get_location_string(self, player_mgr):
        return f'{float("{:.5f}".format(player_mgr.location.x))}, {float("{:.5f}".format(player_mgr.location.y))}, {float("{:.5f}".format(player_mgr.location.z))}'