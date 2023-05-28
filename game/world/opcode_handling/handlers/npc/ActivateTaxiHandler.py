from struct import unpack, pack
from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from game.world.managers.maps.MapManager import MapManager
from network.packet.PacketWriter import PacketWriter
from utils.constants.MiscCodes import ActivateTaxiReplies
from utils.constants.OpCodes import OpCode


class ActivateTaxiHandler(object):

    @staticmethod
    def handle(world_session, reader):
        if len(reader.data) >= 16:  # Avoid handling empty activate taxi packet.
            guid, start_node, dest_node = unpack('<Q2I', reader.data[:16])
            flight_master = MapManager.get_surrounding_unit_by_guid(world_session.player_mgr, guid)

            if not flight_master:
                return 0

            result = ActivateTaxiReplies.ERR_TAXIOK

            if world_session.player_mgr.in_combat:
                result = ActivateTaxiReplies.ERR_TAXIPLAYERBUSY
            elif world_session.player_mgr.mount_display_id > 0:
                result = ActivateTaxiReplies.ERR_TAXIPLAYERALREADYMOUNTED

            taxi_path = DbcDatabaseManager.taxi_path_get(start_node, dest_node)
            if not taxi_path:
                result = ActivateTaxiReplies.ERR_TAXINOSUCHPATH

            if world_session.player_mgr.coinage < taxi_path.Cost:
                result = ActivateTaxiReplies.ERR_TAXINOTENOUGHMONEY

            if result == ActivateTaxiReplies.ERR_TAXIOK:
                world_session.player_mgr.mod_money(-taxi_path.Cost)
                world_session.player_mgr.taxi_manager.begin_taxi_flight(taxi_path, start_node, dest_node,
                                                                        flight_master=flight_master)

            data = pack('<I', result)
            world_session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_ACTIVATETAXIREPLY, data))

        return 0
