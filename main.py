import os
import multiprocessing
from sys import platform
from utils.PathManager import PathManager

# Set multiprocessing context and initialize path FIRST, before any other imports are called.
if __name__ == '__main__':
    # Semaphore objects are leaked on shutdown in macOS if using spawn for some reason.
    if platform == 'darwin':
        multiprocessing.set_start_method('fork')
    else:
        multiprocessing.set_start_method('spawn')

    root_path = os.path.dirname(os.path.realpath(__file__))
    PathManager.set_root_path(root_path)

import argparse
import signal
import threading
from time import sleep
from utils.ConfigManager import config, ConfigManager
from utils.Logger import Logger
from utils.constants import EnvVars

# Configure SQLAlchemy C extensions before importing modules that may load SQLAlchemy.
if config.Server.Settings.disable_sqlalchemy_cext:
    os.environ['DISABLE_SQLALCHEMY_CEXT_RUNTIME'] = '1'
else:
    os.environ.pop('DISABLE_SQLALCHEMY_CEXT_RUNTIME', None)

from game.login.LoginManager import LoginManager
from game.realm.RealmManager import RealmManager
from game.update.UpdateManager import UpdateManager
from game.world import WorldManager
from game.world.managers.CommandManager import CommandManager
from game.world.managers.maps.MapManager import MapManager
from game.world.managers.maps.MapTile import MapTile
from tools.extractors.Extractor import Extractor


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
            # Give the process 10 seconds to shut down. The world process saves every character and then logs each one
            # out (another full save), which takes much longer with hundreds of players.
            active_process.join(timeout=90 if active_process.name == 'World process' else 10)
            if active_process.is_alive():
                Logger.warning(f'{active_process.name} did not exit in time; terminating.')
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
        SHARED_STATE.RUNNING = False
    except EOFError:
        # No console attached (service, container without tty), keep running until a stop signal.
        Logger.info('Console input closed, use a stop signal to shut down.')
    Logger.info(f'Command listener released.')


def handler_stop_signals(signum, frame):
    SHARED_STATE.RUNNING = False


def _wait_for_ready(active_process, ready_check, name, should_wait=True):
    if not should_wait:
        return True
    # Wait for readiness, but stop if the process dies to avoid hanging startup.
    while not ready_check() and SHARED_STATE.RUNNING:
        if not active_process.is_alive():
            Logger.error(f'{name} exited before ready (exit code {active_process.exitcode}).')
            SHARED_STATE.RUNNING = False
            return False
        sleep(0.1)
    return True


def wait_world_server(active_process):
    return _wait_for_ready(active_process, lambda: SHARED_STATE.WORLD_SERVER_READY, 'World process', launch_world)


def wait_realm_server(active_process):
    return _wait_for_ready(active_process, lambda: SHARED_STATE.REALM_SERVER_READY, 'Realm process', launch_realm)


def wait_proxy_server(active_process):
    return _wait_for_ready(active_process, lambda: SHARED_STATE.PROXY_SERVER_READY, 'Proxy process', launch_realm)


def wait_login_server(active_process):
    return _wait_for_ready(active_process, lambda: SHARED_STATE.LOGIN_SERVER_READY, 'Login process')


def wait_update_server(active_process):
    return _wait_for_ready(active_process, lambda: SHARED_STATE.UPDATE_SERVER_READY, 'Update process')

SHARED_STATE = None
ACTIVE_PROCESSES = []

if __name__ == '__main__':
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
    exit_code = 0
    for process, wait_call in ACTIVE_PROCESSES:
        process.start()
        wait_call(process)
        if not SHARED_STATE.RUNNING:
            # Stopped during boot, by a stop signal or because this process died.
            exit_code = 0 if process.is_alive() else 1
            break

    if SHARED_STATE.RUNNING:
        # Print active env vars.
        for env_var_name in EnvVars.EnvironmentalVariables.ACTIVE_ENV_VARS:
            env_var = os.getenv(env_var_name, '')
            if env_var:
                Logger.info(f'Environment variable {env_var_name}: {env_var}')

        # Bell sound character.
        Logger.info('Alpha Core is now running.\a')

        # Handle console mode, the listener thread blocks on input() and ends with the process.
        if console_mode:
            threading.Thread(target=handle_console_commands, daemon=True).start()

        # Wait on main thread for a stop signal, the 'exit' command or a crashed process. Exiting with an error lets
        # supervisors (docker's restart on-failure, systemd) restart the server.
        while SHARED_STATE.RUNNING:
            dead_process = next((process for process, _ in ACTIVE_PROCESSES if not process.is_alive()), None)
            if dead_process:
                Logger.error(f'{dead_process.name} exited unexpectedly (exit code {dead_process.exitcode}).')
                exit_code = 1
                SHARED_STATE.RUNNING = False
                break
            sleep(2)

    # Exit.
    Logger.info('Shutting down the core, please wait...')

    # Make sure all processes finish gracefully (Exit their listening loops).
    [release_process(process) for process, wait_call in ACTIVE_PROCESSES]

    ACTIVE_PROCESSES.clear()

    # Dispose database engines and clear sessions in the main process.
    try:
        from database.auth.AuthDatabaseManager import AuthDatabaseManager
        from database.dbc.DbcDatabaseManager import DbcDatabaseManager
        from database.realm.RealmDatabaseManager import RealmDatabaseManager
        from database.world.WorldDatabaseManager import WorldDatabaseManager

        AuthDatabaseManager.dispose()
        Logger.info('Auth database released.')
        DbcDatabaseManager.dispose()
        Logger.info('DBC database released.')
        RealmDatabaseManager.dispose()
        Logger.info('Realm database released.')
        WorldDatabaseManager.dispose()
        Logger.info('World database released.')
    except:
        pass

    manager.shutdown()
    Logger.success('Core gracefully shut down.')
    exit(exit_code)
