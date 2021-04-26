from struct import unpack


class QuestGiverRemoveQuestHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 1:  # Avoid handling empty quest giver remove quest packet
            slot_num = unpack ('<B', reader.data[:1])[0]
            world_session.player_mgr.quest_manager.remove_quest(slot_num)
        return 0
