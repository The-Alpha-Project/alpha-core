import os
import socket
import traceback

from game.world.WorldSessionStateHandler import RealmDatabaseManager
from network.packet.PacketWriter import *
from utils.ConfigManager import config
from utils.Logger import Logger
from utils.constants import EnvVars


REALMLIST = {realm.realm_id: realm for realm in RealmDatabaseManager.realm_get_list()}


class RealmManager:
    @staticmethod
    def build_socket(address, port):
        socket_ = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        try:
            socket_.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEPORT, 1)
        # Use SO_REUSEADDR if SO_REUSEPORT doesn't exist.
        except AttributeError:
            socket_.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        socket_.bind((address, port))
        socket_.settimeout(2)
        return socket_

    @staticmethod
    def serve_realmlist(sck):
        realmlist_bytes = pack('<B', len(REALMLIST))

        for realm in REALMLIST.values():
            is_realm_local = config.Server.Connection.Realm.local_realm_id == realm.realm_id

            name_bytes = PacketWriter.string_to_bytes(realm.realm_name)
            # Only check if the forward address needs to be overriden if this realm is hosted on this same machine.
            # Docker on Windows hackfix.
            # https://discord.com/channels/628574828038717470/653374433636909077/840314080073351238
            if is_realm_local:
                forward_address = os.getenv(EnvVars.EnvironmentalVariables.FORWARD_ADDRESS_OVERRIDE,
                                            realm.proxy_address)
            else:
                forward_address = realm.proxy_address

            address_bytes = PacketWriter.string_to_bytes(f'{forward_address}:{realm.proxy_port}')
            online_count = RealmDatabaseManager.realmlist_get_online_player_count(realm.realm_id)

            realmlist_bytes += pack(
                f'<{len(name_bytes)}s{len(address_bytes)}sI',
                name_bytes,
                address_bytes,
                online_count
            )

        Logger.debug(f'[{sck.getpeername()[0]}] Sending realmlist...')
        sck.sendall(realmlist_bytes)

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
    def start_realm(running, realm_server_ready):
        local_realm = REALMLIST[config.Server.Connection.Realm.local_realm_id]
        with RealmManager.build_socket(local_realm.realm_address, local_realm.realm_port) as server_socket:
            server_socket.listen()
            real_binding = server_socket.getsockname()
            # Make sure all characters have online = 0 on realm start.
            RealmDatabaseManager.character_set_all_offline()
            Logger.success(f'Login server started, listening on {real_binding[0]}:{real_binding[1]}')
            realm_server_ready.value = 1

            try:
                while running.value:
                    try:
                        client_socket, client_address = server_socket.accept()
                        RealmManager.serve_realmlist(client_socket)
                        client_socket.shutdown(socket.SHUT_RDWR)
                        client_socket.close()
                    except socket.timeout:
                        pass  # Non blocking.
            except OSError:
                Logger.warning(traceback.format_exc())
            except KeyboardInterrupt:
                pass

        Logger.info("Login server turned off.")

    @staticmethod
    def start_proxy(running, proxy_server_ready):
        local_realm = REALMLIST[config.Server.Connection.Realm.local_realm_id]
        with RealmManager.build_socket(local_realm.proxy_address, local_realm.proxy_port) as server_socket:
            server_socket.listen()
            real_binding = server_socket.getsockname()
            Logger.success(f'Proxy server started, listening on {real_binding[0]}:{real_binding[1]}')
            proxy_server_ready.value = 1

            try:
                while running.value:
                    try:
                        client_socket, client_address = server_socket.accept()
                        RealmManager.redirect_to_world(client_socket)
                        client_socket.shutdown(socket.SHUT_RDWR)
                        client_socket.close()
                    except socket.timeout:
                        pass  # Non blocking.
            except OSError:
                Logger.warning(traceback.format_exc())
            except KeyboardInterrupt:
                pass

        Logger.info("Proxy server turned off.")
