from struct import unpack, pack

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from game.world.managers.abstractions.Vector import Vector
from network.packet.PacketWriter import PacketWriter
from utils.ConfigManager import config
from utils.constants.MiscCodes import ActivateTaxiReplies
from utils.constants.OpCodes import OpCode
from utils.constants.UnitCodes import SplineFlags, UnitFlags
from utils.constants.UpdateFields import UnitFields

GRYPHON_DISPLAY_ID = 1149


class ActivateTaxiHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 16:  # Avoid handling empty activate taxi packet.
            guid, start_node, dest_node = unpack('<Q2I', reader.data[:16])
            if guid <= 0:
                return

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

            data = pack('<I', result)
            world_session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_ACTIVATETAXIREPLY, data))

            if result == ActivateTaxiReplies.ERR_TAXIOK:
                world_session.player_mgr.mod_money(-taxi_path.Cost)
                waypoints = []
                taxi_path_nodes = DbcDatabaseManager.TaxiPathNodesHolder.taxi_nodes_get_by_path_id(taxi_path.ID)
                for taxi_path_node in taxi_path_nodes:
                    waypoints.append(Vector(taxi_path_node.LocX, taxi_path_node.LocY, taxi_path_node.LocZ))

                world_session.player_mgr.unit_flags |= UnitFlags.UNIT_FLAG_FROZEN | UnitFlags.UNIT_FLAG_TAXI_FLIGHT
                world_session.player_mgr.set_uint32(UnitFields.UNIT_FIELD_FLAGS, world_session.player_mgr.unit_flags)
                dest_taxi_node = DbcDatabaseManager.TaxiNodesHolder.taxi_nodes_get_by_map_and_id(
                    world_session.player_mgr.map_, dest_node)
                world_session.player_mgr.pending_taxi_destination = Vector(dest_taxi_node.X,
                                                                           dest_taxi_node.Y,
                                                                           dest_taxi_node.Z)
                world_session.player_mgr.mount(GRYPHON_DISPLAY_ID)
                world_session.player_mgr.set_dirty()

                world_session.player_mgr.movement_manager.send_move_to(waypoints,
                                                                       config.Unit.Player.Defaults.flight_speed,
                                                                       SplineFlags.SPLINEFLAG_FLYING)

        return 0
