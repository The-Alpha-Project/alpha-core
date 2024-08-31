import math
from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.dbc.DbcModels import TransportAnimation
from game.world import WorldManager
from bisect import bisect_left
from game.world.managers.abstractions.Vector import Vector
from utils.ConfigManager import config
from utils.constants.MiscCodes import GameObjectStates


# TODO: Players automatically desync to other player viewers when inside transports.
#  this seems to be all client related since we've tried many changes based on other cores and nothing seems to work.
#  From 0.5.4 patch notes. 'fixed problems with elevators.'
#  From 0.7.1 patch notes. 'fixed multiple crashes related to both players and pets on elevators'
class TransportManager:
    def __init__(self, owner):
        self.owner = owner
        self.entry = owner.gobject_template.entry
        self.passengers = {}
        self.current_anim_position = owner.location
        self.path_progress = 0.0
        self.total_time = 0.0
        self.current_segment = 0
        self.path_nodes: dict[int, TransportAnimation] = {}
        self.load_path_nodes()

    def load_path_nodes(self):
        for node in DbcDatabaseManager.TransportAnimationHolder.animations_by_entry(self.entry):
            self.path_nodes[node.TimeIndex] = node
            if self.total_time < node.TimeIndex:
                self.total_time = node.TimeIndex

    def get_previous_node(self, time):
        node_keys = list(self.path_nodes.keys())
        lower_bound = self.path_nodes[node_keys[bisect_left(node_keys, time)]]
        if lower_bound.TimeIndex != node_keys[-1] and lower_bound.TimeIndex != node_keys[0]:
            return self.path_nodes[node_keys[node_keys.index(lower_bound.TimeIndex) - 1]]
        return None

    def get_next_node(self, time):
        node_keys = list(self.path_nodes.keys())
        lower_bound = self.path_nodes[node_keys[bisect_left(node_keys, time)]]
        if lower_bound.TimeIndex != node_keys[-1]:
            return lower_bound
        return None

    def get_path_progress(self):
        return self.update()

    def has_passengers(self):
        return len(self.passengers) > 0

    def update(self):
        self.path_progress = self._get_time()
        next_node = self.get_next_node(self.path_progress)
        prev_node = self.get_previous_node(self.path_progress)
        # No progress.
        if not next_node or not prev_node:
            return int(self.path_progress)
        self.current_segment = prev_node.TimeIndex
        prev_pos = Vector(prev_node.X, prev_node.Y, prev_node.Z)
        next_pos = Vector(next_node.X, next_node.Y, next_node.Z)
        # Stop/Waiting.
        if prev_pos == next_pos:
            location = prev_pos.copy()
        # Moving.
        else:
            time_elapsed = self.path_progress - prev_node.TimeIndex
            time_diff = next_node.TimeIndex - prev_node.TimeIndex
            segment_diff = next_pos - prev_pos
            velocity_x = segment_diff.x / time_diff
            velocity_y = segment_diff.y / time_diff
            velocity_z = segment_diff.z / time_diff
            location = Vector(time_elapsed * velocity_x, time_elapsed * velocity_y, time_elapsed * velocity_z)
            location += prev_pos

        self.current_anim_position = self.owner.get_stationary_position() + location

        if config.Server.Settings.debug_transport:
            self._debug_position(self.current_anim_position)

        self.owner.location.z = self.current_anim_position.z

        self._update_passengers()

        return int(self.path_progress)

    def calculate_passenger_position(self, player_mgr):
        in_x = player_mgr.transport_location.x
        in_y = player_mgr.transport_location.y
        in_z = player_mgr.transport_location.z
        in_o = player_mgr.transport_location.o

        trans_x = self.owner.location.x
        trans_y = self.owner.location.y
        trans_z = self.owner.location.z
        trans_o = self.owner.location.o

        x = trans_x + in_x * math.cos(trans_o) - in_y * math.sin(trans_o)
        y = trans_y + in_y * math.cos(trans_o) + in_x * math.sin(trans_o)
        z = trans_z + in_z
        o = TransportManager.normalize_orientation(trans_o + in_o)

        player_mgr.location.x = x
        player_mgr.location.y = y
        player_mgr.location.z = z
        player_mgr.location.o = o

    def _update_passengers(self):
        for unit in list(self.passengers.values()):
            self.calculate_passenger_position(unit)
            unit.movement_info.send_surrounding_update()

    @staticmethod
    def normalize_orientation(o):
        return math.fmod(o, 2.0*math.pi)

    def add_passenger(self, unit):
        self.passengers[unit.guid] = unit

    def remove_passenger(self, unit):
        if unit.guid not in self.passengers:
            return
        self.passengers.pop(unit.guid)

    def update_passengers(self):
        if len(self.passengers) == 0:
            return

    def _debug_position(self, location):
        from game.world.managers.objects.gameobjects.GameObjectBuilder import GameObjectBuilder
        gameobject = GameObjectBuilder.create(176557, location, self.owner.map_id, self.owner.instance_id,
                                              GameObjectStates.GO_STATE_READY,
                                              summoner=self.owner,
                                              ttl=1)
        self.owner.get_map().spawn_object(world_object_instance=gameobject)

    def _get_time(self):
        return int(WorldManager.get_seconds_since_startup() * 1000) % self.total_time
