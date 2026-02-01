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
    SCRIPT = Fore.MAGENTA + Style.BRIGHT


class DebugLevel(IntEnum):
    NONE = 0x00
    SUCCESS = 0x01
    INFO = 0x02
    ANTICHEAT = 0x04
    WARNING = 0x08
    ERROR = 0x10
    DEBUG = 0x20
    SCRIPT = 0x40


class AbortLoading(Exception):
    pass


class Logger:
    # Initialize colorama.
    init()
    _abort_check = None

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

    @staticmethod
    def script(msg):
        if Logger._should_log(DebugLevel.SCRIPT):
            print(Logger._colorize_message('[SCRIPT]', DebugColorLevel.SCRIPT, msg))

    # Additional methods

    @staticmethod
    def set_abort_check(check):
        Logger._abort_check = check

    @staticmethod
    def progress(msg, current, total, divisions=20):
        if Logger._abort_check and Logger._abort_check():
            raise AbortLoading('Shutdown requested during load.')
        msg = f'{msg} [{current}/{total}] ({int(current * 100 / total)}%)'
        if current != total and divisions > 0:
            if divisions == 1 or int(current % (total / divisions)) == 0:
                Logger.info(msg, end='\r')
        else:
            Logger.success(msg)
