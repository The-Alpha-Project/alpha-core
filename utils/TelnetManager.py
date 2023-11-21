import socket
import select
from utils.ConfigManager import config
from utils.Logger import Logger
import sys
import signal

class TelnetManager:
    connections = []
    server = None
 
    @staticmethod
    def signal_handler(signum, frame):
        Logger.info(f'Telnet: Ctrl+C received. Cleaning up and exiting.')
        # TelnetManager.cleanup()
        for connection in TelnetManager.connections:
            connection.close()

        # if TelnetManager.server:
        TelnetManager.server.close()

        Logger.info(f'Telnet: Cleaning up completed.')
        sys.exit(0)

    @staticmethod
    def cleanup():
        
        for connection in TelnetManager.connections:
            connection.close()

        if TelnetManager.server:
            TelnetManager.server.close()

        Logger.info(f'Telnet: Cleaning up completed.')

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
                readable, _, _ = select.select([TelnetManager.server] + TelnetManager.connections, [], [], 0.1)

                for sock in readable:
                    try:
                        if sock == TelnetManager.server:
                            connection, address = sock.accept()
                            connection.setblocking(False)
                            TelnetManager.connections.append(connection)
                            TelnetManager.send(connection, config.Telnet.Defaults.welcome + "\n\n") 
                            Logger.info(f'Telnet: New connection from {address}')
                        else:
                            data = sock.recv(1024)

                            if not data:
                                Logger.info(f'Telnet: Client disconnected: {sock.getpeername()}')
                                TelnetManager.connections.remove(sock)
                                sock.close()
                            else:
                                data = data.decode().strip().replace('\n', '')

                                if data == "help":
                                    Logger.debug(f'Telnet: help command')
                                else:
                                    Logger.debug(f'Telnet: Received data from {sock.getpeername()}: {data}')
                                
                    except AttributeError as ae:
                        print(f"AttributeError: {ae}")

            except Exception as e:
                # Handle exceptions, e.g., print an error message
                print(f"Exception in the main loop: {e}")

            if conn.poll():
                log_message = conn.recv()
                # Logger.info(f"Received message from child: {log_message}")

                for connection in TelnetManager.connections:
                    TelnetManager.send(connection, log_message + "\n")