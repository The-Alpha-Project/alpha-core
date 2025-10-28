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
from utils.ChatLogManager import ChatLogManager
from utils.constants.AuthCodes import AuthCode

STARTUP_TIME = time()
WORLD_ON = True
SERVER_SEED = os.urandom(4)
MAX_PACKET_BYTES = 4096


def get_seconds_since_startup():
    return time() - STARTUP_TIME


class WorldServerSessionHandler:
    def __init__(self, client_socket, client_address):
        self.client_socket = client_socket
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
    def start_chat_logger():
        # Chat logging queue.
        if config.Server.Logging.log_player_chat:
            logging_thread = threading.Thread(target=ChatLogManager.process_logs)
            logging_thread.daemon = True
            logging_thread.start()

    @staticmethod
    def build_get_schedulers():
        return [
            WorldServerSessionHandler.build_scheduler('Realm Saving', WorldSessionStateHandler.save_characters,
                                                      config.Server.Settings.realm_saving_interval_seconds, 1),
            WorldServerSessionHandler.build_scheduler('Player', WorldSessionStateHandler.update_players, 0.1, 1),
            WorldServerSessionHandler.build_scheduler('Creature', MapManager.update_creatures, 0.2, 1),
            WorldServerSessionHandler.build_scheduler('Gameobject', MapManager.update_gameobjects, 1.0, 1),
            WorldServerSessionHandler.build_scheduler('Transport', MapManager.update_transports, 0.1, 1),
            WorldServerSessionHandler.build_scheduler('DynObject', MapManager.update_dynobjects, 1.0, 1),
            WorldServerSessionHandler.build_scheduler('Spawn', MapManager.update_spawns, 1.0, 1),
            WorldServerSessionHandler.build_scheduler('Corpse', MapManager.update_corpses, 10.0, 1),
            WorldServerSessionHandler.build_scheduler('Script/Event', MapManager.update_map_scripts_and_events, 1.0, 1),
            WorldServerSessionHandler.build_scheduler('Detection', MapManager.update_detection_range_collision, 1.0, 1),
            WorldServerSessionHandler.build_scheduler('Tile Loading', MapManager.initialize_pending_tiles, 0.2, 4),
            WorldServerSessionHandler.build_scheduler('Tile Unloading', MapManager.deactivate_cells, 300.0, 1)]

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
    def start_world(running, world_server_ready):
        WorldLoader.load_data()

        # Start background tasks.
        schedulers = WorldServerSessionHandler.build_get_schedulers()
        WorldServerSessionHandler.start_schedulers(schedulers)

        # Chat logger.
        WorldServerSessionHandler.start_chat_logger()

        # Set ready.
        world_server_ready.value = 1

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
                while WORLD_ON and running.value:
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
        WorldServerSessionHandler.stop_schedulers(schedulers)
