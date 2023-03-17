from struct import unpack
from game.world.managers.maps.MapManager import MapManager
from game.world.opcode_handling.HandlerValidator import HandlerValidator
from utils.GuidUtils import GuidUtils
from utils.constants.MiscCodes import HighGuid, ObjectTypeIds
from utils.Logger import Logger


class QuestGiverHelloHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode)
        if not player_mgr:
            return res

        if len(reader.data) >= 8:  # Avoid handling empty quest giver hello packet.
            guid = unpack('<Q', reader.data[:8])[0]

            is_item = False
            quest_giver = None
            # Use player known objects first.
            if guid in player_mgr.known_objects:
                quest_giver = player_mgr.known_objects[guid]
            else:
                high_guid = GuidUtils.extract_high_guid(guid)
                if high_guid == HighGuid.HIGHGUID_ITEM:
                    is_item = True
                    quest_giver = player_mgr.inventory.get_item_by_guid(guid)
                elif high_guid == HighGuid.HIGHGUID_UNIT:
                    quest_giver = MapManager.get_surrounding_unit_by_guid(player_mgr, guid)
                elif high_guid == HighGuid.HIGHGUID_GAMEOBJECT:
                    quest_giver = MapManager.get_surrounding_gameobject_by_guid(player_mgr, guid)

            if not quest_giver:
                Logger.error(f'Error in {reader.opcode_str()}, could not find quest giver with guid of: {guid}')
                return 0
            if not is_item and player_mgr.is_hostile_to(quest_giver):
                Logger.warning(f'{reader.opcode_str()}, quest giver with guid: {guid} is hostile.')
                return 0

            # TODO: Remove feign death from player
            # TODO: If the gossip menu is already open, do nothing
            if is_item or quest_giver.is_within_interactable_distance(player_mgr):
                # Pause the NPCs movement when a player attempts to talk to them
                # TODO: 60 seconds is an arbitrary value, what's the real one?
                if quest_giver.get_type_id() == ObjectTypeIds.ID_UNIT:
                    quest_giver.movement_manager.try_pause_ooc_movement(60)
                player_mgr.quest_manager.handle_quest_giver_hello(quest_giver, guid)

        return 0
