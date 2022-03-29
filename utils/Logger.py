from datetime import datetime
from enum import Enum, IntEnum
from sys import platform

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
    NONE = 0
    SUCCESS = 1
    INFO = 2
    ANTICHEAT = 3
    WARNING = 4
    ERROR = 5
    DEBUG = 6


class Logger:
    IS_WINDOWS = platform == 'win32'

    @staticmethod
    def _should_log(log_type: DebugLevel):
        debug_level = config.Server.Settings.debug_level
        return debug_level > 0 and debug_level >= log_type

    @staticmethod
    def _colorize_message(label, color, msg):
        date = datetime.now().strftime('[%d/%m/%Y %H:%M:%S]')
        # No colors for Windows :)
        if Logger.IS_WINDOWS:
            return f'{label} {date} {msg}'
        return f'{color.value}{label}{Style.RESET_ALL} {date} {msg}'

    @staticmethod
    def debug(msg):
        if Logger._should_log(DebugLevel.DEBUG):
            print(Logger._colorize_message('[DEBUG]', DebugColorLevel.DEBUG, msg))

    @staticmethod
    def warning(msg):
        if Logger._should_log(DebugLevel.WARNING):
            print(Logger._colorize_message('[WARNING]', DebugColorLevel.WARNING, msg))

    @staticmethod
    def error(msg):
        if Logger._should_log(DebugLevel.ERROR):
            print(Logger._colorize_message('[ERROR]', DebugColorLevel.ERROR, msg))

    @staticmethod
    def info(msg, end='\n'):
        if Logger._should_log(DebugLevel.INFO):
            print(Logger._colorize_message('[INFO]', DebugColorLevel.INFO, msg), end=end)

    @staticmethod
    def success(msg):
        if Logger._should_log(DebugLevel.SUCCESS):
            print(Logger._colorize_message('[SUCCESS]', DebugColorLevel.SUCCESS, msg))

    @staticmethod
    def anticheat(msg):
        if Logger._should_log(DebugLevel.ANTICHEAT):
            print(Logger._colorize_message('[ANTICHEAT]', DebugColorLevel.ANTICHEAT, msg))

    # Additional methods

    @staticmethod
    def progress(msg, current, total):
        msg = f'{msg} {current}/{total} ({int(current * 100 / total)}%)'
        if current != total:
            Logger.info(msg, end='\r')
        else:
            Logger.success(msg)
