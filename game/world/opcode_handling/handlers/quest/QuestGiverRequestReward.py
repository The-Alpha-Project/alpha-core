from struct import unpack
from game.world.managers.objects.ObjectManager import ObjectManager
from utils.constants.MiscCodes import HighGuid
from game.world.managers.maps.MapManager import MapManager
from utils.Logger import Logger


class QuestGiverRequestReward(object):

    @staticmethod
    def handle(world_session, socket, reader):
        player_mgr = world_session.player_mgr
        # No player linked to session requester.
        if not player_mgr:
            Logger.warning('QuestGiverRequestReward received with null player_mgr.')
            return 0

        if len(reader.data) >= 12:  # Avoid handling empty quest giver request reward packet.
            guid, quest_id = unpack('<QI', reader.data[:12])
            high_guid = ObjectManager.extract_high_guid(guid)
            is_item = False

            quest_giver = None
            if high_guid == HighGuid.HIGHGUID_UNIT:
                quest_giver = MapManager.get_surrounding_unit_by_guid(player_mgr, guid)
            elif high_guid == HighGuid.HIGHGUID_GAMEOBJECT:
                quest_giver = MapManager.get_surrounding_gameobject_by_guid(player_mgr, guid)
            elif high_guid == HighGuid.HIGHGUID_ITEM:
                is_item = True
                quest_giver = player_mgr.inventory.get_item_by_guid(guid)

            if not quest_giver:
                Logger.error(f'Error in CMSG_QUESTGIVER_REQUEST_REWARD, could not find quest giver with guid: {guid}')
                return 0

            if not is_item and player_mgr.is_enemy_to(quest_giver):
                return 0

            player_mgr.quest_manager.handle_request_reward(guid, quest_id)
        return 0
