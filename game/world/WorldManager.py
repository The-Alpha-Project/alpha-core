import _queue
import signal
import socket
import threading
import traceback
from time import time
from typing import Any

from apscheduler.schedulers.background import BackgroundScheduler

from game.world.WorldServerTicker import WorldServerTicker
from database.world.WorldDatabaseManager import *
from game.world.WorldLoader import WorldLoader
from game.world.WorldSessionStateHandler import WorldSessionStateHandler
from game.world.managers.maps.MapManager import MapManager
from game.world.managers.objects.units.player.PlayerManager import PlayerManager
from game.world.opcode_handling.Definitions import Definitions
from network.packet.PacketReader import *
from network.packet.PacketWriter import *
from utils.Logger import Logger
from utils.ChatLogManager import ChatLogManager
from utils.constants.AuthCodes import AuthCode

STARTUP_TIME = time()
WORLD_ON = True
SERVER_SEED = os.urandom(4)
MAX_PACKET_BYTES = 4096
BUFFER_SIZE = 65536


def get_seconds_since_startup():
    return time() - STARTUP_TIME


class WorldServerSessionHandler:
    def __init__(self, client_socket, client_address):
        self.client_socket = client_socket
        self.client_address = client_address

        # Optimize socket for low latency and throughput.
        self.client_socket.setsockopt(socket.IPPROTO_TCP, socket.TCP_NODELAY, 1)
        self.client_socket.setsockopt(socket.SOL_SOCKET, socket.SO_SNDBUF, BUFFER_SIZE)
        self.client_socket.setsockopt(socket.SOL_SOCKET, socket.SO_RCVBUF, BUFFER_SIZE)

        self.account_mgr = None
        self.player_mgr: Optional[PlayerManager] = None
        self.keep_alive = False

        self.incoming_pending = _queue.SimpleQueue()
        self.outgoing_pending = _queue.SimpleQueue()

        self._receive_buffer = bytearray(MAX_PACKET_BYTES)
        self._receive_view = memoryview(self._receive_buffer)

    def handle(self):
        try:
            if not WORLD_ON:
                return

            self.player_mgr = None
            self.account_mgr = None
            self.keep_alive = True

            if self.auth_challenge(self.client_socket):
                self.client_socket.settimeout(120)  # 2 minutes timeout should be more than enough.

                incoming_thread = threading.Thread(target=self.process_incoming)
                incoming_thread.daemon = True
                incoming_thread.start()

                outgoing_thread = threading.Thread(target=self.process_outgoing)
                outgoing_thread.daemon = True
                outgoing_thread.start()

                while self.receive(self.client_socket) != -1 and self.keep_alive:
                    continue

        finally:
            self.disconnect()

    @staticmethod
    def save_characters():
        WorldSessionStateHandler.save_characters()

    @staticmethod
    def disconnect_sessions():
        for session in WorldSessionStateHandler.get_world_sessions():
            if session.player_mgr and session.player_mgr.online:
                session.player_mgr.logout()
            session.disconnect()

    def save_character(self):
        WorldSessionStateHandler.save_character(self.player_mgr)

    def enqueue_packets(self, packets):
        [self.outgoing_pending.put_nowait(packet) for packet in packets if self.keep_alive]

    def enqueue_packet(self, data):
        if self.keep_alive:
            self.outgoing_pending.put_nowait(data)

    def process_outgoing(self):
        try:
            while self.keep_alive:
                packet = self.outgoing_pending.get(block=True, timeout=None)
                # We've been blocking, by now keep_alive might be false.
                # data can be None if we shut down the thread.
                if packet and self.keep_alive:
                    self.client_socket.sendall(packet)
        except OSError:
            self.disconnect()
        finally:
            # Flush outgoing packets from the queue, if any.
            while not self.outgoing_pending.empty():
                self.outgoing_pending.get_nowait()

    # noinspection PyBroadException
    def process_incoming(self):
        try:
            while self.keep_alive:
                packet = self.incoming_pending.get(block=True, timeout=None)
                # We've been blocking, by now keep_alive might be false.
                if not packet or not self.keep_alive:  # Can be None if we shut down the thread.
                    break
                if not packet.opcode:
                    continue
                handler, found = Definitions.get_handler_from_packet(self, packet.opcode)
                if handler:
                    res = handler(self, packet)
                    if res == 0:
                        Logger.debug(f'[{self.client_address[0]}] Handling {packet.opcode_str()}')
                    elif res == 1:
                        Logger.debug(f'[{self.client_address[0]}] Ignoring {packet.opcode_str()}')
                    elif res < 0:
                        break
                elif not found:
                    Logger.warning(f'[{self.client_address[0]}] Received unknown data: {packet.data}')
        except:
            # Can be multiple since it includes handlers execution.
            Logger.error(traceback.format_exc())
        finally:
            # Flush incoming packets from the queue, if any.
            while not self.incoming_pending.empty():
                self.incoming_pending.get_nowait()

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

        # Add signals to stop queues from handling packets.
        self.incoming_pending.put_nowait(None)
        self.outgoing_pending.put_nowait(None)

        WorldSessionStateHandler.remove(self)
        try:
            self.client_socket.shutdown(socket.SHUT_RDWR)
            self.client_socket.close()
        except OSError:
            pass

    # We handle auth_challenge before launching queue threads and anything else.
    def auth_challenge(self, sck):
        try:
            sck.settimeout(10)  # Set a 10-second timeout.
            sck.sendall(PacketWriter.get_packet(OpCode.SMSG_AUTH_CHALLENGE, SERVER_SEED))  # Request challenge
            reader = self.receive_client_message(sck)
            if reader and reader.opcode == OpCode.CMSG_AUTH_SESSION:
                handler, found = Definitions.get_handler_from_packet(self, reader.opcode)
                return handler(self, reader) == 0
            return False
        except socket.timeout:  # Can't check this inside Auth handler.
            try:
                data = pack('<B', AuthCode.AUTH_SESSION_EXPIRED)
                sck.client_socket.sendall(PacketWriter.get_packet(OpCode.SMSG_AUTH_RESPONSE, data))
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
        if expected_size <= 0:
            return b''

        # Re-allocate if the requested size is larger than the pre-allocated buffer.
        if expected_size > len(self._receive_buffer):
            self._receive_buffer = bytearray(expected_size)
            self._receive_view = memoryview(self._receive_buffer)

        view = self._receive_view
        bytes_received = 0

        try:
            while bytes_received < expected_size:
                received = sck.recv_into(view[bytes_received:expected_size], expected_size - bytes_received)
                if not received:
                    return b''
                bytes_received += received

            return self._receive_buffer[:expected_size]
        except OSError:
            return b''

    @staticmethod
    def start_chat_logger():
        # Chat logging queue.
        if config.Server.Logging.log_player_chat:
            logging_thread = threading.Thread(target=ChatLogManager.process_logs)
            logging_thread.daemon = True
            logging_thread.start()

    @staticmethod
    def build_get_ticker():
        ticker = WorldServerTicker()
        ticker.add_task('Realm Saving', WorldSessionStateHandler.save_characters,
                        config.Server.Settings.realm_saving_interval_seconds)
        ticker.add_task('Player', WorldSessionStateHandler.update_players, 0.1)
        ticker.add_task('Creature', MapManager.update_creatures, 0.2)
        ticker.add_task('Gameobject', MapManager.update_gameobjects, 1.0)
        ticker.add_task('Transport', MapManager.update_transports, 0.1)
        ticker.add_task('DynObject', MapManager.update_dynobjects, 1.0)
        ticker.add_task('Spawn', MapManager.update_spawns, 1.0)
        ticker.add_task('Corpse', MapManager.update_corpses, 10.0)
        ticker.add_task('Script/Event', MapManager.update_map_scripts_and_events, 1.0)
        ticker.add_task('Detection', MapManager.update_detection_range_collision, 1.0)
        ticker.add_task('Tile Unloading', MapManager.deactivate_cells, 300.0)
        return ticker

    @staticmethod
    def build_get_schedulers():
        # Heavier tasks that benefit from multiple instances or being separate from the main world tick.
        return [
            WorldServerSessionHandler.build_scheduler('Tile Loading', MapManager.initialize_pending_tiles, 0.2, 4)]

    @staticmethod
    def build_scheduler(name, target, seconds, instances, daemon=True):
        scheduler = BackgroundScheduler()
        scheduler.daemon = daemon
        scheduler.add_job(target, 'interval', seconds=seconds, max_instances=instances)
        return scheduler

    @staticmethod
    def start_schedulers(schedulers):
        length = len(schedulers)
        count = 0

        for scheduler in schedulers:
            scheduler.start()
            count += 1
            Logger.progress('Loading background schedulers...', count, length)

    @staticmethod
    def stop_schedulers(schedulers):
        for scheduler in schedulers:
            scheduler.shutdown()
        Logger.info('Background schedulers stopped.')

    @staticmethod
    def start_world(shared_state: Any):
        signal.signal(signal.SIGINT, lambda signum, frame: setattr(shared_state, 'RUNNING', False))
        if not WorldLoader.load_data(shared_state=shared_state):
            Logger.info("World server turned off.")
            return

        # Start background tasks.
        schedulers = WorldServerSessionHandler.build_get_schedulers()
        WorldServerSessionHandler.start_schedulers(schedulers)

        # Start world ticker.
        ticker = WorldServerSessionHandler.build_get_ticker()
        ticker.start_tasks()
        ticker_thread = threading.Thread(target=ticker.run, args=(shared_state,))
        ticker_thread.daemon = True
        ticker_thread.start()

        # Chat logger.
        WorldServerSessionHandler.start_chat_logger()

        # Set ready.
        shared_state.WORLD_SERVER_READY = True

        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as server_socket:
            try:
                server_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEPORT, 1)
            # Use SO_REUSEADDR if SO_REUSEPORT doesn't exist.
            except AttributeError:
                server_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
            server_socket.bind((config.Server.Connection.WorldServer.host, config.Server.Connection.WorldServer.port))
            server_socket.listen()
            server_socket.settimeout(2)

            real_binding = server_socket.getsockname()
            Logger.success(f'World server started, listening on {real_binding[0]}:{real_binding[1]}')

            try:
                while WORLD_ON and shared_state.RUNNING:
                    try:
                        client_socket, client_address = server_socket.accept()
                        server_handler = WorldServerSessionHandler(client_socket, client_address)
                        world_session_thread = threading.Thread(target=server_handler.handle)
                        world_session_thread.daemon = True
                        world_session_thread.start()
                    except socket.timeout:
                        pass  # Non blocking.
            except OSError:
                Logger.warning(traceback.format_exc())
            except KeyboardInterrupt:
                pass

        Logger.info("World server turned off.")
        ChatLogManager.exit()
        # Since only this process is able to see current world sessions, save characters and disconnect all sessions.
        WorldServerSessionHandler.save_characters()
        WorldServerSessionHandler.disconnect_sessions()
        WorldServerSessionHandler.stop_schedulers(schedulers)
        ticker.stop()
