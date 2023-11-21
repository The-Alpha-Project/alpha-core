import socket
import select
import multiprocessing
import telnetlib
from utils.ConfigManager import config
from utils.Logger import Logger
import time


class TelnetManager:
    connections = []

    @staticmethod
    def send(conn, msg):
        conn.send(msg.encode())

    @staticmethod
    def start_telnet(conn):
        # Logger.set_parent_conn(conn)

        # Telnet server setup

        server = telnetlib.Telnet()
        server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        server.bind((config.Server.Connection.Telnet.host, config.Server.Connection.Telnet.port))
        server.listen(config.Telnet.Defaults.listen)
        server.settimeout(config.Telnet.Defaults.timeout)

        Logger.success(f'Telnet server started, listening on {config.Server.Connection.Telnet.host}:{config.Server.Connection.Telnet.port}')
        
        while True:
            readable, addr, exceptional = select.select([server] + TelnetManager.connections, [], [])

            for sock in readable:
                if sock == server:
                    while conn.poll():
                        conn.recv()

                    connection, addr = server.accept()
                    connection.setblocking(False)

                    TelnetManager.send(connection, config.Telnet.Defaults.welcome + "\n\n") 
                    
                    # connection.send(b"User: ")
                    # username = connection.recv(1024).strip().decode('utf-8')

                    # connection.send(b"Password: ")
                    # password = connection.recv(1024).strip().decode('utf-8')

                    # if username == config.Telnet.Defaults.user and password == config.Telnet.Defaults.password:
                    TelnetManager.connections.append(connection)
                    Logger.success(f'Telnet: connection from {addr} \n')
                    # else:
                      #  Logger.success(f'Telnet: Authentication failed for user {username}')
                        # TelnetManager.connections.remove(connection)
                       # connection.close()

        """

            # try:
            if TelnetManager.connections:
                    log_message = conn.recv()
                # while TelnetManager.connections:
                    for connection in TelnetManager.connections:
                        try:
                            TelnetManager.send(connection, log_message + "\n\n") 
                        except socket.error:
                            # Handle socket error (client disconnected)
                            TelnetManager.connections.remove(connection)
                            connection.close()
                            Logger.success("Telnet: Client disconnected")
                            break

                        log_message = conn.recv()

            # except multiprocessing.TimeoutError:
                # print("TIMEOUT")"""