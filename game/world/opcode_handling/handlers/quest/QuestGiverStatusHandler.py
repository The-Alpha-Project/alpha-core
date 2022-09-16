from struct import unpack
from game.world.managers.maps.MapManager import MapManager
from game.world.opcode_handling.HandlerValidator import HandlerValidator
from utils.GuidUtils import GuidUtils
from utils.Logger import Logger
from utils.constants.MiscCodes import HighGuid, ObjectTypeIds


class QuestGiverStatusHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode)
        if not player_mgr:
            return res

        if len(reader.data) >= 8:  # Avoid handling empty quest giver status packet.
            guid = unpack('<Q', reader.data[:8])[0]
            high_guid = GuidUtils.extract_high_guid(guid)

            quest_giver = None
            if high_guid == HighGuid.HIGHGUID_UNIT:
                quest_giver = MapManager.get_surrounding_unit_by_guid(player_mgr, guid)
            elif high_guid == HighGuid.HIGHGUID_GAMEOBJECT:
                quest_giver = MapManager.get_surrounding_gameobject_by_guid(player_mgr, guid)
            elif high_guid == HighGuid.HIGHGUID_ITEM:
                quest_giver = player_mgr.inventory.get_item_by_guid(guid)

            if not quest_giver:
                Logger.error(f'Error in CMSG_QUESTGIVER_STATUS_QUERY, could not find quest giver with guid of: {guid}')
                return 0

            # Only units are able to provide quest status.
            if player_mgr and quest_giver.get_type_id() == ObjectTypeIds.ID_UNIT:
                quest_giver_status = player_mgr.quest_manager.get_dialog_status(quest_giver)
                player_mgr.quest_manager.send_quest_giver_status(guid, quest_giver_status)

        return 0
