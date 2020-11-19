from colorama import Fore, Style
from enum import Enum

from utils.ConfigManager import config


class DebugColorLevel(Enum):
    INFO = Fore.BLUE + Style.BRIGHT
    WARNING = Fore.YELLOW + Style.BRIGHT
    ERROR = Fore.RED + Style.BRIGHT
    SUCCESS = Fore.GREEN + Style.BRIGHT
    DEBUG = Fore.CYAN + Style.BRIGHT
    ANTICHEAT = Fore.LIGHTBLUE_EX + Style.BRIGHT


class Logger(object):
    LABEL = ''

    @staticmethod
    def colorize_message(color, msg):
        return '%s%s%s %s' % (color.value, Logger.LABEL, Style.RESET_ALL, msg)

    @staticmethod
    def debug(msg):
        if config.Server.Settings.debug:
            Logger.LABEL = '[DEBUG]'
            print(Logger.colorize_message(DebugColorLevel.DEBUG, msg))

    @staticmethod
    def warning(msg):
        Logger.LABEL = '[WARNING]'
        print(Logger.colorize_message(DebugColorLevel.WARNING, msg))

    @staticmethod
    def error(msg):
        Logger.LABEL = '[ERROR]'
        print(Logger.colorize_message(DebugColorLevel.ERROR, msg))

    @staticmethod
    def info(msg, end='\n'):
        Logger.LABEL = '[INFO]'
        print(Logger.colorize_message(DebugColorLevel.INFO, msg), end=end)

    @staticmethod
    def success(msg):
        Logger.LABEL = '[SUCCESS]'
        print(Logger.colorize_message(DebugColorLevel.SUCCESS, msg))

    @staticmethod
    def anticheat(msg):
        Logger.LABEL = '[ANTICHEAT]'
        print(Logger.colorize_message(DebugColorLevel.ANTICHEAT, msg))

    # Additional methods

    @staticmethod
    def progress(msg, current, total):
        if current != total:
            Logger.info(msg, end='\r')
        else:
            Logger.success(msg)
