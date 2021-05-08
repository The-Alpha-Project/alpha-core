from struct import unpack

from game.world.managers.maps.GridManager import GridManager
from utils.Logger import Logger


class QuestGiverChooseRewardHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        # CGPlayer_C::GetQuestReward
        if len(reader.data) >= 16:  # Avoid handling empty quest fiver choose reward packet
            quest_giver_guid, quest_id, item_choice = unpack('<Q2I', reader.data[:16])
            quest_giver = GridManager.get_surrounding_unit_by_guid(world_session.player_mgr, quest_giver_guid)
            if not quest_giver:
                Logger.error(f'Error in CMSG_QUESTGIVER_COMPLETE_QUEST, could not find quest giver with guid of: {quest_giver_guid}')
                return 0
            if world_session.player_mgr.is_enemy_to(quest_giver):
                return 0

            world_session.player_mgr.quest_manager.handle_choose_reward(quest_giver_guid, quest_id, item_choice)
        return 0
