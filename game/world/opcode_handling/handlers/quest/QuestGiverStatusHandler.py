from struct import unpack
from game.world.opcode_handling.HandlerValidator import HandlerValidator
from utils.GuidUtils import GuidUtils
from utils.Logger import Logger
from utils.constants.MiscCodes import HighGuid


class QuestGiverStatusHandler(object):

    @staticmethod
    def handle(world_session, reader):
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode)
        if not player_mgr:
            return res

        if len(reader.data) >= 8:  # Avoid handling empty quest giver status packet.
            guid = unpack('<Q', reader.data[:8])[0]

            quest_giver = None
            # Use player known objects first.
            if guid in player_mgr.known_objects:
                quest_giver = player_mgr.known_objects[guid]
            else:
                high_guid = GuidUtils.try_get_high_guid(guid)
                if not high_guid:
                    Logger.error(f'Error in {reader.opcode_str()}, invalid guid: {guid}, loc {player_mgr.location}.')
                    return 0
                if high_guid == HighGuid.HIGHGUID_ITEM:
                    quest_giver = player_mgr.inventory.get_item_by_guid(guid)
                elif high_guid == HighGuid.HIGHGUID_UNIT or high_guid == HighGuid.HIGHGUID_PET:
                    quest_giver = player_mgr.get_map().get_surrounding_unit_by_guid(player_mgr, guid)
                elif high_guid == HighGuid.HIGHGUID_GAMEOBJECT:
                    quest_giver = player_mgr.get_map().get_surrounding_gameobject_by_guid(player_mgr, guid)

            if not quest_giver:
                Logger.error(f'Error in {reader.opcode_str()}, could not find quest giver with guid of: {guid}')
                return 0

            # Only units are able to provide quest status.
            if player_mgr and quest_giver.is_unit():
                quest_giver_status = player_mgr.quest_manager.get_dialog_status(quest_giver)
                player_mgr.quest_manager.send_quest_giver_status(guid, quest_giver_status)

        return 0
