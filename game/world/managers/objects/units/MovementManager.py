from game.world.managers.maps.MapManager import MapManager
from game.world.managers.maps.helpers.CellUtils import CellUtils
from game.world.managers.objects.units.movement.MovementSpline import MovementSpline
from utils.ConfigManager import config
from utils.constants.MiscCodes import MoveFlags, ObjectTypeIds
from utils.constants.UnitCodes import SplineFlags, SplineType


class MovementManager:
    def __init__(self, unit):
        self.unit = unit
        self.is_player = self.unit.get_type_id() == ObjectTypeIds.ID_PLAYER
        self.pending_splines: list[MovementSpline] = []

    def update(self, elapsed):
        if not self.pending_splines:
            return

        pending_spline = self.pending_splines[0]
        position_changed, new_position = pending_spline.update(elapsed)

        if position_changed:
            self.unit.location = new_position
            self.unit.set_has_moved(has_moved=True, has_turned=False)
            if self.is_player and self.unit.pending_taxi_destination:
                self.unit.taxi_manager.update_flight_state()

        if pending_spline.is_complete():
            self.pending_splines.pop(0)
            self._handle_flight_end(pending_spline)
            self._handle_spline_end(pending_spline)

    def reset(self):
        self.pending_splines.clear()
        self.unit.movement_spline = None

    def get_pending_waypoints_length(self):
        return 0 if not self.pending_splines else self.pending_splines[0].get_pending_waypoints_length()

    def get_waypoint_location(self):
        if not self.pending_splines:
            return self.unit.location
        return self.pending_splines[0].get_waypoint_location()

    def unit_is_moving(self):
        if self.is_player:
            return self.pending_splines and self.unit.pending_taxi_destination is not None
        return self.pending_splines

    def try_build_movement_packet(self, waypoints=None, is_initial=False):
        if not self.pending_splines:
            return None
        return self.pending_splines[0].try_build_movement_packet(waypoints, is_initial)

    def _handle_spline_end(self, spline):
        if self.is_player:
            return
        if self.unit.is_evading:
            self.unit.is_evading = False
        if self.unit.is_at_home() and spline.is_type(SplineType.SPLINE_TYPE_NORMAL):
            self.unit.on_at_home()

    def _handle_flight_end(self, spline):
        if not spline.is_flight() or (not self.is_player and not self.unit.pending_taxi_destination):
            return
        self.unit.set_taxi_flying_state(False)
        self.unit.teleport(self.unit.map_id, self.unit.pending_taxi_destination, is_instant=True)
        self.unit.pending_taxi_destination = None
        self.unit.taxi_manager.update_flight_state()

    def send_move_normal(self, waypoints, speed, spline_flag, spline_type=SplineType.SPLINE_TYPE_NORMAL):
        if self.unit.movement_flags & MoveFlags.MOVEFLAG_ROOTED:
            return

        # Generate movement spline.
        spline = MovementSpline(
            unit=self.unit,
            spline_type=spline_type,
            flags=spline_flag,
            spot=self.unit.location,
            guid=self.unit.guid,
            facing=self.unit.location.o,
            speed=speed,
            elapsed=0,
            points=waypoints
        )

        self._send_move_to(spline)

    def send_move_stop(self):
        # Generate stop spline.
        spline = MovementSpline(
            unit=self.unit,
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
            unit=self.unit,
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
            unit=self.unit,
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
            unit=self.unit,
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

        packet = spline.try_build_movement_packet(waypoints=spline.points, is_initial=True)
        if packet:
            MapManager.send_surrounding(packet, self.unit, include_self=self.is_player)
            self.pending_splines.append(spline)

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
