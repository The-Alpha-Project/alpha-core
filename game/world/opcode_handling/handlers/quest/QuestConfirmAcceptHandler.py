from struct import unpack
from network.packet.PacketWriter import PacketWriter, OpCode


class QuestConfirmAcceptHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 4:  # Avoid handling empty quest confirm accept packet.
            quest_id = unpack('<I', reader.data[:4])[0]
            if world_session.player_mgr.quest_manager.is_quest_log_full():
                world_session.player_mgr.session.enqueue_packet(PacketWriter.deflate(OpCode.SMSG_QUESTLOG_FULL))
            else:
                world_session.player_mgr.quest_manager.handle_accept_quest(quest_id, 0, shared=True)  # We have no npc guid.
        return 0
