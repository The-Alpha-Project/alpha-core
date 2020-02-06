from struct import pack

from game.world.managers.GridManager import GridManager
from network.packet.PacketWriter import PacketWriter, OpCode
from utils.constants.ObjectCodes import ChatMsgs, ChatFlags


class ChatManager(object):

    @staticmethod
    def send_system_message(world_session, message):
        message_bytes = PacketWriter.string_to_bytes(message)
        data = pack(
            '<BIQ%usB' % len(message_bytes),
            ChatMsgs.CHAT_MSG_SYSTEM.value,
            0,
            world_session.player_mgr.guid,
            message_bytes,
            ChatFlags.CHAT_TAG_NONE.value
        )
        world_session.request.sendall(PacketWriter.get_packet(OpCode.SMSG_MESSAGECHAT, data))

    @staticmethod
    def send_chat_message(world_session, message, chat_type, lang, range_):
        message_bytes = PacketWriter.string_to_bytes(message)
        data = pack(
            '<BIQ%usB' % len(message_bytes),
            chat_type.value,
            0,  # lang, disregard for now––not implemented
            world_session.player_mgr.guid,
            message_bytes,
            world_session.player_mgr.chat_flags
        )
        GridManager.send_surrounding_in_range(PacketWriter.get_packet(OpCode.SMSG_MESSAGECHAT, data),
                                              world_session.player_mgr, range_)
