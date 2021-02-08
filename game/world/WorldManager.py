import socketserver
import threading
import socket

from struct import pack
from time import sleep
from apscheduler.schedulers.background import BackgroundScheduler
from multiprocessing import Process, Value, active_children

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

TOTAL_DATA_TO_LOAD = 3


class ThreadedWorldServer(socketserver.ThreadingMixIn, socketserver.TCPServer):
    pass


class WorldServerSessionHandler(socketserver.BaseRequestHandler):
    def __init__(self, request, client_address, server):
        super().__init__(request, client_address, server)

        self.account_mgr = None
        self.player_mgr = None

        self.keep_alive = False
        self.is_alive = False

    def handle(self):
        try:
            self.auth_challenge(self.request)

            self.player_mgr = None
            self.account_mgr = None

            self.keep_alive = True
            self.is_alive = True

            realm_saving_scheduler = BackgroundScheduler()
            realm_saving_scheduler._daemon = True
            realm_saving_scheduler.add_job(self.save_character, 'interval',
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

            self.keep_alive = False
            self.is_alive = False
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
        player_update_scheduler = BackgroundScheduler()
        player_update_scheduler._daemon = True
        player_update_scheduler.add_job(WorldSessionStateHandler.update_players, 'interval', seconds=0.05)
        player_update_scheduler.start()

    @staticmethod
    def _load_data():
        load_counter = Value('i', 0)

        if config.Server.Settings.load_gameobjects:
            gobject_process = Process(target=WorldServerSessionHandler._load_gameobjects, args=(load_counter,))
            gobject_process.start()
        else:
            Logger.info('Skipped game object loading.')
            WorldServerSessionHandler.on_data_loaded(load_counter)

        if config.Server.Settings.load_creatures:
            creature_process = Process(target=WorldServerSessionHandler._load_creatures, args=(load_counter,))
            creature_process.start()
        else:
            Logger.info('Skipped creature loading.')
            WorldServerSessionHandler.on_data_loaded(load_counter)

        spell_process = Process(target=WorldServerSessionHandler._load_spells, args=(load_counter,))
        spell_process.start()

        return load_counter

    @staticmethod
    def _load_gameobjects(load_counter):
        gobject_spawns, session = WorldDatabaseManager.gameobject_get_all_spawns()
        length = len(gobject_spawns)
        Logger.info('Spawning %s gameobjects...' % length)

        for gobject in gobject_spawns:
            if gobject.gameobject:
                gobject_mgr = GameObjectManager(
                    gobject_template=gobject.gameobject,
                    gobject_instance=gobject
                )
                gobject_mgr.load()

        session.close()
        Logger.success('Gameobjects spawned successfully.')
        WorldServerSessionHandler.on_data_loaded(load_counter)

        return length

    @staticmethod
    def _load_creatures(load_counter):
        creature_spawns, session = WorldDatabaseManager.creature_get_all_spawns()
        length = len(creature_spawns)
        Logger.info('Spawning %s creatures...' % length)

        for creature in creature_spawns:
            if creature.creature_template:
                creature_mgr = CreatureManager(
                    creature_template=creature.creature_template,
                    creature_instance=creature
                )
                creature_mgr.load()

        session.close()
        Logger.success('Creatures spawned successfully.')
        WorldServerSessionHandler.on_data_loaded(load_counter)

        return length

    @staticmethod
    def _load_spells(load_counter):
        spells = DbcDatabaseManager.spell_get_all()
        length = len(spells)
        Logger.info('Loading %s spells...' % length)

        for spell in spells:
            DbcDatabaseManager.SpellHolder.load_spell(spell)

        Logger.success('Spells loaded successfully.')
        WorldServerSessionHandler.on_data_loaded(load_counter)

        return length

    @staticmethod
    def on_data_loaded(load_counter):
        with load_counter.get_lock():
            load_counter.value += 1

    @staticmethod
    def start():
        load_counter = WorldServerSessionHandler._load_data()
        # Are we done loading yet?
        while True:
            sleep(0.2)
            if load_counter.value == TOTAL_DATA_TO_LOAD:
                # Terminate / join all remaining child processes
                active_children()
                break
        WorldServerSessionHandler.start_world_server()

    @staticmethod
    def start_world_server():
        Logger.success('World server started.')

        WorldServerSessionHandler.schedule_updates()

        ThreadedWorldServer.allow_reuse_address = True
        ThreadedWorldServer.timeout = 10
        with ThreadedWorldServer((config.Server.Connection.RealmServer.host, config.Server.Connection.WorldServer.port),
                                 WorldServerSessionHandler) as world_instance:
            world_session_thread = threading.Thread(target=world_instance.serve_forever())
            world_session_thread.daemon = True
            world_session_thread.start()
