import multiprocessing
import os
import argparse
import signal
from sys import platform
from time import sleep

# Initialize path FIRST, before any other imports that might use PathManager
from utils.PathManager import PathManager
if __name__ == '__main__':
    root_path = os.path.dirname(os.path.realpath(__file__))
    PathManager.set_root_path(root_path)

from game.login.LoginManager import LoginManager
from game.realm.RealmManager import RealmManager
from game.update.UpdateManager import UpdateManager
from game.world import WorldManager
from game.world.managers.CommandManager import CommandManager
from game.world.managers.maps.MapManager import MapManager
from game.world.managers.maps.MapTile import MapTile
from tools.extractors.Extractor import Extractor
from utils.ConfigManager import config, ConfigManager
from utils.Logger import Logger
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

parser.add_argument(
    '-x', '--adt_x',
    help='-x in order to specify adt x extraction',
    dest='adt_x',
    type=int,
    default=False
)

parser.add_argument(
    '-y', '--adt_y',
    help='-y in order to specify adt y extraction',
    dest='adt_y',
    type=int,
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
                active_process.join()
                break
        except (ValueError, KeyboardInterrupt):
            sleep(0.1)

    Logger.info(f'{active_process.name} released.')


def handle_console_commands():
    try:
        command = input()
        while command != 'exit':
            try:
                res, msg = CommandManager.handle_conole_command(command)
                if not res:
                    Logger.info(msg)
                else:
                    Logger.error(f'Invalid command [{command}], [{msg}].')
            except:
                Logger.error(f'Invalid command [{command}].')
            command = input()
    except:
        pass
    Logger.info(f'Command listener released.')
    SHARED_STATE.RUNNING = False


def handler_stop_signals(signum, frame):
    SHARED_STATE.RUNNING = False
    # Console mode, we need to kill stdin input() listener.
    if SHARED_STATE.CONSOLE_LISTENING:
        raise KeyboardInterrupt


def wait_world_server():
    if not launch_world:
        return
    # Wait for world start before starting realm/proxy sockets if needed.
    while not SHARED_STATE.WORLD_SERVER_READY and SHARED_STATE.RUNNING:
        sleep(0.1)


def wait_realm_server():
    if not launch_realm:
        return
    while not SHARED_STATE.REALM_SERVER_READY and SHARED_STATE.RUNNING:
        sleep(0.1)


def wait_proxy_server():
    if not launch_realm:
        return
    while not SHARED_STATE.PROXY_SERVER_READY and SHARED_STATE.RUNNING:
        sleep(0.1)


def wait_login_server():
    while not SHARED_STATE.LOGIN_SERVER_READY and SHARED_STATE.RUNNING:
        sleep(0.1)


def wait_update_server():
    while not SHARED_STATE.UPDATE_SERVER_READY and SHARED_STATE.RUNNING:
        sleep(0.1)

SHARED_STATE = None
ACTIVE_PROCESSES = []

if __name__ == '__main__':
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

    # Semaphore objects are leaked on shutdown in macOS if using spawn for some reason.
    if platform == 'darwin':
        context = multiprocessing.get_context('fork')
    else:
        context = multiprocessing.get_context('spawn')

    if not MapManager.validate_namigator_bindings():
        Logger.error(f'Invalid namigator bindings.')
        exit()

    if args.extract:
        adt_x = args.adt_x if args.adt_x else -1
        adt_y = args.adt_y if args.adt_y else -1
        Extractor.run(context, adt_x, adt_y)
        exit()

    # Validate if maps available and if version match.
    if not MapManager.validate_map_files():
        Logger.error(f'Invalid maps version or maps missing, expected version {MapTile.EXPECTED_VERSION}')
        exit()

    manager = context.Manager()
    # Shared variables inside a namespace.
    SHARED_STATE = manager.Namespace()
    SHARED_STATE.RUNNING = True
    SHARED_STATE.CONSOLE_LISTENING = False
    SHARED_STATE.WORLD_SERVER_READY = False
    SHARED_STATE.REALM_SERVER_READY = False
    SHARED_STATE.PROXY_SERVER_READY = False
    SHARED_STATE.LOGIN_SERVER_READY = False
    SHARED_STATE.UPDATE_SERVER_READY = False

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

    # Process launching starts here.
    if launch_world:
        ACTIVE_PROCESSES.append((context.Process(
            name='World process',
            target=WorldManager.WorldServerSessionHandler.start_world,
            args=(SHARED_STATE,)), wait_world_server))
    else:
        SHARED_STATE.WORLD_SERVER_READY = True

    # Update server.
    ACTIVE_PROCESSES.append((context.Process(
        name='Update process',
        target=UpdateManager.start_update,
        args=(SHARED_STATE,)), wait_update_server))

    # SRP login server.
    ACTIVE_PROCESSES.append((context.Process(
        name='Login process',
        target=LoginManager.start_login,
        args=(SHARED_STATE,)), wait_login_server))

    if launch_realm:
        ACTIVE_PROCESSES.append((context.Process(
            name='Realm process',
            target=RealmManager.start_realm,
            args=(SHARED_STATE,)), wait_realm_server))

        ACTIVE_PROCESSES.append((context.Process(
            name='Proxy process',
            target=RealmManager.start_proxy,
            args=(SHARED_STATE,)), wait_proxy_server))
    else:
        SHARED_STATE.REALM_SERVER_READY = True
        SHARED_STATE.PROXY_SERVER_READY = True

    Logger.info('Booting Alpha Core, please wait...')
    # Start processes.
    for process, wait_call in ACTIVE_PROCESSES:
        process.start()
        wait_call()

    # Print active env vars.
    for env_var_name in EnvVars.EnvironmentalVariables.ACTIVE_ENV_VARS:
        env_var = os.getenv(env_var_name, '')
        if env_var:
            Logger.info(f'Environment variable {env_var_name}: {env_var}')

    # Bell sound character.
    Logger.info('Alpha Core is now running.\a')

    # Handle console mode.
    if console_mode and SHARED_STATE.RUNNING:
        SHARED_STATE.CONSOLE_LISTENING = True
        handle_console_commands()
    else:
        # Wait on main thread for stop signal or 'exit' command.
        while SHARED_STATE.RUNNING:
            sleep(2)

    # Exit.
    Logger.info('Shutting down the core, please wait...')

    # Make sure all process finish gracefully (Exit their listening loops).
    [release_process(process) for process, wait_call in ACTIVE_PROCESSES]

    ACTIVE_PROCESSES.clear()
    manager.shutdown()
    Logger.success('Core gracefully shut down.')
    exit()
