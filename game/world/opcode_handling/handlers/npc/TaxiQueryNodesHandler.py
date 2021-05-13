from struct import pack, unpack

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from network.packet.PacketWriter import PacketWriter, OpCode


class TaxiQueryNodesHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 8:  # Avoid handling empty taxi query nodes packet.
            guid = unpack('<Q', reader.data[:8])[0]
            if guid <= 0:
                return 0

            node = TaxiQueryNodesHandler.get_nearest_taxi_node(world_session.player_mgr)
            if node == -1:
                return 0

            data = pack(
                '<IQI',
                1,  # Show map
                guid,  # NPC taxi guid
                node,  # Node location
            )
            world_session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_SHOWTAXINODES, data))

        return 0

    @staticmethod
    def get_nearest_taxi_node(player_mgr):
        taxi_nodes = DbcDatabaseManager.TaxiNodesHolder.taxi_nodes_get_by_map(player_mgr.map_)
        last_near_distance = -1
        last_near_taxi_node_id = -1
        for taxi_node_id, taxi_node in taxi_nodes:
            distance = player_mgr.location.distance(x=taxi_node.X, y=taxi_node.Y, z=taxi_node.Z)
            if distance < last_near_distance or last_near_distance == -1:
                last_near_distance = distance
                last_near_taxi_node_id = taxi_node_id

        return last_near_taxi_node_id
