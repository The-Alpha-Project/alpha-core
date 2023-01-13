import _queue
from datetime import datetime
from pathlib import Path
from os import path

from utils.PathManager import PathManager
from utils.constants.MiscCodes import ChatMsgs
from utils.ConfigManager import config


class ChatLogManager:
    CHAT_LOG_PATH = config.Server.Logging.log_chat_path
    CHAT_LOG_FILE_NAME = 'chat.log'

    CHAT_LOG_FULL_PATH = path.join(CHAT_LOG_PATH, CHAT_LOG_FILE_NAME)
    CHAT_QUEUE = _queue.SimpleQueue()

    should_process_logs = True

    @staticmethod
    def process_logs():
        Path(ChatLogManager.CHAT_LOG_FULL_PATH).mkdir(parents=True, exist_ok=True)

        while ChatLogManager.should_process_logs:
            log = ChatLogManager.CHAT_QUEUE.get(block=True, timeout=None)

            if log:
                if log[0] == ChatMsgs.CHAT_MSG_SAY or log[0] == ChatMsgs.CHAT_MSG_YELL \
                    or log[0] == ChatMsgs.CHAT_MSG_EMOTE or log[0] == ChatMsgs.CHAT_MSG_PARTY \
                        or log[0] == ChatMsgs.CHAT_MSG_GUILD or log[0] == ChatMsgs.CHAT_MSG_OFFICER:
                    ChatLogManager._log_chat(log[0], log[1], log[2])
                elif log[0] == ChatMsgs.CHAT_MSG_CHANNEL:
                    ChatLogManager._log_channel(log[1], log[2], log[3])
                elif log[0] == ChatMsgs.CHAT_MSG_WHISPER:
                    ChatLogManager._log_whisper(log[1], log[2], log[3])

    @staticmethod
    def exit():
        ChatLogManager.should_process_logs = False

    @staticmethod
    def log_chat(player_mgr, msg, chat_type):
        if config.Server.Logging.log_player_chat:
            ChatLogManager.CHAT_QUEUE.put_nowait((chat_type,
                                                  player_mgr,
                                                  msg))
    
    @staticmethod
    def log_channel(player_mgr, msg, channel):
        if config.Server.Logging.log_player_chat and not channel.is_addon():
            ChatLogManager.CHAT_QUEUE.put_nowait((ChatMsgs.CHAT_MSG_CHANNEL,
                                                  player_mgr,
                                                  msg,
                                                  channel.name))
    
    @staticmethod
    def log_whisper(player_mgr, msg, target_player_mgr):
        if config.Server.Logging.log_player_chat:
            ChatLogManager.CHAT_QUEUE.put_nowait((ChatMsgs.CHAT_MSG_WHISPER,
                                                  player_mgr,
                                                  msg,
                                                  target_player_mgr))
    
    @staticmethod
    def _log_chat(chat_type, player_mgr, msg):
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

        ChatLogManager._write_to_log(f'{date} [CHAT] (GUID {player_mgr.guid}, '
                                     f'NAME {player_mgr.get_name()}, '
                                     f'MAP {player_mgr.map_}, '
                                     f'POS {ChatLogManager._get_location_string(player_mgr)}): '
                                     f'[{log_type}] {player_mgr.get_name()}:{player_mgr.guid} : {msg}')

    @staticmethod
    def _log_channel(player_mgr, msg, channel_name):
        date = datetime.now().strftime('%d-%m-%Y %H:%M:%S')
        ChatLogManager._write_to_log(f'{date} [CHAT] (GUID {player_mgr.guid}, '
                                     f'NAME {player_mgr.get_name()}, '
                                     f'MAP {player_mgr.map_}, '
                                     f'POS {ChatLogManager._get_location_string(player_mgr)}): '
                                     f'[Channel: {channel_name}] {player_mgr.get_name()}:{player_mgr.guid} : {msg}')

    @staticmethod
    def _log_whisper(player_mgr, msg, target_player_mgr):
        date = datetime.now().strftime('%d-%m-%Y %H:%M:%S')
        ChatLogManager._write_to_log(f'{date} [CHAT] (GUID {player_mgr.guid}, '
                                     f'NAME {player_mgr.get_name()}, '
                                     f'MAP {player_mgr.map_}, '
                                     f'POS {ChatLogManager._get_location_string(player_mgr)}): '
                                     f'[Whisper] {player_mgr.get_name()}:{player_mgr.guid} -> '
                                     f'{target_player_mgr.get_name()}:{target_player_mgr.guid} : {msg}')

    @staticmethod
    def _write_to_log(msg):
        with open(ChatLogManager.CHAT_LOG_FULL_PATH, 'a+') as log:
            log.write(f'{msg}\n')
            log.close()

    @staticmethod
    def _get_location_string(player_mgr):
        return f'{float("{:.5f}".format(player_mgr.location.x))}, ' \
               f'{float("{:.5f}".format(player_mgr.location.y))}, ' \
               f'{float("{:.5f}".format(player_mgr.location.z))}'
