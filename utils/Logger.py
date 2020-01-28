from colorama import Fore, Style
from enum import Enum


class DebugColorLevel(Enum):
    INFO = Fore.BLUE + Style.BRIGHT
    WARNING = Fore.YELLOW + Style.BRIGHT
    ERROR = Fore.RED + Style.BRIGHT
    SUCCESS = Fore.GREEN + Style.BRIGHT
    DEBUG = Fore.CYAN + Style.BRIGHT
    TEST = Fore.MAGENTA + Style.BRIGHT


class Logger(object):
    LABEL = ''

    @staticmethod
    def colorize_message(color, msg):
        return '%s%s%s %s' % (color.value, Logger.LABEL, Style.RESET_ALL, msg)

    @staticmethod
    def debug(msg):
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
    def info(msg):
        Logger.LABEL = '[INFO]'
        print(Logger.colorize_message(DebugColorLevel.INFO, msg))

    @staticmethod
    def test(msg):
        Logger.LABEL = '[TEST]'
        print(Logger.colorize_message(DebugColorLevel.TEST, msg))

    @staticmethod
    def success(msg):
        Logger.LABEL = '[SUCCESS]'
        print(Logger.colorize_message(DebugColorLevel.SUCCESS, msg))
