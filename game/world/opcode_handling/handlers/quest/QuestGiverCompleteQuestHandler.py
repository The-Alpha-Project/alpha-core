from struct import unpack
from game.world.managers.objects.ObjectManager import ObjectManager
from game.world.managers.maps.MapManager import MapManager
from utils.Logger import Logger
from utils.constants.MiscCodes import HighGuid


class QuestGiverCompleteQuestHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 12:  # Avoid handling empty quest giver complete quest packet.
            guid, quest_id = unpack ('<QI', reader.data[:12])
            high_guid = ObjectManager.extract_high_guid(guid)

            quest_giver = None
            if high_guid == HighGuid.HIGHGUID_UNIT:
                quest_giver = MapManager.get_surrounding_unit_by_guid(world_session.player_mgr, guid)
            elif high_guid == HighGuid.HIGHGUID_GAMEOBJECT:
                quest_giver = MapManager.get_surrounding_gameobject_by_guid(world_session.player_mgr, guid)

            if not quest_giver:
                Logger.error(f'Error in CMSG_QUESTGIVER_COMPLETE_QUEST, could not find quest giver with guid of: {guid}')
                return 0
            if world_session.player_mgr.is_enemy_to(quest_giver):
                return 0

            world_session.player_mgr.quest_manager.handle_complete_quest(quest_id, guid)
        return 0
