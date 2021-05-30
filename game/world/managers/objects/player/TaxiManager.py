from struct import pack, unpack
from bitarray import bitarray
from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from network.packet.PacketWriter import PacketWriter, OpCode


class TaxiManager(object):
    def __init__(self, player_mgr):
        self.owner = player_mgr
        self.available_taxi_nodes = bitarray(64, 'little')
        self.available_taxi_nodes.setall(0)

    def has_node(self, node):
        return self.available_taxi_nodes[node]

    def add_taxi(self, node):
        self.available_taxi_nodes[node] = True

    def handle_query_node(self, flight_master_guid, node):
        if not self.has_node(node):
            self.add_taxi(node)
            # Notify new taxi path discovered
            self.owner.session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_NEW_TAXI_PATH))
            # Update flight master status
            data = pack('<QB', flight_master_guid, 1)
            self.owner.session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_TAXINODE_STATUS, data))
        else:
            # TODO: Find out how 'flags' and 'known' field correlate,
            #  for now we just display every available flightpath.
            self.available_taxi_nodes.setall(1)

            data = pack(
                f'<IQIQQ',
                1,  # Show map
                flight_master_guid,  # NPC taxi guid
                node,  # Current node
                unpack('<Q', self.available_taxi_nodes.tobytes())[0],  # Flags, nodes to which you could fly to?
                unpack('<Q', self.available_taxi_nodes.tobytes())[0],  # Known, current discovered nodes?
            )

            self.owner.session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_SHOWTAXINODES, data))

    def handle_node_status_query(self, flight_master_guid, node):
        data = pack(
            f'<QB',
            flight_master_guid,  # NPC taxi guid
            0 if self.has_node(node) else 1  # Available path '!' Green icon.
        )

        packet = PacketWriter.get_packet(OpCode.SMSG_TAXINODE_STATUS, data)
        self.owner.session.enqueue_packet(packet)

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
