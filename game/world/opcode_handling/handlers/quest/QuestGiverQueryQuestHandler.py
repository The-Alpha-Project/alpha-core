from struct import unpack, pack

from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.GridManager import GridManager
from utils.Logger import Logger
from utils.constants import ObjectCodes

from network.packet.PacketWriter import PacketWriter, OpCode


class QuestGiverQueryQuestHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 8:  # Avoid handling empty quest giver hello packet
            guid, quest_entry = unpack('<QL', reader.data[:12])
            print("guid: %s" %(guid))
            print("quest_entry: %s" %(quest_entry))
            # TODO: If not a surrounding unit, use guid to get an item
            quest_giver = GridManager.get_surrounding_unit_by_guid(world_session.player_mgr, guid)
            if not quest_giver:
                Logger.error("Error in CMSG_QUESTGIVER_QUERY_QUEST, could not find quest giver with guid of: %u" % guid)
                return 0

            # TODO: check whether the quest giver is related to the quest_entry, if not, close the gossip
            
            quest = WorldDatabaseManager.quest_get_by_entry(quest_entry)
            if not quest:
                Logger.error("Error in CMSG_QUESTGIVER_QUERY_QUEST, could not find quest with an entry of: %u" % quest_entry)
                return 0
 
            world_session.player_mgr.quest_manager.send_quest_giver_quest_details(quest, guid, True)

        return 0

