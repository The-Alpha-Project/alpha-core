import socketserver
import threading
import socket

from struct import pack
from time import sleep

from game.world.opcode_handling.Definitions import Definitions
from network.packet.PacketWriter import *
from network.packet.PacketReader import *
from database.realm.RealmDatabaseManager import *


class ThreadedWorldServer(socketserver.ThreadingMixIn, socketserver.TCPServer):
    pass


class WorldServerSessionHandler(socketserver.BaseRequestHandler):
    def __init__(self, request, client_address, server):
        super().__init__(request, client_address, server)
        self.account = None

    def handle(self):
        try:
            self.auth_challenge(self.request)
            while self.receive(self, self.request) != -1:
                sleep(0.001)
        finally:
            self.request.shutdown(socket.SHUT_RDWR)
            self.request.close()

    @staticmethod
    def auth_challenge(sck):
        fmt = PacketWriter.get_packet_header_format(OpCode.SMSG_AUTH_CHALLENGE) + 'B' * 6
        header = PacketWriter.get_packet_header(OpCode.SMSG_AUTH_CHALLENGE, fmt)
        packet = pack(
            fmt,
            header[0], header[1], header[2], header[3],
            0, 0, 0, 0, 0, 0
        )

        sck.sendall(packet)

    @staticmethod
    def receive(self, sck):
        try:
            data = sck.recv(8192)
            reader = PacketReader(data)
            if reader.opcode:
                handler = Definitions.get_handler_from_packet(reader.opcode)
                if handler:
                    Logger.debug('Handling %s' % OpCode(reader.opcode))
                    if handler(self, sck, reader.data) != 0:
                        return -1
        except OSError:
            Logger.warning('Tried to interact with a closed socket.')
            return -1

    @staticmethod
    def start():
        Logger.info('World server started.')

        RealmDatabaseManager.load_tables()

        with ThreadedWorldServer((config.Server.Connection.WorldServer.host, config.Server.Connection.WorldServer.port),
                                 WorldServerSessionHandler) as world_instance:
            world_instance.allow_reuse_address = True
            world_session_thread = threading.Thread(target=world_instance.serve_forever())
            world_session_thread.daemon = True
            world_session_thread.start()
