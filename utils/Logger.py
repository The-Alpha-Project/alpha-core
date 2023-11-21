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

    @staticmethod
    def set_parent_conn(parent_conn):
        if not Logger.parent_conn:
            Logger.parent_conn = parent_conn

    def send_to_telnet(func):
        def wrapper(*args, **kwargs):
            result = func(*args, **kwargs)
            if Logger.parent_conn:
                Logger.parent_conn.send(*args)
            return result
        return wrapper

    @staticmethod
    def _should_log(log_type: DebugLevel):
        return config.Server.Logging.logging_mask & log_type

    @staticmethod
    def _colorize_message(label, color, msg):
        date = datetime.now().strftime('[%d/%m/%Y %H:%M:%S]')
        return f'{color.value}{label}{Style.RESET_ALL} {date} {msg}'

    @staticmethod
    def debug(msg):
        if Logger._should_log(DebugLevel.DEBUG):
            formatted_msg = Logger._colorize_message('[DEBUG]', DebugColorLevel.DEBUG, msg)
            print(formatted_msg)

            if Logger.parent_conn:
                Logger.parent_conn.send(formatted_msg)

    @staticmethod
    def warning(msg):
        if Logger._should_log(DebugLevel.WARNING):
            formatted_msg = Logger._colorize_message('[WARNING]', DebugColorLevel.WARNING, msg)
            print(formatted_msg)

            if Logger.parent_conn:
                Logger.parent_conn.send(formatted_msg)

    @staticmethod
    def error(msg):
        if Logger._should_log(DebugLevel.ERROR):
            formatted_msg = Logger._colorize_message('[ERROR]', DebugColorLevel.ERROR, msg)
            print(formatted_msg)

            if Logger.parent_conn:
                Logger.parent_conn.send(formatted_msg)

    @staticmethod
    def info(msg, end='\n'):
        if Logger._should_log(DebugLevel.INFO):
            formatted_msg = Logger._colorize_message('[INFO]', DebugColorLevel.INFO, msg)
            print(formatted_msg, end=end)

    @staticmethod
    def success(msg):
        if Logger._should_log(DebugLevel.SUCCESS):
            formatted_msg = Logger._colorize_message('[SUCCESS]', DebugColorLevel.SUCCESS, msg)
            print(formatted_msg)

            if Logger.parent_conn:
                Logger.parent_conn.send(formatted_msg)
           
    @staticmethod
    def anticheat(msg):
        if Logger._should_log(DebugLevel.ANTICHEAT):
            formatted_msg = Logger._colorize_message('[ANTICHEAT]', DebugColorLevel.ANTICHEAT, msg)
            print(formatted_msg)

            if Logger.parent_conn:
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