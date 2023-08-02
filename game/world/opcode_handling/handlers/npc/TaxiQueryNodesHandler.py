from struct import unpack
from game.world.managers.objects.units.creature.CreatureManager import CreatureManager
from game.world.managers.objects.units.player.taxi.TaxiManager import TaxiManager


class TaxiQueryNodesHandler(object):

    @staticmethod
    def handle(world_session, reader):
        if len(reader.data) >= 8:  # Avoid handling empty taxi query nodes packet.
            guid = unpack('<Q', reader.data[:8])[0]
            if guid <= 0:
                return 0

            flight_master: CreatureManager = world_session.player_mgr.get_map().get_surrounding_unit_by_guid(world_session.player_mgr, guid)
            if not flight_master:
                return 0

            node = TaxiManager.get_nearest_taxi_node(world_session.player_mgr)
            if node == -1:
                return 0

            # Mark FP as discovered in case it hasn't been discovered yet.
            is_new_taxi = world_session.player_mgr.taxi_manager.discover_taxi(node, guid)

            # If flight master is a quest giver and player has an active quest involving this NPC, send quest window
            # instead of flying paths window.
            if flight_master.is_quest_giver():
                quests = world_session.player_mgr.quest_manager.get_active_quest_num_from_quest_giver(flight_master)
                if quests > 0:
                    world_session.player_mgr.quest_manager.handle_quest_giver_hello(flight_master, guid)
                    return 0

            # Only show the FP window if the node has not just been discovered by the first time.
            if not is_new_taxi:
                world_session.player_mgr.taxi_manager.handle_query_node(node, guid)

        return 0
