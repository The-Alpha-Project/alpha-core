import math
from struct import pack, unpack
from typing import NamedTuple

from database.realm.RealmDatabaseManager import RealmDatabaseManager
from game.world import WorldManager
from game.world.managers.GridManager import GridManager
from game.world.managers.abstractions.Vector import Vector
from network.packet.PacketWriter import PacketWriter, OpCode
from utils.ConfigManager import config
from utils.constants.ObjectCodes import ObjectTypes
from utils.constants.UnitCodes import UnitFlags, SplineFlags
from utils.constants.UpdateFields import UnitFields


class PendingWaypoint(NamedTuple):
    id_: int
    expected_timestamp: int
    location: Vector


class MovementManager(object):
    def __init__(self, unit):
        self.unit = unit
        self.is_player = self.unit.get_type() == ObjectTypes.TYPE_PLAYER
        self.speed = 0
        self.should_update_waypoints = False
        self.last_position = None
        self.pending_waypoints = []
        self.total_waypoint_time = 0
        self.total_waypoint_timer = 0
        self.waypoint_timer = 0

    def update_pending_waypoints(self, elapsed):
        if not self.should_update_waypoints:
            return

        self.total_waypoint_timer += elapsed
        self.waypoint_timer += elapsed
        # Set elapsed time to the current movement spline data
        if self.unit.movement_spline:
            if self.unit.movement_spline.elapsed < self.unit.movement_spline.total_time:
                self.unit.movement_spline.elapsed += elapsed * 1000
                if self.unit.movement_spline.elapsed > self.unit.movement_spline.total_time:
                    self.unit.movement_spline.elapsed = self.unit.movement_spline.total_time

        waypoint_length = len(self.pending_waypoints)
        if waypoint_length > 0:
            current_waypoint = self.pending_waypoints[0]
            if self.total_waypoint_timer > current_waypoint.expected_timestamp:
                new_position = current_waypoint.location
                self.last_position = new_position
                self.waypoint_timer = 0

                self.pending_waypoints.pop(0)
            # Guess current position based on speed and time
            else:
                guessed_distance = self.speed * self.waypoint_timer
                new_position = self.last_position.get_point_in_between(guessed_distance, current_waypoint.location)

            if new_position:
                self.unit.location.x = new_position.x
                self.unit.location.y = new_position.y
                self.unit.location.z = new_position.z

                GridManager.update_object(self.unit)
        else:
            # Path finished
            if self.total_waypoint_timer > self.total_waypoint_time:
                if self.is_player and self.unit.pending_taxi_destination:
                    self.unit.unit_flags &= ~(UnitFlags.UNIT_FLAG_FROZEN | UnitFlags.UNIT_FLAG_TAXI_FLIGHT)
                    self.unit.set_uint32(UnitFields.UNIT_FIELD_FLAGS, self.unit.unit_flags)
                    self.unit.unmount(force_update=False)
                    self.unit.teleport(self.unit.map_, self.unit.pending_taxi_destination)
                    self.unit.pending_taxi_destination = None
                self.reset()

    def reset(self):
        self.unit.movement_spline = None
        self.should_update_waypoints = False
        self.last_position = None
        self.total_waypoint_time = 0
        self.total_waypoint_timer = 0
        self.waypoint_timer = 0
        self.pending_waypoints.clear()

    def send_move_to(self, waypoints, speed, spline_flag):
        self.reset()
        self.speed = speed

        start_time = int(WorldManager.get_seconds_since_startup() * 1000)

        location_bytes = self.unit.location.to_bytes(include_orientation=False)
        data = pack(
            f'<Q{len(location_bytes)}sIBI',
            self.unit.guid,
            location_bytes,
            start_time,
            0,
            spline_flag
        )

        waypoints_data = b''
        waypoints_length = len(waypoints)
        last_waypoint = self.unit.location
        total_distance = 0
        total_time = 0
        current_id = 0
        for waypoint in waypoints:
            waypoints_data += waypoint.to_bytes(include_orientation=False)
            current_distance = last_waypoint.distance(waypoint)
            current_time = current_distance / speed
            total_distance += current_distance
            total_time += current_time

            self.pending_waypoints.append(PendingWaypoint(current_id, total_time, waypoint))
            last_waypoint = waypoint
            current_id += 1

        data += pack(
            f'<2I{len(waypoints_data)}s',
            int(total_time * 1000),
            waypoints_length,
            waypoints_data
        )

        GridManager.send_surrounding(PacketWriter.get_packet(OpCode.SMSG_MONSTER_MOVE, data), self.unit,
                                     include_self=self.is_player)

        # Player should dismount after some seconds have passed since FP destination is reached (Blizzlike).
        # This is also kind of a hackfix (at least for now) since the client always takes a bit more time to reach
        # the actual destination than the time you specify in SMSG_MONSTER_MOVE, for some reason.
        if self.is_player and spline_flag == SplineFlags.SPLINEFLAG_FLYING:
            self.total_waypoint_time = total_time + (total_distance * 0.0042)  # TODO This can't be normal, investigate ^
        else:
            self.total_waypoint_time = total_time

        # Generate the spline
        spline = MovementSpline()
        spline.flags = spline_flag
        spline.spot = self.unit.location
        spline.guid = self.unit.guid
        spline.facing = self.unit.location.o
        spline.elapsed = 0
        spline.total_time = int(self.total_waypoint_time * 1000)
        spline.points = waypoints
        self.unit.movement_spline = spline

        self.last_position = self.unit.location
        self.should_update_waypoints = True

    def move_random(self, start_position, radius, speed=config.Unit.Defaults.walk_speed):
        random_point = start_position.get_random_point_in_radius(radius)
        self.send_move_to([random_point], speed, SplineFlags.SPLINEFLAG_RUNMODE)


