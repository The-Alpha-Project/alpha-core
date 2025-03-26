import socket
import threading
import traceback

from game.login.LoginSessionStateHandler import LoginSessionStateHandler
from network.sockets.SocketBuilder import SocketBuilder
from utils.ConfigManager import config
from utils.Logger import Logger


class LoginManager:
    @staticmethod
    def start_login(running, login_server_ready):
        login_host = config.Server.Connection.Login.host
        login_port = config.Server.Connection.Login.port
        with SocketBuilder.build_socket(login_host, login_port, timeout=2) as server_socket:
            server_socket.listen()
            real_binding = server_socket.getsockname()
            Logger.success(f'Login server started, listening on {real_binding[0]}:{real_binding[1]}')
            login_server_ready.value = 1

            try:
                while running.value:
                    try:
                        client_socket, client_address = server_socket.accept()
                        server_handler = LoginSessionStateHandler(client_socket, client_address)
                        auth_session_thread = threading.Thread(target=server_handler.handle)
                        auth_session_thread.daemon = True
                        auth_session_thread.start()
                    except socket.timeout:
                        pass  # Non blocking.
            except OSError:
                Logger.warning(traceback.format_exc())
            except KeyboardInterrupt:
                pass

        Logger.info("Login server turned off.")
