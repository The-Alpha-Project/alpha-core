from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.dbc.DbcModels import TransportAnimation
from game.world import WorldManager
from bisect import bisect_left
from game.world.managers.abstractions.Vector import Vector
from game.world.managers.maps.MapManager import MapManager
from utils.ConfigManager import config
from utils.constants.MiscCodes import GameObjectStates


# TODO: Find a way to tell clients about elevator real position upon creation.
#  All clients must receive the original spawn location and then somehow we must tell them in which
#  part of the animation node paths the object is standing.
#  Compared to vanilla, we have no 'GAMEOBJECT_ANIMPROGRESS' nor 'UPDATEFLAG_TRANSPORT' for create packets.
class TransportManager:
    def __init__(self, owner):
        self.owner = owner
        self.entry = owner.gobject_template.entry
        self.path_progress = 0
        self.total_time = 0
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

    def update(self):
        self.path_progress = self._get_time()
        next_node = self.get_next_node(self.path_progress)
        prev_node = self.get_previous_node(self.path_progress)
        if not next_node or not prev_node:
            return int(self.path_progress)
        self.current_segment = prev_node.TimeIndex
        prev_pos = Vector(prev_node.X, prev_node.Y, prev_node.Z)
        next_pos = Vector(next_node.X, next_node.Y, next_node.Z)
        if prev_pos == next_pos:
            location = prev_pos.copy()
        else:
            time_elapsed = self.path_progress - prev_node.TimeIndex
            time_diff = next_node.TimeIndex - prev_node.TimeIndex
            segment_diff = next_pos - prev_pos
            velocity_x = segment_diff.x / time_diff
            velocity_y = segment_diff.y / time_diff
            velocity_z = segment_diff.z / time_diff
            location = Vector(time_elapsed * velocity_x, time_elapsed * velocity_y, time_elapsed * velocity_z)
            location += prev_pos

        current_anim_location = self.owner.location + location
        if config.Server.Settings.debug_transport:
            self._debug_position(current_anim_location)

        return int(self.path_progress)

    def _debug_position(self, location):
        from game.world.managers.objects.gameobjects.GameObjectBuilder import GameObjectBuilder
        gameobject = GameObjectBuilder.create(176557, location, self.owner.map_id, self.owner.instance_id,
                                              GameObjectStates.GO_STATE_READY,
                                              summoner=self.owner,
                                              ttl=1)
        MapManager.spawn_object(world_object_instance=gameobject)

    def _get_time(self):
        return int(WorldManager.get_seconds_since_startup() * 1000) % self.total_time
