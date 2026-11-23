import socket
import threading
import time
import traceback

from utils.ConfigManager import config
from utils.Logger import Logger


class SocketBuilder:
    # Sessions per IP and server (Settings.max_connections_per_ip, 0 = no cap), slow or idle connections hold a thread
    # each.
    _connections_lock = threading.Lock()
    _connections = {}  # (server name, ip) -> open sessions

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
        key = (server_name, client_address[0])
        max_connections = config.Server.Settings.max_connections_per_ip
        with SocketBuilder._connections_lock:
            if max_connections and SocketBuilder._connections.get(key, 0) >= max_connections:
                Logger.warning(f'[{server_name}] Refusing {client_address[0]}, too many connections.')
                client_socket.close()
                return
            SocketBuilder._connections[key] = SocketBuilder._connections.get(key, 0) + 1

        started = False
        try:
            server_handler = handler_class(client_socket, client_address)
            session_thread = threading.Thread(target=SocketBuilder._run_session, args=(server_handler, key))
            session_thread.daemon = True
            session_thread.start()
            started = True
        except OSError:
            client_socket.close()  # The client reset the connection.
        except RuntimeError as ex:
            Logger.warning(f'[{server_name}] Unable to start a session: {ex}.')
            client_socket.close()
        except Exception:
            Logger.error(traceback.format_exc())
            client_socket.close()
        finally:
            if not started:
                SocketBuilder._release(key)

    @staticmethod
    def _run_session(server_handler, key):
        try:
            server_handler.handle()
        finally:
            SocketBuilder._release(key)

    @staticmethod
    def _release(key):
        with SocketBuilder._connections_lock:
            left = SocketBuilder._connections.get(key, 1) - 1
            if left > 0:
                SocketBuilder._connections[key] = left
            else:
                SocketBuilder._connections.pop(key, None)
