import socket
import threading
import traceback
from typing import Any

from game.update.UpdateSessionStateHandler import UpdateSessionStateHandler
from network.sockets.SocketBuilder import SocketBuilder
from utils.ConfigManager import config
from utils.Logger import Logger


class UpdateManager:
    @staticmethod
    def start_update(shared_state: Any):
        update_host = config.Server.Connection.UpdateServer.host
        update_port = config.Server.Connection.UpdateServer.port
        with SocketBuilder.build_socket(update_host, update_port, timeout=2) as server_socket:
            server_socket.listen()
            real_binding = server_socket.getsockname()
            Logger.success(f'Update server started, listening on {real_binding[0]}:{real_binding[1]}')
            shared_state.UPDATE_SERVER_READY = 1

            try:
                while shared_state.RUNNING:
                    try:
                        client_socket, client_address = server_socket.accept()
                        server_handler = UpdateSessionStateHandler(client_socket, client_address)
                        update_session_thread = threading.Thread(target=server_handler.handle)
                        update_session_thread.daemon = True
                        update_session_thread.start()
                    except socket.timeout:
                        pass  # Non blocking.
            except OSError:
                Logger.warning(traceback.format_exc())
            except KeyboardInterrupt:
                pass

        Logger.info("Update server turned off.")
