import os
import socket
import socketserver
import threading

from game.world.WorldSessionStateHandler import RealmDatabaseManager
from network.packet.PacketWriter import *
from utils.ConfigManager import config
from utils.Logger import Logger
from utils.constants import EnvVars

realm_info = RealmDatabaseManager.realm_get_info()

class ThreadedLoginServer(socketserver.ThreadingMixIn, socketserver.TCPServer):
    pass


class LoginServerSessionHandler(socketserver.BaseRequestHandler):
    def handle(self):
        try:
            self.serve_realm(self.request)
        except OSError:
            pass
        finally:
            try:
                self.request.shutdown(socket.SHUT_RDWR)
                self.request.close()
            except OSError:
                pass

    @staticmethod
    def serve_realm(sck):
        name_bytes = PacketWriter.string_to_bytes(realm_info.realm_name)
        forward_address = os.getenv(EnvVars.EnvironmentalVariables.FORWARD_ADDRESS_OVERRIDE,
                                    realm_info.proxy_address)
        address_bytes = PacketWriter.string_to_bytes(f'{forward_address}:{realm_info.proxy_port}')

        # TODO: Update RealmDatabaseManager.realm_get_* to handle multiple realms?
        packet = pack(
            f'<B{len(name_bytes)}s{len(address_bytes)}sI',
            1,  # Number of realms
            name_bytes,
            address_bytes,
            RealmDatabaseManager.character_get_online_count()
        )

        Logger.debug(f'[{sck.getpeername()[0]}] Sending realmlist...')
        sck.sendall(packet)

    @staticmethod
    def start():
        ThreadedLoginServer.allow_reuse_address = True
        with ThreadedLoginServer((realm_info.realm_address,
                                  realm_info.realm_port), LoginServerSessionHandler) \
                as login_instance:
            Logger.success(f'Login server started, listening on {login_instance.server_address[0]}:{login_instance.server_address[1]}')
            # Make sure all characters have online = 0 on realm start.
            RealmDatabaseManager.character_set_all_offline()
            try:
                login_session_thread = threading.Thread(target=login_instance.serve_forever())
                login_session_thread.daemon = True
                login_session_thread.start()
            except KeyboardInterrupt:
                Logger.info("Login server turned off.")


class ThreadedProxyServer(socketserver.ThreadingMixIn, socketserver.TCPServer):
    pass


class ProxyServerSessionHandler(socketserver.BaseRequestHandler):
    def handle(self):
        try:
            self.redirect_to_world(self.request)
        except OSError:
            return
        finally:
            try:
                self.request.shutdown(socket.SHUT_RDWR)
                self.request.close()
            except OSError:
                return

    @staticmethod
    def redirect_to_world(sck):
        forward_address = os.getenv(EnvVars.EnvironmentalVariables.FORWARD_ADDRESS_OVERRIDE,
                                    config.Server.Connection.WorldServer.host)
        world_bytes = PacketWriter.string_to_bytes(f'{forward_address}:{config.Server.Connection.WorldServer.port}')
        packet = pack(
            f'<{len(world_bytes)}s',
            world_bytes
        )

        Logger.debug(f'[{sck.getpeername()[0]}] Redirecting to world server...')
        sck.sendall(packet)

    @staticmethod
    def start():
        ThreadedProxyServer.allow_reuse_address = True
        with ThreadedProxyServer((realm_info.proxy_address,
                                  realm_info.proxy_port), ProxyServerSessionHandler) \
                as proxy_instance:
            Logger.success(f'Proxy server started, listening on {proxy_instance.server_address[0]}:{proxy_instance.server_address[1]}')
            try:
                proxy_session_thread = threading.Thread(target=proxy_instance.serve_forever())
                proxy_session_thread.daemon = True
                proxy_session_thread.start()
            except KeyboardInterrupt:
                Logger.info("Proxy server turned off.")

