import multiprocessing
import os
import argparse
import signal
import threading
from sys import platform
from time import sleep

from game.realm.RealmManager import RealmManager
from game.world import WorldManager
from game.world.managers.CommandManager import CommandManager
from game.world.managers.maps.MapManager import MapManager
from game.world.managers.maps.MapTile import MapTile
from tools.map_extractor.MapExtractor import MapExtractor
from utils.ConfigManager import config, ConfigManager
from utils.Logger import Logger
from utils.PathManager import PathManager
from utils.constants import EnvVars


# Initialize argument parser.
parser = argparse.ArgumentParser()
parser.add_argument(
    '-l', '--launch',
    help='-l realm to launch realm or -l to launch world, if nothing is specified both are launched',
    dest='launch',
    action='store',
    default=None
)
parser.add_argument(
    '-e', '--extract',
    help='-e in order to extract .map files',
    dest='extract',
    action='store_true',
    default=False
)
args = parser.parse_args()


def release_process(active_process):
    Logger.info(f'Releasing {active_process.name}...')
    while active_process.is_alive():
        try:
            # Give the process 2 seconds to shut down.
            active_process.join(timeout=2)
            if active_process.is_alive():
                active_process.terminate()
                break
        except (ValueError, KeyboardInterrupt):
            sleep(0.1)

    Logger.info(f'{active_process.name} released.')


def handle_console_commands():
    try:
        while input() != 'exit':
            Logger.error("Invalid command.")
    except:
        pass
    RUNNING.value = 0


def handler_stop_signals(signum, frame):
    RUNNING.value = 0


def wait_world_server():
    if not launch_world:
        return
    # Wait for world start before starting realm/proxy sockets if needed.
    while not WORLD_SERVER_READY.value and RUNNING.value:
        sleep(1)


def wait_realm_server():
    if not launch_realm:
        return
    while not REALM_SERVER_READY.value and RUNNING.value:
        sleep(1)


def wait_proxy_server():
    if not launch_realm:
        return
    while not PROXY_SERVER_READY.value and RUNNING.value:
        sleep(1)


CONSOLE_THREAD = None
RUNNING = None
WORLD_SERVER_READY = None
REALM_SERVER_READY = None
PROXY_SERVER_READY = None
ACTIVE_PROCESSES = []


if __name__ == '__main__':
    # Initialize path.
    PathManager.set_root_path(os.path.dirname(os.path.realpath(__file__)))

    # Validate configuration file version.
    # (Not using Logger since it can fail due to missing config options too).
    try:
        if config.Version.current != ConfigManager.EXPECTED_VERSION:
            print(f'Invalid config.yml version. Expected {ConfigManager.EXPECTED_VERSION} '
                  f'found {config.Version.current}.')
            exit()
    except AttributeError:
        print(f'Invalid config.yml version. Expected {ConfigManager.EXPECTED_VERSION}, none found.')
        exit()

    if args.extract:
        MapExtractor.run()
        exit()

    # Validate if maps available and if version match.
    if not MapManager.validate_map_files():
        Logger.error(f'Invalid maps version or maps missing, expected version {MapTile.EXPECTED_VERSION}')
        exit()

    # Semaphore objects are leaked on shutdown in macOS if using spawn for some reason.
    if platform == 'darwin':
        context = multiprocessing.get_context('fork')
    else:
        context = multiprocessing.get_context('spawn')

    RUNNING = context.Value('i', 1)
    WORLD_SERVER_READY = context.Value('i', 0)
    REALM_SERVER_READY = context.Value('i', 0)
    PROXY_SERVER_READY = context.Value('i', 0)

    # Print active env vars.
    for env_var_name in EnvVars.EnvironmentalVariables.ACTIVE_ENV_VARS:
        env_var = os.getenv(env_var_name, '')
        if env_var:
            Logger.info(f'Environment variable {env_var_name}: {env_var}')

    launch_realm = not args.launch or args.launch == 'realm'
    launch_world = not args.launch or args.launch == 'world'
    console_mode = os.getenv(EnvVars.EnvironmentalVariables.CONSOLE_MODE,
                             config.Server.Settings.console_mode) in [True, 'True', 'true']

    if not launch_world and not launch_realm:
        Logger.error('Realm and World launch are disabled.')
        exit()

    # Hook exit signals.
    signal.signal(signal.SIGINT, handler_stop_signals)
    signal.signal(signal.SIGTERM, handler_stop_signals)

    # Handle console mode.
    if console_mode:
        CONSOLE_THREAD = threading.Thread(target=handle_console_commands, daemon=True)
        CONSOLE_THREAD.start()

    # Process launching starts here.
    if launch_world:
        ACTIVE_PROCESSES.append((context.Process(
            name='World process',
            target=WorldManager.WorldServerSessionHandler.start_world,
            args=(RUNNING, WORLD_SERVER_READY)), wait_world_server))
    else:
        WORLD_SERVER_READY.value = 1

    if launch_realm:
        ACTIVE_PROCESSES.append((context.Process(name='Login process', target=RealmManager.start_realm,
                                                 args=(RUNNING, REALM_SERVER_READY)), wait_realm_server))
        ACTIVE_PROCESSES.append((context.Process(name='Proxy process', target=RealmManager.start_proxy,
                                                 args=(RUNNING, PROXY_SERVER_READY)), wait_proxy_server))
    else:
        REALM_SERVER_READY.value = 1
        PROXY_SERVER_READY.value = 1

    Logger.info('Booting Alpha core, please wait...')
    # Start processes.
    for process, wait_call in ACTIVE_PROCESSES:
        process.start()
        wait_call()

    # Bell sound character.
    Logger.info('Alpha core is now running.\a')

    # Wait on main thread for stop signal or 'exit' command.
    while RUNNING.value:
        sleep(2)

    # Exit.
    Logger.info('Shutting down the core, please wait...')

    if launch_world:
        # Make sure we disconnect current players and save their characters.
        CommandManager.worldoff(None, args='confirm')

    # Make sure all process finish gracefully (Exit their listening loops).
    [release_process(process) for process, wait_call in ACTIVE_PROCESSES]

    ACTIVE_PROCESSES.clear()
    Logger.success('Core gracefully shut down.')
    exit()
