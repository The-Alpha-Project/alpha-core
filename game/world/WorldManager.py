import socketserver
import threading
import socket

from struct import pack
from time import sleep, time
from apscheduler.schedulers.background import BackgroundScheduler

from game.world.WorldLoader import WorldLoader
from game.world.WorldSessionStateHandler import WorldSessionStateHandler
from game.world.managers.GridManager import GridManager
from game.world.managers.objects.CreatureManager import CreatureManager
from game.world.managers.objects.GameObjectManager import GameObjectManager
from game.world.opcode_handling.Definitions import Definitions
from network.packet.PacketWriter import *
from network.packet.PacketReader import *
from database.realm.RealmDatabaseManager import *
from database.dbc.DbcDatabaseManager import *
from database.world.WorldDatabaseManager import *

from utils.Logger import Logger


STARTUP_TIME = time()
WORLD_ON = True


def get_seconds_since_startup():
    return time() - STARTUP_TIME


class ThreadedWorldServer(socketserver.ThreadingMixIn, socketserver.TCPServer):
    pass


class WorldServerSessionHandler(socketserver.BaseRequestHandler):
    def __init__(self, request, client_address, server):
        super().__init__(request, client_address, server)

        self.account_mgr = None
        self.player_mgr = None
        self.keep_alive = False

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

            while self.receive(self.request) != -1 and self.keep_alive:
                continue

        finally:
            self.disconnect()

    def disconnect(self):
        try:
            if self.player_mgr:
                self.player_mgr.logout()
        except AttributeError:
            pass

        self.keep_alive = False
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
        except AttributeError:
            pass

    def auth_challenge(self, sck):
        data = pack('<6B', 0, 0, 0, 0, 0, 0)
        sck.sendall(PacketWriter.get_packet(OpCode.SMSG_AUTH_CHALLENGE, data))

    def receive(self, sck):
        try:
            data = sck.recv(2048)
            if len(data) > 0:
                reader = PacketReader(data)
                if reader.opcode:
                    handler, res = Definitions.get_handler_from_packet(self, reader.opcode)
                    if handler:
                        Logger.debug('[%s] Handling %s' % (self.client_address[0], OpCode(reader.opcode)))
                        if handler(self, sck, reader) != 0:
                            return -1
                    elif res == -1:
                        Logger.warning('[%s] Received unknown data: %s' % (self.client_address[0], data))
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
                                        max_instances=2)
        player_update_scheduler.start()

        # Creature & Gameobject updates
        active_object_update_scheduler = BackgroundScheduler()
        active_object_update_scheduler._daemon = True
        active_object_update_scheduler.add_job(GridManager.update_active_objects, 'interval', seconds=0.2,
                                               max_instances=8)
        active_object_update_scheduler.start()

    @staticmethod
    def start():
        WorldLoader.load_data()
        Logger.success('World server started.')

        WorldServerSessionHandler.schedule_updates()

        ThreadedWorldServer.allow_reuse_address = True
        ThreadedWorldServer.timeout = 10
        with ThreadedWorldServer((config.Server.Connection.RealmServer.host, config.Server.Connection.WorldServer.port),
                                 WorldServerSessionHandler) as world_instance:
            try:
                world_session_thread = threading.Thread(target=world_instance.serve_forever())
                world_session_thread.daemon = True
                world_session_thread.start()
            except KeyboardInterrupt:
                Logger.info("World server turned off.")
