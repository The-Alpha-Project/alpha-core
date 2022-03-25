import multiprocessing
import os
from sys import platform
from time import sleep

import colorama

from game.realm import RealmManager
from game.world import WorldManager
from game.world.managers.maps.MapManager import MapManager
from game.world.managers.maps.MapTile import MapTile
from utils.ConfigManager import config, ConfigManager
from utils.Logger import Logger
from utils.PathManager import PathManager


def release_process(process):
    retry = True
    while retry:
        try:
            process.close()
        except ValueError:
            sleep(0.1)
        finally:
            retry = False


if __name__ == '__main__':
    # Initialize colorama
    colorama.init()
    # Initialize path
    PathManager.set_root_path(os.path.dirname(os.path.realpath(__file__)))

    # Validate configuration file version.
    try:
        if config.Version.current != ConfigManager.EXPECTED_VERSION:
            Logger.error(f'Invalid config.yml version. Expected {ConfigManager.EXPECTED_VERSION} '
                         f'found {config.Version.current}.')
            exit()
    except AttributeError:
        Logger.error(f'Invalid config.yml version. Expected {ConfigManager.EXPECTED_VERSION}, none found.')
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

    login_process = context.Process(target=RealmManager.LoginServerSessionHandler.start)
    login_process.start()

    proxy_process = context.Process(target=RealmManager.ProxyServerSessionHandler.start)
    proxy_process.start()

    world_process = context.Process(target=WorldManager.WorldServerSessionHandler.start)
    world_process.start()

    try:
        if os.getenv('CONSOLE_MODE', config.Server.Settings.console_mode) in [True, 'True', 'true']:
            while input() != 'exit':
                Logger.error('Invalid command.')
        else:
            world_process.join()
    except:
        Logger.info('Shutting down the core...')

    # Send SIGTERM to processes.
    world_process.terminate()
    Logger.info('World process terminated.')
    proxy_process.terminate()
    Logger.info('Proxy process terminated.')
    login_process.terminate()
    Logger.info('Login process terminated.')

    # Release process resources.
    Logger.info('Waiting to release resources...')
    release_process(world_process)
    release_process(proxy_process)
    release_process(login_process)

    Logger.success('Core gracefully shut down.')
