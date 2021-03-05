import math
from struct import pack, unpack
from typing import NamedTuple

from database.realm.RealmDatabaseManager import RealmDatabaseManager
from game.world import WorldManager
from game.world.managers.GridManager import GridManager
from game.world.managers.abstractions.Vector import Vector
from network.packet.PacketWriter import PacketWriter, OpCode
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
        self.should_update_waypoints = False
        self.pending_waypoints = []
        self.total_waypoint_time = 0
        self.waypoint_timer = 0

    def update_pending_waypoints(self, elapsed):
        if not self.should_update_waypoints:
            return

        self.waypoint_timer += elapsed

        waypoint_length = len(self.pending_waypoints)
        current_waypoint = None
        if waypoint_length > 0:
            current_waypoint = self.pending_waypoints[0]

        if current_waypoint and self.waypoint_timer > current_waypoint.expected_timestamp:
            self.unit.location = current_waypoint.location
            GridManager.update_object(self.unit)

            self.pending_waypoints.pop(0)

            return

        if waypoint_length == 0 and self.waypoint_timer > self.total_waypoint_time:
            if self.is_player and self.unit.pending_taxi_destination:
                self.unit.teleport(self.unit.map_, self.unit.pending_taxi_destination)
                self.unit.unit_flags &= ~(UnitFlags.UNIT_FLAG_FROZEN | UnitFlags.UNIT_FLAG_TAXI_FLIGHT)
                self.unit.set_uint32(UnitFields.UNIT_FIELD_FLAGS, self.unit.unit_flags)
                self.unit.unmount()
                self.unit.pending_taxi_destination = None
            self.unit.movement_spline = None
            self.should_update_waypoints = False
            self.total_waypoint_time = 0
            self.waypoint_timer = 0

    def send_move_to(self, waypoints, speed, spline_flag):
        self.should_update_waypoints = False
        self.pending_waypoints.clear()

        start_time = int(WorldManager.get_seconds_since_startup() * 1000)

        data = pack(
            '<Q12sIBI',
            self.unit.guid,
            self.unit.location.to_bytes(include_orientation=False),
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
            '<2I%us' % len(waypoints_data),
            int(total_time * 1000),
            waypoints_length,
            waypoints_data
        )

        GridManager.send_surrounding(PacketWriter.get_packet(OpCode.SMSG_MONSTER_MOVE, data), self.unit,
                                     include_self=self.is_player)

        # Player should dismount after some seconds have passed since FP destination is reached (Blizzlike).
        # This is also kind of a hackfix (at least for now) since the client always takes a bit more time to reach
        # the actual destination than the time you specify in SMSG_MONSTER_MOVE.
        if self.is_player and spline_flag == SplineFlags.SPLINEFLAG_FLYING:
            self.total_waypoint_time = total_time + (0.15 * waypoints_length)
        else:
            self.total_waypoint_time = total_time

        # Generate the spline
        spline = MovementSpline()
        spline.flags = spline_flag
        spline.spot = self.unit.location
        spline.guid = self.unit.guid
        spline.facing = self.unit.location.o
        spline.start = int(start_time)
        spline.time = int(self.total_waypoint_time)
        spline.points = waypoints
        self.unit.movement_spline = spline

        self.should_update_waypoints = True


class MovementSpline(object):
    def __init__(self, flags=0, spot=None, guid=0, facing=0, start=0, time=0, points=None):
        self.flags = flags
        self.spot = spot
        self.guid = guid
        self.facing = facing
        self.start = start
        self.time = time
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

        spline.start, spline.time = unpack('<2I', spline_bytes[bytes_read:8])
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
            self.start,
            self.time,
            len(self.points)
        )

        for point in self.points:
            data += point.to_bytes(include_orientation=False)

        return data
