from struct import pack

from game.world.managers.GridManager import GridManager
from network.packet.PacketWriter import PacketWriter, OpCode
from utils.constants.ObjectCodes import ChatMsgs, ChatFlags


class ChatManager(object):

    @staticmethod
    def send_system_message(world_session, message):
        world_session.request.sendall(ChatManager._get_message_packet(world_session.player_mgr.guid,
                                                                      ChatFlags.CHAT_TAG_NONE,
                                                                      message, ChatMsgs.CHAT_MSG_SYSTEM, 0))

    # This message will only be shown on the client console
    #
    # int __stdcall NotifyHandler(unsigned int timestamp, CDataStore *msg)
    # {
    #   char text[256]; // [sp+0h] [bp-100h]@1
    #
    #   CDataStore::GetString(msg, text, 0x100u);
    #   ConsoleWriteA(aNotificationRe, ERROR_COLOR, text);
    #   return 1;
    # }
    @staticmethod
    def send_notification(world_session, message):
        message_bytes = PacketWriter.string_to_bytes(message)
        data = pack('<%us' % len(message_bytes), message_bytes)
        world_session.request.sendall(PacketWriter.get_packet(OpCode.SMSG_NOTIFICATION, data))

    @staticmethod
    def send_chat_message(world_session, guid, chat_flags, message, chat_type, lang, range_):
        GridManager.send_surrounding_in_range(ChatManager._get_message_packet(guid,
                                                                              chat_flags,
                                                                              message, chat_type, 0), # TODO Handle language
                                              world_session.player_mgr, range_)

    @staticmethod
    def send_whisper(sender, receiver, message, lang):
        sender_packet = ChatManager._get_message_packet(receiver.guid, receiver.chat_flags, message,
                                                        ChatMsgs.CHAT_MSG_WHISPER_INFORM, lang)
        sender.session.request.sendall(sender_packet)
        receiver_packet = ChatManager._get_message_packet(sender.guid, sender.chat_flags, message,
                                                          ChatMsgs.CHAT_MSG_WHISPER, lang)
        receiver.session.request.sendall(receiver_packet)

    @staticmethod
    def _get_message_packet(guid, chat_flags, message, chat_type, lang):
        message_bytes = PacketWriter.string_to_bytes(message)
        data = pack(
            '<BIQ%usB' % len(message_bytes),
            chat_type,
            lang,
            guid,
            message_bytes,
            chat_flags
        )
        return PacketWriter.get_packet(OpCode.SMSG_MESSAGECHAT, data)
