from struct import pack

from game.world.managers.maps.MapManager import MapManager
from game.world.managers.objects.units.player.ChannelManager import ChannelManager
from game.world.managers.objects.units.player.GroupManager import GroupManager
from game.world.managers.objects.units.player.guild.GuildManager import GuildManager
from game.world.managers.objects.units.player.trade.ChatAddonManager import ChatAddonManager
from network.packet.PacketWriter import PacketWriter, OpCode
from utils.ChatLogManager import ChatLogManager
from utils.constants.GroupCodes import PartyOperations, PartyResults
from utils.constants.MiscCodes import GuildRank, ChatMsgs, ChatFlags, GuildChatMessageTypes, GuildCommandResults, \
    GuildTypeCommand, ChannelNotifications, Languages


class ChatManager(object):

    @staticmethod
    def send_system_message(world_session, message):
        world_session.enqueue_packet(ChatManager._get_message_packet(world_session.player_mgr.guid,
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
        data = pack(f'<{len(message_bytes)}s', message_bytes)
        world_session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_NOTIFICATION, data))

    @staticmethod
    def send_chat_message(world_session, guid, chat_flags, message, chat_type, lang, range_):
        MapManager.send_surrounding_in_range(ChatManager._get_message_packet(guid, chat_flags, message, chat_type, lang),
                                             world_session.player_mgr, range_, use_ignore=True)
        ChatLogManager.log_chat(world_session.player_mgr, message, chat_type)

    @staticmethod
    def send_monster_emote_message(sender, guid, message, chat_type, lang, range_):
        packet = ChatManager._get_monster_message_packet(sender.creature_template.name, guid,
                                                         ChatFlags.CHAT_TAG_NONE, message, chat_type, lang)
        MapManager.send_surrounding_in_range(packet, sender, range_, use_ignore=False)

    @staticmethod
    def send_channel_message(sender, channel_name, message, lang):
        channel = ChannelManager.get_channel(channel_name, sender)
        # Check if channel exists.
        if not channel:
            packet = ChannelManager.build_notify_packet(channel_name, ChannelNotifications.NOT_MEMBER)
            ChannelManager.send_to_player(sender, packet)
            return 0

        if channel.is_addon():
            ChatAddonManager.process_addon_request(channel, sender, message)
        else:
            packet = ChatManager._get_message_packet(sender.guid, sender.chat_flags, message, ChatMsgs.CHAT_MSG_CHANNEL,
                                                     lang, channel=channel_name)
            channel.broadcast_to_channel(sender, packet)
            ChatLogManager.log_channel(sender, message, channel)

    @staticmethod
    def send_party(sender, message, lang):
        if sender.group_manager:
            sender_packet = ChatManager._get_message_packet(sender.guid, sender.chat_flags, message,
                                                            ChatMsgs.CHAT_MSG_PARTY, lang)
            sender.group_manager.send_packet_to_members(sender_packet, source=sender, use_ignore=True)
            ChatLogManager.log_chat(sender, message, ChatMsgs.CHAT_MSG_PARTY)
        else:
            GroupManager.send_group_operation_result(sender, PartyOperations.PARTY_OP_LEAVE, '',
                                                     PartyResults.ERR_NOT_IN_GROUP)

    @staticmethod
    def send_guild(sender, message, lang, chat_type):
        if sender.guild_manager:
            sender_packet = ChatManager._get_message_packet(sender.guid, sender.chat_flags, message, chat_type, lang)

            if chat_type == ChatMsgs.CHAT_MSG_GUILD:
                sender.guild_manager.send_message_to_guild(sender_packet, GuildChatMessageTypes.G_MSGTYPE_ALL,
                                                           source=sender)
                ChatLogManager.log_chat(sender, message, chat_type)
            else:
                if sender.guild_manager.get_rank(sender.guid) > GuildRank.GUILDRANK_OFFICER:
                    GuildManager.send_guild_command_result(sender, GuildTypeCommand.GUILD_CREATE_S, '',
                                                           GuildCommandResults.GUILD_PERMISSIONS)
                else:
                    sender.guild_manager.send_message_to_guild(sender_packet, GuildChatMessageTypes.G_MSGTYPE_OFFICERCHAT, source=sender)
                    ChatLogManager.log_chat(sender, message, chat_type)
        else:
            GuildManager.send_guild_command_result(sender, GuildTypeCommand.GUILD_CREATE_S, '',
                                                   GuildCommandResults.GUILD_PLAYER_NOT_IN_GUILD)

    @staticmethod
    def send_whisper(sender, receiver, message, lang):
        if receiver.friends_manager.has_ignore(sender.guid):
            sender_packet = ChatManager._get_message_packet(receiver.guid, receiver.chat_flags, message,
                                                            ChatMsgs.CHAT_MSG_IGNORED, lang)
            sender.enqueue_packet(sender_packet)
        else:
            sender_packet = ChatManager._get_message_packet(receiver.guid, receiver.chat_flags, message,
                                                            ChatMsgs.CHAT_MSG_WHISPER_INFORM, lang)
            sender.enqueue_packet(sender_packet)
            receiver_packet = ChatManager._get_message_packet(sender.guid, sender.chat_flags, message,
                                                              ChatMsgs.CHAT_MSG_WHISPER, lang)
            receiver.enqueue_packet(receiver_packet)
            ChatLogManager.log_whisper(sender, message, receiver)

    @staticmethod
    def _get_message_packet(guid, chat_flags, message, chat_type, lang, channel=None):
        message_bytes = PacketWriter.string_to_bytes(message)

        data = pack('<BI', chat_type, lang)
        if not channel:
            data += pack('<Q', guid)
        else:
            channel_bytes = PacketWriter.string_to_bytes(channel)
            data += pack(f'<{len(channel_bytes)}sQ', channel_bytes, guid)
        data += pack(f'<{len(message_bytes)}sB', message_bytes, chat_flags)

        return PacketWriter.get_packet(OpCode.SMSG_MESSAGECHAT, data)

    @staticmethod
    def _get_monster_message_packet(name, guid, chat_flags, message, chat_type, lang, target_guid=0):
        message_bytes = PacketWriter.string_to_bytes(message)
        monster_name_bytes = PacketWriter.string_to_bytes(name)

        data = pack('<BI', chat_type, lang)

        if chat_type == ChatMsgs.CHAT_MSG_MONSTER_EMOTE:
            data += pack(f'<{len(monster_name_bytes)}sQ', monster_name_bytes, target_guid)
        elif chat_type == ChatMsgs.CHAT_MSG_MONSTER_SAY or chat_type == ChatMsgs.CHAT_MSG_MONSTER_YELL:
            data += pack(f'<{len(monster_name_bytes)}sQ', monster_name_bytes, guid)

        data += pack(f'<{len(message_bytes)}sB', message_bytes, chat_flags)
        return PacketWriter.get_packet(OpCode.SMSG_MESSAGECHAT, data)
