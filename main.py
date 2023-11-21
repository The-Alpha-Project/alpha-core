import multiprocessing
import os
import argparse
from sys import platform
from time import sleep

from game.realm.RealmManager import RealmManager
from game.world import WorldManager
from game.world.managers.maps.MapManager import MapManager
from game.world.managers.maps.MapTile import MapTile
from tools.map_extractor.MapExtractor import MapExtractor
from utils.ConfigManager import config, ConfigManager
from utils.Logger import Logger
from utils.ChatLogManager import ChatLogManager
from utils.TelnetManager import TelnetManager
from utils.PathManager import PathManager
from utils.constants import EnvVars

from game.world.managers.CommandManager import CommandManager

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


def release_process(process):
    while process.is_alive():
        try:
            process.join(timeout=2)  # Seconds.
            if process.is_alive():
                process.terminate()
        except (ValueError, KeyboardInterrupt):
            sleep(0.1)


if __name__ == '__main__':
    parent_conn1, telnet_conn = multiprocessing.Pipe()
    parent_conn2, world_conn = multiprocessing.Pipe()
    parent_conn3, realm_conn = multiprocessing.Pipe()
    parent_conn4, proxy_conn = multiprocessing.Pipe()

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
    if not MapManager.validate_maps():
        Logger.error(f'Invalid maps version or maps missing, expected version {MapTile.EXPECTED_VERSION}')
        exit()

    # if platform != 'win32':
    #    from signal import signal, SIGPIPE, SIG_DFL
    #    # https://stackoverflow.com/a/30091579
    #    signal(SIGPIPE, SIG_DFL)

    # Semaphore objects are leaked on shutdown in macOS if using spawn for some reason.
    if platform == 'darwin':
        context = multiprocessing.get_context('fork')
    else:
        context = multiprocessing.get_context('spawn')

    # Print active env vars.
    for env_var_name in EnvVars.EnvironmentalVariables.ACTIVE_ENV_VARS:
        env_var = os.getenv(env_var_name, '')
        if env_var:
            Logger.info(f'Environment variable {env_var_name}: {env_var}')

    # Process launching starts here.

    launch_realm = not args.launch or args.launch == 'realm'
    launch_world = not args.launch or args.launch == 'world'

    login_process = None
    proxy_process = None
    world_process = None
    telnet_process = None

    if config.Telnet.Defaults.enabled:
        telnet_process = context.Process(target=TelnetManager.start_telnet, args=(telnet_conn,))
        telnet_process.start()
    
    if launch_realm:
        login_process = context.Process(target=RealmManager.start_realm, args=(realm_conn,))
        login_process.start()

        proxy_process = context.Process(target=RealmManager.start_proxy, args=(proxy_conn,))
        proxy_process.start()

        if not launch_world:
            try:
                login_process.join()
            except:
                Logger.info('Terminating login processes...')
    
    if launch_world:
        world_process = context.Process(target=WorldManager.WorldServerSessionHandler.start,args=(world_conn,))
        world_process.start()

        if not launch_realm:
            try:
                world_process.join()
            except:
                Logger.info('Shutting down the core...')

        ChatLogManager.exit()

    processes = [telnet_process, login_process, world_process]
        
    if config.Telnet.Defaults.enabled:
        while any(process.is_alive() for process in processes):
            if parent_conn2.poll():
                message = parent_conn2.recv()
                parent_conn1.send(message)
                # print(f"Received message from child: {message}")

    # Send SIGTERM to processes.
    for process in processes:
        if process and process.is_alive():
            process.terminate()
            Logger.info(f'{process.name} process terminated.')

    # Release process resources.
    Logger.info('Waiting to release resources...')

    for process in processes:
        if process:
            release_process(process)

    Logger.success('Core gracefully shut down.')
