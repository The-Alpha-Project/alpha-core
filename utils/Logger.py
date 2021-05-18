from enum import Enum
from sys import platform

from colorama import Fore, Style

from utils.ConfigManager import config


class DebugColorLevel(Enum):
    INFO = Fore.BLUE + Style.BRIGHT
    WARNING = Fore.YELLOW + Style.BRIGHT
    ERROR = Fore.RED + Style.BRIGHT
    SUCCESS = Fore.GREEN + Style.BRIGHT
    DEBUG = Fore.CYAN + Style.BRIGHT
    ANTICHEAT = Fore.LIGHTBLUE_EX + Style.BRIGHT


class Logger:
    IS_WINDOWS = platform == 'win32'

    @staticmethod
    def colorize_message(label, color, msg):
        # No colors for Windows :)
        if Logger.IS_WINDOWS:
            return f'{label} {msg}'
        return f'{color.value}{label}{Style.RESET_ALL} {msg}'

    @staticmethod
    def debug(msg):
        if config.Server.Settings.debug:
            print(Logger.colorize_message('[DEBUG]', DebugColorLevel.DEBUG, msg))

    @staticmethod
    def warning(msg):
        print(Logger.colorize_message('[WARNING]', DebugColorLevel.WARNING, msg))

    @staticmethod
    def error(msg):
        print(Logger.colorize_message('[ERROR]', DebugColorLevel.ERROR, msg))

    @staticmethod
    def info(msg, end='\n'):
        print(Logger.colorize_message('[INFO]', DebugColorLevel.INFO, msg), end=end)

    @staticmethod
    def success(msg):
        print(Logger.colorize_message('[SUCCESS]', DebugColorLevel.SUCCESS, msg))

    @staticmethod
    def anticheat(msg):
        print(Logger.colorize_message('[ANTICHEAT]', DebugColorLevel.ANTICHEAT, msg))

    # Additional methods

    @staticmethod
    def progress(msg, current, total):
        msg = f'{msg} {current}/{total} ({int(current * 100 / total)}%)'
        if current != total:
            Logger.info(msg, end='\r')
        else:
            Logger.success(msg)
