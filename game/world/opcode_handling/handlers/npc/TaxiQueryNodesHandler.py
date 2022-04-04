from struct import unpack

from game.world.managers.maps.MapManager import MapManager
from game.world.managers.objects.units.creature.CreatureManager import CreatureManager
from game.world.managers.objects.units.player.taxi.TaxiManager import TaxiManager


class TaxiQueryNodesHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 8:  # Avoid handling empty taxi query nodes packet.
            guid = unpack('<Q', reader.data[:8])[0]
            if guid <= 0:
                return 0

            flight_master: CreatureManager = MapManager.get_surrounding_unit_by_guid(world_session.player_mgr, guid)
            if flight_master and flight_master.is_quest_giver():
                quests = world_session.player_mgr.quest_manager.get_active_quest_num_from_quest_giver(flight_master)
                if quests > 0:
                    world_session.player_mgr.quest_manager.handle_quest_giver_hello(flight_master, guid)
                    return 0

            node = TaxiManager.get_nearest_taxi_node(world_session.player_mgr)
            if node == -1:
                return 0

            world_session.player_mgr.taxi_manager.handle_query_node(guid, node)

        return 0
