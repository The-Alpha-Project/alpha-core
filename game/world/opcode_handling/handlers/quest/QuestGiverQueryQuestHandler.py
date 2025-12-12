from struct import unpack
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.opcode_handling.HandlerValidator import HandlerValidator
from utils.GuidUtils import GuidUtils
from utils.Logger import Logger
from utils.constants.MiscCodes import HighGuid


class QuestGiverQueryQuestHandler:

    @staticmethod
    def handle(world_session, reader):
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode)
        if not player_mgr:
            return res

        if len(reader.data) >= 8:  # Avoid handling empty quest giver query quest packet.
            guid, quest_entry = unpack('<QL', reader.data[:12])

            quest = WorldDatabaseManager.QuestTemplateHolder.quest_get_by_entry(quest_entry)
            if not quest:
                Logger.error(f'Error in {reader.opcode_str()}, could not find quest with an entry of: {quest_entry}')
                return 0

            quest_giver = None
            # Use player known objects first.
            if guid in player_mgr.known_objects:
                quest_giver = player_mgr.known_objects[guid]

            high_guid = GuidUtils.try_get_high_guid(guid)
            if not high_guid:
                Logger.error(f'Error in {reader.opcode_str()}, invalid guid: {guid}, loc {player_mgr.location}.')
                return 0

            if high_guid == HighGuid.HIGHGUID_UNIT or high_guid == HighGuid.HIGHGUID_PET:
                quest_giver = quest_giver if quest_giver else player_mgr.get_map().get_surrounding_unit_by_guid(player_mgr, guid)
                if not quest_giver:
                    return 0
                elif not player_mgr.quest_manager.check_quest_giver_npc_is_related(quest_giver, quest_entry):
                    return 0
            elif high_guid == HighGuid.HIGHGUID_GAMEOBJECT:
                quest_giver = quest_giver if quest_giver else player_mgr.get_map().get_surrounding_gameobject_by_guid(player_mgr, guid)
                if not quest_giver:
                    return 0
            elif high_guid == HighGuid.HIGHGUID_ITEM:
                quest_giver = quest_giver if quest_giver else player_mgr.inventory.get_item_by_guid(guid)
                if not quest_giver:
                    return 0
                if not quest_giver.item_template.start_quest == quest_entry:
                    return 0
            else:
                Logger.error(f'Error in {reader.opcode_str()}, unknown quest giver type.')
                return 0
 
            player_mgr.quest_manager.send_quest_giver_quest_details(quest, guid, True)

        return 0
