import atexit
import os
import re
import sys
from _queue import SimpleQueue
from datetime import datetime
from enum import Enum, IntEnum
from shutil import get_terminal_size
from threading import Thread

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
    ADDON = Fore.LIGHTGREEN_EX + Style.DIM


class DebugLevel(IntEnum):
    NONE = 0x00
    SUCCESS = 0x01
    INFO = 0x02
    ANTICHEAT = 0x04
    WARNING = 0x08
    ERROR = 0x10
    DEBUG = 0x20
    SCRIPT = 0x40
    ADDON = 0x80


class AbortLoading(Exception):
    pass


# Lines are printed by one background thread, in order. A stdout that blocks (a full or slow log pipe) then only stalls
# that thread instead of every game thread that logs. Past this many pending lines (stdout stuck) new ones are dropped.
MAX_PENDING_LINES = 100000
_LINES = SimpleQueue()
_ANSI_CODES = re.compile(r'\x1b\[[0-9;]*[A-Za-z]')


def _print_lines():
    # Straight to the file descriptor: a write blocked in the OS holds no Python lock, so the process can still exit.
    # On Windows colorama converts the colors when printing, and a replaced stdout (an IDE) may have no descriptor.
    fd, encoding, strip_colors = None, None, False
    if os.name != 'nt':
        try:
            fd, encoding = sys.stdout.fileno(), sys.stdout.encoding or 'utf-8'
            strip_colors = not os.isatty(fd)  # Like colorama does for print, keep files and docker logs plain.
        except (AttributeError, OSError, ValueError):
            pass
    while (line := _LINES.get()) is not None:
        try:
            if fd is None:
                print(line[0], end=line[1], flush=True)
                continue
            text = line[0] + line[1]
            data = (_ANSI_CODES.sub('', text) if strip_colors else text).encode(encoding, errors='replace')
            while data:
                data = data[os.write(fd, data):]
        except Exception:
            pass  # Stdout closed or the line can't be printed, drop it but keep the thread for the next ones.


_PRINTER = Thread(target=_print_lines, name='Logger', daemon=True)
_PRINTER.start()
_PRINT_DIRECTLY = False


def _print_directly_after_fork():
    # A forked child (macOS starts the server processes with fork) has no printer thread, print as before.
    global _PRINT_DIRECTLY
    _PRINT_DIRECTLY = True


if hasattr(os, 'register_at_fork'):
    os.register_at_fork(after_in_child=_print_directly_after_fork)


@atexit.register
def _flush_lines():
    _LINES.put(None)
    _PRINTER.join(timeout=5)  # Print what is left, without hanging the exit on a blocked stdout.


class Logger:
    # Initialize colorama.
    init()
    _abort_check = None
    _progress_active = False

    @staticmethod
    def _write(text, end='\n'):
        if _PRINT_DIRECTLY:
            print(text, end=end, flush=True)
        elif _LINES.qsize() < MAX_PENDING_LINES:
            _LINES.put((text, end))

    @staticmethod
    def _should_log(log_type: DebugLevel):
        return (config.Server.Logging.logging_mask & log_type) != 0

    @staticmethod
    def _colorize_message(label, color, msg):
        date = datetime.now().strftime('[%d/%m/%Y %H:%M:%S]')
        return f'{color.value}{label}{Style.RESET_ALL} {date} {msg}'

    @staticmethod
    def _clear_progress_line():
        if not Logger._progress_active:
            return
        width = get_terminal_size(fallback=(120, 20)).columns
        Logger._write('\r' + (' ' * (width - 1)) + '\r', end='')
        Logger._progress_active = False

    @staticmethod
    def debug(msg):
        if Logger._should_log(DebugLevel.DEBUG):
            Logger._clear_progress_line()
            Logger._write(Logger._colorize_message('[DEBUG]', DebugColorLevel.DEBUG, msg))

    @staticmethod
    def warning(msg):
        if Logger._should_log(DebugLevel.WARNING):
            Logger._clear_progress_line()
            Logger._write(Logger._colorize_message('[WARNING]', DebugColorLevel.WARNING, msg))

    @staticmethod
    def error(msg):
        if Logger._should_log(DebugLevel.ERROR):
            Logger._clear_progress_line()
            Logger._write(Logger._colorize_message('[ERROR]', DebugColorLevel.ERROR, msg))

    @staticmethod
    def info(msg, end='\n', progress=False):
        if Logger._should_log(DebugLevel.INFO):
            if not progress:
                Logger._clear_progress_line()
            Logger._write(Logger._colorize_message('[INFO]', DebugColorLevel.INFO, msg), end=end)
            Logger._progress_active = end == '\r'

    @staticmethod
    def success(msg):
        if Logger._should_log(DebugLevel.SUCCESS):
            Logger._clear_progress_line()
            Logger._write(Logger._colorize_message('[SUCCESS]', DebugColorLevel.SUCCESS, msg))

    @staticmethod
    def anticheat(msg):
        if Logger._should_log(DebugLevel.ANTICHEAT):
            Logger._clear_progress_line()
            Logger._write(Logger._colorize_message('[ANTICHEAT]', DebugColorLevel.ANTICHEAT, msg))

    @staticmethod
    def script(msg):
        if Logger._should_log(DebugLevel.SCRIPT):
            Logger._clear_progress_line()
            Logger._write(Logger._colorize_message('[SCRIPT]', DebugColorLevel.SCRIPT, msg))

    @staticmethod
    def addon(msg):
        if Logger._should_log(DebugLevel.ADDON):
            Logger._clear_progress_line()
            Logger._write(Logger._colorize_message('[ADDON]', DebugColorLevel.ADDON, msg))

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
                Logger.info(msg, end='\r', progress=True)
        else:
            Logger.success(msg)
