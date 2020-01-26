import socketserver
import threading

from struct import pack

from utils.ConfigManager import config
from utils.Logger import Logger
from network.packet.PacketWriter import *


class ThreadedLoginServer(socketserver.ThreadingMixIn, socketserver.TCPServer):
    pass


class LoginServerHandler(socketserver.BaseRequestHandler):
    def handle(self):
        self.serve_realm(self.request)

    @staticmethod
    def serve_realm(socket):
        name_bytes = PacketWriter.string_to_bytes(config.Server.Connection.RealmServer.realm_name)
        address_bytes = PacketWriter.string_to_bytes(('%s:%s' % (config.Server.Connection.RealmProxy.host,
                                                                 config.Server.Connection.RealmProxy.port)))
        packet = pack(
            '!B%us%usL' % (len(name_bytes), len(address_bytes)),
            1,
            name_bytes,
            address_bytes,
            0
        )

        Logger.debug('Sending realmlist to %s...' % socket.getpeername()[0])
        socket.sendall(packet)
        socket.close()

    @staticmethod
    def start():
        Logger.info('Login server started.')
        with ThreadedLoginServer((config.Server.Connection.RealmServer.host,
                                  config.Server.Connection.RealmServer.port), LoginServerHandler) as login_instance:
            login_instance.allow_reuse_address = True
            login_session_thread = threading.Thread(target=login_instance.serve_forever())
            login_session_thread.daemon = True
            login_session_thread.start()


class ThreadedProxyServer(socketserver.ThreadingMixIn, socketserver.TCPServer):
    pass


class ProxyServer(socketserver.BaseRequestHandler):
    def handle(self):
        self.redirect_to_world(self.request)

    @staticmethod
    def redirect_to_world(socket):
        world_bytes = PacketWriter.string_to_bytes(('%s:%s' % (config.Server.Connection.WorldServer.host,
                                                               config.Server.Connection.WorldServer.port)))
        packet = pack(
            '!%us' % len(world_bytes),
            world_bytes
        )

        Logger.debug('Redirecting %s to world server...' % socket.getpeername()[0])
        socket.sendall(packet)
        socket.close()

    @staticmethod
    def start():
        Logger.info('Proxy server started.')
        with ThreadedProxyServer((config.Server.Connection.RealmProxy.host,
                                  config.Server.Connection.RealmProxy.port), ProxyServer) as proxy_instance:
            proxy_instance.allow_reuse_address = True
            proxy_session_thread = threading.Thread(target=proxy_instance.serve_forever())
            proxy_session_thread.daemon = True
            proxy_session_thread.start()
