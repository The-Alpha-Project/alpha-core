from game.world.opcode_handling.HandlerValidator import HandlerValidator
from struct import unpack
from game.world.managers.objects.units.creature.CreatureManager import CreatureManager
from game.world.managers.objects.units.player.taxi.TaxiManager import TaxiManager
from utils.Formulas import Distances
from utils.constants.MiscCodes import NpcFlags


class TaxiQueryNodesHandler:

    @staticmethod
    def handle(world_session, reader):
        if not world_session or not world_session.player_mgr:
            return 0

        # Avoid handling an empty taxi query nodes packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=8):
            return 0

        guid = unpack('<Q', reader.data[:8])[0]
        if guid <= 0:
            return 0

        player_mgr = world_session.player_mgr
        if not player_mgr.is_alive:
            return 0
        flight_master: CreatureManager = player_mgr.get_map().get_surrounding_unit_by_guid(player_mgr, guid)
        if not flight_master:
            return 0
        if (flight_master.get_npc_flags() & NpcFlags.NPC_FLAG_FLIGHTMASTER) == 0:
            return 0
        if not Distances.is_within_shop_distance(player_mgr, flight_master):
            return 0

        node = TaxiManager.get_nearest_taxi_node(player_mgr)
        if node == -1:
            return 0

        # Mark FP as discovered in case it hasn't been discovered yet.
        is_new_taxi = player_mgr.taxi_manager.discover_taxi(node, guid)

        # If flight master is a quest giver and player has an active quest involving this NPC, send quest window
        # instead of flying paths window.
        if flight_master.is_quest_giver():
            quests = player_mgr.quest_manager.get_active_quest_num_from_quest_giver(flight_master)
            if quests > 0:
                player_mgr.quest_manager.handle_quest_giver_hello(flight_master, guid)
                return 0

        # Only show the FP window if the node has not just been discovered by the first time.
        if is_new_taxi:
            return 0

        player_mgr.taxi_manager.handle_query_node(node, guid)

        return 0
