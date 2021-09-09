from struct import pack, unpack
from bitarray import bitarray
from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from game.world.managers.abstractions.Vector import Vector
from network.packet.PacketWriter import PacketWriter, OpCode
from utils.ConfigManager import config
from utils.constants.UnitCodes import UnitFlags, Teams, SplineFlags
from utils.constants.UpdateFields import UnitFields


GRYPHON_DISPLAY_ID = 1149
HIPPOGRYPH_DISPLAY_ID = 1936
BAT_DISPLAY_ID = 1566
WIND_RIDER_DISPLAY_ID = 2157

HIPPOGRYPH_MASTERS = (3838, 3841, 4267, 4319, 4407, 6706, 8019, 10897, 11138, 12577, 12578)
BAT_HANDLERS = (2226, 2389, 3575, 4551, 12636)


class TaxiManager(object):
    def __init__(self, player_mgr):
        self.owner = player_mgr
        self.available_taxi_nodes = bitarray(player_mgr.player.taximask, 'little')
        self.taxi_path = player_mgr.player.taxi_path
        self.start_node = 0
        self.dest_node = 0
        self.mount_display_id = 0
        self.remaining_waypoints = 0

    def resume_taxi_flight(self):
        data = self.taxi_path.rsplit(',')
        start_node = int(data[0])
        dest_node = int(data[1])
        mount_display_id = int(data[2])
        waypoints = int(data[3])

        taxi_path = DbcDatabaseManager.taxi_path_get(start_node, dest_node)
        if taxi_path:
            self.begin_taxi_flight(taxi_path, start_node, dest_node, mount_display_id=mount_display_id, remaining_wp=waypoints)

    def begin_taxi_flight(self, taxi_path, start_node, dest_node, flight_master=None, mount_display_id=None, remaining_wp=None):
        waypoints = []
        nodes = DbcDatabaseManager.TaxiPathNodesHolder.taxi_nodes_get_by_path_id(taxi_path.ID)

        for i in range(0, len(nodes)):
            waypoints.append(Vector(nodes[i].LocX, nodes[i].LocY, nodes[i].LocZ))

        if remaining_wp:
            while len(waypoints) != remaining_wp:
                waypoints.pop(0)

        # Get the proper display_id for the mount.
        # This information is not stored in the dbc like in later versions.
        if flight_master:
            if flight_master.entry in HIPPOGRYPH_MASTERS:
                mount_display_id = HIPPOGRYPH_DISPLAY_ID
            elif flight_master.entry in BAT_HANDLERS:
                mount_display_id = BAT_DISPLAY_ID
            elif self.owner.team == Teams.TEAM_HORDE:
                mount_display_id = WIND_RIDER_DISPLAY_ID
            else:
                mount_display_id = GRYPHON_DISPLAY_ID

        self.owner.unit_flags |= UnitFlags.UNIT_FLAG_FROZEN | UnitFlags.UNIT_FLAG_TAXI_FLIGHT
        self.owner.set_uint32(UnitFields.UNIT_FIELD_FLAGS, self.owner.unit_flags)
        dest_taxi_node = DbcDatabaseManager.TaxiNodesHolder.taxi_nodes_get_by_map_and_id(self.owner.map_, dest_node)
        self.owner.pending_taxi_destination = Vector(dest_taxi_node.X, dest_taxi_node.Y, dest_taxi_node.Z)
        self.owner.mount(mount_display_id)
        self.owner.set_dirty()

        speed = config.Unit.Player.Defaults.flight_speed
        spline = SplineFlags.SPLINEFLAG_FLYING

        # Set current flight state.
        self.start_node = start_node
        self.dest_node = dest_node
        self.mount_display_id = mount_display_id
        self.remaining_waypoints = len(waypoints)
        self.taxi_path = f'{self.start_node},{self.dest_node},{self.mount_display_id},{len(waypoints)}'
        # Notify player and surroundings.
        self.owner.movement_manager.send_move_to(waypoints, speed, spline)

    def update_flight_state(self):
        if self.owner.movement_manager.unit_is_moving():
            self.taxi_path = f'{self.start_node},{self.dest_node},{self.mount_display_id},{len(self.owner.movement_manager.pending_waypoints)}'
        else:
            self.clear_flight_state()

    def clear_flight_state(self):
        self.start_node = 0
        self.dest_node = 0
        self.mount_display_id = 0
        self.remaining_waypoints = 0
        self.taxi_path = ''

    # Enable all taxi node bits.
    def enable_all_taxi_nodes(self):
        count = 0
        for taxi_node_id, node in DbcDatabaseManager.TaxiNodesHolder.EASTERN_KINGDOMS_TAXI_NODES.items():
            if node.custom_Team == self.owner.team.value:
                self.available_taxi_nodes[taxi_node_id - 1] = True
                count += 1
        for taxi_node_id, node in DbcDatabaseManager.TaxiNodesHolder.KALIMDOR_TAXI_NODES.items():
            if node.custom_Team == self.owner.team.value:
                self.available_taxi_nodes[taxi_node_id - 1] = True
                count += 1
        return count

    # Disable all taxi node bits.
    def disable_all_taxi_nodes(self):
        self.available_taxi_nodes.setall(0)

    def has_node(self, node):
        # Apparently nodes start at bit 0, bit 0 = node 1.
        return self.available_taxi_nodes[node - 1]

    def add_taxi(self, node):
        self.available_taxi_nodes[node - 1] = True

    def handle_query_node(self, flight_master_guid, node):
        if not self.has_node(node):
            self.add_taxi(node)
            # Notify new taxi path discovered.
            self.owner.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_NEW_TAXI_PATH))
            # Update flight master status.
            data = pack('<QB', flight_master_guid, 1)
            self.owner.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_TAXINODE_STATUS, data))
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

            self.owner.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_SHOWTAXINODES, data))

    def handle_node_status_query(self, flight_master_guid, node):
        data = pack(
            '<QB',
            flight_master_guid,  # NPC taxi guid.
            0 if self.has_node(node) else 1  # Available path '!' Green icon.
        )

        packet = PacketWriter.get_packet(OpCode.SMSG_TAXINODE_STATUS, data)
        self.owner.enqueue_packet(packet)

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
