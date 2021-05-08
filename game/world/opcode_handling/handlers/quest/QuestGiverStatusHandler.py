from struct import unpack

from game.world.managers.maps.GridManager import GridManager
from utils.Logger import Logger
from utils.constants.ObjectCodes import ObjectTypes, QuestGiverStatus, HighGuid


class QuestGiverStatusHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 8:  # Avoid handling empty quest giver status packet
            quest_giver_guid = unpack('<Q', reader.data[:8])[0]
            quest_giver = None
            # NPC
            if quest_giver_guid & HighGuid.HIGHGUID_UNIT:
                quest_giver = GridManager.get_surrounding_unit_by_guid(world_session.player_mgr, quest_giver_guid)
            # Gameobject
            elif quest_giver_guid & HighGuid.HIGHGUID_GAMEOBJECT:
                quest_giver = GridManager.get_surrounding_gameobject_by_guid(world_session.player_mgr, quest_giver_guid)
            if not quest_giver:
                return 0

            quest_giver_status = QuestGiverStatus.QUEST_GIVER_NONE
            if world_session.player_mgr:
                if quest_giver.get_type() == ObjectTypes.TYPE_UNIT:
                    quest_giver_status = world_session.player_mgr.quest_manager.get_dialog_status(quest_giver)
                elif quest_giver.get_type() == ObjectTypes.TYPE_GAMEOBJECT:
                    # TODO: Proper handling for game object
                    quest_giver_status = QuestGiverStatus.QUEST_GIVER_NONE
                else:
                    Logger.error(f'Error in CMSG_QUESTGIVER_STATUS_QUERY, quest giver was an unexpected type of: {quest_giver.object_type}')

                world_session.player_mgr.quest_manager.send_quest_giver_status(quest_giver_guid, quest_giver_status)

        return 0
