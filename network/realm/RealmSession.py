import socketserver

from utils.ConfigManager import config
from utils.Logger import Logger
from network.packet.PacketWriter import *


class LoginServer(socketserver.BaseRequestHandler):
    def handle(self):
        self.serve_realm(self.request)

    @staticmethod
    def serve_realm(request):
        name_bytes = PacketWriter.string_to_bytes(config.Server.Connection.RealmServer.realm_name)
        address_bytes = PacketWriter.string_to_bytes(('%s:%s' % (config.Server.Connection.RealmProxy.host,
                                                                 config.Server.Connection.RealmProxy.port)))
        packet = pack(
            '>B%us%usL' % (len(name_bytes), len(address_bytes)),
            1,
            name_bytes,
            address_bytes,
            0
        )

        Logger.debug('Sending realmlist to %s...' % request.getpeername()[0])
        request.sendall(packet)
        request.close()

    @staticmethod
    def start():
        Logger.info('Login server started.')
        with socketserver.TCPServer((config.Server.Connection.RealmServer.host,
                                     config.Server.Connection.RealmServer.port), LoginServer) as login_instance:
            login_instance.allow_reuse_address = True
            login_instance.serve_forever()


class ProxyServer(socketserver.BaseRequestHandler):
    def handle(self):
        pass

    @staticmethod
    def start():
        Logger.info('Proxy server started.')
        with socketserver.TCPServer((config.Server.Connection.RealmProxy.host,
                                     config.Server.Connection.RealmProxy.port), ProxyServer) as proxy_instance:
            proxy_instance.allow_reuse_address = True
            proxy_instance.serve_forever()
