from utils.ConfigManager import config
from utils.Logger import Logger

import select
import signal
import socket
import struct
import sys


class TelnetManager:
    connections = []
    server = None

    @staticmethod
    def authenticate_user(connection):
        connection.send("Enter username: ".encode())
        username = connection.recv(1024).decode().strip()

        connection.send("Enter password: ".encode())
        password = connection.recv(1024).decode().strip()

        # Check if username and password are valid
        if username == config.Telnet.Defaults.username and password == config.Telnet.Defaults.password:
            connection.send("\nAuthentication successful!\n\n".encode())
            return True
        else:
            connection.send("\nAuthentication failed. Closing connection.\n\n".encode())
            return False

    def connect(sock):
        try:
            connection, address = sock.accept()
            connection.setblocking(True)
            
            msg = config.Telnet.Defaults.welcome + "\n\n"
            Logger.success(f'New connection from {address}')
            connection.send(msg.encode())

            # Authenticate the user
            if not TelnetManager.authenticate_user(connection):
                connection.close()
                Logger.error(f'Failed authentication from {address}')
                return

            # Add the authenticated connection to the list
            connection.setblocking(False)
            TelnetManager.connections.append(connection)

        except Exception as e:
            Logger.error(f"Error in connect: {e}")

    @staticmethod
    def connections_handler():
        while True:
            try:
                readable, _, _ = select.select([TelnetManager.server] + TelnetManager.connections, [], [], config.Telnet.Defaults.timeout)

                for sock in readable:             
                    try:
                        if sock == TelnetManager.server:
                            TelnetManager.connect(sock)
                        else:
                            data = sock.recv(1024)

                            if not data:
                                TelnetManager.disconnect(sock)
                            else:
                                data = data.decode().strip().replace('\n', '')

                                if '/' in data[0]:
                                   TelnetManager.parent_conn.send(data.encode())

                    except AttributeError as ae:
                        Logger.error(f"Error {ae}")

            except Exception as e:
                    Logger.error(f"Error in the main loop: {e}")

            if TelnetManager.parent_conn.poll():
                TelnetManager.send_to_all_clients(TelnetManager.parent_conn.recv())


    def disconnect(sock):
        TelnetManager.connections.remove(sock)
        Logger.telnet_info(f'Client disconnected: {sock.getpeername()}')
        sock.close()

    @staticmethod
    def send_to_all_clients(msg):
        for connection in TelnetManager.connections:
            msg = msg + "\n"
            connection.send(msg.encode())

    @staticmethod
    def signal_handler(signum, frame):
        Logger.telnet_info(f'Ctrl+C received. Telnet cleaning up and exiting.')

        for connection in TelnetManager.connections:
            connection.setsockopt(socket.SOL_SOCKET, socket.SO_LINGER, struct.pack('ii', 1, 0))
            TelnetManager.disconnect(connection)

        TelnetManager.server.close()

        Logger.telnet_info(f'Cleaning up completed.')
        sys.exit(0)
   
    @staticmethod
    def start_telnet(parent_conn):
        TelnetManager.parent_conn = parent_conn

        # Register the signal handler for Ctrl+C (SIGINT)
        signal.signal(signal.SIGINT, TelnetManager.signal_handler)
        Logger.set_parent_conn(TelnetManager.parent_conn)

        # starting telnet server
        TelnetManager.server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        TelnetManager.server.bind((config.Server.Connection.Telnet.host, config.Server.Connection.Telnet.port))
        TelnetManager.server.listen(config.Telnet.Defaults.listen)
        TelnetManager.server.settimeout(config.Telnet.Defaults.timeout)
        TelnetManager.server.setblocking(False)
    
        Logger.success(f'Telnet server started, listening on {config.Server.Connection.Telnet.host}:{config.Server.Connection.Telnet.port}')
        TelnetManager.connections_handler()