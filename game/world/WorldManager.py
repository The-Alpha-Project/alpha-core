import socketserver
import threading
import socket

from struct import pack
from time import sleep
from apscheduler.schedulers.background import BackgroundScheduler
from uuid import uuid1

from game.world.WorldSessionStateHandler import WorldSessionStateHandler
from game.world.managers.GridManager import GridManager
from game.world.opcode_handling.Definitions import Definitions
from network.packet.PacketWriter import *
from network.packet.PacketReader import *
from database.realm.RealmDatabaseManager import *
from database.dbc.DbcDatabaseManager import *
from database.world.WorldDatabaseManager import *

from utils.Logger import Logger


class ThreadedWorldServer(socketserver.ThreadingMixIn, socketserver.TCPServer):
    pass


class WorldServerSessionHandler(socketserver.BaseRequestHandler):
    def __init__(self, request, client_address, server, account_mgr=None, player_mgr=None):
        super().__init__(request, client_address, server)

        self.account_mgr = account_mgr
        self.player_mgr = player_mgr

        self.realm_db_session = None
        self.world_db_session = None
        self.dbc_db_session = None

        self.keep_alive = False
        self.is_alive = False

    def handle(self):
        try:
            self.auth_challenge(self.request)

            self.keep_alive = True
            self.is_alive = True

            self.realm_db_session = RealmDatabaseManager.acquire_session()
            self.world_db_session = WorldDatabaseManager.acquire_session()
            self.dbc_db_session = DbcDatabaseManager.acquire_session()

            realm_saving_scheduler = BackgroundScheduler()
            realm_saving_scheduler._daemon = True
            realm_saving_scheduler.add_job(self.save_realm, 'interval',
                                           seconds=config.Server.Settings.realm_saving_interval_seconds)
            realm_saving_scheduler.start()

            while self.receive(self.request) != -1 and self.keep_alive:
                sleep(0.001)

        finally:
            self.disconnect()

    def disconnect(self):
        if self.is_alive:
            try:
                if self.player_mgr:
                    self.player_mgr.logout()
            except AttributeError:
                pass

            try:
                if self.realm_db_session:
                    RealmDatabaseManager.close(self.realm_db_session)
                if self.world_db_session:
                    WorldDatabaseManager.close(self.world_db_session)
                if self.dbc_db_session:
                    DbcDatabaseManager.close(self.dbc_db_session)
            except AttributeError:
                pass

            self.keep_alive = False
            self.is_alive = False
            WorldSessionStateHandler.remove(self)

            try:
                self.request.shutdown(socket.SHUT_RDWR)
                self.request.close()
            except OSError:
                pass

    def save_realm(self):
        try:
            if self.realm_db_session:
                RealmDatabaseManager.save(self.realm_db_session)
        except AttributeError:
            pass

    def auth_challenge(self, sck):
        data = pack('<6B', 0, 0, 0, 0, 0, 0)
        sck.sendall(PacketWriter.get_packet(OpCode.SMSG_AUTH_CHALLENGE, data))

    def receive(self, sck):
        try:
            data = sck.recv(2048)
            reader = PacketReader(data)
            if reader.opcode:
                handler = Definitions.get_handler_from_packet(self, reader.opcode)
                if handler:
                    Logger.debug('[%s] Handling %s' % (self.client_address[0], OpCode(reader.opcode)))
                    if handler(self, sck, reader) != 0:
                        return -1
        except OSError:
            Logger.error('[%s] Tried to interact with a closed socket.' % self.client_address[0])
            self.disconnect()
            return -1

    @staticmethod
    def start():
        Logger.success('World server started.')

        ThreadedWorldServer.allow_reuse_address = True
        with ThreadedWorldServer((config.Server.Connection.RealmServer.host, config.Server.Connection.WorldServer.port),
                                 WorldServerSessionHandler) as world_instance:
            world_session_thread = threading.Thread(target=world_instance.serve_forever())
            world_session_thread.daemon = True
            world_session_thread.start()
