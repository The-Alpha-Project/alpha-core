from struct import unpack

from game.world.opcode_handling.HandlerValidator import HandlerValidator


class QuestGiverRemoveQuestHandler:

    @staticmethod
    def handle(world_session, reader):
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode)
        if not player_mgr:
            return res

        if len(reader.data) >= 1:  # Avoid handling empty quest giver remove quest packet.
            slot = unpack('<B', reader.data[:1])[0]
            player_mgr.quest_manager.handle_remove_quest(slot)
        return 0
