from struct import unpack, pack
from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from game.world.opcode_handling.HandlerValidator import HandlerValidator
from network.packet.PacketWriter import PacketWriter
from utils.constants.MiscCodes import ActivateTaxiReplies
from utils.constants.OpCodes import OpCode


class ActivateTaxiHandler:
    @staticmethod
    def handle(world_session, reader):
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode, disconnect=True)
        if not player_mgr:
            return res

        if len(reader.data) >= 16:  # Avoid handling empty activate taxi packet.
            guid, start_node, dest_node = unpack('<Q2I', reader.data[:16])
            flight_master = player_mgr.get_map().get_surrounding_unit_by_guid(player_mgr, guid)

            if not flight_master:
                return 0

            result = ActivateTaxiReplies.ERR_TAXIOK

            if player_mgr.in_combat:
                result = ActivateTaxiReplies.ERR_TAXIPLAYERBUSY
            elif ActivateTaxiHandler._is_blocked_by_shapeshift(player_mgr):
                result = ActivateTaxiReplies.ERR_TAXIPLAYERSHAPESHIFTED
            elif player_mgr.mount_display_id > 0:
                result = ActivateTaxiReplies.ERR_TAXIPLAYERALREADYMOUNTED

            taxi_path = None
            if result == ActivateTaxiReplies.ERR_TAXIOK:
                taxi_path = DbcDatabaseManager.taxi_path_get(start_node, dest_node)
                if not taxi_path:
                    result = ActivateTaxiReplies.ERR_TAXINOSUCHPATH

            if result == ActivateTaxiReplies.ERR_TAXIOK and player_mgr.coinage < taxi_path.Cost:
                result = ActivateTaxiReplies.ERR_TAXINOTENOUGHMONEY

            if result == ActivateTaxiReplies.ERR_TAXIOK:
                player_mgr.mod_money(-taxi_path.Cost)
                player_mgr.taxi_manager.begin_taxi_flight(taxi_path, start_node, dest_node, flight_master=flight_master)

            data = pack('<I', result)
            player_mgr.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_ACTIVATETAXIREPLY, data))

        return 0

    @staticmethod
    def _is_blocked_by_shapeshift(player_mgr):
        if not player_mgr.shapeshift_form:
            return False

        form_entry = DbcDatabaseManager.spell_shapeshift_form_get_by_id(player_mgr.shapeshift_form)
        # Stances are shapeshifts in dbc but should not block taxi usage.
        return not (form_entry and (form_entry.Flags & 1))
