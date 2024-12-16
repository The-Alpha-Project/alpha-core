import math

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.dbc.DbcModels import TransportAnimation
from game.world import WorldManager
from bisect import bisect_left
from game.world.managers.abstractions.Vector import Vector
from game.world.managers.objects.gameobjects.GameObjectManager import GameObjectManager
from utils.ConfigManager import config
from utils.Logger import Logger
from utils.constants.MiscCodes import GameObjectStates, HighGuid


# TODO: Players automatically desync to other player viewers when inside transports.
#  this seems to be all client related since we've tried many changes based on other cores and nothing seems to work.
#  From 0.5.4 patch notes. 'fixed problems with elevators.'
#  From 0.7.1 patch notes. 'fixed multiple crashes related to both players and pets on elevators'
class TransportManager(GameObjectManager):
    def __init__(self, **kwargs):
        super().__init__(**kwargs)

        self.passengers = {}
        self.current_anim_position = self.location
        self.path_progress = 0.0
        self.total_time = 0.0
        self.current_segment = 0
        self.path_nodes: dict[int, TransportAnimation] = {}
        self.stationary_position = self.location.copy()
        self.auto_close_secs = 0

    # override
    def initialize_from_gameobject_template(self, gobject_template):
        super().initialize_from_gameobject_template(gobject_template)
        self.auto_close_secs = self.get_data_field(3, int)
        self.load_path_nodes()

    # override
    def update(self, now):
        if now > self.last_tick > 0:
            if self.is_active_object() and self.has_passengers():
                self._calculate_progress()
                self._update_passengers()
        super().update(now)

    def load_path_nodes(self):
        for node in DbcDatabaseManager.TransportAnimationHolder.animations_by_entry(self.get_entry()):
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

    # override
    def get_fall_time(self):
        self._calculate_progress()
        return int(self.path_progress)

    def has_passengers(self):
        return len(self.passengers) > 0

    def calculate_passenger_position(self, player_mgr):
        in_x = player_mgr.transport_location.x
        in_y = player_mgr.transport_location.y
        in_z = player_mgr.transport_location.z
        in_o = player_mgr.transport_location.o

        trans_x = self.location.x
        trans_y = self.location.y
        trans_z = self.location.z
        trans_o = self.location.o

        x = trans_x + in_x * math.cos(trans_o) - in_y * math.sin(trans_o)
        y = trans_y + in_y * math.cos(trans_o) + in_x * math.sin(trans_o)
        z = trans_z + in_z
        o = TransportManager.normalize_orientation(trans_o + in_o)

        player_mgr.location.x = x
        player_mgr.location.y = y
        player_mgr.location.z = z
        player_mgr.location.o = o

    def _calculate_progress(self):
        self.path_progress = self._get_time()
        try:
            next_node = self.get_next_node(self.path_progress)
            prev_node = self.get_previous_node(self.path_progress)
        except IndexError:
            Logger.error(f'Unable to retrieve node information for transport with entry {self.entry} and spawn id '
                         f'{self.spawn_id} at {self.path_progress} progress.')
            return

        # No progress.
        if not next_node or not prev_node:
            return

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

        self.current_anim_position = self.get_stationary_position() + location

        if config.Server.Settings.debug_transport:
            self._debug_position(self.current_anim_position)

        self.location.z = self.current_anim_position.z

    def _update_passengers(self):
        for unit in list(self.passengers.values()):
            self.calculate_passenger_position(unit)
            unit.movement_info.send_surrounding_update()

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
        gameobject = GameObjectBuilder.create(176557, location, self.map_id, self.instance_id,
                                              GameObjectStates.GO_STATE_READY, summoner=self, ttl=1)
        self.get_map().spawn_object(world_object_instance=gameobject)

    # override
    def get_auto_close_time(self):
        return self.auto_close_secs / 0x10000

    def _get_time(self):
        if not self.total_time:
            return 0
        return int(WorldManager.get_seconds_since_startup() * 1000) % self.total_time

    # override
    def get_low_guid(self):
        return self.guid & ~HighGuid.HIGHGUID_TRANSPORT

    # override
    def get_stationary_position(self):
        return self.stationary_position

    # override
    def generate_object_guid(self, low_guid):
        return low_guid | HighGuid.HIGHGUID_TRANSPORT

    @staticmethod
    def normalize_orientation(o):
        return math.fmod(o, 2.0*math.pi)
