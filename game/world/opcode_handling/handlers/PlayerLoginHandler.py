import time

from struct import unpack

from game.world.WorldSessionStateHandler import WorldSessionStateHandler
from network.packet.PacketWriter import *
from database.realm.RealmDatabaseManager import *
from database.dbc.DbcDatabaseManager import *
from network.packet.UpdatePacketFactory import UpdatePacketFactory, UpdateTypes
from utils.Logger import Logger
from game.world.managers.objects.player.PlayerManager import PlayerManager
from utils.ConfigManager import config
from game.world.managers.ChatManager import ChatManager


class PlayerLoginHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) < 8:  # Avoid handling wrong player login packet
            return -1

        guid = unpack('<Q', reader.data[:8])[0]

        world_session.player_mgr = PlayerManager(
            RealmDatabaseManager.character_get_by_guid(world_session.realm_db_session, guid), world_session)
        world_session.player_mgr.session = world_session
        if not world_session.player_mgr.player:
            Logger.anticheat('Character with wrong guid (%u) tried to login.' % guid)
            return -1

        socket.sendall(PacketWriter.get_packet(OpCode.SMSG_LOGIN_SETTIMESPEED,
                                               PlayerLoginHandler._get_login_timespeed()))

        world_session.player_mgr.load_skills()
        world_session.player_mgr.load_spells()

        socket.sendall(world_session.player_mgr.get_tutorial_packet())
        socket.sendall(world_session.player_mgr.get_initial_spells())
        socket.sendall(world_session.player_mgr.get_action_buttons())

        # MotD
        ChatManager.send_system_message(world_session, config.Server.General.motd)

        # Clear Who list on login, otherwise the last search will appear
        PlayerLoginHandler._clear_who_list(socket)

        world_session.player_mgr.inventory.load_items(world_session)
        update_packet = UpdatePacketFactory.compress_if_needed(PacketWriter.get_packet(
            OpCode.SMSG_UPDATE_OBJECT,
            world_session.player_mgr.get_update_packet(update_type=UpdateTypes.UPDATE_FULL)))
        socket.sendall(update_packet)

        PlayerLoginHandler._send_cinematic(world_session, world_session.player_mgr.player, socket)
        time.sleep(0.5)  # Wait half a second before completing the login
        world_session.player_mgr.complete_login()

        return 0

    @staticmethod
    def _clear_who_list(socket):
        data = pack('<2I', 0, 0)
        socket.sendall(PacketWriter.get_packet(OpCode.SMSG_WHO, data))

    @staticmethod
    def _send_cinematic(world_session, player, socket):
        if player.totaltime == 0:
            # Sadly, ONLY undeads have intro cinematic.
            cinematic_id = DbcDatabaseManager.chr_races_get_by_race(
                world_session.dbc_db_session, player.race).CinematicSequenceID
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
