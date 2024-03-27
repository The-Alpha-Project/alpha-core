from datetime import datetime
from enum import Enum, IntEnum

from colorama import init
from colorama import Fore, Style

from utils.ConfigManager import config


class DebugColorLevel(Enum):
    SUCCESS = Fore.GREEN + Style.BRIGHT
    INFO = Fore.BLUE + Style.BRIGHT
    ANTICHEAT = Fore.LIGHTBLUE_EX + Style.BRIGHT
    WARNING = Fore.YELLOW + Style.BRIGHT
    ERROR = Fore.RED + Style.BRIGHT
    DEBUG = Fore.CYAN + Style.BRIGHT


class DebugLevel(IntEnum):
    NONE = 0x00
    SUCCESS = 0x01
    INFO = 0x02
    ANTICHEAT = 0x04
    WARNING = 0x08
    ERROR = 0x10
    DEBUG = 0x20


class Logger:
    parent_conn = None

    # Initialize colorama.
    init()

    def set_parent_conn(parent_conn):
        if not Logger.parent_conn:
            Logger.parent_conn = parent_conn

    @staticmethod
    def _should_log(log_type: DebugLevel):
        return config.Server.Logging.logging_mask & log_type
    
    @staticmethod
    def _should_log_telnet(log_type: DebugLevel):
        return config.Server.Logging.logging_mask_telnet & log_type

    @staticmethod
    def _colorize_message(label, color, msg):
        date = datetime.now().strftime('[%d/%m/%Y %H:%M:%S]')
        return f'{color.value}{label}{Style.RESET_ALL} {date} {msg}'

    @staticmethod
    def debug(msg, LogMarkers='[DEBUG]'):
        formatted_msg = Logger._colorize_message(LogMarkers, DebugColorLevel.DEBUG, msg)

        if Logger._should_log(DebugLevel.DEBUG):
            print(formatted_msg)
        
        if Logger._should_log_telnet(DebugLevel.DEBUG) and Logger.parent_conn:
            formatted_msg += '\r' if 'DEBUG' in LogMarkers and '%' in msg else '\n'
            Logger.parent_conn.send(formatted_msg)

    @staticmethod
    def warning(msg, LogMarkers='[WARNING]'):
        formatted_msg = Logger._colorize_message(LogMarkers, DebugColorLevel.WARNING, msg)

        if Logger._should_log(DebugLevel.WARNING):
            print(formatted_msg)
        
        if Logger._should_log_telnet(DebugLevel.WARNING) and Logger.parent_conn:
            formatted_msg +='\r' if 'WARNING' in LogMarkers and '%' in msg else '\n'
            Logger.parent_conn.send(formatted_msg)

    @staticmethod
    def error(msg, LogMarkers='[ERROR]'):
        formatted_msg = Logger._colorize_message(LogMarkers, DebugColorLevel.ERROR, msg)

        if Logger._should_log(DebugLevel.ERROR):
            print(formatted_msg)
        
        if Logger._should_log_telnet(DebugLevel.ERROR) and Logger.parent_conn:
            formatted_msg += '\r' if 'ERROR' in LogMarkers and '%' in msg else '\n'
            Logger.parent_conn.send(formatted_msg)

    @staticmethod
    def info(msg, LogMarkers='[INFO]', end='\n'):
        formatted_msg = Logger._colorize_message(LogMarkers, DebugColorLevel.INFO, msg)
        
        if Logger._should_log(DebugLevel.INFO):
            print(formatted_msg, end=end)

        if Logger._should_log_telnet(DebugLevel.ERROR) and Logger.parent_conn:
            formatted_msg += '\r' if 'INFO' in LogMarkers and '%' in msg else '\n'
            Logger.parent_conn.send(formatted_msg)
        
    @staticmethod
    def plain(msg, LogMarkers=''):
        if Logger.parent_conn:
            Logger.parent_conn.send(msg)
        
    @staticmethod
    def success(msg, LogMarkers='[SUCCESS]'):
        formatted_msg = Logger._colorize_message(LogMarkers, DebugColorLevel.SUCCESS, msg)

        if Logger._should_log(DebugLevel.SUCCESS):
            print(formatted_msg)
        
        if Logger._should_log_telnet(DebugLevel.SUCCESS) and Logger.parent_conn:
            formatted_msg += '\r' if 'SUCCESS' in LogMarkers and '%' in msg else '\n'
            Logger.parent_conn.send(formatted_msg)

    @staticmethod
    def anticheat(msg, LogMarkers='[ANTICHEAT]'):
        formatted_msg = Logger._colorize_message(LogMarkers, DebugColorLevel.ANTICHEAT, msg)

        if Logger._should_log(DebugLevel.ANTICHEAT):
            print(formatted_msg)
        
        if Logger._should_log_telnet(DebugLevel.ANTICHEAT) and Logger.parent_conn:
            formatted_msg += '\r' if 'ANTICHEAT' in LogMarkers and '%' in msg else '\n'
            Logger.parent_conn.send(formatted_msg)
        
    # Additional methods

    @staticmethod
    def progress(msg, current, total, divisions=20):
        msg = f'{msg} [{current}/{total}] ({int(current * 100 / total)}%)'
        try:
            if current != total and divisions > 0:
                if int(current % (total / divisions)) == 0:
                    Logger.info(msg, end='\r')
            else:
                Logger.success(msg)

        except:
            pass