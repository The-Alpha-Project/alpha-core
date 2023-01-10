import _queue
import socket
import threading
import traceback
from time import time

from apscheduler.schedulers.background import BackgroundScheduler

from database.world.WorldDatabaseManager import *
from game.world.WorldLoader import WorldLoader
from game.world.WorldSessionStateHandler import WorldSessionStateHandler
from game.world.managers.maps.MapManager import MapManager
from game.world.managers.objects.units.player.PlayerManager import PlayerManager
from game.world.opcode_handling.Definitions import Definitions
from network.packet.PacketReader import *
from network.packet.PacketWriter import *
from utils.Logger import Logger
from utils.LogManager import LogManager
from utils.constants.AuthCodes import AuthCode

STARTUP_TIME = time()
WORLD_ON = True

MAX_PACKET_BYTES = 4096


def get_seconds_since_startup():
    return time() - STARTUP_TIME


class WorldServerSessionHandler:
    def __init__(self, request, client_address):
        self.request = request
        self.client_address = client_address

        self.account_mgr = None
        self.player_mgr: Optional[PlayerManager] = None
        self.keep_alive = False

        self.incoming_pending = _queue.SimpleQueue()
        self.outgoing_pending = _queue.SimpleQueue()

    def handle(self):
        try:
            if not WORLD_ON:
                return

            self.player_mgr = None
            self.account_mgr = None
            self.keep_alive = True

            if self.auth_challenge(self.request):
                self.request.settimeout(120)  # 2 minutes timeout should be more than enough.

                incoming_thread = threading.Thread(target=self.process_incoming)
                incoming_thread.daemon = True
                incoming_thread.start()

                outgoing_thread = threading.Thread(target=self.process_outgoing)
                outgoing_thread.daemon = True
                outgoing_thread.start()

                while self.receive(self.request) != -1 and self.keep_alive:
                    continue

        finally:
            self.disconnect()

    def save_character(self):
        WorldSessionStateHandler.save_character(self.player_mgr)

    def enqueue_packets(self, packets):
        [self.outgoing_pending.put_nowait(packet) for packet in packets if self.keep_alive]

    def enqueue_packet(self, data):
        if self.keep_alive:
            self.outgoing_pending.put_nowait(data)

    def process_outgoing(self):
        while self.keep_alive:
            try:
                data = self.outgoing_pending.get(block=True, timeout=None)
                # We've been blocking, by now keep_alive might be false.
                # data can be None if we shutdown the thread.
                if data and self.keep_alive:
                    self.request.sendall(data)
            except OSError:
                self.disconnect()

    # noinspection PyBroadException
    def process_incoming(self):
        try:
            while self.keep_alive:
                reader = self.incoming_pending.get(block=True, timeout=None)
                # We've been blocking, by now keep_alive might be false.
                if reader and self.keep_alive:  # Can be None if we shutdown the thread.
                    if reader.opcode:
                        handler, found = Definitions.get_handler_from_packet(self, reader.opcode)
                        if handler:
                            res = handler(self, self.request, reader)
                            if res == 0:
                                Logger.debug(f'[{self.client_address[0]}] Handling {reader.opcode_str()}')
                            elif res == 1:
                                Logger.debug(f'[{self.client_address[0]}] Ignoring {reader.opcode_str()}')
                            elif res < 0:
                                break
                        elif not found:
                            Logger.warning(f'[{self.client_address[0]}] Received unknown data: {reader.data}')
                else:
                    break
        except:
            # Can be multiple since it includes handlers execution.
            Logger.error(traceback.format_exc())

        # End this session.
        self.disconnect()

    def disconnect(self):
        # Avoid multiple calls.
        if not self.keep_alive:
            return
        self.keep_alive = False

        try:
            if self.player_mgr and self.player_mgr.online:
                self.player_mgr.logout()
        except AttributeError:
            pass

        # Unblock and flush queues.
        self.incoming_pending.put_nowait(None)
        while not self.incoming_pending.empty():
            self.incoming_pending.get(block=False, timeout=None)
        self.outgoing_pending.put_nowait(None)
        while not self.outgoing_pending.empty():
            self.outgoing_pending.get(block=False, timeout=None)

        WorldSessionStateHandler.remove(self)
        try:
            self.request.shutdown(socket.SHUT_RDWR)
            self.request.close()
        except OSError:
            pass

    # We handle auth_challenge before launching queue threads and anything else.
    def auth_challenge(self, sck):
        data = pack('<I', 0)  # Server seed, not used.
        try:
            sck.settimeout(10)  # Set a 10 second timeout.
            sck.sendall(PacketWriter.get_packet(OpCode.SMSG_AUTH_CHALLENGE, data))  # Request challenge
            reader = self.receive_client_message(sck)
            if reader and reader.opcode == OpCode.CMSG_AUTH_SESSION:
                handler, found = Definitions.get_handler_from_packet(self, reader.opcode)
                if handler:
                    res = handler(self, sck, reader)
                    if res == 0:
                        return True
            return False
        except socket.timeout:  # Can't check this inside Auth handler.
            try:
                data = pack('<B', AuthCode.AUTH_SESSION_EXPIRED)
                sck.request.sendall(PacketWriter.get_packet(OpCode.SMSG_AUTH_RESPONSE, data))
            except AttributeError:
                pass
            return False
        except (OSError, ConnectionResetError, ValueError):
            return False

    def receive(self, sck):
        try:
            reader = self.receive_client_message(sck)
            if reader:
                self.incoming_pending.put(reader)
            else:
                return -1
            return 0
        except (socket.timeout, OSError, ConnectionResetError, ValueError):
            self.disconnect()
            return -1

    def receive_client_message(self, sck):
        header_bytes = self.receive_all(sck, 6)  # 6 = header size
        if not header_bytes:
            return None

        reader = PacketReader(header_bytes)
        reader.data = self.receive_all(sck, int(reader.size))
        return reader

    def receive_all(self, sck, expected_size):
        # Prevent wrong size because of malformed packets.
        if expected_size <= 0:
            return b''

        # Try to fill at once.
        received = sck.recv(expected_size)
        if not received:
            return b''

        # We got what we expect, return buffer.
        if received == expected_size:
            return received

        # If we got incomplete data, request missing payload.
        buffer = bytearray(received)
        current_buffer_size = len(buffer)
        while current_buffer_size < expected_size:
            received = sck.recv(expected_size - current_buffer_size)
            if not received:
                return b''
            buffer.extend(received)  # Keep appending to our buffer until we're done.
            current_buffer_size = len(buffer)
            # Avoid handling any packet that's above the maximum packet size.
            if current_buffer_size > MAX_PACKET_BYTES:
                return b''
        return buffer

    @staticmethod
    def schedule_background_tasks():
        # Save characters.
        realm_saving_scheduler = BackgroundScheduler()
        realm_saving_scheduler._daemon = True
        realm_saving_scheduler.add_job(WorldSessionStateHandler.save_characters, 'interval',
                                       seconds=config.Server.Settings.realm_saving_interval_seconds, max_instances=1)
        realm_saving_scheduler.start()

        # Player updates.
        player_update_scheduler = BackgroundScheduler()
        player_update_scheduler._daemon = True
        player_update_scheduler.add_job(WorldSessionStateHandler.update_players, 'interval', seconds=0.1,
                                        max_instances=1)
        player_update_scheduler.start()

        # Player updates.
        player_update_known_object_scheduler = BackgroundScheduler()
        player_update_known_object_scheduler._daemon = True
        player_update_known_object_scheduler.add_job(WorldSessionStateHandler.update_known_players_objects, 'interval',
                                                     seconds=1, max_instances=1)
        player_update_known_object_scheduler.start()

        # Corpses updates.
        corpses_update_scheduler = BackgroundScheduler()
        corpses_update_scheduler._daemon = True
        corpses_update_scheduler.add_job(MapManager.update_corpses, 'interval', seconds=10.0, max_instances=1)
        corpses_update_scheduler.start()

        # MapManager tile loading.
        tile_loading_scheduler = BackgroundScheduler()
        tile_loading_scheduler._daemon = True
        tile_loading_scheduler.add_job(MapManager.initialize_pending_tiles, 'interval', seconds=1.0, max_instances=4)
        tile_loading_scheduler.start()

        # Creature updates.
        creature_update_scheduler = BackgroundScheduler()
        creature_update_scheduler._daemon = True
        creature_update_scheduler.add_job(MapManager.update_creatures, 'interval', seconds=0.2, max_instances=1)
        creature_update_scheduler.start()

        # Gameobject updates.
        gameobject_update_scheduler = BackgroundScheduler()
        gameobject_update_scheduler._daemon = True
        gameobject_update_scheduler.add_job(MapManager.update_gameobjects, 'interval', seconds=1.0, max_instances=1)
        gameobject_update_scheduler.start()

        # Dynamicobject updates.
        dynobject_update_scheduler = BackgroundScheduler()
        dynobject_update_scheduler._daemon = True
        dynobject_update_scheduler.add_job(MapManager.update_dynobjects, 'interval', seconds=1.0, max_instances=1)
        dynobject_update_scheduler.start()

        # Creature and Gameobject spawn updates (mostly to handle respawn logic).
        spawn_update_scheduler = BackgroundScheduler()
        spawn_update_scheduler._daemon = True
        spawn_update_scheduler.add_job(MapManager.update_spawns, 'interval', seconds=1.0, max_instances=1)
        spawn_update_scheduler.start()

        # Cell deactivation.
        cell_unloading_scheduler = BackgroundScheduler()
        cell_unloading_scheduler._daemon = True
        cell_unloading_scheduler.add_job(MapManager.deactivate_cells, 'interval', seconds=120.0, max_instances=1)
        cell_unloading_scheduler.start()

        # Behavior logging.
        logging_thread = threading.Thread(target=LogManager.process_logs)
        logging_thread.daemon = True
        logging_thread.start()

    @staticmethod
    def start():
        WorldLoader.load_data()

        server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        try:
            server_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEPORT, 1)
        # Use SO_REUSEADDR if SO_REUSEPORT doesn't exist.
        except AttributeError:
            server_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        server_socket.bind((config.Server.Connection.WorldServer.host, config.Server.Connection.WorldServer.port))
        server_socket.listen()

        WorldServerSessionHandler.schedule_background_tasks()

        real_binding = server_socket.getsockname()
        Logger.success(f'World server started, listening on {real_binding[0]}:{real_binding[1]}\a')

        while WORLD_ON:  # sck.accept() is a blocking call, we can't exit this loop gracefully.
            # noinspection PyBroadException
            try:
                (client_socket, client_address) = server_socket.accept()
                server_handler = WorldServerSessionHandler(client_socket, client_address)
                world_session_thread = threading.Thread(target=server_handler.handle)
                world_session_thread.daemon = True
                world_session_thread.start()
            except:
                break
