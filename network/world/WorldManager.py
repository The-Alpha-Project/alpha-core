import socketserver

from struct import pack

from utils.ConfigManager import config
from utils.Logger import Logger
from network.packet.PacketWriter import *


class WorldServer(socketserver.BaseRequestHandler):
    def handle(self):
        self.receive(self.request)

    @staticmethod
    def receive(socket):
        header = PacketWriter.get_packet_header(SMSG_AUTH_CHALLENGE)

        packet = pack(
            PacketWriter.get_packet_header_format(SMSG_AUTH_CHALLENGE) + 'B' * 6,
            header[0],
            header[1],
            header[2],
            header[3],
            header[4],
            0, 0, 0, 0, 0, 0
        )

        socket.sendall(packet)
        socket.close()

    @staticmethod
    def start():
        Logger.info('World server started.')
        with socketserver.TCPServer((config.Server.Connection.WorldServer.host,
                                     config.Server.Connection.WorldServer.port), WorldServer) as world_instance:
            world_instance.allow_reuse_address = True
            world_instance.serve_forever()
