from game.world.WorldSessionStateHandler import WorldSessionStateHandler
from game.world.managers.CommandManager import CommandManager
from game.world.managers.objects.units.ChatManager import ChatManager
from network.packet.PacketReader import *
from utils.ConfigManager import config
from utils.constants.MiscCodes import ChatMsgs, Languages


class ChatHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        chat_type, lang = unpack('<2I', reader.data[:8])
        message = ''

        # Return if no player.
        if not world_session.player_mgr:
            return 0

        # Override language to universal for GMs.
        if world_session.account_mgr.is_gm():
            lang = Languages.LANG_UNIVERSAL

        # Channel.
        if chat_type == ChatMsgs.CHAT_MSG_CHANNEL:
            channel_name = PacketReader.read_string(reader.data, 8).strip()
            message = PacketReader.read_string(reader.data, 8 + len(channel_name)+1)
            ChatManager.send_channel_message(world_session.player_mgr, channel_name, message, lang)
        # Say, Yell, Emote.
        elif chat_type == ChatMsgs.CHAT_MSG_SAY \
                or chat_type == ChatMsgs.CHAT_MSG_EMOTE \
                or chat_type == ChatMsgs.CHAT_MSG_YELL:
            message = PacketReader.read_string(reader.data, 8)
            guid = world_session.player_mgr.guid
            chat_flags = world_session.player_mgr.chat_flags

            # Only send message if it's not a command.
            if not ChatHandler.check_if_command(world_session, message):
                ChatManager.send_chat_message(world_session, guid, chat_flags, message, chat_type, lang,
                                              ChatHandler.get_range_by_type(chat_type))
        # Whisper.
        elif chat_type == ChatMsgs.CHAT_MSG_WHISPER:
            target_name = PacketReader.read_string(reader.data, 8).strip()
            target_player_mgr = WorldSessionStateHandler.find_player_by_name(target_name)
            if not target_player_mgr:
                ChatManager.send_system_message(world_session, f'No player named \'{target_name.capitalize()}\' is currently playing.')
                return 0
            message = PacketReader.read_string(reader.data, 8 + len(target_name)+1)
            if not ChatHandler.check_if_command(world_session, message):
                # Always whisper in universal language when speaking with a GM.
                if target_player_mgr.session.account_mgr.is_gm():
                    lang = Languages.LANG_UNIVERSAL

                ChatManager.send_whisper(world_session.player_mgr, target_player_mgr, message, lang)
            return 0
        # Party.
        elif chat_type == ChatMsgs.CHAT_MSG_PARTY:
            if not ChatHandler.check_if_command(world_session, message):
                message = PacketReader.read_string(reader.data, 8)
                ChatManager.send_party(world_session.player_mgr, message, lang)
            return 0
        # Guild.
        elif chat_type == ChatMsgs.CHAT_MSG_GUILD or chat_type == ChatMsgs.CHAT_MSG_OFFICER:
            if not ChatHandler.check_if_command(world_session, message):
                message = PacketReader.read_string(reader.data, 8)
                ChatManager.send_guild(world_session.player_mgr, message, lang, chat_type)
            return 0

        return 0

    @staticmethod
    def check_if_command(world_session, message):
        if len(message) > 0 and message.startswith('.') and len(message) > 1 and message[1] != '.':
            CommandManager.handle_command(world_session, message)
            return True
        return False

    @staticmethod
    def get_range_by_type(chat_type):
        if chat_type == ChatMsgs.CHAT_MSG_YELL or chat_type == ChatMsgs.CHAT_MSG_MONSTER_YELL:
            return config.World.Chat.ChatRange.yell_range
        else:
            return config.World.Chat.ChatRange.say_range
