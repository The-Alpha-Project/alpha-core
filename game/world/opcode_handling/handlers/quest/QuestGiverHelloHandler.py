from struct import unpack

from game.world.managers.maps.MapManager import MapManager
from utils.Logger import Logger


class QuestGiverHelloHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 8:  # Avoid handling empty quest giver hello packet.
            guid = unpack('<Q', reader.data[:8])[0]
            quest_giver = MapManager.get_surrounding_unit_by_guid(world_session.player_mgr, guid)
            if not quest_giver:
                Logger.error(f'Error in CMSG_QUESTGIVER_HELLO, could not find quest giver with guid of: {guid}')
                return 0
            if world_session.player_mgr.is_enemy_to(quest_giver):
                return 0

            # TODO: Stop the npc if it's moving
            # TODO: Remove feign death from player (if it even exists in 0.5.3)
            # TODO: If the gossip menu is already open, do nothing
            if quest_giver.is_within_interactable_distance(world_session.player_mgr):
                world_session.player_mgr.quest_manager.prepare_quest_giver_gossip_menu(quest_giver, guid)

        return 0
