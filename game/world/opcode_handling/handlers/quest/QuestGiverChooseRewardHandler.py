from struct import unpack
from game.world.managers.objects.ObjectManager import ObjectManager
from utils.constants.MiscCodes import HighGuid
from game.world.managers.maps.MapManager import MapManager
from utils.Logger import Logger


class QuestGiverChooseRewardHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        # CGPlayer_C::GetQuestReward
        if len(reader.data) >= 16:  # Avoid handling empty quest giver choose reward packet.
            guid, quest_id, item_choice = unpack('<Q2I', reader.data[:16])
            high_guid = ObjectManager.extract_high_guid(guid)
            is_item = False

            quest_giver = None
            if high_guid == HighGuid.HIGHGUID_UNIT:
                quest_giver = MapManager.get_surrounding_unit_by_guid(world_session.player_mgr, guid)
            elif high_guid == HighGuid.HIGHGUID_GAMEOBJECT:
                quest_giver = MapManager.get_surrounding_gameobject_by_guid(world_session.player_mgr, guid)
            elif high_guid == HighGuid.HIGHGUID_ITEM:
                is_item = True
                quest_giver = world_session.player_mgr.inventory.get_item_by_guid(guid)

            if not quest_giver:
                Logger.error(f'Error in CMSG_QUESTGIVER_COMPLETE_QUEST, could not find quest giver with guid of: {guid}')
                return 0

            if not is_item and world_session.player_mgr.is_enemy_to(quest_giver):
                return 0

            world_session.player_mgr.quest_manager.handle_choose_reward(quest_giver, quest_id, item_choice)
        return 0
