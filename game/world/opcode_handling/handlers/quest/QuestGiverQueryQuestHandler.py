from struct import unpack, pack

from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.GridManager import GridManager
# from game.world.managers.objects.player.InventoryManager import InventoryManager

from utils.Logger import Logger
from utils.constants import ObjectCodes

from network.packet.PacketWriter import PacketWriter, OpCode


class QuestGiverQueryQuestHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 8:  # Avoid handling empty quest giver hello packet
            guid, quest_entry = unpack('<QL', reader.data[:12])
            # quest giver is an npc or an item
            quest_giver = GridManager.get_surrounding_unit_by_guid(world_session.player_mgr, guid) or world_session.player_mgr.inventory.get_item_info_by_guid(guid)[3].item_template
            if not quest_giver:
                Logger.error("Error in CMSG_QUESTGIVER_QUERY_QUEST, could not find quest giver with guid of: %u" % guid)
                return 0

            quest_giver_is_related = world_session.player_mgr.quest_manager.check_quest_giver_npc_is_related(quest_giver.entry, quest_entry) or quest_giver.start_quest == quest_entry
            if not quest_giver_is_related:
                Logger.error("Error in CMSG_QUESTGIVER_QUERY_QUEST, quest giver %u was not related to quest %u" % (quest_giver.entry, quest_entry))
                return 0

            quest = WorldDatabaseManager.quest_get_by_entry(quest_entry)
            if not quest:
                Logger.error("Error in CMSG_QUESTGIVER_QUERY_QUEST, could not find quest with an entry of: %u" % quest_entry)
                return 0
 
            world_session.player_mgr.quest_manager.send_quest_giver_quest_details(quest, guid, True)

        return 0

