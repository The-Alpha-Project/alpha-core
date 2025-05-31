import os
import socket
import traceback
import ipaddress

from game.world.WorldSessionStateHandler import RealmDatabaseManager
from network.packet.PacketWriter import *
from network.sockets.SocketBuilder import SocketBuilder
from utils.ConfigManager import config
from utils.Logger import Logger
from utils.constants import EnvVars

def is_private_ip(ip):
    try:
        return ipaddress.ip_address(ip).is_private
    except ValueError:
        return False

REALMLIST = {realm.realm_id: realm for realm in RealmDatabaseManager.realm_get_list()}


class RealmManager:


    @staticmethod
    def serve_realmlist(sck):
        client_ip = sck.getpeername()[0]
        realmlist_bytes = pack('<B', len(REALMLIST))

        for realm in REALMLIST.values():
            is_realm_local = config.Server.Connection.Realm.local_realm_id == realm.realm_id

            name_bytes = PacketWriter.string_to_bytes(realm.realm_name)

            if is_private_ip(client_ip):
                forward_address = realm.proxy_address
                Logger.debug(f'[{sck.getpeername()[0]}] Connection from {client_ip} -> Private')
            else:
                forward_address = realm.public_proxy_address
                Logger.debug(f'[{sck.getpeername()[0]}] Connection from {client_ip} -> Public')


            address_bytes = PacketWriter.string_to_bytes(f'{forward_address}:{realm.proxy_port}')
            online_count = RealmDatabaseManager.realmlist_get_online_player_count(realm.realm_id)

            realmlist_bytes += pack(
                f'<{len(name_bytes)}s{len(address_bytes)}sI',
                name_bytes,
                address_bytes,
                online_count
            )

        Logger.debug(f'[{sck.getpeername()[0]}] Sending realmlist... (sent {forward_address}:{realm.proxy_port})')
        sck.sendall(realmlist_bytes)

    @staticmethod
    def redirect_to_world(sck):
        client_ip = sck.getpeername()[0]
        local_realm = REALMLIST[config.Server.Connection.Realm.local_realm_id]

        if is_private_ip(client_ip):
            forward_address = local_realm.realm_address
        else:
            forward_address = local_realm.public_realm_address


        world_bytes = PacketWriter.string_to_bytes(f'{forward_address}:{config.Server.Connection.WorldServer.port}')
        packet = pack(
            f'<{len(world_bytes)}s',
            world_bytes
        )

        Logger.debug(f'[{client_ip}] Redirecting to world server... (sent {forward_address}:{config.Server.Connection.WorldServer.port})')
        sck.sendall(packet)

    @staticmethod
    def start_realm(running, realm_server_ready):
        local_realm = REALMLIST[config.Server.Connection.Realm.local_realm_id]
        with SocketBuilder.build_socket('0.0.0.0', local_realm.realm_port, timeout=2) as server_socket:
            server_socket.listen()
            real_binding = server_socket.getsockname()
            # Make sure all characters have online = 0 on realm start.
            RealmDatabaseManager.character_set_all_offline()
            Logger.success(f'Realm server started, listening on {real_binding[0]}:{real_binding[1]}')
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

        Logger.info("Realm server turned off.")

    @staticmethod
    def start_proxy(running, proxy_server_ready):
        local_realm = REALMLIST[config.Server.Connection.Realm.local_realm_id]
        with SocketBuilder.build_socket('0.0.0.0', local_realm.proxy_port, timeout=2) as server_socket:
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
