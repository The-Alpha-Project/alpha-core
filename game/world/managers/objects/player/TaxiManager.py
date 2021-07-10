from struct import pack, unpack
from bitarray import bitarray
from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.realm.RealmDatabaseManager import RealmDatabaseManager
from network.packet.PacketWriter import PacketWriter, OpCode


class TaxiManager(object):
    def __init__(self, player_mgr):
        self.owner = player_mgr
        self.available_taxi_nodes = bitarray(player_mgr.player.taximask, 'little')

    # Enable all taxi node bits, not persisted.
    def enable_all_taxi_nodes(self):
        count = 0
        for taxi_node_id, node in DbcDatabaseManager.TaxiNodesHolder.EASTERN_KINGDOMS_TAXI_NODES.items():
            if node.custom_team == self.owner.team.value:
                self.available_taxi_nodes[taxi_node_id - 1] = True
                count += 1
        for taxi_node_id, node in DbcDatabaseManager.TaxiNodesHolder.KALIMDOR_TAXI_NODES.items():
            if node.custom_team == self.owner.team.value:
                self.available_taxi_nodes[taxi_node_id - 1] = True
                count += 1
        return count

    # Disable all taxi node bits, not persisted.
    def disable_all_taxi_nodes(self):
        self.owner.available_taxi_nodes.setall(0)

    def has_node(self, node):
        # Apparently nodes start at bit 0, bit 0 = node 1.
        return self.available_taxi_nodes[node - 1]

    def add_taxi(self, node):
        self.available_taxi_nodes[node - 1] = True

    def handle_query_node(self, flight_master_guid, node):
        if not self.has_node(node):
            self.add_taxi(node)
            # Notify new taxi path discovered.
            self.owner.session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_NEW_TAXI_PATH))
            # Update flight master status.
            data = pack('<QB', flight_master_guid, 1)
            self.owner.session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_TAXINODE_STATUS, data))
        else:
            # TODO: Find out how 'Destination Nodes' and 'Known Nodes' fields correlate,
            #  Client does an OR operation between the two, 'destNodesa = knownNodes | destNodes'
            known_nodes = unpack('<Q', self.available_taxi_nodes.tobytes())[0]
            data = pack(
                '<IQI2Q',
                1,  # Show map.
                flight_master_guid,  # NPC taxi guid.
                node,  # Current node.
                known_nodes,  # Destination nodes.
                known_nodes  # Known nodes.
            )

            self.owner.session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_SHOWTAXINODES, data))

    def handle_node_status_query(self, flight_master_guid, node):
        data = pack(
            '<QB',
            flight_master_guid,  # NPC taxi guid.
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
