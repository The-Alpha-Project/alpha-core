import socketserver
import threading
import socket

from struct import pack
from time import sleep
from apscheduler.schedulers.background import BackgroundScheduler

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
                continue

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
        player_update_scheduler.add_job(WorldSessionStateHandler.update_players, 'interval', seconds=0.1)
        player_update_scheduler.start()

    @staticmethod
    def _load_data():
        # TODO: Use threads to load the data more efficiently
        if config.Server.Settings.load_gameobjects:
            WorldServerSessionHandler._load_gameobjects()
        else:
            Logger.info('Skipped game object loading.')

        if config.Server.Settings.load_creatures:
            WorldServerSessionHandler._load_creatures()
        else:
            Logger.info('Skipped creature loading.')

        WorldServerSessionHandler._load_spells()
        WorldServerSessionHandler._load_skills()
        WorldServerSessionHandler._load_skill_line_abilities()
        WorldServerSessionHandler._load_taxi_nodes()

    @staticmethod
    def _load_gameobjects():
        gobject_spawns, session = WorldDatabaseManager.gameobject_get_all_spawns()
        length = len(gobject_spawns)
        count = 0

        for gobject in gobject_spawns:
            if gobject.gameobject:
                gobject_mgr = GameObjectManager(
                    gobject_template=gobject.gameobject,
                    gobject_instance=gobject
                )
                gobject_mgr.load()
            count += 1
            Logger.progress('Spawning gameobjects...', count, length)

        session.close()
        return length

    @staticmethod
    def _load_creatures():
        creature_spawns, session = WorldDatabaseManager.creature_get_all_spawns()
        length = len(creature_spawns)
        count = 0

        for creature in creature_spawns:
            if creature.creature_template:
                creature_mgr = CreatureManager(
                    creature_template=creature.creature_template,
                    creature_instance=creature
                )
                creature_mgr.load()
            count += 1
            Logger.progress('Spawning creatures...', count, length)

        session.close()
        return length

    @staticmethod
    def _load_spells():
        spells = DbcDatabaseManager.spell_get_all()
        length = len(spells)
        count = 0

        for spell in spells:
            DbcDatabaseManager.SpellHolder.load_spell(spell)

            count += 1
            Logger.progress('Loading spells...', count, length)

    @staticmethod
    def _load_skills():
        skills = DbcDatabaseManager.skill_get_all()
        length = len(skills)
        count = 0

        for skill in skills:
            DbcDatabaseManager.SkillHolder.load_skill(skill)

            count += 1
            Logger.progress('Loading skills...', count, length)

    @staticmethod
    def _load_skill_line_abilities():
        skill_line_abilities = DbcDatabaseManager.skill_line_ability_get_all()
        length = len(skill_line_abilities)
        count = 0

        for skill_line_ability in skill_line_abilities:
            DbcDatabaseManager.SkillLineAbilityHolder.load_skill_line_ability(skill_line_ability)

            count += 1
            Logger.progress('Loading skill line abilities...', count, length)

    @staticmethod
    def _load_taxi_nodes():
        taxi_nodes = DbcDatabaseManager. taxi_nodes_get_all()
        length = len(taxi_nodes)
        count = 0

        for taxi_node in taxi_nodes:
            DbcDatabaseManager.TaxiNodesHolder.load_taxi_node(taxi_node)

            count += 1
            Logger.progress('Loading taxi nodes...', count, length)

    @staticmethod
    def start():
        WorldServerSessionHandler._load_data()
        Logger.success('World server started.')

        WorldServerSessionHandler.schedule_updates()

        ThreadedWorldServer.allow_reuse_address = True
        ThreadedWorldServer.timeout = 10
        with ThreadedWorldServer((config.Server.Connection.RealmServer.host, config.Server.Connection.WorldServer.port),
                                 WorldServerSessionHandler) as world_instance:
            world_session_thread = threading.Thread(target=world_instance.serve_forever())
            world_session_thread.daemon = True
            world_session_thread.start()
