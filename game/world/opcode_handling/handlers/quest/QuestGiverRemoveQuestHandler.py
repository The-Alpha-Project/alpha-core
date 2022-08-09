from struct import unpack
from utils.Logger import Logger


class QuestGiverRemoveQuestHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        player_mgr = world_session.player_mgr
        # No player linked to session requester.
        if not player_mgr:
            Logger.warning('QuestGiverRemoveQuestHandler received with null player_mgr.')
            return 0

        if len(reader.data) >= 1:  # Avoid handling empty quest giver remove quest packet.
            slot = unpack('<B', reader.data[:1])[0]
            player_mgr.quest_manager.handle_remove_quest(slot)
        return 0
