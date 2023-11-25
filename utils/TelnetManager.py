import socket
import select
from utils.ConfigManager import config
from utils.Logger import Logger
import sys
import signal
import struct

class TelnetManager:
    connections = []
    server = None
 
    @staticmethod
    def signal_handler(signum, frame):
        Logger.sucess(f'Telnet: Ctrl+C received. Cleaning up and exiting.')

        for connection in TelnetManager.connections:
            connection.setsockopt(socket.SOL_SOCKET, socket.SO_LINGER, struct.pack('ii', 1, 0))
            connection.close()
            TelnetManager.connections.remove(connection)

        TelnetManager.server.close()

        Logger.success(f'Telnet: Cleaning up completed.')
        sys.exit(0)

    @staticmethod
    def send(conn, msg):
        conn.send(msg.encode())

    @staticmethod
    def start_telnet(conn):
        Logger.set_parent_conn(conn)

        TelnetManager.server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        TelnetManager.server.bind((config.Server.Connection.Telnet.host, config.Server.Connection.Telnet.port))
        TelnetManager.server.listen(config.Telnet.Defaults.listen)
        TelnetManager.server.settimeout(config.Telnet.Defaults.timeout)
        TelnetManager.server.setblocking(False)

        # Register the signal handler for Ctrl+C (SIGINT)
        signal.signal(signal.SIGINT, TelnetManager.signal_handler)
    
        Logger.success(f'Telnet server started, listening on {config.Server.Connection.Telnet.host}:{config.Server.Connection.Telnet.port}')

        while True:
            try:
                # Use a timeout of 0.1 seconds to prevent blocking indefinitely
                readable, _, _ = select.select([TelnetManager.server] + TelnetManager.connections, [], [], config.Telnet.Defaults.timeout)

                for sock in readable:
                    try:
                        if sock == TelnetManager.server:
                            connection, address = sock.accept()
                            connection.setblocking(False)
                            TelnetManager.connections.append(connection)
                            TelnetManager.send(connection, config.Telnet.Defaults.welcome + "\n\n") 
                            Logger.success(f'Telnet: New connection from {address}')
                        else:
                            data = sock.recv(1024)

                            if not data:
                                Logger.success(f'Telnet: Client disconnected: {sock.getpeername()}')
                                TelnetManager.connections.remove(sock)
                                sock.close()
                            else:
                                data = data.decode().strip().replace('\n', '')

                                if '/' in data:
                                    TelnetManager.send(conn, data)
                                    Logger.success(f'Telnet: {data}')
                                else:
                                    Logger.success(f'Telnet: Received data from {sock.getpeername()}: {data}')
                                
                    except AttributeError as ae:
                        print(f"AttributeError: {ae}")

            except Exception as e:
                print(f"Exception in the main loop: {e}")

            if conn.poll():
                log_message = conn.recv()
                # For testing
                # Logger.debug(f"Received message from other processes: {log_message}")

                # Send messages to all conected clients.
                for connection in TelnetManager.connections:
                    TelnetManager.send(connection, log_message + "\n")