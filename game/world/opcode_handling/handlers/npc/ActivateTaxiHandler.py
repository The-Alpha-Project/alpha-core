from struct import unpack, pack
from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from game.world.opcode_handling.HandlerValidator import HandlerValidator
from network.packet.PacketWriter import PacketWriter
from utils.Formulas import Distances
from utils.constants.MiscCodes import ActivateTaxiReplies, NpcFlags
from utils.constants.OpCodes import OpCode


class ActivateTaxiHandler:
    @staticmethod
    def handle(world_session, reader):
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode, disconnect=True)
        if not player_mgr:
            return res

        # Avoid handling an empty activate taxi packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=16):
            return 0
        guid, start_node, dest_node = unpack('<Q2I', reader.data[:16])
        flight_master = player_mgr.get_map().get_surrounding_unit_by_guid(player_mgr, guid)

        result = ActivateTaxiReplies.ERR_TAXIOK

        # "You are too far away from the taxi stand!"
        if not flight_master:
            result = ActivateTaxiReplies.ERR_TAXITOOFARAWAY
        # "There is no taxi vendor nearby!"
        elif (flight_master.get_npc_flags() & NpcFlags.NPC_FLAG_FLIGHTMASTER) == 0:
            result = ActivateTaxiReplies.ERR_TAXINOVENDORNEARBY
        # "You are too far away from the taxi stand!"
        elif not Distances.is_within_shop_distance(player_mgr, flight_master):
            result = ActivateTaxiReplies.ERR_TAXITOOFARAWAY
        # "You are busy and can't use the taxi service now."
        elif player_mgr.in_combat:
            result = ActivateTaxiReplies.ERR_TAXIPLAYERBUSY
        # "You are in shapeshift form."
        elif ActivateTaxiHandler._is_blocked_by_shapeshift(player_mgr):
            result = ActivateTaxiReplies.ERR_TAXIPLAYERSHAPESHIFTED
        # "You are already mounted! Dismount first."
        elif player_mgr.mount_display_id > 0:
            result = ActivateTaxiReplies.ERR_TAXIPLAYERALREADYMOUNTED
        # "You are moving."
        elif player_mgr.is_moving():
            result = ActivateTaxiReplies.ERR_TAXIPLAYERMOVING
        # "You are already there!"
        elif start_node == dest_node:
            result = ActivateTaxiReplies.ERR_TAXISAMENODE
        # "You haven't reached that taxi node on foot yet!"
        elif not ActivateTaxiHandler._is_known_taxi_node(player_mgr, start_node) \
                or not ActivateTaxiHandler._is_known_taxi_node(player_mgr, dest_node):
            result = ActivateTaxiReplies.ERR_TAXINOTVISITED

        taxi_path = None
        if result == ActivateTaxiReplies.ERR_TAXIOK:
            taxi_path = DbcDatabaseManager.taxi_path_get(start_node, dest_node)
            # "There is no direct path to that destination!"
            if not taxi_path:
                result = ActivateTaxiReplies.ERR_TAXINOSUCHPATH

        # "You don't have enough money!"
        if result == ActivateTaxiReplies.ERR_TAXIOK and player_mgr.coinage < taxi_path.Cost:
            result = ActivateTaxiReplies.ERR_TAXINOTENOUGHMONEY

        if result == ActivateTaxiReplies.ERR_TAXIOK:
            player_mgr.mod_money(-taxi_path.Cost)
            player_mgr.taxi_manager.begin_taxi_flight(taxi_path, start_node, dest_node, flight_master=flight_master)

        data = pack('<I', result)
        player_mgr.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_ACTIVATETAXIREPLY, data))

        return 0

    @staticmethod
    def _is_known_taxi_node(player_mgr, taxi_node):
        known_nodes_count = len(player_mgr.taxi_manager.available_taxi_nodes)
        if taxi_node <= 0 or taxi_node > known_nodes_count:
            return False
        return player_mgr.taxi_manager.has_node(taxi_node)

    @staticmethod
    def _is_blocked_by_shapeshift(player_mgr):
        if not player_mgr.shapeshift_form:
            return False

        form_entry = DbcDatabaseManager.spell_shapeshift_form_get_by_id(player_mgr.shapeshift_form)
        # Stances are shapeshifts in dbc but should not block taxi usage.
        return not (form_entry and (form_entry.Flags & 1))
