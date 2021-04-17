import _queue
import socketserver
import threading
import socket

from time import time
from apscheduler.schedulers.background import BackgroundScheduler

from game.world.WorldLoader import WorldLoader
from game.world.WorldSessionStateHandler import WorldSessionStateHandler
from game.world.managers.GridManager import GridManager
from game.world.opcode_handling.Definitions import Definitions
from network.packet.PacketWriter import *
from network.packet.PacketReader import *
from database.realm.RealmDatabaseManager import *
from database.world.WorldDatabaseManager import *

from utils.Logger import Logger


STARTUP_TIME = time()
WORLD_ON = True


def get_seconds_since_startup():
    return time() - STARTUP_TIME


class WorldServerSessionHandler(object):
    def __init__(self, request, client_address):
        self.request = request
        self.client_address = client_address

        self.account_mgr = None
        self.player_mgr = None
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

            self.auth_challenge(self.request)

            realm_saving_scheduler = BackgroundScheduler()
            realm_saving_scheduler._daemon = True
            realm_saving_scheduler.add_job(self.save_character, 'interval',
                                           seconds=config.Server.Settings.realm_saving_interval_seconds)
            realm_saving_scheduler.start()

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

    def send_message(self, data):
        self.outgoing_pending.put_nowait(data)

    def process_outgoing(self):
        while self.keep_alive:
            try:
                data = self.outgoing_pending.get(block=True, timeout=None)
                if data:  # Can be None if we shutdown the thread.
                    self.request.sendall(data)
            except OSError:
                self.disconnect()

    def process_incoming(self):
        while self.keep_alive:
            data = self.incoming_pending.get(block=True, timeout=None)
            if data:  # Can be None if we shutdown the thread.
                reader = PacketReader(data)
                if reader.opcode:
                    handler, res = Definitions.get_handler_from_packet(self, reader.opcode)
                    if handler:
                        Logger.debug(f'[{self.client_address[0]}] Handling {OpCode(reader.opcode).name}')
                        if handler(self, self.request, reader) != 0:
                            self.disconnect()
                            break
                    elif res == -1:
                        Logger.warning(f'[{self.client_address[0]}] Received unknown data: {data}')

    def disconnect(self):
        try:
            if self.player_mgr:
                self.player_mgr.logout()
        except AttributeError:
            pass

        self.keep_alive = False
        self.incoming_pending.empty()
        self.outgoing_pending.empty()
        WorldSessionStateHandler.remove(self)

        try:
            self.request.shutdown(socket.SHUT_RDWR)
            self.request.close()
        except OSError:
            pass

    def save_character(self):
        try:
            self.player_mgr.sync_player()
            RealmDatabaseManager.character_update(self.player_mgr.player)
            RealmDatabaseManager.character_update_social(self.player_mgr.friends_manager.character_social)
        except AttributeError:
            pass

    def auth_challenge(self, sck):
        data = pack('<6B', 0, 0, 0, 0, 0, 0)
        sck.sendall(PacketWriter.get_packet(OpCode.SMSG_AUTH_CHALLENGE, data))

    def receive(self, sck):
        try:
            data = sck.recv(2048)
            if len(data) > 0:
                self.incoming_pending.put(data)
                return 0
            else:
                return -1
        except OSError:
            self.disconnect()
            return -1

    @staticmethod
    def schedule_updates():
        # Player updates
        player_update_scheduler = BackgroundScheduler()
        player_update_scheduler._daemon = True
        player_update_scheduler.add_job(WorldSessionStateHandler.update_players, 'interval', seconds=0.1,
                                        max_instances=1)
        player_update_scheduler.start()

        # Creature updates
        creature_update_scheduler = BackgroundScheduler()
        creature_update_scheduler._daemon = True
        creature_update_scheduler.add_job(GridManager.update_creatures, 'interval', seconds=0.2,
                                          max_instances=1)
        creature_update_scheduler.start()

        # Gameobject updates
        gameobject_update_scheduler = BackgroundScheduler()
        gameobject_update_scheduler._daemon = True
        gameobject_update_scheduler.add_job(GridManager.update_gameobjects, 'interval', seconds=1.0,
                                            max_instances=1)
        gameobject_update_scheduler.start()

    @staticmethod
    def start():
        WorldLoader.load_data()

        server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        server_socket.bind((config.Server.Connection.RealmServer.host, config.Server.Connection.WorldServer.port))
        server_socket.listen()
        server_socket.settimeout(1)
        WorldServerSessionHandler.schedule_updates()

        Logger.success('World server started.')

        while WORLD_ON:  # sck.accept() is a blocking call, we can't exit this loop gracefully.
            try:
                (client_socket, client_address) = server_socket.accept()
                server_handler = WorldServerSessionHandler(client_socket, client_address)
                world_session_thread = threading.Thread(target=server_handler.handle)
                world_session_thread.daemon = True
                world_session_thread.start()
            except socket.timeout:
                continue
            except:
                break