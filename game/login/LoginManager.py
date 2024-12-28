import socket
import threading
import traceback

from game.login.LoginSessionStateHandler import LoginSessionStateHandler
from utils.ConfigManager import config
from utils.Logger import Logger


class LoginManager:
    @staticmethod
    def build_socket(address, port):
        socket_ = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        try:
            socket_.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEPORT, 1)
        # Use SO_REUSEADDR if SO_REUSEPORT doesn't exist.
        except AttributeError:
            socket_.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        socket_.bind((address, port))
        socket_.settimeout(2)
        return socket_

    @staticmethod
    def start_login(running, login_server_ready):
        login_host = config.Server.Connection.Login.host
        login_port = config.Server.Connection.Login.port
        with LoginManager.build_socket(login_host, login_port) as server_socket:
            server_socket.listen()
            real_binding = server_socket.getsockname()
            Logger.success(f'Login server started, listening on {real_binding[0]}:{real_binding[1]}')
            login_server_ready.value = 1

            try:
                while running.value:
                    try:
                        client_socket, client_address = server_socket.accept()
                        server_handler = LoginSessionStateHandler(client_socket, client_address)
                        world_session_thread = threading.Thread(target=server_handler.handle)
                        world_session_thread.daemon = True
                        world_session_thread.start()
                    except socket.timeout:
                        pass  # Non blocking.
            except OSError:
                Logger.warning(traceback.format_exc())
            except KeyboardInterrupt:
                pass

        Logger.info("Login server turned off.")
