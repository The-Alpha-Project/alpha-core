from struct import pack
from game.world.managers.GridManager import GridManager
from network.packet.PacketWriter import PacketWriter, OpCode
from utils.constants.ObjectCodes import GuildRank, ChatMsgs, ChatFlags, GuildChatMessageTypes, GuildCommandResults, GuildTypeCommand
from game.world.managers.objects.player.guild.GuildManager import GuildManager

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
                                                                              message, chat_type, lang),
                                              world_session.player_mgr, range_)

    @staticmethod
    def send_party(sender, message, lang):
        if sender.group_manager:
            sender_packet = ChatManager._get_message_packet(sender.guid, sender.chat_flags, message,
                                                            ChatMsgs.CHAT_MSG_PARTY, lang)
            sender.group_manager.send_packet_to_members(sender_packet)

    @staticmethod
    def send_guild(sender, message, lang, chat_type):
        if sender.guild_manager:
            msg_type = ChatMsgs.CHAT_MSG_GUILD if chat_type == ChatMsgs.CHAT_MSG_GUILD else ChatMsgs.CHAT_MSG_OFFICER
            sender_packet = ChatManager._get_message_packet(sender.guid, sender.chat_flags, message, msg_type, lang)

            if msg_type == ChatMsgs.CHAT_MSG_GUILD:
                sender.guild_manager.send_message_to_guild(sender_packet, GuildChatMessageTypes.G_MSGTYPE_ALL)
            else:
                if sender.guild_manager.get_guild_rank(sender) > GuildRank.GUILDRANK_OFFICER:
                    GuildManager.send_guild_command_result(sender, GuildTypeCommand.GUILD_CREATE_S, '',
                                                           GuildCommandResults.GUILD_PERMISSIONS)
                else:
                    sender.guild_manager.send_message_to_guild(sender_packet, GuildChatMessageTypes.G_MSGTYPE_OFFICERCHAT)

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
