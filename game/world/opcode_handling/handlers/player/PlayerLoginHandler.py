from game.world.managers.objects.units.player.guild.GuildManager import GuildManager
from network.packet.PacketReader import PacketReader
import time
from struct import unpack

from database.dbc.DbcDatabaseManager import *
from database.realm.RealmDatabaseManager import *
from game.world.WorldSessionStateHandler import WorldSessionStateHandler
from game.world.managers.objects.units.ChatManager import ChatManager
from game.world.managers.objects.units.player.GroupManager import GroupManager
from game.world.managers.objects.units.player.PlayerManager import PlayerManager
from network.packet.PacketWriter import *
from utils.ConfigManager import config
from utils.Logger import Logger
from utils.constants.CharCodes import CharLogin
from utils.constants.OpCodes import OpCode


class PlayerLoginHandler(object):

    @staticmethod
    def handle(world_session, reader: PacketReader) -> int:
        if len(reader.data) < 8:  # Avoid handling wrong player login packet.
            return -1

        guid = unpack('<Q', reader.data[:8])[0]

        world_session.player_mgr = PlayerManager(
            RealmDatabaseManager.character_get_by_guid(guid), world_session)
        player_mgr = world_session.player_mgr

        if not world_session.player_mgr.player:
            Logger.anticheat(f'Character with wrong guid ({guid}) tried to login.')
            return -1
        else:
            WorldSessionStateHandler.push_active_player_session(world_session)

        # Disabled race & class checks (only if not a GM).
        if not world_session.account_mgr.is_gm():
            disabled_race_mask = config.Server.General.disabled_race_mask
            disabled = disabled_race_mask & player_mgr.race_mask == player_mgr.race_mask

            if not disabled:
                disabled_class_mask = config.Server.General.disabled_class_mask
                disabled = disabled_class_mask & player_mgr.class_mask == player_mgr.class_mask

            if disabled:
                # Not 100% sure if CHAR_LOGIN_DISABLED matters here, but I don't know where else to send it.
                data = pack(
                    '<B', CharLogin.CHAR_LOGIN_DISABLED
                )
                player_mgr.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_CHARACTER_LOGIN_FAILED, data))
                return 0

        # Class & race allowed, continue with the login process.

        player_mgr.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_LOGIN_SETTIMESPEED,
                                                          PlayerLoginHandler._get_login_timespeed()))

        player_mgr.skill_manager.load_proficiencies()
        player_mgr.skill_manager.load_skills()
        player_mgr.spell_manager.load_spells()
        player_mgr.skill_manager.update_skills_max_value()  # Can depend on learned spells.
        player_mgr.pet_manager.load_pets()

        player_mgr.deathbind = RealmDatabaseManager.character_get_deathbind(player_mgr.guid)
        player_mgr.friends_manager.load_from_db(RealmDatabaseManager.character_get_social(player_mgr.guid))

        # Only send the deathbind packet if it's a Binder NPC what bound the player.
        if player_mgr.deathbind.creature_binder_guid > 0:
            player_mgr.enqueue_packet(player_mgr.get_deathbind_packet())
        # Tutorials aren't implemented in 0.5.3.
        # world_session.enqueue_packet(world_session.player_mgr.get_tutorial_packet())
        player_mgr.enqueue_packet(player_mgr.spell_manager.get_initial_spells())
        player_mgr.enqueue_packet(player_mgr.get_action_buttons())

        # MotD.
        ChatManager.send_system_message(world_session, config.Server.General.motd)

        player_mgr.inventory.load_items()

        # Initialize stats first to have existing base stats for further calculations.
        player_mgr.stat_manager.init_stats()

        player_mgr.skill_manager.init_proficiencies()

        player_mgr.quest_manager.load_quests()
        player_mgr.reputation_manager.load_reputations()
        GuildManager.set_character_guild(player_mgr)
        GroupManager.set_character_group(player_mgr)

        first_login = player_mgr.player.totaltime == 0
        # Send cinematic.
        if first_login:
            PlayerLoginHandler._send_cinematic(world_session, world_session.player_mgr.player)

        player_mgr.complete_login(first_login=first_login)

        return 0

    @staticmethod
    def _send_cinematic(world_session, player):
        # Sadly, ONLY undeads have intro cinematic.
        cinematic_id = DbcDatabaseManager.chr_races_get_by_race(player.race).CinematicSequenceID
        if cinematic_id != 0:
            data = pack('<I', cinematic_id)
            world_session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_TRIGGER_CINEMATIC, data))

    @staticmethod
    def _get_login_timespeed() -> bytes:
        data = pack(
            '<If',
            PlayerLoginHandler._get_secs_to_time_bit_fields(),  # game time (secs) to bit
            config.World.Gameplay.game_speed
        )
        return data

    @staticmethod
    def _get_secs_to_time_bit_fields() -> int:
        local = time.localtime()

        year = local.tm_year - 2000  # "Blizz Time" starts at year 2000
        month = local.tm_mon - 1
        day = local.tm_mday - 1
        day_of_week = local.tm_wday
        hour = local.tm_hour
        minute = local.tm_min

        return minute | (hour << 6) | (day_of_week << 11) | (day << 14) | (month << 20) | (year << 24)
