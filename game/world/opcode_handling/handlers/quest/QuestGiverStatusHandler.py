from struct import unpack, pack

from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.GridManager import GridManager
from utils.Logger import Logger
from utils.constants.ObjectCodes import ObjectTypes, QuestGiverStatuses

from network.packet.PacketWriter import PacketWriter, OpCode


class QuestGiverStatusHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 8:  # Avoid handling empty set selection packet
            quest_giver_guid = unpack('<Q', reader.data[:8])[0]
            quest_giver_npc = GridManager.get_surrounding_unit_by_guid(world_session.player_mgr, quest_giver_guid)
            if not quest_giver_npc:
                Logger.error("Error in OpCode CMSG_QUESTGIVER_STATUS_QUERY, could not find quest giver with guid of: %s"%(quest_giver_guid))
                return 0

            if world_session.player_mgr:
                if ObjectTypes.TYPE_UNIT in quest_giver_npc.object_type:
                    quest_giver_status = world_session.player_mgr.quests.get_dialog_status(quest_giver_npc)
                elif ObjectTypes.TYPE_GAMEOBJECT in quest_giver_npc.object_type:
                    #   TODO: Proper handling for game object. However, it may be possible that the alpha client does not send status queries for game objects
                    quest_giver_status = QuestGiverStatuses.QUEST_GIVER_NONE
                else:
                    Logger.error("Error in OpCode CMSG_QUESTGIVER_STATUS_QUERY, quest giver was an unexpected type of: %s" %(quest_giver_npc.object_type))

                world_session.player_mgr.quests.send_quest_status(quest_giver_guid, quest_giver_status)

        return 0