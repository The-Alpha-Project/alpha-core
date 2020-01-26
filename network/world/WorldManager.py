import socketserver

from struct import pack
from time import sleep

from utils.ConfigManager import config
from utils.Logger import Logger
from network.packet.PacketWriter import *
from network.packet.PacketReader import *
from network.world.handlers.Definitions import *


class WorldServer(socketserver.BaseRequestHandler):
    def handle(self):
        self.auth_challenge(self.request)
        while True:
            sleep(0.01)
            self.receive(self.request)

    @staticmethod
    def auth_challenge(socket):
        fmt = PacketWriter.get_packet_header_format(OpCode.SMSG_AUTH_CHALLENGE) + 'B' * 6
        header = PacketWriter.get_packet_header(OpCode.SMSG_AUTH_CHALLENGE, fmt)
        packet = pack(
            fmt,
            header[0],
            header[1],
            header[2],
            header[3],
            0, 0, 0, 0, 0, 0
        )

        socket.sendall(packet)

    @staticmethod
    def receive(socket):
        data = socket.recv(4096)
        reader = PacketReader(data)
        handler = Definitions.get_handler_from_packet(reader.opcode)
        if handler:
            Logger.debug('Handling %s' % OpCode(reader.opcode))
            handler(socket, data)

    @staticmethod
    def start():
        Logger.info('World server started.')
        with socketserver.TCPServer((config.Server.Connection.WorldServer.host,
                                     config.Server.Connection.WorldServer.port), WorldServer) as world_instance:
            world_instance.allow_reuse_address = True
            world_instance.serve_forever()
