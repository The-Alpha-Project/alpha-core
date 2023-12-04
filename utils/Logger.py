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
    def _colorize_message(label, color, msg):
        date = datetime.now().strftime('[%d/%m/%Y %H:%M:%S]')

        formatted_msg = f'{color.value}{label}{Style.RESET_ALL} {date} {msg}'

        if Logger.parent_conn:
            line_ending = "\r" if 'INFO' in label and '%' in msg else "\n"
            Logger.parent_conn.send(formatted_msg + line_ending)

        return formatted_msg 

    @staticmethod
    def debug(msg, LogMarkers='[DEBUG]'):
        if Logger._should_log(DebugLevel.DEBUG):
            formatted_msg = Logger._colorize_message(LogMarkers, DebugColorLevel.DEBUG, msg)
            print(formatted_msg)

    @staticmethod
    def warning(msg, LogMarkers='[WARNING]'):
        if Logger._should_log(DebugLevel.WARNING):
            formatted_msg = Logger._colorize_message(LogMarkers, DebugColorLevel.WARNING, msg)
            print(formatted_msg)

    @staticmethod
    def error(msg, LogMarkers='[ERROR]'):
        if Logger._should_log(DebugLevel.ERROR):
            formatted_msg = Logger._colorize_message(LogMarkers, DebugColorLevel.ERROR, msg)
            print(formatted_msg)

    @staticmethod
    def info(msg, LogMarkers='[INFO]', end='\n'):
        if Logger._should_log(DebugLevel.INFO):
            formatted_msg = Logger._colorize_message(LogMarkers, DebugColorLevel.INFO, msg)
            print(formatted_msg, end=end)
        
    @staticmethod
    def plain(msg, LogMarkers=''):
        # if we just want to send unformated text Telnet (output of help)

        if Logger.parent_conn:
            Logger.parent_conn.send(msg)
        
    @staticmethod
    def success(msg, LogMarkers='[SUCCESS]'):
        if Logger._should_log(DebugLevel.SUCCESS):
            formatted_msg = Logger._colorize_message(LogMarkers, DebugColorLevel.SUCCESS, msg)
            print(formatted_msg)

    @staticmethod
    def anticheat(msg, LogMarkers='[ANTICHEAT]'):
        if Logger._should_log(DebugLevel.ANTICHEAT):
            formatted_msg = Logger._colorize_message(LogMarkers, DebugColorLevel.ANTICHEAT, msg)
            print(formatted_msg)
        
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