import threading

import colorama

from network.realm import RealmManager
from network.world import WorldManager

if __name__ == '__main__':
    # initialize colorama to make ansi codes work in Windows
    colorama.init()

    login_thread = threading.Thread(target=RealmManager.LoginServerSessionHandler.start)
    login_thread.start()

    proxy_thread = threading.Thread(target=RealmManager.ProxyServerSessionHandler.start)
    proxy_thread.start()

    world_thread = threading.Thread(target=WorldManager.WorldServerSessionHandler.start)
    world_thread.start()



