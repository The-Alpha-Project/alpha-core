import multiprocessing
import os
import argparse
from sys import platform, argv
from time import sleep

from game.realm import RealmManager
from game.world import WorldManager
from game.world.managers.maps.MapManager import MapManager
from game.world.managers.maps.MapTile import MapTile
from utils.ConfigManager import config, ConfigManager
from utils.Logger import Logger
from utils.ChatLogManager import ChatLogManager
from utils.PathManager import PathManager
from utils.constants import EnvVars

#Argument Parser
parser = argparse.ArgumentParser(description="Alpha-Core help", formatter_class=argparse.ArgumentDefaultsHelpFormatter)
parser.add_argument("-l", help="Usage: -l realm -l world", dest='launch', action='store_true')
args, unknown = parser.parse_known_args()

def release_process(process):
    while process.is_alive():
        try:
            process.join(timeout=2)  # Seconds.
            if process.is_alive():
                process.terminate()
        except ValueError:
            sleep(0.1)


if __name__ == '__main__':
    # Initialize path
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

    if not args.launch:
        login_process = context.Process(target=RealmManager.LoginServerSessionHandler.start)
        login_process.start()

        proxy_process = context.Process(target=RealmManager.ProxyServerSessionHandler.start)
        proxy_process.start()

        world_process = context.Process(target=WorldManager.WorldServerSessionHandler.start)
        world_process.start()
    else:
        if (argv[-1] == "realm"):
            login_process = context.Process(target=RealmManager.LoginServerSessionHandler.start)
            login_process.start()
        
            proxy_process = context.Process(target=RealmManager.ProxyServerSessionHandler.start)
            proxy_process.start()
        
        if (argv[-1] == "world"):
            world_process = context.Process(target=WorldManager.WorldServerSessionHandler.start)
            world_process.start()
        
    # noinspection PyBroadException
    try:
        if os.getenv('CONSOLE_MODE', config.Server.Settings.console_mode) in [True, 'True', 'true']:
            while input() != 'exit':
                Logger.error('Invalid command.')
        else:
            world_process.join()
    except:
        Logger.info('Shutting down the core...')

    ChatLogManager.exit()
    
    # Send SIGTERM to processes.
    # Add checks to send SIGTERM to only running process
    if argv:
        if argv[-1] == "world":
            world_process.terminate()
            Logger.info('World process terminated.')
        if argv[-1] == "realm":
            login_process.terminate()
            Logger.info('Login process terminated.')
            proxy_process.terminate()
            Logger.info('Proxy process terminated.')
    else:
        world_process.terminate()
        Logger.info('World process terminated.')
        proxy_process.terminate()
        Logger.info('Proxy process terminated.')
        login_process.terminate()
        Logger.info('Login process terminated.')

    # Release process resources.
    Logger.info('Waiting to release resources...')
    
    #These checks are needed to prevent an end of program crash with keyboard interrupt
    if argv[-1] == "world":
        release_process(world_process)
    elif argv[-1] == "realm":
        release_process(proxy_process)
        release_process(login_process)
    else:
        release_process(world_process)
        release_process(proxy_process)
        release_process(login_process)

    Logger.success('Core gracefully shut down.')
