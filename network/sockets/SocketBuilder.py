import socket
import threading
import time
import traceback

from utils.Logger import Logger


class SocketBuilder:

    @staticmethod
    def build_socket(address, port, timeout):
        socket_ = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        try:
            socket_.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEPORT, 1)
        # Use SO_REUSEADDR if SO_REUSEPORT doesn't exist.
        except AttributeError:
            socket_.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        socket_.bind((address, port))
        socket_.settimeout(timeout)
        return socket_

    # A failed accept (fd limit, a connection reset before it was accepted) must not stop the server.
    @staticmethod
    def accept(server_socket, server_name):
        try:
            return server_socket.accept()
        except socket.timeout:
            pass  # Non blocking.
        except OSError as ex:
            Logger.warning(f'[{server_name}] Unable to accept a connection: {ex}.')
            time.sleep(0.2)
        return None, None

    # Build the session handler and start its thread. A failing client is refused instead of ending the accept loop,
    # which would end the process, and the main process then stops the whole server.
    @staticmethod
    def start_session(handler_class, client_socket, client_address, server_name):
        try:
            server_handler = handler_class(client_socket, client_address)
            session_thread = threading.Thread(target=server_handler.handle)
            session_thread.daemon = True
            session_thread.start()
        except OSError:
            client_socket.close()  # The client reset the connection.
        except RuntimeError as ex:
            Logger.warning(f'[{server_name}] Unable to start a session: {ex}.')
            client_socket.close()
        except Exception:
            Logger.error(traceback.format_exc())
            client_socket.close()
