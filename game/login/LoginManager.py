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
            Logger.success(f'[LoginServer] Started, listening on {real_binding[0]}:{real_binding[1]}')
            shared_state.LOGIN_SERVER_READY = True

            try:
                while shared_state.RUNNING:
                    client_socket, client_address = SocketBuilder.accept(server_socket, 'LoginServer')
                    if not client_socket:
                        continue
                    SocketBuilder.start_session(LoginSessionStateHandler, client_socket, client_address, 'LoginServer')
            except OSError:
                Logger.warning(traceback.format_exc())
            except KeyboardInterrupt:
                pass

        Logger.info('[LoginServer] Turned off.')
