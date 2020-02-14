import threading

import colorama

from apscheduler.schedulers.background import BackgroundScheduler
from sys import platform

from game.realm import RealmManager
from game.world import WorldManager
from utils.ConfigManager import config
from database.realm.RealmDatabaseManager import RealmDatabaseManager
from utils.Logger import Logger


if __name__ == '__main__':
    # initialize colorama to make ansi codes work in Windows
    colorama.init()

    if platform != 'win32':
        from signal import signal, SIGPIPE, SIG_DFL
        # https://stackoverflow.com/a/30091579
        signal(SIGPIPE, SIG_DFL)

    login_thread = threading.Thread(target=RealmManager.LoginServerSessionHandler.start)
    login_thread.start()

    proxy_thread = threading.Thread(target=RealmManager.ProxyServerSessionHandler.start)
    proxy_thread.start()

    world_thread = threading.Thread(target=WorldManager.WorldServerSessionHandler.start)
    world_thread.start()

    realm_saving_scheduler = BackgroundScheduler()
    realm_saving_scheduler._daemon = True
    realm_saving_scheduler.add_job(RealmDatabaseManager.save, 'interval',
                                   seconds=config.Server.Settings.realm_saving_interval_seconds)
    realm_saving_scheduler.start()
