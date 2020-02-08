from network.packet.PacketReader import *
from struct import pack, unpack, error
from game.world.managers.ChatManager import ChatManager
from utils.constants.ObjectCodes import ChatMsgs, ChatFlags
from utils.ConfigManager import config
from utils.Logger import Logger


class ChatHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        chat_type, lang = unpack('<2I', reader.data[:8])
        chat_type = ChatMsgs(chat_type)

        # Say, Yell, Emote
        if chat_type == ChatMsgs.CHAT_MSG_SAY \
                or chat_type == ChatMsgs.CHAT_MSG_EMOTE \
                or chat_type == ChatMsgs.CHAT_MSG_YELL:
            message = PacketReader.read_string(reader.data[8:], 0)

            if len(message) > 0:
                ChatManager.send_chat_message(world_session, message, chat_type, lang,
                                              ChatHandler.get_range_by_type(chat_type))

        return 0

    @staticmethod
    def get_range_by_type(chat_type):
        if chat_type == ChatMsgs.CHAT_MSG_YELL:
            return config.World.Chat.ChatRange.yell_range
        else:
            return config.World.Chat.ChatRange.say_range
