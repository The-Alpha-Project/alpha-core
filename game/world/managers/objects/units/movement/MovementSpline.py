from struct import pack, unpack

from game.world import WorldManager
from game.world.managers.abstractions.Vector import Vector
from game.world.managers.maps.MapManager import MapManager
from game.world.managers.objects.gameobjects.GameObjectBuilder import GameObjectBuilder
from game.world.managers.objects.units.movement.PendingWaypoint import PendingWaypoint
from network.packet.PacketWriter import PacketWriter
from utils.ConfigManager import config
from utils.constants.MiscCodes import ObjectTypeIds, GameObjectStates, MoveFlags
from utils.constants.OpCodes import OpCode
from utils.constants.UnitCodes import SplineFlags, SplineType


class MovementSpline(object):
    def __init__(self, unit, spline_type=0, flags=0, spot=None, guid=0, facing=0, speed=0, elapsed=0, total_time=0,
                 points=None):
        self.unit = unit
        self.is_player = self.unit.get_type_id() == ObjectTypeIds.ID_PLAYER
        self.spline_type = spline_type
        self.flags = flags
        self.spot = spot
        self.guid = guid
        self.facing = facing
        self.speed = speed
        self.start_time = int(WorldManager.get_seconds_since_startup() * 1000)
        self.elapsed = elapsed
        self.total_time = total_time
        self.points = points
        self.pending_waypoints: list[PendingWaypoint] = []
        self.total_waypoint_timer = 0

    def update(self, elapsed):
        self.total_waypoint_timer += elapsed
        self.elapsed += elapsed * 1000
        if self.elapsed > self.total_time:
            self.elapsed = self.total_time

        if not self.pending_waypoints:
            return False, None

        current_waypoint = self.pending_waypoints[0]
        self.unit.location.face_point(current_waypoint.location)
        print(f'{current_waypoint.location}')

        is_complete = self.total_waypoint_timer >= current_waypoint.expected_timestamp
        if is_complete:
            print('Complete')
            self.pending_waypoints.pop(0)

        new_position = self._get_position(current_waypoint, elapsed, is_complete)

        if new_position and config.Server.Settings.debug_movement:
            self._debug_position(new_position)

        return new_position is not None, new_position  # Position changed.

    def _get_position(self, pending_waypoint, elapsed, is_complete=False):
        # Handle players collision due wrong pathing.
        if self.unit.movement_flags & MoveFlags.MOVEFLAG_REDIRECTED:
            return self.unit.location
        if is_complete:
            return pending_waypoint.location
        guessed_distance = self.speed * elapsed
        return self.unit.location.get_point_in_between(guessed_distance, pending_waypoint.location,
                                                       map_id=self.unit.map_id)

    def _debug_position(self, location):
        gameobject = GameObjectBuilder.create(2555, location, self.unit.map_id, self.unit.instance_id,
                                              GameObjectStates.GO_STATE_READY,
                                              summoner=self.unit,
                                              ttl=1)
        MapManager.spawn_object(world_object_instance=gameobject)

    def is_complete(self):
        return not self.pending_waypoints and self.total_waypoint_timer >= self.total_time

    def is_type(self, spline_type):
        return spline_type == self.spline_type

    def is_flight(self):
        return self.flags & SplineFlags.SPLINEFLAG_FLYING

    def get_pending_waypoints_length(self):
        return len(self.pending_waypoints)

    def get_waypoint_location(self):
        if not self.pending_waypoints:
            return self.unit.location
        return self.pending_waypoints[0].location

    def try_build_movement_packet(self, waypoints=None, is_initial=False):
        # If this is a partial packet, use pending waypoints.
        if not waypoints:
            waypoints = [pending_wp.location for pending_wp in list(self.pending_waypoints)]

        # Sending no waypoints crashes the client.
        if len(waypoints) == 0:
            return None

        # Fill header.
        data = self._get_header_bytes()

        # Short circuit on stop spline.
        if self.is_type(SplineType.SPLINE_TYPE_STOP):
            return PacketWriter.get_packet(OpCode.SMSG_MONSTER_MOVE, data)

        # Fill payload.
        data += self._get_payload_bytes(waypoints, is_initial=is_initial)

        return PacketWriter.get_packet(OpCode.SMSG_MONSTER_MOVE, data)

    def _get_payload_bytes(self, waypoints, is_initial=False):
        data = b''
        last_waypoint = self.unit.location
        total_time = 0
        for wp in waypoints:
            data += wp.to_bytes(include_orientation=False)
            current_distance = last_waypoint.distance(wp)
            # Avoid div by zero. e.g. Facing spline.
            current_time = 0 if not self.speed else current_distance / self.speed
            total_time += current_time
            if is_initial:
                self.pending_waypoints.append(PendingWaypoint(self, len(self.pending_waypoints), total_time, wp))
            last_waypoint = wp

        # Player shouldn't instantly dismount after reaching the taxi destination, add 1 extra second.
        if is_initial and self.is_player and self.flags == SplineFlags.SPLINEFLAG_FLYING:
            total_time += 1.0

        # Update total time.
        self.total_time = total_time

        return pack(
            f'<I2I{len(data)}s',
            self.flags,
            int(self.total_time * 1000),
            len(waypoints),
            data
        )

    def _get_header_bytes(self):
        start_time = self.get_total_elapsed()
        location_bytes = self.unit.location.to_bytes(include_orientation=False)
        data = pack(
            f'<Q{len(location_bytes)}sIB',
            self.unit.guid,
            location_bytes,
            start_time,
            self.spline_type
        )
        if self.is_type(SplineType.SPLINE_TYPE_FACING_SPOT):
            spot_bytes = self.spot.to_bytes(include_orientation=False)
            data += pack(f'<{len(spot_bytes)}s', spot_bytes)
        elif self.is_type(SplineType.SPLINE_TYPE_FACING_TARGET):
            data += pack('<Q', self.guid)
        elif self.is_type(SplineType.SPLINE_TYPE_FACING_ANGLE):
            data += pack('<f', self.facing)
        return data

    def get_total_elapsed(self):
        return int(self.start_time + self.elapsed)

    @staticmethod
    def from_bytes(unit, spline_bytes):
        if len(spline_bytes < 42):
            return None

        bytes_read = 0

        spline = MovementSpline(unit)
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
