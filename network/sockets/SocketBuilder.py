import socket
import threading
import time

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

    # Refuse the client instead of stopping the server when no more threads can be started.
    @staticmethod
    def start_session_thread(client_socket, target, server_name):
        try:
            session_thread = threading.Thread(target=target)
            session_thread.daemon = True
            session_thread.start()
        except RuntimeError as ex:
            Logger.warning(f'[{server_name}] Unable to start a session: {ex}.')
            client_socket.close()
