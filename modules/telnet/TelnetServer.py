from utils.ConfigManager import config
from utils.Logger import Logger

import select
import socket


class TelnetServer:
    connections = []
    command_history = []
    server = None

    @staticmethod
    def authenticate_user(connection):
        connection.send('Enter username: '.encode())
        username = connection.recv(1024).decode().strip()

        connection.send('Enter password: '.encode())
        password = connection.recv(1024).decode().strip()

        if username == config.Telnet.Defaults.username and password == config.Telnet.Defaults.password:
            connection.send('\nAuthentication successful!\n'.encode())
            connection.send('\nType history or h to list all used commands'.encode())
            connection.send('\nExit with Ctrl+5 quit\n\n'.encode())
            return True
        else:
            connection.send('\nAuthentication failed. Closing connection.\n\n'.encode())
            return False

    def connect(sock):
        try:
            connection, address = sock.accept()
            connection.setblocking(True)
            
            msg = config.Telnet.Defaults.welcome + '\n\n'
            Logger.success(f'New connection from {address}')
            connection.send(msg.encode())

            if not TelnetServer.authenticate_user(connection):
                connection.close()
                Logger.error(f'Failed authentication from {address}')
                return

            connection.setblocking(False)
            TelnetServer.connections.append(connection)

        except Exception as e:
            Logger.error(f'Error in connect: {e}')

    @staticmethod
    def connections_handler():
        while True:
            try:
                readable, _, _ = select.select([TelnetServer.server] + TelnetServer.connections, [], [], config.Telnet.Defaults.timeout)

                for sock in readable:             
                    if sock == TelnetServer.server:
                        TelnetServer.connect(sock)
                    else:
                        data = sock.recv(1024)

                        if not data:
                            TelnetServer.disconnect(sock)
                        else:
                            data = data.decode().strip().replace('\n', '')

                            if data == 'history' or data == 'h':
                                for command in TelnetServer.command_history:
                                    sock.send(command.encode())
                            elif data == 'help' or data == 'h':
                                    sock.send('All telnet commands need to start with a slash "/"\n'.encode())
                                    sock.send('You can also use "history" or "h"'.encode())
                            else:
                                TelnetServer.command_history.append(data + '\n')

                            if '/' in data[0] and len(data) > 1:
                                TelnetServer.parent_conn.send(data.encode())

            except Exception as e:
                    Logger.error(f'Error in the main loop: {e}')
                    pass 
                    
            if TelnetServer.parent_conn.poll():
                TelnetServer.send_to_all_clients(TelnetServer.parent_conn.recv())

    def disconnect(sock):
        TelnetServer.connections.remove(sock)
        Logger.info(f'Client disconnected: {sock.getpeername()}')
        sock.close()

    @staticmethod
    def send_to_all_clients(msg):
        for connection in TelnetServer.connections:
            connection.send(msg.encode())

    @staticmethod
    def start_telnet(parent_conn):
        TelnetServer.parent_conn = parent_conn

        Logger.set_parent_conn(TelnetServer.parent_conn)

        TelnetServer.server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        TelnetServer.server.bind((config.Server.Connection.Telnet.host, config.Server.Connection.Telnet.port))
        TelnetServer.server.listen(config.Telnet.Defaults.listen)
        TelnetServer.server.settimeout(config.Telnet.Defaults.timeout)
        TelnetServer.server.setblocking(False)
    
        Logger.success(f'Telnet server started, listening on {config.Server.Connection.Telnet.host}:{config.Server.Connection.Telnet.port}')
        TelnetServer.connections_handler()