import threading

import colorama

from network.realm import RealmManager
from network.world import WorldManager

if __name__ == '__main__':
    # initialize colorama to make ansi codes work in Windows
    colorama.init()

    login_thread = threading.Thread(target=RealmManager.LoginServer.start)
    login_thread.start()

    proxy_thread = threading.Thread(target=RealmManager.ProxyServer.start)
    proxy_thread.start()

    world_thread = threading.Thread(target=WorldManager.WorldServer.start)
    world_thread.start()
