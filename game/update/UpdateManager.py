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
            Logger.success(f'[UpdateServer] Started, listening on {real_binding[0]}:{real_binding[1]}')
            shared_state.UPDATE_SERVER_READY = True

            try:
                while shared_state.RUNNING:
                    client_socket, client_address = SocketBuilder.accept(server_socket, 'UpdateServer')
                    if not client_socket:
                        continue
                    Logger.debug(f'[UpdateServer] Accepted {client_address}')
                    server_handler = UpdateSessionStateHandler(client_socket, client_address)
                    SocketBuilder.start_session_thread(client_socket, server_handler.handle, 'UpdateServer')
            except OSError:
                Logger.warning(traceback.format_exc())
            except KeyboardInterrupt:
                pass

        Logger.info('[UpdateServer] Turned off.')
