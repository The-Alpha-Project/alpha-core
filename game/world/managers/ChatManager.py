from struct import pack

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
