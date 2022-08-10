from struct import unpack
from game.world.managers.objects.ObjectManager import ObjectManager
from game.world.managers.maps.MapManager import MapManager
from utils.constants.MiscCodes import HighGuid
from utils.Logger import Logger


class QuestGiverHelloHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 8:  # Avoid handling empty quest giver hello packet.
            guid = unpack('<Q', reader.data[:8])[0]
            high_guid = ObjectManager.extract_high_guid(guid)
            is_item = False

            quest_giver = None
            if high_guid == HighGuid.HIGHGUID_UNIT:
                quest_giver = MapManager.get_surrounding_unit_by_guid(world_session.player_mgr, guid)
            elif high_guid == HighGuid.HIGHGUID_GAMEOBJECT:
                quest_giver = MapManager.get_surrounding_gameobject_by_guid(world_session.player_mgr, guid)
            elif high_guid == HighGuid.HIGHGUID_ITEM:
                is_item = True
                quest_giver = world_session.player_mgr.inventory.get_item_by_guid(guid)

            if not quest_giver:
                Logger.error(f'Error in CMSG_QUESTGIVER_HELLO, could not find quest giver with guid of: {guid}')
                return 0
            if not is_item and world_session.player_mgr.is_hostile_to(quest_giver):
                return 0

            # TODO: Stop the npc if it's moving
            # TODO: Remove feign death from player
            # TODO: If the gossip menu is already open, do nothing
            if quest_giver.is_within_interactable_distance(world_session.player_mgr):
                world_session.player_mgr.quest_manager.handle_quest_giver_hello(quest_giver, guid)

        return 0
