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
from utils.TelnetManager import TelnetManager, TelnetManager2
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

    login_process, login_conn = None, None
    proxy_process, proxy_conn = None, None
    world_process, world_conn = None, None
    telnet_process, telnet_conn= None, None

    if config.Telnet.Defaults.enabled and not config.Server.Settings.console_mode:
        parent_login_conn, login_conn = multiprocessing.Pipe()
        parent_proxy_conn, proxy_conn = multiprocessing.Pipe()
        parent_world_conn, world_conn = multiprocessing.Pipe()
        parent_telnet_conn, telnet_conn = multiprocessing.Pipe()

        telnet_process = context.Process(target=TelnetManager2.start_telnet, args=(telnet_conn,))
        telnet_process.start()

    if launch_realm:
        login_process = context.Process(target=RealmManager.start_realm, args=(login_conn,))
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

        # noinspection PyBroadException
        try:
            if os.getenv(EnvVars.EnvironmentalVariables.CONSOLE_MODE,
                         config.Server.Settings.console_mode) in [True, 'True', 'true']:
                while input() != 'exit':
                    Logger.error('Invalid command.')
            else:
                if not config.Telnet.Defaults.enabled:
                    world_process.join()
                else:
                    if config.Telnet.Defaults.enabled:
                        processes = [login_process, world_process, proxy_process, telnet_process]

                        # Checking for pipe messages to telnet from all processes
                        while any(process.is_alive() for process in processes):
                            if parent_world_conn.poll():
                                message = parent_world_conn.recv()
                                parent_telnet_conn.send(message)
                            if parent_login_conn.poll():
                                message = parent_login_conn.recv()
                                parent_telnet_conn.send(message)
                            if parent_proxy_conn.poll():
                                message = parent_proxy_conn.recv()
                                parent_telnet_conn.send(message)
                            if parent_telnet_conn.poll():
                                message = parent_telnet_conn.recv()
                                
                                if isinstance(message, bytes):
                                    if b'/' in message: 
                                        parent_world_conn.send(message)
                                
                                    parent_telnet_conn.send(message.decode())
                                       
        except Exception as e:
            print(f"An unexpected error occurred: {e}")
            Logger.info('Shutting down the core...')

        ChatLogManager.exit()

    # Send SIGTERM to processes.
    # Add checks to send SIGTERM to only running process
    if launch_world:
        world_process.terminate()
        Logger.info('World process terminated.')
    if launch_realm:
        login_process.terminate()
        Logger.info('Login process terminated.')
        proxy_process.terminate()
        Logger.info('Proxy process terminated.')
    if config.Telnet.Defaults.enabled:
        telnet_process.terminate()
        Logger.info('Telnet process terminated.') 

    # Release process resources.
    Logger.info('Waiting to release resources...')

    if launch_world:
        release_process(world_process)
    if launch_realm:
        release_process(proxy_process)
        release_process(login_process)
    if config.Telnet.Defaults.enabled:
        release_process(telnet_process)

    Logger.success('Core gracefully shut down.')
