from struct import pack

from game.world import WorldManager
from game.world.managers.maps.MapManager import MapManager
from game.world.managers.maps.helpers.CellUtils import CellUtils
from game.world.managers.objects.units.MovementSpline import MovementSpline
from game.world.managers.objects.units.PendingWaypoint import PendingWaypoint
from network.packet.PacketWriter import PacketWriter, OpCode
from utils.ConfigManager import config
from utils.constants.MiscCodes import MoveFlags, ObjectTypeIds
from utils.constants.UnitCodes import SplineFlags, SplineType


class MovementManager:
    def __init__(self, unit):
        self.unit = unit
        self.is_player = self.unit.get_type_id() == ObjectTypeIds.ID_PLAYER
        self.should_update_waypoints = False
        self.last_position = None
        self.pending_waypoints: list[PendingWaypoint] = []
        self.total_waypoint_time = 0
        self.total_waypoint_timer = 0
        self.waypoint_timer = 0

    def update_pending_waypoints(self, elapsed):
        if not self.should_update_waypoints:
            return

        self.total_waypoint_timer += elapsed
        self.waypoint_timer += elapsed
        # Set elapsed time to the current movement spline data.
        if self.unit.movement_spline:
            if self.unit.movement_spline.elapsed < self.unit.movement_spline.total_time:
                self.unit.movement_spline.elapsed += elapsed * 1000
                if self.unit.movement_spline.elapsed > self.unit.movement_spline.total_time:
                    self.unit.movement_spline.elapsed = self.unit.movement_spline.total_time

        waypoint_length = len(self.pending_waypoints)
        if waypoint_length > 0:
            current_waypoint = self.pending_waypoints[0]
            if self.total_waypoint_timer >= current_waypoint.expected_timestamp:
                new_position = current_waypoint.location
                self.last_position = new_position.copy()
                self.waypoint_timer = 0
                self.pending_waypoints.pop(0)
            # Guess current position based on speed and time.
            else:
                guessed_distance = self.unit.movement_spline.speed * self.waypoint_timer
                # If player is flying, don't guess in between locations, use waypoints only.
                if self.is_player and self.unit.movement_spline and \
                        self.unit.movement_spline.flags == SplineFlags.SPLINEFLAG_FLYING:
                    return
                # Guess the unit new position.
                new_position = self.last_position.get_point_in_between_movement(current_waypoint, guessed_distance)

            if new_position:
                self.waypoint_timer = 0
                self.last_position = new_position.copy()
                self.unit.location.x = new_position.x
                self.unit.location.y = new_position.y
                self.unit.location.z = new_position.z
                self.unit.set_has_moved(has_moved=True, has_turned=False)

                if self.is_player and self.unit.pending_taxi_destination:
                    self.unit.taxi_manager.update_flight_state()
        else:
            # Path finished.
            if self.total_waypoint_timer >= self.total_waypoint_time:
                if self.is_player and self.unit.pending_taxi_destination:
                    self.unit.set_taxi_flying_state(False)
                    self.unit.teleport(self.unit.map_id, self.unit.pending_taxi_destination, is_instant=True)
                    self.unit.pending_taxi_destination = None
                    self.unit.taxi_manager.update_flight_state()

                if not self.is_player:
                    if self.unit.is_evading:
                        self.unit.is_evading = False
                    if self.unit.is_at_home() and self.unit.movement_spline.is_type(SplineType.SPLINE_TYPE_NORMAL):
                        self.unit.on_at_home()

                self.reset()

    def reset(self):
        self.should_update_waypoints = False
        self.pending_waypoints.clear()
        self.unit.movement_spline = None
        self.last_position = None
        self.total_waypoint_time = 0
        self.total_waypoint_timer = 0
        self.waypoint_timer = 0

    def unit_is_moving(self):
        if self.is_player:
            return len(self.pending_waypoints) > 0 and self.unit.pending_taxi_destination is not None
        return len(self.pending_waypoints) > 0

    def try_build_movement_packet(self, waypoints=None, is_initial=False):
        # If this is a partial packet, use pending waypoints.
        if not waypoints:
            waypoints = [pending_wp.location for pending_wp in list(self.pending_waypoints)]

        # Sending no waypoints crashes the client.
        if len(waypoints) == 0:
            return None

        start_time = int(WorldManager.get_seconds_since_startup() * 1000)
        location_bytes = self.unit.location.to_bytes(include_orientation=False)
        data = pack(
            f'<Q{len(location_bytes)}sIB',
            self.unit.guid,
            location_bytes,
            start_time,
            self.unit.movement_spline.spline_type
        )

        if self.unit.movement_spline.spline_type == SplineType.SPLINE_TYPE_STOP:
            return PacketWriter.get_packet(OpCode.SMSG_MONSTER_MOVE, data)
        elif self.unit.movement_spline.spline_type == SplineType.SPLINE_TYPE_FACING_SPOT:
            spot_bytes = self.unit.movement_spline.spot.to_bytes(include_orientation=False)
            data += pack(f'<{len(location_bytes)}s', spot_bytes)
        elif self.unit.movement_spline.spline_type == SplineType.SPLINE_TYPE_FACING_TARGET:
            data += pack('<Q', self.unit.movement_spline.guid)
        elif self.unit.movement_spline.spline_type == SplineType.SPLINE_TYPE_FACING_ANGLE:
            data += pack('<f', self.unit.movement_spline.facing)

        data += pack('<I', self.unit.movement_spline.flags)

        waypoints_data = b''
        waypoints_length = len(waypoints)
        last_waypoint = self.unit.location.copy()
        total_distance = 0
        total_time = 0
        current_id = 0
        for waypoint in waypoints:
            waypoints_data += waypoint.to_bytes(include_orientation=False)
            current_distance = last_waypoint.distance(waypoint)
            # Avoid div by zero. e.g. Facing spline.
            current_time = 0 if not self.unit.movement_spline.speed else \
                current_distance / self.unit.movement_spline.speed
            total_distance += current_distance
            total_time += current_time

            if is_initial:
                self.pending_waypoints.append(PendingWaypoint(current_id, total_time, waypoint))
            last_waypoint = waypoint
            current_id += 1

        data += pack(
            f'<2I{len(waypoints_data)}s',
            int(total_time * 1000),
            waypoints_length,
            waypoints_data
        )

        if is_initial:
            # Player shouldn't instantly dismount after reaching the taxi destination
            if self.is_player and self.unit.movement_spline.flags == SplineFlags.SPLINEFLAG_FLYING:
                self.total_waypoint_time = total_time + 1.0  # Add 1 extra second
            else:
                self.total_waypoint_time = total_time

        # Avoid empty move packet.
        if len(waypoints_data) == 0:
            return None

        return PacketWriter.get_packet(OpCode.SMSG_MONSTER_MOVE, data)

    def send_move_normal(self, waypoints, speed, spline_flag, spline_type=SplineType.SPLINE_TYPE_NORMAL):
        if self.unit.movement_flags & MoveFlags.MOVEFLAG_ROOTED:
            return

        # Generate movement spline.
        spline = MovementSpline(
            spline_type=spline_type,
            flags=spline_flag,
            spot=self.unit.location,
            guid=self.unit.guid,
            facing=self.unit.location.o,
            speed=speed,
            elapsed=0,
            total_time=int(self.total_waypoint_time * 1000),
            points=waypoints
        )

        self._send_move_to(spline)

    def send_move_stop(self):
        # Generate stop spline.
        spline = MovementSpline(
            spline_type=SplineType.SPLINE_TYPE_STOP,
            flags=SplineFlags.SPLINEFLAG_NONE,
            spot=self.unit.location,
            guid=self.unit.guid,
            facing=self.unit.location.o,
            points=[self.unit.location]
        )

        self._send_move_to(spline)

    def send_face_spot(self, spot):
        # Generate face spot spline.
        spline = MovementSpline(
            spline_type=SplineType.SPLINE_TYPE_FACING_SPOT,
            flags=SplineFlags.SPLINEFLAG_SPOT,
            spot=spot,
            guid=self.unit.guid,
            facing=spot.o,
            points=[spot]
        )

        self._send_move_to(spline)

    def send_face_target(self, target):
        if not target:
            return

        # Server side.
        self.unit.location.face_point(target.location)

        # Generate face target spline
        spline = MovementSpline(
            spline_type=SplineType.SPLINE_TYPE_FACING_TARGET,
            flags=SplineFlags.SPLINEFLAG_TARGET,
            spot=target.location,
            guid=target.guid,
            facing=target.location.o,
            points=[self.unit.location]  # On its own axis.
        )

        self._send_move_to(spline)

    def send_face_angle(self, angle):
        # Generate face angle spline
        spline = MovementSpline(
            spline_type=SplineType.SPLINE_TYPE_FACING_ANGLE,
            flags=SplineFlags.SPLINEFLAG_FACING,
            spot=self.unit.location,
            guid=self.unit.guid,
            facing=angle,
            points=[self.unit.location]
        )

        self._send_move_to(spline)

    def _send_move_to(self, spline):
        # Reset old waypoints (if any) before sending new waypoints.
        self.reset()

        # Set spline and last position.
        self.unit.movement_spline = spline
        self.last_position = self.unit.location.copy()

        packet = self.try_build_movement_packet(waypoints=spline.points, is_initial=True)
        if packet:
            MapManager.send_surrounding(packet, self.unit, include_self=self.is_player)
            self.should_update_waypoints = True

    # TODO: Namigator: FindRandomPointAroundCircle (Detour)
    def move_random(self, start_position, radius, speed=config.Unit.Defaults.walk_speed):
        random_point = start_position.get_random_point_in_radius(radius, map_id=self.unit.map_id)
        failed, in_place, path = MapManager.calculate_path(self.unit.map_id, start_position, random_point)
        if failed or len(path) > 2 or in_place:
            return

        random_point = path[0]
        # Don't move if the destination is not an active cell.
        new_cell_coords = CellUtils.get_cell_key(random_point.x, random_point.y, self.unit.map_id, self.unit.instance_id)
        map_ = MapManager.get_map(self.unit.map_id, self.unit.instance_id)
        if self.unit.current_cell != new_cell_coords and not map_.is_active_cell(new_cell_coords):
            return

        self.send_move_normal([random_point], speed, SplineFlags.SPLINEFLAG_RUNMODE)
