from game.world.opcode_handling.HandlerValidator import HandlerValidator
from struct import unpack

from game.world.managers.objects.units.player.taxi.TaxiManager import TaxiManager
from utils.Formulas import Distances
from utils.constants.MiscCodes import NpcFlags


class TaxiNodeStatusQueryHandler:

    @staticmethod
    def handle(world_session, reader):
        if not world_session or not world_session.player_mgr:
            return 0

        # Avoid handling an empty taxi node status query packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=8):
            return 0

        guid = unpack('<Q', reader.data[:8])[0]
        if guid <= 0:
            return 0

        player_mgr = world_session.player_mgr
        if not player_mgr.is_alive:
            return 0

        flight_master = player_mgr.get_map().get_surrounding_unit_by_guid(player_mgr, guid)
        if not flight_master:
            return 0
        if not Distances.is_within_shop_distance(player_mgr, flight_master):
            return 0
        if (flight_master.get_npc_flags() & NpcFlags.NPC_FLAG_FLIGHTMASTER) == 0:
            return 0

        node = TaxiManager.get_nearest_taxi_node(player_mgr)
        if node == -1:
            return 0

        player_mgr.taxi_manager.handle_node_status_query(guid, node)

        return 0
