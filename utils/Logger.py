from colorama import Fore, Back, Style
from enum import Enum


class DebugColorLevel(Enum):

    INFO            = Back.WHITE + Fore.BLACK
    WARNING         = Fore.YELLOW
    CRITICAL        = Fore.YELLOW + Style.BRIGHT
    ERROR           = Fore.RED + Style.BRIGHT
    SUCCESS         = Fore.GREEN + Style.BRIGHT
    DEBUG           = Fore.CYAN + Style.BRIGHT
    TEST            = Fore.MAGENTA + Style.BRIGHT
    NOTIFICATION    = Fore.BLUE + Style.BRIGHT


class Logger(object):

    LABEL = ''

    @staticmethod
    def colorize_message(color: DebugColorLevel, msg: str):
        return f'{color.value}{Logger.LABEL}{Style.RESET_ALL} {msg}'

    @staticmethod
    def debug(msg: str):
        Logger.LABEL = '[DEBUG]'
        print(Logger.colorize_message(DebugColorLevel.DEBUG, msg))

    @staticmethod
    def warning(msg: str):
        Logger.LABEL = '[WARNING]'
        print(Logger.colorize_message(DebugColorLevel.WARNING, msg))

    @staticmethod
    def critical(msg: str):
        Logger.LABEL = '[CRITICAL]'
        print(Logger.colorize_message(DebugColorLevel.CRITICAL, msg))

    @staticmethod
    def error(msg: str):
        Logger.LABEL = '[ERROR]'
        print(Logger.colorize_message(DebugColorLevel.ERROR, msg))

    @staticmethod
    def info(msg: str):
        Logger.LABEL = '[INFO]'
        print(Logger.colorize_message(DebugColorLevel.INFO, msg))

    @staticmethod
    def test(msg: str):
        Logger.LABEL = '[TEST]'
        print(Logger.colorize_message(DebugColorLevel.TEST, msg))

    @staticmethod
    def success(msg: str):
        Logger.LABEL = '[SUCCESS]'
        print(Logger.colorize_message(DebugColorLevel.SUCCESS, msg))

    @staticmethod
    def notify(msg: str):
        Logger.LABEL = '[NOTIFICATION]'
        print(Logger.colorize_message(DebugColorLevel.NOTIFICATION, msg))