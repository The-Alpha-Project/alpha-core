from struct import pack, unpack
from bitarray import bitarray
from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from game.world.managers.abstractions.Vector import Vector
from game.world.managers.objects.units.player.taxi.TaxiResumeInformation import TaxiResumeInformation
from network.packet.PacketWriter import PacketWriter
from utils.constants.OpCodes import OpCode
from utils.constants.UnitCodes import Teams


GRYPHON_DISPLAY_ID = 1149
HIPPOGRYPH_DISPLAY_ID = 1936
BAT_DISPLAY_ID = 1566
WIND_RIDER_DISPLAY_ID = 2157

HIPPOGRYPH_MASTERS = (3838, 3841, 4267, 4319, 4407, 6706, 8019, 10897, 11138, 12577, 12578)
BAT_HANDLERS = (2226, 2389, 3575, 4551, 12636)


class TaxiManager:
    def __init__(self, player_mgr):
        self.owner = player_mgr
        self.available_taxi_nodes = bitarray(player_mgr.player.taximask, 'little')
        self.taxi_resume_info = TaxiResumeInformation(player_mgr.player.taxi_path)

    def resume_taxi_flight(self):
        taxi_path = DbcDatabaseManager.taxi_path_get(self.taxi_resume_info.start_node, self.taxi_resume_info.dest_node)
        if taxi_path:
            return self.begin_taxi_flight(taxi_path,
                                          self.taxi_resume_info.start_node,
                                          self.taxi_resume_info.dest_node,
                                          mount_display_id=self.taxi_resume_info.mount_display_id,
                                          remaining_wp=self.taxi_resume_info.remaining_waypoints)
        else:
            return False

    def begin_taxi_flight(self, taxi_path, start_node, dest_node, flight_master=None, mount_display_id=None, remaining_wp=None):
        waypoints = []
        nodes = DbcDatabaseManager.TaxiPathNodesHolder.taxi_nodes_get_by_path_id(taxi_path.ID)

        for i in range(len(nodes)):
            waypoints.append(Vector(nodes[i].LocX, nodes[i].LocY, nodes[i].LocZ))

        if remaining_wp:
            while len(waypoints) != remaining_wp:
                waypoints.pop(0)
            # If the first waypoint is already the player location, pop.
            if len(waypoints) > 0 and self.owner.location == waypoints[0]:
                waypoints.pop(0)

        # Player is already on the last waypoint, do not trigger flight and just move him there.
        if len(waypoints) == 0:
            self.taxi_resume_info.flush()
            self.owner.teleport(self.owner.map_id, Vector(nodes[-1].LocX, nodes[-1].LocY, nodes[-1].LocZ))
            return False

        # Get mount according to Flight Master if this is an initial flight trigger.
        if flight_master:
            mount_display_id = self.get_mount_display_id(flight_master)

        # Detach active pets.
        self.owner.pet_manager.detach_active_pets()

        dest_taxi_node = DbcDatabaseManager.TaxiNodesHolder.taxi_nodes_get_by_map_id_and_node_id(self.owner.map_id, dest_node)
        self.owner.pending_taxi_destination = Vector(dest_taxi_node.X, dest_taxi_node.Y, dest_taxi_node.Z)
        self.owner.set_taxi_flying_state(True, mount_display_id)

        # Update current flight state.
        self.taxi_resume_info.update_fields(start_location=waypoints[0].copy(),
                                            start_node=start_node,
                                            dest_node=dest_node,
                                            mount_id=mount_display_id,
                                            remaining_wp=len(waypoints))

        # Notify player and surroundings.
        self.owner.movement_manager.move_flight(waypoints)
        return True

    # Get the proper display_id for the mount.
    # This information is not stored in the dbc like in later versions.
    def get_mount_display_id(self, flight_master=None):
        if flight_master:
            if flight_master.entry in HIPPOGRYPH_MASTERS:
                return HIPPOGRYPH_DISPLAY_ID
            elif flight_master.entry in BAT_HANDLERS:
                return BAT_DISPLAY_ID

        if self.owner.team == Teams.TEAM_HORDE:
            return WIND_RIDER_DISPLAY_ID
        else:
            return GRYPHON_DISPLAY_ID

    def update_partial_flight_state(self, current_waypoint, remaining_waypoints_count):
        self.taxi_resume_info.update_fields(start_location=current_waypoint, remaining_wp=remaining_waypoints_count)

    def flight_end(self):
        self.owner.set_taxi_flying_state(False)
        self.owner.teleport(self.owner.map_id, self.owner.pending_taxi_destination)
        self.owner.pending_taxi_destination = None
        self.taxi_resume_info.flush()

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

    def discover_taxi(self, node, flight_master_guid=0):
        if not self.has_node(node):
            self.available_taxi_nodes[node - 1] = True
            # Notify new taxi path discovered.
            self.owner.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_NEW_TAXI_PATH))
            if flight_master_guid > 0:
                # Update flight master status.
                data = pack('<QB', flight_master_guid, 1)
                self.owner.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_TAXINODE_STATUS, data))
            return True
        return False

    def handle_query_node(self, node, flight_master_guid):
        # Destination nodes are reachable from the current node; known nodes are the full discovered mask.
        # Client ORs them for display, but expects them as separate masks.
        dest_nodes_mask = bitarray(len(self.available_taxi_nodes))
        dest_nodes_mask.setall(0)
        for taxi_node_id, _node in DbcDatabaseManager.TaxiNodesHolder.taxi_nodes_get_by_map_id(
                self.owner.map_id):
            if taxi_node_id - 1 >= len(dest_nodes_mask):
                continue
            if not self.available_taxi_nodes[taxi_node_id - 1]:
                continue
            if (DbcDatabaseManager.taxi_path_get(node, taxi_node_id)
                    or DbcDatabaseManager.taxi_path_get(taxi_node_id, node)):
                dest_nodes_mask[taxi_node_id - 1] = True

        dest_nodes = unpack('<Q', dest_nodes_mask.tobytes())[0]
        known_nodes = unpack('<Q', self.available_taxi_nodes.tobytes())[0]
        data = pack(
            '<IQI2Q',
            1,  # Show map.
            flight_master_guid,  # NPC taxi guid.
            node,  # Current node.
            dest_nodes,  # Destination nodes.
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
        taxi_nodes = DbcDatabaseManager.TaxiNodesHolder.taxi_nodes_get_by_map_id(player_mgr.map_id)
        last_near_distance = -1
        last_near_taxi_node_id = -1
        for taxi_node_id, taxi_node in taxi_nodes:
            distance = player_mgr.location.distance(x=taxi_node.X, y=taxi_node.Y, z=taxi_node.Z)
            if distance < last_near_distance or last_near_distance == -1:
                last_near_distance = distance
                last_near_taxi_node_id = taxi_node_id

        return last_near_taxi_node_id
