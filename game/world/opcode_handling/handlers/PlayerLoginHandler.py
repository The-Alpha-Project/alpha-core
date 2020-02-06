import time

from struct import unpack

from network.packet.PacketWriter import *
from database.realm.RealmDatabaseManager import *
from database.dbc.DbcDatabaseManager import *
from utils.Logger import Logger
from game.world.managers.objects.PlayerManager import PlayerManager
from utils.ConfigManager import config
from utils.constants.ObjectCodes import UpdateTypes
from game.world.managers.ChatManager import ChatManager


class PlayerLoginHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        guid = unpack('<Q', reader.data)[0]

        world_session.player_mgr = PlayerManager(RealmDatabaseManager.character_get_by_guid(guid))
        if not world_session.player_mgr.player:
            Logger.error('Character with wrong guid (%u) tried to login.' % guid)
            return -1

        socket.sendall(PacketWriter.get_packet(OpCode.SMSG_LOGIN_SETTIMESPEED,
                                               PlayerLoginHandler._get_login_timespeed()))

        socket.sendall(world_session.player_mgr.get_tutorial_packet())
        socket.sendall(world_session.player_mgr.get_initial_spells())
        socket.sendall(world_session.player_mgr.get_query_details())
        # MotD
        ChatManager.send_system_message(world_session, config.Server.General.motd)

        socket.sendall(PacketWriter.get_packet(
            OpCode.SMSG_UPDATE_OBJECT,
            world_session.player_mgr.get_update_packet()))

        PlayerLoginHandler.send_cinematic(world_session.player_mgr.player, socket)

        world_session.player_mgr.complete_login(world_session)

        return 0

    @staticmethod
    def send_cinematic(player, socket):
        # Sadly, ONLY undeads have intro cinematic.
        cinematic_id = DbcDatabaseManager.chr_races_get_by_race(player.race).CinematicSequenceID
        if cinematic_id != 0:
            data = pack(
                '<I', cinematic_id
            )
            socket.sendall(PacketWriter.get_packet(OpCode.SMSG_TRIGGER_CINEMATIC, data))

    @staticmethod
    def _get_login_timespeed():
        data = pack(
            '<If',
            PlayerLoginHandler._get_secs_to_time_bit_fields(),  # game time (secs) to bit
            config.World.Gameplay.game_speed
        )
        return data

    @staticmethod
    def _get_secs_to_time_bit_fields():
        local = time.localtime()

        year = local.tm_year - 2000
        month = local.tm_mon - 1
        day = local.tm_mday - 1
        day_of_week = local.tm_wday
        hour = local.tm_hour
        minute = local.tm_min

        return ((((minute | (hour << 6)) | (day_of_week << 11)) | (day << 14)) | (month << 20)) | (year << 24)
