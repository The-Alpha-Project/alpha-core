from game.world.WorldSessionStateHandler import WorldSessionStateHandler
from game.world.managers.CommandManager import CommandManager
from game.world.managers.objects.units.ChatManager import ChatManager
from game.world.opcode_handling.HandlerValidator import HandlerValidator
from network.packet.PacketReader import *
from utils.ConfigManager import config
from utils.constants.MiscCodes import ChatMsgs, Languages


class ChatHandler:

    @staticmethod
    def handle(world_session, reader):
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode)
        if not player_mgr:
            return res
        # Avoid handling an empty or truncated packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=8):
            return 0

        chat_type, lang = unpack('<2I', reader.data[:8])
        message = ''

        if player_mgr.language_mod > -1:
            lang = player_mgr.language_mod

        # Override language to universal for GMs.
        if world_session.account_mgr.is_gm():
            lang = Languages.LANG_UNIVERSAL

        # Channel.
        if chat_type == ChatMsgs.CHAT_MSG_CHANNEL:
            channel_name = PacketReader.read_string(reader.data, 8).strip()
            message = PacketReader.read_string(reader.data, 8 + len(channel_name)+1)
            ChatManager.send_channel_message(player_mgr, channel_name, message, lang)
        # Say, Yell, Emote.
        elif chat_type == ChatMsgs.CHAT_MSG_SAY \
                or chat_type == ChatMsgs.CHAT_MSG_EMOTE \
                or chat_type == ChatMsgs.CHAT_MSG_YELL:
            message = PacketReader.read_string(reader.data, 8)
            guid = player_mgr.guid
            chat_flags = player_mgr.chat_flags

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
                ChatManager.send_whisper(player_mgr, target_player_mgr, message, lang)
            return 0
        # Party.
        elif chat_type == ChatMsgs.CHAT_MSG_PARTY:
            if not ChatHandler.check_if_command(world_session, message):
                message = PacketReader.read_string(reader.data, 8)
                ChatManager.send_party(player_mgr, message, lang)
            return 0
        # Guild.
        elif chat_type == ChatMsgs.CHAT_MSG_GUILD or chat_type == ChatMsgs.CHAT_MSG_OFFICER:
            if not ChatHandler.check_if_command(world_session, message):
                message = PacketReader.read_string(reader.data, 8)
                ChatManager.send_guild(player_mgr, message, lang, chat_type)
            return 0
        # AFK.
        elif chat_type == ChatMsgs.CHAT_MSG_AFK:
            if not ChatHandler.check_if_command(world_session, message):
                message = PacketReader.read_string(reader.data, 8)
                if message and message != player_mgr.afk_message:
                    player_mgr.afk_message = message

                if not message or not player_mgr.is_afk():
                    player_mgr.toggle_afk()

                if player_mgr.is_afk() and player_mgr.is_dnd():
                    player_mgr.toggle_dnd()
        # DND.
        elif chat_type == ChatMsgs.CHAT_MSG_DND:
            if not ChatHandler.check_if_command(world_session, message):
                message = PacketReader.read_string(reader.data, 8)
                if message or not player_mgr.is_dnd():
                    player_mgr.dnd_message = message

                if not message or not player_mgr.is_dnd():
                    player_mgr.toggle_dnd()

                if player_mgr.is_afk() and player_mgr.is_dnd():
                    player_mgr.toggle_afk()

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
