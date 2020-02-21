from game.world.managers.GridManager import GridManager
from network.packet.PacketReader import *
from struct import pack, unpack, error
from game.world.managers.ChatManager import ChatManager
from utils.constants.ObjectCodes import ChatMsgs, ChatFlags
from utils.ConfigManager import config
from game.world.managers.CommandManager import CommandManager
from database.realm.RealmDatabaseManager import RealmDatabaseManager
from utils.Logger import Logger


class ChatHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        chat_type, lang = unpack('<2I', reader.data[:8])
        message = ''
        guid = 0
        chat_flags = 0

        # Say, Yell, Emote
        if chat_type == ChatMsgs.CHAT_MSG_SAY \
                or chat_type == ChatMsgs.CHAT_MSG_EMOTE \
                or chat_type == ChatMsgs.CHAT_MSG_YELL:
            message = PacketReader.read_string(reader.data, 8)
            guid = world_session.player_mgr.guid
            chat_flags = world_session.player_mgr.chat_flags
        # Whisper
        elif chat_type == ChatMsgs.CHAT_MSG_WHISPER:
            target_name = PacketReader.read_string(reader.data, 8).strip()
            target_player_mgr = GridManager.find_player_by_name(target_name)
            if not target_player_mgr:
                ChatManager.send_system_message(world_session, 'No player named \'%s\' is currently playing.'
                                                % target_name.capitalize())
                return 0
            message = PacketReader.read_string(reader.data, 8 + len(target_name)+1)
            if not ChatHandler.check_if_command(world_session, message):
                ChatManager.send_whisper(world_session.player_mgr, target_player_mgr, message, 0)  # TODO: handle lang
            return 0

        if not ChatHandler.check_if_command(world_session, message):
            ChatManager.send_chat_message(world_session, guid, chat_flags, message, chat_type, lang,
                                          ChatHandler.get_range_by_type(chat_type))

        return 0

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
