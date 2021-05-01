from struct import unpack

from game.world.managers.GridManager import GridManager
from utils.Logger import Logger


class QuestGiverAcceptQuestHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 12:  # Avoid handling empty quest giver accept quest packet
            quest_giver_guid, quest_id = unpack ('<QI', reader.data[:12])
            quest_giver = GridManager.get_surrounding_unit_by_guid(world_session.player_mgr, quest_giver_guid)
            if not quest_giver:
                Logger.error(f'Error in CMSG_QUESTGIVER_ACCEPT_QUEST, could not find quest giver with guid of: {quest_giver_guid}')
                return 0
            if world_session.player_mgr.is_enemy_to(quest_giver):
                return 0

            world_session.player_mgr.quest_manager.add_quest(quest_id, quest_giver_guid)
        return 0
