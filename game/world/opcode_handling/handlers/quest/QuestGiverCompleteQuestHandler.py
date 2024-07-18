from struct import unpack
from game.world.opcode_handling.HandlerValidator import HandlerValidator
from utils.GuidUtils import GuidUtils
from utils.Logger import Logger
from utils.constants.MiscCodes import HighGuid


class QuestGiverCompleteQuestHandler(object):

    @staticmethod
    def handle(world_session, reader):
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode)
        if not player_mgr:
            return res

        if len(reader.data) >= 12:  # Avoid handling empty quest giver complete quest packet.
            guid, quest_id = unpack('<QI', reader.data[:12])

            is_item = False
            quest_giver = None
            # Use player known objects first.
            if guid in player_mgr.known_objects:
                quest_giver = player_mgr.known_objects[guid]
            else:
                if not GuidUtils.validate_guid(guid):
                    Logger.error(f'Error in {reader.opcode_str()}, invalid guid: {guid}.')
                    return 0
                high_guid = GuidUtils.extract_high_guid(guid)
                if high_guid == HighGuid.HIGHGUID_ITEM:
                    is_item = True
                    quest_giver = player_mgr.inventory.get_item_by_guid(guid)
                elif high_guid == HighGuid.HIGHGUID_UNIT or high_guid == HighGuid.HIGHGUID_PET:
                    quest_giver = player_mgr.get_map().get_surrounding_unit_by_guid(player_mgr, guid)
                elif high_guid == HighGuid.HIGHGUID_GAMEOBJECT:
                    quest_giver = player_mgr.get_map().get_surrounding_gameobject_by_guid(player_mgr, guid)

            if not quest_giver:
                Logger.error(f'Error in {reader.opcode_str()}, could not find quest giver with guid of: {guid}.')
                return 0
            if not is_item and player_mgr.is_hostile_to(quest_giver):
                Logger.warning(f'{reader.opcode_str()}, quest giver with guid: {guid} is hostile.')
                return 0

            if is_item or quest_giver.is_within_interactable_distance(player_mgr):
                player_mgr.quest_manager.handle_complete_quest(quest_id, guid)
        return 0
