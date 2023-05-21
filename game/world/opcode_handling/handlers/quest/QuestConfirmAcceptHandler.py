from struct import unpack

from game.world.opcode_handling.HandlerValidator import HandlerValidator
from network.packet.PacketWriter import PacketWriter
from utils.constants.OpCodes import OpCode


class QuestConfirmAcceptHandler(object):

    @staticmethod
    def handle(world_session, reader):
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode)
        if not player_mgr:
            return res

        if len(reader.data) >= 4:  # Avoid handling empty quest confirm accept packet.
            quest_id = unpack('<I', reader.data[:4])[0]
            if player_mgr.quest_manager.is_quest_log_full():
                player_mgr.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_QUESTLOG_FULL))
            else:
                player_mgr.quest_manager.handle_accept_quest(quest_id, 0, shared=True)  # We have no npc guid.
        return 0
