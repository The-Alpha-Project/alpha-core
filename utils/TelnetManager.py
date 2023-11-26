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
        Logger.success(f'Ctrl+C received. Telnet cleaning up and exiting.')

        for connection in TelnetManager2.connections:
            connection.setsockopt(socket.SOL_SOCKET, socket.SO_LINGER, struct.pack('ii', 1, 0))
            connection.close()
            TelnetManager.connections.remove(connection)

        TelnetManager.server.close()

        Logger.success(f'Cleaning up completed.')
        sys.exit(0)

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
                            connection.send(connection, config.Telnet.Defaults.welcome + "\n\n") 
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
                
                # Send messages to all conected clients.
                for connection in TelnetManager.connections:
                    log_message = log_message + "\n"
                    connection.send(log_message.endcode())


class TelnetManager2:
    connections = []
    server = None

    @staticmethod
    def signal_handler(signum, frame):
        Logger.success(f'Ctrl+C received. Telnet cleaning up and exiting.')

        for connection in TelnetManager2.connections:
            connection.setsockopt(socket.SOL_SOCKET, socket.SO_LINGER, struct.pack('ii', 1, 0))
            connection.close()
            TelnetManager2.connections.remove(connection)

        TelnetManager2.server.close()

        Logger.success(f'Cleaning up completed.')
        sys.exit(0)

    @staticmethod
    def send_to_all_clients(msg):
        for connection in TelnetManager2.connections:
            msg = msg + "\n"
            connection.send(msg.encode())
   
    @staticmethod
    def start_telnet(parent_conn):
        TelnetManager2.parent_conn = parent_conn

        # Register the signal handler for Ctrl+C (SIGINT)
        signal.signal(signal.SIGINT, TelnetManager2.signal_handler)
        Logger.set_parent_conn(TelnetManager2.parent_conn)

        # starting telnet server
        TelnetManager2.server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        TelnetManager2.server.bind((config.Server.Connection.Telnet.host, config.Server.Connection.Telnet.port))
        TelnetManager2.server.listen(config.Telnet.Defaults.listen)
        TelnetManager2.server.settimeout(config.Telnet.Defaults.timeout)
        TelnetManager2.server.setblocking(False)
    
        Logger.success(f'Telnet server started, listening on {config.Server.Connection.Telnet.host}:{config.Server.Connection.Telnet.port}')
        TelnetManager2.connections_handler()

    @staticmethod
    def connections_handler():
        while True:
            try:
                readable, _, _ = select.select([TelnetManager2.server] + TelnetManager2.connections, [], [], config.Telnet.Defaults.timeout)

                for sock in readable:             
                    try:
                        if sock == TelnetManager2.server:
                            TelnetManager2.connect(sock)
                        else:
                            data = sock.recv(1024)

                            if not data:
                                TelnetManager2.disconnect(sock)
                            else:
                                data = data.decode().strip().replace('\n', '')

                                if '/' in data[0]:
                                   TelnetManager2.parent_conn.send(data.encode())

                    except AttributeError as ae:
                        Logger.error(f"Error {ae}")

            except Exception as e:
                    Logger.error(f"Error in the main loop: {e}")

            if TelnetManager2.parent_conn.poll():
                TelnetManager2.send_to_all_clients(TelnetManager2.parent_conn.recv())

    def connect(sock):
        connection, address = sock.accept()
        connection.setblocking(False)
        TelnetManager2.connections.append(connection)
        
        Logger.success(f'New connection from {address}')
        msg = config.Telnet.Defaults.welcome + "\n\n"
        connection.send(msg.encode()) 

    def disconnect(sock):
        TelnetManager2.connections.remove(sock)
        sock.close()
        
        Logger.success(f'Telnet: Client disconnected: {sock.getpeername()}')