class MovementSpline(object):
    def __init__(self, flags=0, spot=None, guid=0, facing=0, elapsed=0, total_time=0, points=None):
        self.flags = flags
        self.spot = spot
        self.guid = guid
        self.facing = facing
        self.elapsed = elapsed
        self.total_time = total_time
        self.points = points
        if not points:
            self.points = []

    @staticmethod
    def from_bytes(spline_bytes):
        if len(spline_bytes < 42):
            return None

        bytes_read = 0

        spline = MovementSpline()
        spline.flags = unpack('<I', spline_bytes[:4])[0]
        bytes_read += 4

        if spline.flags & SplineFlags.SPLINEFLAG_SPOT:
            spline.spot = Vector.from_bytes(spline_bytes[bytes_read:12])
            bytes_read += 12
        if spline.flags & SplineFlags.SPLINEFLAG_TARGET:
            spline.guid = unpack('<Q', spline_bytes[bytes_read:8])[0]
            bytes_read += 8
        if spline.flags & SplineFlags.SPLINEFLAG_FACING:
            spline.facing = unpack('<f', spline_bytes[bytes_read:4])[0]
            bytes_read += 4

        spline.elapsed, spline.total_time = unpack('<2I', spline_bytes[bytes_read:8])
        bytes_read += 8

        points_length = unpack('<I', spline_bytes[bytes_read:4])[0]
        bytes_read += 4
        for i in range(points_length):
            spline.points.append(Vector.from_bytes(spline_bytes[bytes_read:12]))
            bytes_read += 12

        return spline

    def to_bytes(self):
        data = pack('<I', self.flags)

        if self.flags & SplineFlags.SPLINEFLAG_SPOT:
            data += self.spot.to_bytes(include_orientation=False)
        if self.flags & SplineFlags.SPLINEFLAG_TARGET:
            data += pack('<Q', self.guid)
        if self.flags & SplineFlags.SPLINEFLAG_FACING:
            data += pack('<f', self.facing)

        data += pack(
            '<2Ii',
            int(self.elapsed),
            self.total_time,
            len(self.points)
        )

        for point in self.points:
            data += point.to_bytes(include_orientation=False)

        return data
