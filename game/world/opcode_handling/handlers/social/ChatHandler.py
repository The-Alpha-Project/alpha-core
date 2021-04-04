from game.world.WorldSessionStateHandler import WorldSessionStateHandler
from game.world.managers.GridManager import GridManager
from network.packet.PacketReader import *
from struct import pack, unpack, error
from game.world.managers.ChatManager import ChatManager
from utils.constants.ObjectCodes import ChatMsgs, ChatFlags, Languages
from utils.ConfigManager import config
from game.world.managers.CommandManager import CommandManager
from game.world.managers.objects.player.guild.GuildManager import GuildManager
from database.realm.RealmDatabaseManager import RealmDatabaseManager
from utils.Logger import Logger


class ChatHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        chat_type, lang = unpack('<2I', reader.data[:8])
        message = ''
        guid = 0
        chat_flags = 0

        # Return if no player
        if not world_session.player_mgr:
            return 0

        # Override language to universal for GMs
        if world_session.player_mgr.is_gm:
            lang = Languages.LANG_UNIVERSAL

        # Say, Yell, Emote
        if chat_type == ChatMsgs.CHAT_MSG_SAY \
                or chat_type == ChatMsgs.CHAT_MSG_EMOTE \
                or chat_type == ChatMsgs.CHAT_MSG_YELL:
            message = PacketReader.read_string(reader.data, 8)
            guid = world_session.player_mgr.guid
            chat_flags = world_session.player_mgr.chat_flags

            # Only send message if it's not a command
            if not ChatHandler.check_if_command(world_session, message):
                ChatManager.send_chat_message(world_session, guid, chat_flags, message, chat_type, lang,
                                              ChatHandler.get_range_by_type(chat_type))
        # Whisper
        elif chat_type == ChatMsgs.CHAT_MSG_WHISPER:
            target_name = PacketReader.read_string(reader.data, 8).strip()
            target_player_mgr = WorldSessionStateHandler.find_player_by_name(target_name)
            if not target_player_mgr:
                ChatManager.send_system_message(world_session, 'No player named \'%s\' is currently playing.'
                                                % target_name.capitalize())
                return 0
            message = PacketReader.read_string(reader.data, 8 + len(target_name)+1)
            if ChatHandler.check_if_external_guild_create(world_session, message):
                return 0
            if not ChatHandler.check_if_command(world_session, message):
                # Always whisper in universal language when speaking with a GM
                if target_player_mgr.is_gm:
                    lang = Languages.LANG_UNIVERSAL

                ChatManager.send_whisper(world_session.player_mgr, target_player_mgr, message, lang)
            return 0
        # Party
        elif chat_type == ChatMsgs.CHAT_MSG_PARTY:
            message = PacketReader.read_string(reader.data, 8)
            ChatManager.send_party(world_session.player_mgr, message, lang)
            return 0
        # Guild
        elif chat_type == ChatMsgs.CHAT_MSG_GUILD:
            message = PacketReader.read_string(reader.data, 8)
            ChatManager.send_guild(world_session.player_mgr, message, lang)
            return 0

        return 0

    @staticmethod
    def check_if_external_guild_create(world_session, message):
        if not message:
            return False

        parse = message.split(' ')

        if len(parse) < 2 or len(parse) > 2:
            return False
        if parse[0] != 'guildcreate':
            return False
        if len(parse[1]) < 4: # TODO, guild name length limits?
            ChatManager.send_system_message(world_session, 'Guild name must be at least 4 characters long.')
            return False

        GuildManager.create_guild(world_session.player_mgr, parse[1])
        return True

    @staticmethod
    def check_if_command(world_session, message):
        if len(message) > 0 and message.startswith('.') and len(message) > 1 and message[1] != '.':
            CommandManager.handle_command(world_session, message)
            return True
        return False

    @staticmethod
    def get_range_by_type(chat_type):
        if chat_type == ChatMsgs.CHAT_MSG_YELL:
            return config.World.Chat.ChatRange.yell_range
        else:
            return config.World.Chat.ChatRange.say_range
