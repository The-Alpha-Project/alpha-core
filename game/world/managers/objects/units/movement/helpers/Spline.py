import time
from struct import pack, unpack

from game.world import WorldManager
from game.world.managers.abstractions.Vector import Vector
from game.world.managers.objects.gameobjects.GameObjectBuilder import GameObjectBuilder
from game.world.managers.objects.units.movement.helpers.PendingWaypoint import PendingWaypoint
from network.packet.PacketWriter import PacketWriter
from utils.ConfigManager import config
from utils.constants.MiscCodes import ObjectTypeIds, GameObjectStates, MoveFlags
from utils.constants.OpCodes import OpCode
from utils.constants.UnitCodes import SplineFlags, SplineType


class Spline(object):
    def __init__(self, unit, spline_type=0, spline_flags=0, spot=None, guid=0, facing=0, speed=0, elapsed=0,
                 total_time=0, points=None, extra_time_seconds=0):
        self.unit = unit
        self.is_player = self.unit.get_type_id() == ObjectTypeIds.ID_PLAYER
        self.spline_type = spline_type
        self.spline_flags = spline_flags
        self.spot = spot
        self.guid = guid
        self.facing = facing
        self.speed = speed
        self.elapsed = elapsed  # Milliseconds.
        self.elapsed_since_last_location = 0  # Elapsed since we were able to update unit location on this spline.
        self.total_time = total_time  # Milliseconds.
        self.points = points
        self.pending_waypoints: list[PendingWaypoint] = []
        self.waypoints_bytes = b''
        self.total_waypoint_timer = 0
        self.extra_time_seconds = extra_time_seconds  # After real time ends, wait n secs.
        self.initialized = False

    def initialize(self):
        self.waypoints_bytes = b''
        last_waypoint = self.unit.location
        total_time = 0
        for wp in self.points:
            self.waypoints_bytes += wp.to_bytes(include_orientation=False)
            current_distance = last_waypoint.distance(wp)
            # Avoid div by zero. e.g. Facing spline.
            current_time = 0 if not self.speed else current_distance / self.speed
            total_time += current_time
            self.pending_waypoints.append(PendingWaypoint(self, len(self.pending_waypoints), total_time, wp))
            last_waypoint = wp

        self.total_time = total_time * 1000
        self.initialized = True

    def get_total_time_secs(self):
        return self.extra_time_seconds + (self.total_time / 1000)

    def get_total_time_ms(self):
        return self.total_time + (self.extra_time_seconds * 1000)

    def update(self, elapsed):
        if not self.initialized:
            return False, None, False

        self.total_waypoint_timer += elapsed
        self.elapsed += elapsed * 1000  # Milliseconds.
        self.elapsed_since_last_location += elapsed

        if not self.pending_waypoints:
            return False, None, False

        current_waypoint = self.pending_waypoints[0]

        is_complete = self.total_waypoint_timer >= current_waypoint.expected_timestamp
        if is_complete:
            self.pending_waypoints.pop(0)

        new_position = self._get_position(current_waypoint, self.elapsed_since_last_location, is_complete)

        if new_position:
            self.elapsed_since_last_location = 0
            if config.Server.Settings.debug_movement:
                self._debug_position(new_position)
            # While in movement (guessed position) always face target destination.
            # End orientation upon waypoint finish is handled by movement behaviors.
            if not is_complete:
                new_position.face_point(current_waypoint.location)

        # Position changed, vector, waypoint completed (Not guessed).
        return new_position is not None, new_position, is_complete

    def _get_position(self, pending_waypoint, elapsed, is_complete=False):
        # Handle players collision due wrong pathing.
        if self.unit.movement_flags & MoveFlags.MOVEFLAG_REDIRECTED:
            return self.unit.location
        if is_complete:
            self._validate_orientation(self.unit, pending_waypoint)
            return pending_waypoint.location
        guessed_distance = self.speed * elapsed
        return self.unit.location.get_point_in_between(guessed_distance, pending_waypoint.location,
                                                       map_id=self.unit.map_id)

    # noinspection PyMethodMayBeStatic
    def _validate_orientation(self, unit, pending_waypoint):
        wp_vector = pending_waypoint.location
        if wp_vector.o != 0 and wp_vector.o != 100:
            return
        # Waypoint has no valid orientation, use current or calculate towards waypoint.
        orientation = unit.location.get_angle_towards_vector(wp_vector) if unit.location.o == 0 else unit.location.o
        wp_vector.set_orientation(orientation)

    def _debug_position(self, location):
        gameobject = GameObjectBuilder.create(2555, location, self.unit.map_id, self.unit.instance_id,
                                              GameObjectStates.GO_STATE_READY,
                                              summoner=self.unit,
                                              ttl=1)
        self.unit.get_map().spawn_object(world_object_instance=gameobject)

    def is_complete(self):
        return not self.pending_waypoints and self.elapsed >= self.get_total_time_ms()

    def is_type(self, spline_type):
        return spline_type == self.spline_type

    def is_flight(self):
        return self.spline_flags & SplineFlags.SPLINEFLAG_FLYING

    def get_waypoint_location(self):
        if not self.pending_waypoints:
            return self.unit.location
        return self.pending_waypoints[0].location

    # Update spline to current time when someone requests a movement update.
    def update_to_now(self):
        elapsed = time.time() - self.unit.last_tick
        if elapsed:
            self.update(elapsed)

    def try_build_movement_packet(self):
        # Sending no waypoints crashes the client.
        if len(self.pending_waypoints) == 0:
            return None

        # Initialize if needed.
        if not self.initialized:
            self.initialize()

        # Fill header.
        data = bytearray(self._get_header_bytes())

        if not self.is_type(SplineType.SPLINE_TYPE_STOP):
            data.extend(self._get_payload_bytes())

        return PacketWriter.get_packet(OpCode.SMSG_MONSTER_MOVE, data)

    def _get_header_bytes(self):
        location_bytes = self.unit.location.to_bytes(include_orientation=False)
        data = pack(
            f'<Q{len(location_bytes)}sIB',
            self.unit.guid,
            location_bytes,
            int(WorldManager.get_seconds_since_startup() * 1000),
            int(self.spline_type)
        )
        if self.is_type(SplineType.SPLINE_TYPE_FACING_SPOT):
            spot_bytes = self.spot.to_bytes(include_orientation=False)
            data += pack(f'<{len(spot_bytes)}s', spot_bytes)
        elif self.is_type(SplineType.SPLINE_TYPE_FACING_TARGET):
            data += pack('<Q', self.guid)
        elif self.is_type(SplineType.SPLINE_TYPE_FACING_ANGLE):
            data += pack('<f', self.facing)
        return data

    def _get_payload_bytes(self):
        return pack(
            f'<3I{len(self.waypoints_bytes)}s',
            self.spline_flags,
            int(self.total_time - int(self.elapsed)),
            len(self.points),
            self.waypoints_bytes
        )

    @staticmethod
    def from_bytes(unit, spline_bytes):
        if len(spline_bytes < 42):
            return None

        bytes_read = 0

        spline = Spline(unit)
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

    # TODO: Fix SMSG_UPDATE_OBJECT create movement block.
    #  Client expects at least 3 waypoints for MOVEFLAG_SPLINE_MOVER.
    def to_bytes(self):
        data = pack('<I', self.spline_flags)

        if self.spline_flags & SplineFlags.SPLINEFLAG_SPOT:
            data += self.spot.to_bytes(include_orientation=False)
        if self.spline_flags & SplineFlags.SPLINEFLAG_TARGET:
            data += pack('<Q', self.guid)
        if self.spline_flags & SplineFlags.SPLINEFLAG_FACING:
            data += pack('<f', self.facing)

        len_points = len(self.points) - 1
        data += pack(
            '<3I',
            int(self.elapsed),
            int(self.total_time),
            len_points,
        )

        for point in range(1, len_points):
            data += self.points[point].to_bytes(include_orientation=False)

        return data
