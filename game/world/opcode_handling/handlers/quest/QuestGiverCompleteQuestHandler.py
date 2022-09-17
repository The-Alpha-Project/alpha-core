from struct import unpack
from game.world.managers.maps.MapManager import MapManager
from game.world.opcode_handling.HandlerValidator import HandlerValidator
from utils.GuidUtils import GuidUtils
from utils.Logger import Logger
from utils.constants.MiscCodes import HighGuid


class QuestGiverCompleteQuestHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode)
        if not player_mgr:
            return res

        if len(reader.data) >= 12:  # Avoid handling empty quest giver complete quest packet.
            guid, quest_id = unpack('<QI', reader.data[:12])
            high_guid = GuidUtils.extract_high_guid(guid)
            is_item = False

            quest_giver = None
            if high_guid == HighGuid.HIGHGUID_UNIT:
                quest_giver = MapManager.get_surrounding_unit_by_guid(player_mgr, guid)
            elif high_guid == HighGuid.HIGHGUID_GAMEOBJECT:
                quest_giver = MapManager.get_surrounding_gameobject_by_guid(player_mgr, guid)
            elif high_guid == HighGuid.HIGHGUID_ITEM:
                is_item = True
                quest_giver = player_mgr.inventory.get_item_by_guid(guid)

            if not quest_giver:
                Logger.error(f'Error in CMSG_QUESTGIVER_COMPLETE_QUEST, could not find quest giver with guid of: {guid}.')
                return 0
            if not is_item and player_mgr.is_hostile_to(quest_giver):
                return 0

            player_mgr.quest_manager.handle_complete_quest(quest_id, guid)
        return 0
