from struct import unpack
from network.packet.PacketWriter import PacketWriter, OpCode
from utils.Logger import Logger


class QuestConfirmAcceptHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        player_mgr = world_session.player_mgr
        # No player linked to session requester.
        if not player_mgr:
            Logger.warning('QuestConfirmAcceptHandler received with null player_mgr.')
            return 0

        if len(reader.data) >= 4:  # Avoid handling empty quest confirm accept packet.
            quest_id = unpack('<I', reader.data[:4])[0]
            if player_mgr.quest_manager.is_quest_log_full():
                player_mgr.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_QUESTLOG_FULL))
            else:
                player_mgr.quest_manager.handle_accept_quest(quest_id, 0, shared=True)  # We have no npc guid.
        return 0
