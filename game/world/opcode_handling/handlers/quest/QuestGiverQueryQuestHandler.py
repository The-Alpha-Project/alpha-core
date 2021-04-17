from struct import unpack, pack

from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.GridManager import GridManager
from utils.Logger import Logger
from utils.constants import ObjectCodes

from network.packet.PacketWriter import PacketWriter, OpCode


class QuestGiverQueryQuestHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 8:  # Avoid handling empty quest giver query quest packet
            guid, quest_entry = unpack('<QL', reader.data[:12])
            # Quest giver is an NPC or an item
            quest_giver = GridManager.get_surrounding_unit_by_guid(world_session.player_mgr, guid) or world_session.player_mgr.inventory.get_item_info_by_guid(guid)[3].item_template
            if not quest_giver:
                Logger.error(f'Error in CMSG_QUESTGIVER_QUERY_QUEST, could not find quest giver with guid of: {guid}')
                return 0

            quest_giver_is_related = world_session.player_mgr.quest_manager.check_quest_giver_npc_is_related(quest_giver.entry, quest_entry) or quest_giver.start_quest == quest_entry
            if not quest_giver_is_related:
                Logger.error(f'Error in CMSG_QUESTGIVER_QUERY_QUEST, quest giver {quest_giver.entry} was not related to quest {quest_entry}')
                return 0

            quest = WorldDatabaseManager.QuestTemplateHolder.quest_get_by_entry(quest_entry)
            if not quest:
                Logger.error(f'Error in CMSG_QUESTGIVER_QUERY_QUEST, could not find quest with an entry of: {quest_entry}')
                return 0
 
            world_session.player_mgr.quest_manager.send_quest_giver_quest_details(quest, guid, True)

        return 0

