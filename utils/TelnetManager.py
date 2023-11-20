import socket
import select
import multiprocessing
import telnetlib
from utils.Logger import Logger


class TelnetManager:
    connections = []

    @staticmethod
    def start_telnet(conn, host='0.0.0.0', port=5000):
        Logger.set_parent_conn(conn)

        # Telnet server setup
        server = telnetlib.Telnet()
        server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        server.bind((host, port))
        server.listen(5)
        server.settimeout(0.1)

        Logger.success(f'Telnet server started, listening on {host}:{port}')

        while True:
            readable, addr, exceptional = select.select([server] + TelnetManager.connections, [], [])

            for sock in readable:
                if sock == server:
                    while conn.poll():
                        conn.recv()

                    connection, addr = server.accept()
                    connection.setblocking(False)
                    connection.send(b"Welcome to the Telnet server!\n\n")
                    TelnetManager.connections.append(connection)
                    Logger.success(f'Telnet: connection from {addr} \n')

            try:
               # if TelnetManager.connections:
                        log_message = conn.recv()
                    # while TelnetManager.connections:
                        for connection in TelnetManager.connections:
                            try:
                                connection.send((log_message + "\r\n").encode())
                            except socket.error:
                                # Handle socket error (client disconnected)
                                TelnetManager.connections.remove(connection)
                                connection.close()
                                Logger.success("Telnet: Client disconnected")
                                break

                        log_message = conn.recv()

            except multiprocessing.TimeoutError:
                pass

            print("No loop")