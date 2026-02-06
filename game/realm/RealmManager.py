import os
import socket
import traceback
from typing import Any

from database.auth.AuthDatabaseManager import AuthDatabaseManager
from game.world.WorldSessionStateHandler import RealmDatabaseManager
from network.packet.PacketWriter import *
from network.sockets.SocketBuilder import SocketBuilder
from utils.ConfigManager import config
from utils.Logger import Logger
from utils.constants import EnvVars


REALMLIST = {realm.realm_id: realm for realm in AuthDatabaseManager.realm_get_list()}


class RealmManager:

    @staticmethod
    def serve_realmlist(sck):
        realmlist_bytes = pack('<B', len(REALMLIST))

        for realm in REALMLIST.values():
            is_realm_local = config.Server.Connection.Realm.local_realm_id == realm.realm_id

            name_bytes = PacketWriter.string_to_bytes(realm.realm_name)
            # Only check if the forward address needs to be overridden if this realm is hosted on this same machine.
            # Docker on Windows hackfix.
            # https://discord.com/channels/628574828038717470/653374433636909077/840314080073351238
            if is_realm_local:
                forward_address = os.getenv(EnvVars.EnvironmentalVariables.FORWARD_ADDRESS_OVERRIDE,
                                            realm.proxy_address)
            else:
                forward_address = realm.proxy_address

            address_bytes = PacketWriter.string_to_bytes(f'{forward_address}:{realm.proxy_port}')
            online_count = AuthDatabaseManager.realm_get_online_player_count(realm.realm_id)

            realmlist_bytes += pack(
                f'<{len(name_bytes)}s{len(address_bytes)}sI',
                name_bytes,
                address_bytes,
                online_count
            )

        Logger.debug(f'[RealmServer] {sck.getpeername()[0]} Sending realmlist')
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

        Logger.debug(f'[ProxyServer] {sck.getpeername()[0]} Redirecting to world server')
        sck.sendall(packet)

    @staticmethod
    def start_realm(shared_state: Any):
        local_realm = REALMLIST[config.Server.Connection.Realm.local_realm_id]
        with SocketBuilder.build_socket(local_realm.realm_address, local_realm.realm_port, timeout=2) as server_socket:
            server_socket.listen()
            real_binding = server_socket.getsockname()
            # Make sure all characters have online = 0 on realm start.
            RealmDatabaseManager.character_set_all_offline()
            AuthDatabaseManager.realm_clear_online_count()
            Logger.success(f'[RealmServer] Started, listening on {real_binding[0]}:{real_binding[1]}')
            shared_state.REALM_SERVER_READY = True

            try:
                while shared_state.RUNNING:
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

        Logger.info('[RealmServer] Turned off.')

    @staticmethod
    def start_proxy(shared_state: Any):
        local_realm = REALMLIST[config.Server.Connection.Realm.local_realm_id]
        with SocketBuilder.build_socket(local_realm.proxy_address, local_realm.proxy_port, timeout=2) as server_socket:
            server_socket.listen()
            real_binding = server_socket.getsockname()
            Logger.success(f'[ProxyServer] Started, listening on {real_binding[0]}:{real_binding[1]}')
            shared_state.PROXY_SERVER_READY = True

            try:
                while shared_state.RUNNING:
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

        Logger.info('[ProxyServer] Turned off.')
