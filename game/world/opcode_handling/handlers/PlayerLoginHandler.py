import time

from struct import pack, unpack

from network.packet.PacketWriter import *
from game.world.objects.PlayerManager import PlayerManager
from database.realm.RealmDatabaseManager import *
from utils.Logger import Logger
from game.world.objects.ObjectManager import ObjectManager
from game.world.objects.PlayerManager import PlayerManager
from utils.constants.ObjectCodes import ObjectTypes
from utils.ConfigManager import config


class PlayerLoginHandler(object):

    @staticmethod
    def handle(world_session, socket, packet):
        guid = unpack('>Q', packet)[0]

        world_session.player_mgr = PlayerManager(RealmDatabaseManager.character_get_by_guid(guid))
        if not world_session.player_mgr.player:
            Logger.error('Character with wrong guid (%u) tried to login.' % guid)
            return -1

        socket.sendall(PacketWriter.get_packet(OpCode.SMSG_LOGIN_SETTIMESPEED,
                                               PlayerLoginHandler._get_login_timespeed()))

        socket.sendall(world_session.player_mgr.get_tutorial_packet())
        socket.sendall(world_session.player_mgr.get_initial_spells())
        socket.sendall(world_session.player_mgr.get_query_details())
        socket.sendall(world_session.player_mgr.get_build_object_update_packet())
        socket.sendall(world_session.player_mgr.get_player_build_update_packet(deflate=True))

        return 0

    @staticmethod
    def _get_login_timespeed():
        data = pack(
            '!if',
            PlayerLoginHandler._get_secs_to_time_bit_fields(),  # game time (secs) to bit
            config.World.Gameplay.game_speed
        )
        return data

    @staticmethod
    def _get_secs_to_time_bit_fields():
        local = time.localtime()

        return ((local.tm_year - 100) << 24 |
                local.tm_mon << 20 |
                (local.tm_mday - 1) << 14 |
                local.tm_wday << 11 |
                (local.tm_hour - 3) << 6 |
                local.tm_min)
