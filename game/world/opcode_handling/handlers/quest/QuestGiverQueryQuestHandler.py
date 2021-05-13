from struct import unpack

from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.maps.MapManager import MapManager
from utils.Logger import Logger

from utils.constants.ObjectCodes import HighGuid


class QuestGiverQueryQuestHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 8:  # Avoid handling empty quest giver query quest packet.
            guid, quest_entry = unpack('<QL', reader.data[:12])
            # NPC
            if guid & HighGuid.HIGHGUID_UNIT:
                quest_giver = MapManager.get_surrounding_unit_by_guid(world_session.player_mgr, guid)
                if not quest_giver:
                    return 0

                quest_giver_is_related = world_session.player_mgr.quest_manager.check_quest_giver_npc_is_related(
                    quest_giver.entry, quest_entry)
                if not quest_giver_is_related:
                    return 0
            # Gameobject
            elif guid & HighGuid.HIGHGUID_GAMEOBJECT:
                quest_giver = MapManager.get_surrounding_gameobject_by_guid(world_session, guid)
                if not quest_giver:
                    return 0
            # Item
            elif guid & HighGuid.HIGHGUID_ITEM:
                item_info = world_session.player_mgr.inventory.get_item_info_by_guid(guid)
                if not item_info[3]:
                    return 0

                quest_giver = item_info[3].item_template
                quest_giver_is_related = quest_giver.start_quest == quest_entry
                if not quest_giver_is_related:
                    return 0
            else:
                Logger.error(f'Error in CMSG_QUESTGIVER_QUERY_QUEST, unknown quest giver type.')
                return 0

            quest = WorldDatabaseManager.QuestTemplateHolder.quest_get_by_entry(quest_entry)
            if not quest:
                Logger.error(f'Error in CMSG_QUESTGIVER_QUERY_QUEST, could not find quest with an entry of: {quest_entry}')
                return 0
 
            world_session.player_mgr.quest_manager.send_quest_giver_quest_details(quest, guid, True)

        return 0

