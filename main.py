import threading

import colorama

from network.realm import RealmSession

if __name__ == '__main__':
    # initialize colorama to make ansi codes work in Windows
    colorama.init()

    login_thread = threading.Thread(target=RealmSession.LoginServer.start)
    login_thread.start()

    proxy_thread = threading.Thread(target=RealmSession.ProxyServer.start)
    proxy_thread.start()
