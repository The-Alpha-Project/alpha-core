import socket
import threading
import traceback
from typing import Any

from game.login.LoginSessionStateHandler import LoginSessionStateHandler
from network.sockets.SocketBuilder import SocketBuilder
from utils.ConfigManager import config
from utils.Logger import Logger


class LoginManager:
    @staticmethod
    def start_login(shared_state: Any):
        login_host = config.Server.Connection.LoginServer.host
        login_port = config.Server.Connection.LoginServer.port
        with SocketBuilder.build_socket(login_host, login_port, timeout=2) as server_socket:
            server_socket.listen()
            real_binding = server_socket.getsockname()
            Logger.success(f'Login server started, listening on {real_binding[0]}:{real_binding[1]}')
            shared_state.LOGIN_SERVER_READY = True

            try:
                while shared_state.RUNNING:
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
