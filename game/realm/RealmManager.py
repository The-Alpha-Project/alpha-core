import os
import socket
import socketserver
import threading

from game.world.WorldSessionStateHandler import RealmDatabaseManager
from network.packet.PacketWriter import *
from utils.ConfigManager import config
from utils.Logger import Logger
from utils.constants import EnvVars


REALMLIST = {realm.realm_id: realm for realm in RealmDatabaseManager.realm_get_list()}


class ThreadedLoginServer(socketserver.ThreadingMixIn, socketserver.TCPServer):
    pass


class LoginServerSessionHandler(socketserver.BaseRequestHandler):
    def handle(self):
        try:
            self.serve_realmlist(self.request)
        except OSError:
            pass
        finally:
            try:
                self.request.shutdown(socket.SHUT_RDWR)
                self.request.close()
            except OSError:
                pass

    @staticmethod
    def serve_realmlist(sck):
        realmlist_bytes = pack('<B', len(REALMLIST))

        for realm in REALMLIST.values():
            is_realm_local = config.Server.Connection.Realm.local_realm_id == realm.realm_id

            forward_hostname = None
            name_bytes = PacketWriter.string_to_bytes(realm.realm_name)
            # Only check if the forward address needs to be overriden if this realm is hosted on this same machine.
            # Docker on Windows hackfix.
            # https://discord.com/channels/628574828038717470/653374433636909077/840314080073351238
            if is_realm_local:
                forward_address = os.getenv(EnvVars.EnvironmentalVariables.FORWARD_ADDRESS_OVERRIDE,
                                            realm.proxy_address)
                forward_hostname = os.getenv(EnvVars.EnvironmentalVariables.FORWARD_HOSTNAME_OVERRIDE, None)
            else:
                forward_address = realm.proxy_address

            # If we have a forward hostname, resolve the ip address.
            if forward_hostname:
                try:
                    forward_address = socket.gethostbyname(forward_hostname)
                except socket.gaierror as e:
                    Logger.error(f'Invalid forward hostname, error: {e}')

            address_bytes = PacketWriter.string_to_bytes(f'{forward_address}:{realm.proxy_port}')
            # TODO: Find a way to get online count of realms not connected to the same database server?
            online_count = RealmDatabaseManager.character_get_online_count(realm.realm_id)

            realmlist_bytes += pack(
                f'<{len(name_bytes)}s{len(address_bytes)}sI',
                name_bytes,
                address_bytes,
                online_count
            )

        Logger.debug(f'[{sck.getpeername()[0]}] Sending realmlist...')
        sck.sendall(realmlist_bytes)

    @staticmethod
    def start():
        ThreadedLoginServer.allow_reuse_address = True

        local_realm = REALMLIST[config.Server.Connection.Realm.local_realm_id]
        with ThreadedLoginServer((local_realm.realm_address,
                                  local_realm.realm_port), LoginServerSessionHandler) \
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

        forward_hostname = os.getenv(EnvVars.EnvironmentalVariables.FORWARD_HOSTNAME_OVERRIDE, None)
        # If we have a forward hostname, resolve the ip address.
        if forward_hostname:
            try:
                forward_address = socket.gethostbyname(forward_hostname)
            except socket.gaierror as e:
                Logger.error(f'Invalid forward hostname, error: {e}')

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

        local_realm = REALMLIST[config.Server.Connection.Realm.local_realm_id]
        with ThreadedProxyServer((local_realm.proxy_address,
                                  local_realm.proxy_port), ProxyServerSessionHandler) \
                as proxy_instance:
            Logger.success(f'Proxy server started, listening on {proxy_instance.server_address[0]}:{proxy_instance.server_address[1]}')
            try:
                proxy_session_thread = threading.Thread(target=proxy_instance.serve_forever())
                proxy_session_thread.daemon = True
                proxy_session_thread.start()
            except KeyboardInterrupt:
                Logger.info("Proxy server turned off.")
